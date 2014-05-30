# -*- coding: utf-8 -*-
"""
Created on Tue Apr 29 23:52:59 2014

@author: pi
"""

from imgproc import *
import RPi.GPIO as GPIO
import time
import serial
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
from pylab import *

def lcdCLS():
    lcd.write("\x7C\x00")
    
def lcdBacklightOn():
    lcd.write("\x7C\x02\xFF")

def lcdBacklightOff():
    lcd.write("\x7C\x02\x00")

def lcdReset():
    lcd.write("\x7C\x06")

def lcdReverse():
    lcd.write("\x7C\x14")

def f(xx, yy):
    return np.sin(xx) + np.cos(y)

lcd = serial.Serial('/dev/ttyUSB0', 115200)
lcd.open()
whiteLED = 4
redLED = 18
testCamera = 0

lcdReset()
lcdCLS()
lcdBacklightOff()
time.sleep(1)
lcdBacklightOn()
#lcdReverse()
lcd.write(" Meridian Scientific ")
lcd.write("PhotoSpectrometer v01")

lcd.write("Setting Up GPIO:")
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(whiteLED, GPIO.OUT)
GPIO.setup(redLED, GPIO.OUT)
lcd.write(" OK  ")

lcd.write("Imaging: ")
GPIO.output(redLED, GPIO.HIGH)

waitTime(2000)
GPIO.output(whiteLED, GPIO.HIGH)
camera1 = Camera(400,300)
if (testCamera == 1):
    while (1):
        image1 = camera1.grabImage()
        view1 = Viewer(image1.width, image1.height, "Image Photospectrometer #1")
        view1.displayImage(image1)

image1 = camera1.grabImage()
view1 = Viewer(image1.width, image1.height, "Image Photospectrometer #1")
view1.displayImage(image1)
lcd.write("Done.       ")
waitTime(2000)
GPIO.output(whiteLED, GPIO.LOW)

lcdCLS()
lcd.write("Analyzing: ")

fig1 = plt.figure()
plt.xlabel('Spectra')
plt.ylabel('Intensity')
plt.title('Meridian Scientific Photospectroscope')
plt.grid(True)
plt.ion()
plt.show()
rdata = [0] * 200
gdata = [0] * 200
bdata = [0] * 200

lineR, = plt.plot(rdata, color="red")
lineG, = plt.plot(gdata, color="green")
lineB, = plt.plot(bdata, color="blue")

#t = arange(0.0, 200.0, 01.01)
#s = sin(2*pi*t)
#plt.plot(t,s, 'b')

for x in range (90, 250):
    red, green, blue = image1[x, 135]
    for y in range (125, 145):
        image1[x, y] = 255, 0, 0
    view1.displayImage(image1)
    pmin = float(min(bdata)) - 10
    pmax = float(max(bdata)) + 100
    plt.ylim([pmin, pmax])
    rdata.append(red)
    gdata.append(green)
    bdata.append(blue)
    del rdata[0]
    del gdata[0]
    del bdata[0]
    lineR.set_xdata(np.arange(len(rdata)))
    lineR.set_ydata(rdata)
    plt.draw()
    lineG.set_xdata(np.arange(len(gdata)))
    lineG.set_ydata(gdata)
    plt.draw()
    lineB.set_xdata(np.arange(len(bdata)))
    lineB.set_ydata(bdata)
    plt.draw()
    lcd.write("*")
#    print(x, red)
lcd.write("Done.          ")
lcd.write("Saving red spectra.. ")
savefig("spectra.jpg")
lcd.write("Done.               ")

#test
#for x in range (0, image1.width):
#    for y in range(0, image1.height):
#        red, green, blue = image1[x, y]        
#        if red > green:
#            if red > blue:
#                image1[x, y] = 0, 0, 255
#view1.displayImage(image1)
#test
#waitTime(5000)

GPIO.output(redLED, GPIO.LOW)
lcd.close()
