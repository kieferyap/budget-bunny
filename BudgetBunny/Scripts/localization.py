import collections
import os

class Localization:

	# Class constants
	DATABASE_NAME = "budget_bunny"
	OUTPUT_FOLDER = "output"
	OUTPUT_FILE = OUTPUT_FOLDER+"/budget_bunny.sql"

	# Localization constants
	LOCALIZATION_FILE_MARKER = "COPY localizable_words"
	LOCALIZATION_FILE_ENDER = "\.\n"
	EN_OUTPUT = "../Resources/en.lproj/Localizable.strings"
	JP_OUTPUT = "../Resources/ja.lproj/Localizable.strings"
	ZH_OUTPUT = "../Resources/zh.lproj/Localizable.strings"

	def __init__ (self):
		print "[Internal] Initialized Localization class"

	# Accesses the budget_bunny database and exports an SQL file
	def database_dump(self):
		print "[Status] Running database dump"

		if not os.path.isdir(self.OUTPUT_FOLDER):
			os.popen("mkdir "+self.OUTPUT_FOLDER)

		dump_command = "pg_dump "+self.DATABASE_NAME+" > "+self.OUTPUT_FILE
		os.popen(dump_command)
		print "[Status] Database dump complete: "+self.OUTPUT_FILE

	# Creates the localization strings
	def create_localization_file(self, destination_location):
		print "[Status] Checking database dump file"

		# Add more indices if more languages are added
		localization_idx = 1
		en_idx = 2
		jp_idx = 3
		zh_idx = 4
		output_list = [EN_OUTPUT, JP_OUTPUT, ZH_OUTPUT]

		if os.path.isfile(self.OUTPUT_FILE):
			file = open(self.OUTPUT_FILE)
			self.find_localization_portion(file)

			line = file.readline()
			while not line == self.LOCALIZATION_FILE_ENDER:
				localization_arr = line.split()

				# Output to file here

				print localization_arr[localization_idx], localization_arr[en_idx], localization_arr[jp_idx], localization_arr[zh_idx]
				line = file.readline()
			
		else:
			print "[Error] File not found: "+self.OUTPUT_FILE

		print "[Status] Finished"

	def find_localization_portion(self, file):
		line = file.readline()

		while not self.LOCALIZATION_FILE_MARKER in line:
			line = file.readline()

if __name__ == "__main__":
	localization = Localization()
	localization.database_dump()
	localization.create_localization_file()