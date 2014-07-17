#Use the following python program to test
#depends on pySerial pkg
 
#pyTerm.py
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
    #print raw hex data
    hexData = ':'.join(x.encode('hex') for x in h)
    print hexData
 
def sendHex(h):
    serial.write(h)
    serial.write("\r") 
 
def logd(log, newline=True):
    tag = "sys"
    if (not newline):
        sys.stdout.write("[%.5f] %s" % (time.time() - t0 , log))
    else:
        print "[%.5f] %s" % (time.time() - t0 , log)
 
def welcomeMsg(): 
    print
    print 'Python-mbed Test Interface Program'
    print '[Tutorial_BinarySerialCom]'
    print 'Press Ctrl+c to quit'
    print
 
def initSerial(port, baudrate):
    # Serial port Configuration
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
 
 
# Thread for printing data from serial
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
#            logd("Enter a number: ", False)
#            inStr = raw_input() 
#            try:
#                inFloat = float(inStr)
#                inHex = double_to_hex(inFloat)
                #printHex(inHex)
#                sendHex(inHex) 
           byte = chr(0xA0)
           serial.write(byte)
           printHex(byte)

           time.sleep(0.12)

           byte = chr(0xA5)
           serial.write(byte)
           printHex(byte)
#            except ValueError:
#               logd("Enter a proper number!")
 
           time.sleep(4)
 
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