# -*- coding: utf-8 -*-
"""
Created on Tue Apr 29 20:01:00 2014

@author: pi
"""

import RPi.GPIO as GPIO
import time
import picamera
import serial

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

lcd = serial.Serial('/dev/ttyUSB0', 115200)
lcd.open()
whiteLED = 18
redLED = 4

lcdReset()
lcdCLS()
lcdBacklightOff()
time.sleep(1)
lcdBacklightOn()
#lcdReverse()
lcd.write(" Meridian Scientific ")
lcd.write("PhotoSpectrometer v01")

lcd.write("Setting Up GPIO:")
GPIO.setmode(GPIO.BCM)
GPIO.setup(whiteLED, GPIO.OUT)
GPIO.setup(redLED, GPIO.OUT)
lcd.write(" OK  ")

lcd.write("Imaging: ")
GPIO.output(redLED, GPIO.HIGH)
GPIO.output(whiteLED, GPIO.HIGH)

with picamera.PiCamera() as camera:
    camera.start_preview()
    time.sleep(20)
#    camera.capture('/home/pi/images/image.jpg')
    camera.stop_preview()
lcd.write("Done.       ")

GPIO.output(whiteLED, GPIO.LOW)
GPIO.output(redLED, GPIO.LOW)
lcd.close()
