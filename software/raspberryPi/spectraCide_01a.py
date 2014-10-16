# -*- coding: utf-8 -*-
"""
Created on Tue Aug 19 01:40:03 2014

@author: fl@c@
"""
import matplotlib.pyplot as plt
import serial
import numpy as np
import os
import plotly.plotly as py
from plotly.graph_objs import *

def killOldData():
	try:
		os.remove("spectra.dat")																														# remove any previous version of spectra.dat
	except OSError:
		print("   ***   Could not find or delete previous spectra.dat")
		pass

fname = 'spectra.dat'																																	# set the file name to spectra.dat
fmode = 'ab'																																					# set the file mode to append binary
lines = 0

yAxisMin = 0.85
yAxisMax = 4
xAxisMin = 1
xAxisMax = 3648



def getSpectra():
	with serial.Serial('COM62', 921600) as mcu, open(fname,fmode) as outf: 												# setup serial for communication to Nucelo and open the data file
		mcu.write('r\r\n') 																																	# send the command to the nucleo to start the capture
		for i in range(xAxisMax):																															# set the range for the number of signalElements in the CCD
			z = mcu.readline().strip()																													# read the data from the nucleo with the CCD data and strip the cr/lf
			outf.write(z + '\r\n')																															# write that data to the spectra.dat file
			outf.flush()                                                																						# flush the file

def readSpectra(saveIt):
	f2 = open('spectra.dat', 'r')                                																						# open the spectra.dat file for reading into the graph
	lines = f2.readlines()                                          																						# read the entire file into a single variable
	f2.close()                                                          																						# close the spectra.dat file

#def plotSpectra():
	x1 = []                                                                 																					# initialize the X coord
	y1 = []                                                                 																					# initialize the y coord

	py.sign_in("YOUR_USER_ID_HERE", "YOUR_USER_KEY_HERE")																										# sign into plot.ly

	for line in lines:
		p = line.split()																																		# scan the rows of the file stored in lines, and put the values 
		x1.append(float(p[0]))																															#      into some variables:
		y1.append(float(p[1]))

	print y1[2323]
		
	fig = plt.figure(1)
	ax = fig.add_subplot(111, axisbg='black')
	rect = fig.patch 																																		# a rectangle instance
	rect.set_facecolor('lightslategray')	
	ax.relim()
	ax.autoscale_view(True,True,True)
	ax.grid('on')
	plt.title(plot_Title, fontsize=24, color='black')
	t = plt.xlabel('pixelNumber', fontsize=16, color='red')																				# set the x label on the graph
	v = plt.ylabel('intensity', fontsize=16, color='blue')																					# set the y label on the graph
	plt.ylim([yAxisMin,yAxisMax])
	plt.xlim([xAxisMin,xAxisMax]) 
	plt.gca().set_yscale('linear')
#	plt.autoscale(True, axis='y', tight=True)
	xv = np.array(x1)                                                       																				# set the array for x
	yv = np.array(y1)                                                       																				# set the array for y
	
	plotly_trace1 = Scatter(x=xv, y=yv)																									# add data to plot.ly array
	plotly_data = Data([plotly_trace1])																											# send data to plot.ly
	plot_url = py.plot(plotly_data, filename='ramanPi')																					# create graph and display on plot.ly

	plt.plot(xv, yv, color = 'white', lw=1)                                                        												# plot the matplotlib data
	plt.show()                                                              																					# show the matplotlib graph
	if saveIt == 1:
		fname = "\figure_1.png"
		print "Creating: " + fname
#		plt.savefig(fname, dpi=100, bbox_extra_artist=(lgd1,), bbox_inches='tight')
		plt.close()

	
def startSpectraCapture(saveOrNot):
		print "Aquiring spectra......"
		getSpectra()
		print "Reading specta......"
		print "Plotting spectra....."
		readSpectra(saveOrNot)
#		plotSpectra()
		print "Done..."

def setSensitivity():
	mcu = serial.Serial('COM62', 921600)
	print "Set Sensitivity Level:"
	try:
		sens = input("Enter Sensitivity Level (1-6):")
	except SyntaxError:
		pass
	if sens == 1:
		mcu.write('l\r\n')
	if sens == 2:
		mcu.write('v\r\n')
	if sens == 3:
		mcu.write('n\r\n')
	if sens == 4:
		mcu.write('m\r\n')
	if sens == 5:
		mcu.write('h\r\n')
	if sens == 6:
		mcu.write('c\r\n')
		
	
plot_Title = 'ramanPi - DIY 3D Printable RaspberryPi Raman Spectrometer'
while(1):
	os.system('cls')
	print "ramanPi - DIY 3D Printable RaspberryPi Raman Spectrometer"
	print "SpectraSide_01  by fl@c@"
	print ""
	killOldData()
	print "1 - Get Spectra"
	print "2 - Get Spectra and Save File"
	print "3 - Set Sensitivity"
	print "4 - Quit"
	try:
		req = input("Enter your choice..")
	except SyntaxError:
		pass
	if req ==1:
		startSpectraCapture(0)
	if req ==2:
		startSpectraCapture(1)
	if req == 3:
		setSensitivity()
	if req == 4:
		quit()
