import os

#
# The goal of this script is to read localization data from a PostgreSQL database
# and generate the needed localization string files for the project.
#

class LocalizationFile:

	def __init__ (self, index, output_path):
		self.index = index
		self.output_path = output_path
		self.file_object = open(output_path, 'w')

	def write_line(self, line):
		self.file_object.write(line)


class Localization:

	# Class constants
	DATABASE_NAME = "budget_bunny"
	OUTPUT_FOLDER = "output"
	OUTPUT_FILE = OUTPUT_FOLDER+"/budget_bunny.sql"
	HEADER = "/* This file was generated using the localization script. Please do not make any changes to this file. */"

	# Localization constants
	LOCALIZATION_FILE_MARKER = "COPY localizable_words"
	LOCALIZATION_FILE_ENDER = "\.\n"

	def __init__ (self, localization_list):
		print "[Internal] Initialized Localization class"
		self.localization_list = localization_list

	# Accesses the budget_bunny database and exports an SQL file
	def database_dump(self):
		print "[Status] Running database dump"

		if not os.path.isdir(self.OUTPUT_FOLDER):
			os.popen("mkdir "+self.OUTPUT_FOLDER)

		dump_command = "pg_dump "+self.DATABASE_NAME+" > "+self.OUTPUT_FILE
		os.popen(dump_command)
		print "[Status] Database dump complete: "+self.OUTPUT_FILE

	# Creates the localization strings
	def create_localization_file(self):
		print "[Status] Checking database dump file"

		localization_idx = 1

		if os.path.isfile(self.OUTPUT_FILE):
			file = open(self.OUTPUT_FILE)
			self.find_localization_portion(file)

			for item in self.localization_list:
				item.write_line(self.HEADER+"\n")

			line = file.readline()
			while not line == self.LOCALIZATION_FILE_ENDER:
				localization_arr = line.split("\t")

				# Output to file here
				for item in self.localization_list:
					item.write_line("\""+localization_arr[localization_idx]+"\" = \""+localization_arr[item.index]+"\";\n")

				line = file.readline()
			
		else:
			print "[Error] File not found: "+self.OUTPUT_FILE

		print "[Status] Finished"

	def find_localization_portion(self, file):
		line = file.readline()

		while not self.LOCALIZATION_FILE_MARKER in line:
			line = file.readline()

if __name__ == "__main__":

	en_local = LocalizationFile(index = 2, output_path = "../Resources/Localization/en.lproj/Localizable.strings")
	ja_local = LocalizationFile(index = 3, output_path = "../Resources/Localization/ja.lproj/Localizable.strings")
	zh_local = LocalizationFile(index = 4, output_path = "../Resources/Localization/zh-Hans.lproj/Localizable.strings")
	all_localizations = [en_local, ja_local, zh_local]

	localization = Localization(all_localizations)
	localization.database_dump()
	localization.create_localization_file()





