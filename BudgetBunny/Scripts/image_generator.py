import os
import json

#
# The goal of this script is to gather image resources,
# place them in xcassets, and modify the corresponding Contents.json file
# in order for the images to be usable in the project.
#

class ImageGenerator:

	def __init__(self, all_image_files):
		self.all_image_files = all_image_files

	def generate(self):
		for image_file in self.all_image_files:
			image_file.convert_and_move()
			image_file.write_to_json()
			image_file.append_json_info()

class ImageIcon(object):

	def factory(type):
		if type == "TabIcon": return TabIcon()
		if type == "AppIcon": return AppIcon()
		assert 0, "Incorrect use of ImageIcon: "+type
	factory = staticmethod(factory)

	def initialize(self, filename):
		# Check if output directory exists. If not, create it.
		if not os.path.isdir(self.image_output_directory):
			os.popen("mkdir "+self.image_output_directory)
			print "Creating: "+self.image_output_directory
		self.filename = filename
		self.src_file = self.src_directory+self.filename
		self.json_file_object = open(self.image_output_directory+"Contents.json", 'w')
		self.json_data = {}
		self.json_data["images"] = []

	def convert_and_move(self):
		for idiom in self.size_list:
			for size in self.size_list[idiom]:
				for scale in self.size_list[idiom][size]:
					new_filename = self.generate_new_filename(size, scale)
					self.convert_file(self.src_file, size, scale, new_filename)
					self.move_file(new_filename, self.image_output_directory)
					self.add_to_json(idiom, size, scale, new_filename)
					
	def generate_new_filename(self, size, scale):
		if scale == 1:
			return "Icon-"+str(size)+".png"
		return "Icon-"+str(size)+"@"+str(scale)+"x.png"

	def convert_file(self, source_file, size, scale, new_filename):
		image_size = str(float(size)*float(scale))
		new_filename = "\""+new_filename+"\""
		source_file = source_file+".png"
		os.popen("convert \""+source_file+"\" -resize "+image_size+"x"+image_size+"^ "+new_filename)

	def move_file(self, new_filename, image_output_directory):
		os.popen("mv "+new_filename+" "+self.image_output_directory)

	def add_to_json(self, idiom, size, scale, new_filename):
		self.json_data["images"].append({"idiom": idiom, "filename": new_filename, "size": str(size)+"x"+str(size), "scale":str(scale)+"x"})

	def append_json_info(self):
		self.json_data["info"] = {"version": 1, "author": "xcode"}

	def write_to_json(self):
		print json.dumps(self.json_data, sort_keys=True, indent=4, separators=(',', ': '))
		json.dump(self.json_data, self.json_file_object, sort_keys=True, indent=4, separators=(',', ': '))

class TabIcon(ImageIcon):

	def __init__(self, filename):
		self.src_directory = "input/TabIcon/"
		self.image_output_directory = "../Resources/Assets.xcassets/"+filename+".imageset/"
		self.size_list = {}
		self.size_list["universal"] = {"22": [1, 2, 3]}
		self.initialize(filename)

class AppIcon(ImageIcon):

	def __init__(self, filename):
		self.src_directory = "input/AppIcon/"
		self.image_output_directory = "../Resources/Assets.xcassets/"+filename+".appiconset/"
		self.size_list = {}
		self.size_list["iphone"] = {"29": [1, 2, 3], "40": [2, 3], "57": [1, 2], "60": [2, 3]}
		self.size_list["ipad"] = {"29": [1, 2], "40": [1, 2], "50": [1, 2], "72": [1, 2], "76": [1, 2], "83.5": [2]}
		self.initialize(filename)

if __name__ == "__main__":
	all_image_files = []
	
	all_image_files.append(AppIcon("AppIcon"))
	all_image_files.append(TabIcon("AccountIcon"))
	all_image_files.append(TabIcon("BudgetIcon"))
	all_image_files.append(TabIcon("DashboardIcon"))
	all_image_files.append(TabIcon("RecordsIcon"))

	image_generator = ImageGenerator(all_image_files)
	image_generator.generate()
