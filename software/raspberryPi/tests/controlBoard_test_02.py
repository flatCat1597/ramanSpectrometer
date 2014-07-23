#controlBoard_test_02.py
#------------
#!/usr/bin/python
 
import time
import serial
import sys
import thread
import struct
import getopt 
 
def hex_to_float(h):
    return struct.unpack('f', h)
 
def float_to_hex(f):
    return struct.pack('f', f)
 
def double_to_hex(d):
    return struct.pack('d', d)
 
def printHex(h):
    hexData = ':'.join(x.encode('hex') for x in h)
    print hexData
 
def sendHex(h):
    serial.write(h)
    serial.write("\r") 
 
def logd(log, newline=True):
    if (not newline):
        sys.stdout.write("[%.5f] %s" % (time.time() - t0 , log))
    else:
        print "[%.5f] %s" % (time.time() - t0 , log)

def welcomeMsg(): 
    print
    print 'meridianScientific ramanSpectrometer controlBoard interfaceTest'
    print 'DIY 3D Printable raspberryPi Raman Spectrometer'
    print 'version_01'
    print
 
def initSerial(port, baudrate):
    serial.port = port
    serial.baudrate = baudrate
    serial.timeout = 1
    serial.writeTimeout = 1
    serial.open()
    serial.flush()
 
    logd( 'Opening port %s - %s' %(port, baudrate) )
    if serial.isOpen(): 
        logd('Success')
    else:
        logd('Failed')
        exit(2)

def readSerial(threadName, delay):
    s = ""
    while not Quit:
        if serial.inWaiting() != 0:
            c = serial.read()
            if (c == '\n'):
                print "[%7s] %s" % (threadName, s)
                s =""
            else:
                s += c
        else:
            time.sleep(0.01)
  
Quit= False;
if __name__ == '__main__':
    welcomeMsg();
    t0 = time.time()
    serial = serial.Serial()
    port = '/dev/ttyACM0'
    baudrate = 921600
    try:
        opts, args = getopt.getopt(sys.argv[1:],"hp:b:",["port=","baudrate="])
    except getopt.GetoptError:
        print 'pyTerm.py -p <port> -b <baudrate>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'pyTerm.py -p <port> -b <baudrate>'
            sys.exit()
        elif opt in ("-p", "--port"):
            port = arg
        elif opt in ("-b", "--baudrate"):
            baudrate = int(arg)
    initSerial("/dev/ttyACM0", baudrate)
 
    thread.start_new_thread( readSerial , ("controlBoard", 2, ))
 
    while 1 :
        try:
           print "Request Laser Temp:"
           req_laser_temp = (chr(0xF0)+chr(0xF2)+chr(0XC0)+chr(0xC5)+chr(0xF2)+chr(0xF3))
           serial.write(req_laser_temp)
 
           time.sleep(2)

           print "Request Cuvette Temp:"
           req_cuvette_temp = (chr(0xF0)+chr(0xF2)+chr(0XA0)+chr(0xA5)+chr(0xF2)+chr(0xF3))
           serial.write(req_cuvette_temp)
 
           time.sleep(2)

           print "Command Open Tray:"
           cmd_tray_open = (chr(0xF0)+chr(0xF2)+chr(0XA0)+chr(0xA1)+chr(0xF2)+chr(0xF3))
           serial.write(cmd_tray_open)
 
           time.sleep(7)

           print "Command Close Tray:"
           cmd_tray_close = (chr(0xF0)+chr(0xF2)+chr(0XA0)+chr(0xA2)+chr(0xF2)+chr(0xF3))
           serial.write(cmd_tray_close)
 
           time.sleep(7)
 
           print "Command Filter Select:"
           cmd_filter_select = (chr(0xF0)+chr(0xF2)+chr(0XB0)+chr(0xB1)+chr(0xF2)+chr(0xF3))
           serial.write(cmd_filter_select)
 
           time.sleep(10)

        except KeyboardInterrupt:
            print
            logd("Keyboard interrupt")
            Quit = True
            serial.close()
            break
        except Exception, err:
            logd("Exception")
            print sys.exc_info()[0]
            print err
            break