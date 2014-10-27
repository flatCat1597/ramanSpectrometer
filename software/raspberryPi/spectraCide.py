import sys
from PyQt4 import QtCore, QtGui, uic
import matplotlib.pyplot as plt
import serial
import numpy as np
import os
import plotly.plotly as py
from plotly.graph_objs import *
import time

form_class = uic.loadUiType("mainwindow.ui")[0]

fname = 'spectra.dat'																																	# set the file name to spectra.dat
fmode = 'ab'																																					# set the file mode to append binary
lines = 0

yAxisMin = 0.85
yAxisMax = 5
xAxisMin = 1
xAxisMax = 3648

class mainWindowClass(QtGui.QMainWindow, form_class):
	def __init__(self, parent=None):
		QtGui.QMainWindow.__init__(self, parent)
		self.setupUi(self)
		self.getSpectra_btn.clicked.connect(self.startSpectraCapture)
		self.postSpectra_btn.clicked.connect(self.plotLy)
		self.saveSpectra_btn.clicked.connect(self.saveSpectra)
		self.quit_btn.clicked.connect(self.quitApp)
		self.popUpSpectra_btn.clicked.connect(self.popUpSpectra)
		self.captureProgress.setValue(0)

	def killOldData(self):
		try:
			os.remove("spectra.dat")																													 # remove any previous version of spectra.dat
		except OSError:
			print("   ***   Could not find or delete previous spectra.dat")
			pass
		try:
			os.remove("tmpSpectra.png")																												 # remove any previous version of spectra.dat
		except OSError:
			print("   ***   Could not find or delete previous tmpSpectra.png")
			pass

	def save(self, path, ext='png', close=True, verbose=True):																		 # borrowed from http://www.jesshamrick.com/2012/09/03/saving-figures-from-pyplot/
		directory = os.path.split(path)[0]																											 # Extract the directory and filename from the given path
		filename = "%s.%s" % (os.path.split(path)[1], ext)
		if directory == '':
			directory = '.'
		if not os.path.exists(directory):																												 # If the directory does not exist, create it
			os.makedirs(directory)
		savepath = os.path.join(directory, filename)																							 # The final path to save to
		if verbose:
			print("Saving figure to '%s'..." % savepath),																						 # Actually save the figure
		plt.savefig(savepath, dpi=None, faceColor='w', edgecolor='w', orientation='portrait', papertype=None, format=None, transparent=False, bbox_inches=None, pad_inches=0.1, frameon=None)
		if close:																																					 # Close it
			plt.close()
		if verbose:
			print("Done")
		
	def getSpectra(self):
		with serial.Serial('COM62', 921600) as mcu, open(fname,fmode) as outf: 												# setup serial for communication to Nucelo and open the data file
			mcu.write('r\r\n') 																																	# send the command to the nucleo to start the capture
			for i in range(xAxisMax):																															# set the range for the number of signalElements in the CCD
				z = mcu.readline().strip()																													# read the data from the nucleo with the CCD data and strip the cr/lf
				outf.write(z + '\r\n')																															# write that data to the spectra.dat file
				outf.flush()                                                																						# flush the file

	def readSpectra(self):
		f2 = open('spectra.dat', 'r')                                																						# open the spectra.dat file for reading into the graph
		lines = f2.readlines()                                          																						# read the entire file into a single variable
		f2.close()                                                          																						# close the spectra.dat file

	#def plotSpectra():
		x1 = []                                                                 																					# initialize the X coord
		y1 = []                                                                 																					# initialize the y coord

		for line in lines:
			p = line.split()																																		# scan the rows of the file stored in lines, and put the values 
			x1.append(float(p[0]))																															#      into some variables:
			y1.append(float(p[1]))

		fig = plt.figure(1)
		ax = fig.add_subplot(111, axisbg='black')
		rect = fig.patch 																																		# a rectangle instance
		rect.set_facecolor('lightslategray')	
		ax.relim()
		ax.autoscale_view(True,True,True)
		ax.grid('on')
		plt.title(self.plot_Title, fontsize=24, color='black')
		t = plt.xlabel('pixelNumber', fontsize=16, color='red')																				# set the x label on the graph
		v = plt.ylabel('intensity', fontsize=16, color='blue')																					# set the y label on the graph
		plt.ylim([yAxisMin,yAxisMax])
		plt.xlim([xAxisMin,xAxisMax]) 
		plt.gca().set_yscale('linear')
#		plt.autoscale(True, axis='y', tight=True)
		xv = np.array(x1)                                                       																				# set the array for x
		yv = np.array(y1)                                                       																				# set the array for y
		plt.plot(xv, yv, color = 'white', lw=1)                                                        												# plot the matplotlib data
		self.save("tmpSpectra", ext="png", close=False, verbose=True)
#		plt.show()                                                              																					# show the matplotlib graph

		scene = QtGui.QGraphicsScene(self)
#		scene.setSceneRect(0,0,461,281)
		img = QtGui.QPixmap("tmpSpectra.png")
		imgItem = QtGui.QGraphicsPixmapItem(img)
		scene.addItem(QtGui.QGraphicsPixmapItem(img))
		scene.addText("ramanPi_2014")
		view = self.spectralView
		view.setScene(scene)
		view.fitInView(imgItem)
		view.setRenderHint(QtGui.QPainter.Antialiasing)
		view.show()
		
	def popUpSpectra(self):
		plt.show()

	def saveSpectra(self):
		timestr = time.strftime("%Y%m%d%H%M%S")
		self.save("ramanPi_spectra_" + timestr, ext="png", close=False, verbose=True)

	def plotLy(self):
		userID = self.userName_box.text()
		userKey = self.userKey_box.text()
		py.sign_in(userId, userKey)																													# sign into plot.ly

		f2 = open('spectra.dat', 'r')                                																						# open the spectra.dat file for reading into the graph
		lines = f2.readlines()                                          																						# read the entire file into a single variable
		f2.close()                                                          																						# close the spectra.dat file

		x1 = []                                                                 																					# initialize the X coord
		y1 = []                                                                 																					# initialize the y coord
		for line in lines:
			p = line.split()																																		# scan the rows of the file stored in lines, and put the values 
			x1.append(float(p[0]))																															#      into some variables:
			y1.append(float(p[1]))

		xv = np.array(x1)                                                       																				# set the array for x
		yv = np.array(y1)                                                       																				# set the array for y

		timestr = time.strftime("%Y%m%d%H%M%S")
		plotly_trace1 = Scatter(x=xv, y=yv)																										# add data to plot.ly array
		plotly_data = Data([plotly_trace1])																											# send data to plot.ly
		plot_url = py.plot(plotly_data, filename='ramanPi' + timestr)																					# create graph and display on plot.ly

	def startSpectraCapture(self):
		self.setSensitivity()
		self.captureProgress.setValue(0)
		self.killOldData()
		print "Aquiring spectra......"
		value = self.captureProgress.value() + 20
		self.captureProgress.setValue(value)
		self.getSpectra()
		print "Reading specta......"
		value = self.captureProgress.value() + 20
		self.captureProgress.setValue(value)
		print "Plotting spectra....."
		value = self.captureProgress.value() + 20
		self.captureProgress.setValue(value)
		self.readSpectra()
#		plotSpectra()
		value = self.captureProgress.value() + 20
		self.captureProgress.setValue(value)
		print "Done..."
		value = self.captureProgress.value() + 20
		self.captureProgress.setValue(value)

	def setSensitivity(self):
		mcu = serial.Serial('COM62', 921600)
		print "Set Sensitivity Level:" 
		print self.exposureDial.value()
#		try:
#			sens = input("Enter Sensitivity Level (1-6):")
#		except SyntaxError:
#			pass
#		if sens == 1:
		expVal = self.exposureDial.value()
		if expVal == 1:
			mcu.write('l\r\n')
			print "Exposure Setting: 1"
#		if sens == 2:
		if expVal == 2:
			mcu.write('v\r\n')
			print "Exposure Setting: 2"
#		if sens == 3:
		if expVal == 3:
			mcu.write('n\r\n')
			print "Exposure Setting: 3"
#		if sens == 4:
		if expVal == 4:
			mcu.write('m\r\n')
			print "Exposure Setting: 4"
#		if sens == 5:
		if expVal == 5:
			mcu.write('h\r\n')
			print "Exposure Setting: 5"
#		if sens == 6:
		if expVal == 6:
			mcu.write('c\r\n')
			print "Exposure Setting: 6"
		
	def quitApp(self):
		sys.exit()
	
	plot_Title = 'ramanPi_spectraCide Ver0.1a'


		
app = QtGui.QApplication(sys.argv)
mainWindow = mainWindowClass(None)
mainWindow.show()
app.exec_()