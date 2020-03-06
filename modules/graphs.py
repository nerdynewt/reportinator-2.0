#!/bin/python

import os
import matplotlib.pyplot as plt
import numpy as np
import math
import csv
import sys
import re
import subprocess
import glob


csv_files=[]

# Function that does the plotting.
def graph(data, axes, graph_name):
	data=np.array(data)
	plt.plot(data[1:,0], data[1:,3])
	for i in axes[1:]:
		# plt.plot(data[1:,int(axes[0])], data[1:,int(i)])
		plt.savefig("./modules/dat/graphs/" + graph_name)
#		plt.show()
		graphpath = "graphs/" + graph_name
	return

# Finding all csv files 
for root, dirs, files in os.walk("./modules/dat/tables/"):
    path = root.split(os.sep)
    for file in files:
        if len((re.findall(re.compile('.\.csv'),file))) >= 1:
            csv_files.append(file)

# Plots every csv file with a graph(x;y) line at the last row
for file in csv_files:
	filename = "./modules/dat/tables/"+file
	data = list(csv.reader(open(filename)))
	for arg in data[-1]:
		if "graph" in arg:
			del data[-1]
			arg = re.sub('graph\(', '', arg)
			arg = re.sub('\)', '', arg)
			axes=arg.split(';')
			graph_name = str(arg.replace(";","")) + file.replace(".csv", ".png")
			graph(data, axes, graph_name)
			graphpath = "graphs/" + graph_name
			call = "./modules/images.py " + graphpath
			os.system(call)




# xaxis= "$\sin(x)$"
 
# plt.plot([1, 2, 3, 4, 5, 6],[4, 5, 1, 3, 6, 7])
# plt.title('Title')
# plt.xlabel(r'%s' % xaxis)
# plt.show() 
