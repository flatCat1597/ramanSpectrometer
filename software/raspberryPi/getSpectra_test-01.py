# -*- coding: utf-8 -*-
"""
Created on Tue Aug 19 01:40:03 2014

@author: fl@c@
"""
import matplotlib.pyplot as plt
import serial
import numpy as np
import os

try:
    os.remove("spectra.dat")                                            # remove any previous version of spectra.dat
except OSError:
    print("   ***   Could not find or delete previous spectra.dat")
    pass

fname = 'spectra.dat'                                                   # set the file name to spectra.dat
fmode = 'ab'                                                            # set the file mode to append binary

with serial.Serial('COM62', 921600) as mcu, open(fname,fmode) as outf:  # setup serial for communication to Nucelo and open the data file
    mcu.write('r\r\n')                                                  # send the command to the nucleo to start the capture
    for i in range(3648):                                               # set the range for the number of signalElements in the CCD
        z = mcu.readline().strip()                                      # read the data from the nucleo with the CCD data and strip the cr/lf
        outf.write(z + '\r\n')                                          # write that data to the spectra.dat file
        outf.flush()                                                    # flush the file

f2 = open('spectra.dat', 'r')                                           # open the spectra.dat file for reading into the graph
lines = f2.readlines()                                                  # read the entire file into a single variable
f2.close()                                                              # close the spectra.dat file

x1 = []                                                                 # initialize the X coord
y1 = []                                                                 # initialize the y coord
                                                                        # scan the rows of the file stored in lines, and put the values 
                                                                        #      into some variables:
for line in lines:
    p = line.split()
    x1.append(float(p[0]))
    y1.append(float(p[1]))
plt.xlabel('pixelNumber')                                               # set the x label on the graph
plt.ylabel('voltage - inverted')                                        # set the y label on the graph
xv = np.array(x1)                                                       # set the array for x
yv = np.array(y1)                                                       # set the array for y
plt.plot(xv, yv)                                                        # plot the data
plt.show()                                                              # show the graph