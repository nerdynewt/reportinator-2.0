#!/bin/python

import os
import matplotlib.pyplot as plt
import numpy as np
import math

# for filename in os.listdir("dat/tables"):
# 	if filename.endswith(".csv"):
# 		file=os.path.join("dat/tables/", filename)
#         print(file)
#          for line in file:
#          	a = numpy.fromstring(line.strip(), dtype=int, sep=",")
# #         data = np.genfromtxt(file, dtype=float, delimiter=',', names=True)
#  #        print(data[1][1])

#          continue
#      else:
#          continue

print ("GRAPH")


for filename in os.listdir("dat/tables"):
	if filename.endswith(".csv"):
		file=os.path.join("dat/tables/", filename)
		print(file)
		for line in file:
			a = np.fromstring(line.strip(), dtype=int, sep=",")
			print a
		continue
	else:
		continue
