#!/bin/python

import os
import re
import subprocess
import sys


if len(sys.argv) == 1:
	for root, dirs, files in os.walk("./modules/dat/tables/"):
	    path = root.split(os.sep)
	    for file in files:
	        if len((re.findall(re.compile('.\.csv'),file))) >= 1:
	            filepath = "./modules/dat/tables/" + file
	            call = "./modules/tably.py -e " + filepath
	            os.system(call)
				# call = "./modules/tably.py -e " + filepath
				# os.system(call)
	            # subprocess.call(['./modules/tably.py' -e, filepath])
else:
	for file in sys.argv[1:]:
		if os.path.isfile("./modules/dat/tables/" + file + ".csv") or os.path.isfile("./modules/dat/tables/" + file):
			if ".csv" not in file:
				file=file+".csv"
			filepath = "./modules/dat/tables/" + file
			call = "./modules/tably.py -e " + filepath
			os.system(call)
			# subprocess.call(['./modules/tably.py' -e, filepath])


