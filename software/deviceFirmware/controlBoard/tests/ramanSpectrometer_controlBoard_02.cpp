#include "mbed.h"
#include "DS18B20.h"
#include "OneWireDefs.h"

#define THERMOMETER DS18B20

#define     msg_cuvette_tray            0x10
#define     msg_cuvette_temp            0x11
#define     msg_cuvette_status          0x12
#define     msg_cuvette_tray_pos        0x13
#define     msg_cuvette_pelt_status     0x14
#define     msg_cuvette_stepper         0x15

#define     msg_filter_wheel            0x20
#define     msg_filter_pos              0x21

#define     msg_laser_temp              0x30
#define     msg_laser_power_status      0x31
#define     msg_laser_ttl_status        0x32
#define     msg_laser_good_status       0x33
#define     msg_laser_color             0x34
#define     msg_uv_index                0x35

#define     msg_ccd_pelt_status         0x40

#define     msg_shutter_servo_pos       0x50
#define     msg_shutter_status          0x51

#define     msg_board_ID                0x60
#define     msg_board_serial            0x61
#define     msg_board_status            0x62
#define     msg_board_time              0x63
#define     msg_board_model             0x64
#define     msg_board_version           0x65
#define     req_reboot                  0x66

#define     msg_ambient_temp            0x70
#define     req_baro                    0x71
#define     req_humidity                0x72

#define     cmd_cuvette                 0xA0
#define     tray_open                   0xA1
#define     tray_close                  0xA2
#define     cuvette_peltier             0xA3
#define     req_cuvette_status          0xA4
#define     req_cuvette_temp            0xA5
#define     req_cuvette_pelt_status     0xA6
#define     req_cuvette_tray_pos        0xA7

#define     cmd_filter_wheel            0xB0
#define     filter_select               0xB1
#define     filter_reset                0xB2
#define     req_filter_ID               0xB3
#define     req_filter_status           0xB4
#define     req_filter_count            0xB5
#define     req_filter_pos              0xB6

#define     cmd_laser                   0xC0
#define     laser_power                 0xC1
#define     laser_ttl                   0xC2
#define     req_laser_good_status       0xC3
#define     req_laser_color             0xC4
#define     req_laser_temp              0xC5
#define     req_uv_index                0xC6

#define     cmd_ccd_peltier             0xD0
#define     cmd_ccd_pelt_power          0xD1
#define     cmd_cuvette_peltier         0xD2
#define     cmd_cuvette_pelt_power      0xD3
#define     req_pelt_cool               0xD4
#define     req_pelt_heat               0xD5
#define     req_pelt_off                0xD6

#define     cmd_shutter_servo           0xE0
#define     shutter_open                0xE1
#define     shutter_close               0xE2
#define     shutter_deflect             0xE3
#define     shutter_alternate           0xE4
#define     req_shutter_state           0xE5
#define     req_shutter_status          0xE6

#define     packet_start                0xF0
#define     packet_ack                  0xF1
#define     packet_flag                 0xF2
#define     packet_end                  0xF3
#define     packet_err                  0xF4
#define     cmd_err                     0xF5
#define     req_err                     0xF6
#define     brd_err                     0xF7

#define     env_err                     0x80
#define     cuvette_err                 0x81
#define     laser_err                   0x82
#define     filter_err                  0x83
#define     ccd_pelt_err                0x84
#define     cuvette_pelt_err            0x85
#define     shutter_err                 0x86
#define     board_err                   0x87

DigitalIn button(USER_BUTTON);
DigitalOut grnLED(LED1);
DigitalOut cuvette_IN1(PC_14);
DigitalOut cuvette_IN2(PC_15);
DigitalOut cuvette_IN3(PH_0);
DigitalOut cuvette_IN4(PH_1);
DigitalOut filter_IN1(PA_4);
DigitalOut filter_IN2(PB_0);
DigitalOut filter_IN3(PC_1);
DigitalOut filter_IN4(PC_0);
PwmOut cuvettePeltA(PB_13);
PwmOut cuvettePeltB(PB_14);
PwmOut ccdPeltA(PB_1);
PwmOut ccdPeltB(PB_15);

const int mDelay=1;
double temp;
int z;
int trayOpen;
THERMOMETER device(PC_8);
Serial raspi(USBTX, USBRX);

typedef union bytes {
    double d ;
    char c[8];
} bytes;

void printDoubleToHex(double d)
{
    bytes b;
    b.d = d;
    raspi.printf("%f -> %x %x %x %x %x %x %x %x\r\n", b.d, b.c[0], b.c[1], b.c[2], b.c[3], b.c[4], b.c[5], b.c[6], b.c[7]);
}

void printHexToDouble(char *arr)
{
    bytes b;
    for (int i=0; i<8; ++i)
        b.c[i] = arr[i];
    raspi.printf("received hex: %x %x %x %x %x %x %x %x \r\n", b.c[0], b.c[1], b.c[2], b.c[3], b.c[4], b.c[5], b.c[6], b.c[7]);
    raspi.printf("convert to: %f\r\n", b.d);
}

void readTemp(int deviceNum)
{
    temp = device.readTemperature(deviceNum);
    if (deviceNum == 0) {
//        raspi.printf("Cuvette Temperature: %f\r\n", temp);
//        const char begin[2]= {packet_flag, packet_start};
//        raspi.printf(begin);
        printDoubleToHex(temp);
//        const char stop[2]= {packet_flag, packet_end};
//        raspi.printf(stop);
    }
    if (deviceNum == 1) {
//        raspi.printf("Laser Emitter Temperature: %f\r\n", temp);
//        const char begin[2]= {packet_flag, packet_start};
//        raspi.printf(begin);
        printDoubleToHex(temp);
//        const char stop[2]= {packet_flag, packet_end};
//        raspi.printf(stop);
    }
//    raspi.printf("Device %d is %f",deviceNum, temp);
    wait(0.5);
}

int openTray()
{
    while (z < 500) {
        z++;
        grnLED = 1;
        wait_ms(1);
        cuvette_IN1 = 0;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 1;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 1;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 1;
        cuvette_IN3= 1;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 1;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 1;
        cuvette_IN2= 1;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 1;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 1;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
    }
    trayOpen = 1;
    z = 0;
    return(0);
}

int closeTray()
{
    while (z < 500) {
        z++;
        grnLED = 1;
        wait_ms(1);
        cuvette_IN1= 1;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 1;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 1;
        cuvette_IN2= 1;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 1;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 1;
        cuvette_IN3= 1;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 1;
        cuvette_IN4= 0;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 1;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 1;
        wait_ms(mDelay);

        cuvette_IN1= 0;
        cuvette_IN2= 0;
        cuvette_IN3= 0;
        cuvette_IN4= 0;
    }
    trayOpen = 0;
    z = 0;
    return(0);
}

int filterForward()
{
    while (z < 500) {
        z++;
        grnLED = 1;
        wait_ms(1);
        filter_IN1 = 0;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 1;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 1;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 1;
        filter_IN3= 1;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 1;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 1;
        filter_IN2= 1;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 1;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 1;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 0;
    }
    z = 0;
    return(0);
}
int filterBack()
{
    while (z < 500) {
        z++;
        grnLED = 0;
        wait_ms(1);
        filter_IN1= 1;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 1;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 1;
        filter_IN2= 1;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 1;
        filter_IN3= 0;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 1;
        filter_IN3= 1;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 1;
        filter_IN4= 0;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 1;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 1;
        wait_ms(mDelay);

        filter_IN1= 0;
        filter_IN2= 0;
        filter_IN3= 0;
        filter_IN4= 0;
    }
    z = 0;
    return(0);
}

int cuvettePeltCycle(){
    cuvettePeltA = 0;
    cuvettePeltB = 0;
    wait(3);
    cuvettePeltA = 1;
    cuvettePeltB = 1;
    wait(3);
    cuvettePeltA = 1;
    cuvettePeltB = 0;
    wait(3);
    cuvettePeltA = 0;
    cuvettePeltB = 1;
    wait(3);
    cuvettePeltA = 0;
    cuvettePeltB = 0;
    return 0;
}    

int err;
char* command;
int packetFlag = 0;
int main()
{
    trayOpen = 0;
    raspi.baud(921600);

    cuvettePeltCycle();    
    
    wait(10);
//    raspi.printf("meridianScientific_ramanSpectrometer_controlBoard_V0\r\n");

    while (!device.initialize());    // keep calling until it works

    int deviceCount = device.getDeviceCount();
//    raspi.printf("Located %d sensors\n\r",deviceCount);

    z = 0;
    device.setResolution(twelveBit);
    while(1) {
//        for (int i = 0; i < deviceCount; i++) {
//            readTemp(i);
//        }
        if (raspi.readable()) {                                                                         // check if serial port is reaadable
            switch (raspi.getc()) {                                                                     // retrieve a character from serial
                case packet_start:                                                                      // case for packet start flag
                    switch (raspi.getc()) {                                                             // set condition for listening to another character
                        case packet_flag:                                                               // case for packet flag
                            packetFlag = 1;                                                             // turn the flag on
                            while (packetFlag == 1) {                                                   // start a loop that runs while the flag is on
                                switch (raspi.getc()) {                                                 // set another condition for listening to another character
                                    case cmd_laser:                                                     // case for cmd_laser
                                        grnLED = 1;                                                     // turn the led on
                                        raspi.printf("%x", cmd_laser);                                  // return cmd_laser to the raspi
                                        switch (raspi.getc()) {                                         // set another condition for listening to another character
                                            case req_laser_temp:                                        // case for req_laser_temp
                                                raspi.printf("%x\r\n", req_laser_temp);                 // return req_laser_temp to the raspi
                                                readTemp(0);                                            // read the temperature for device 0 which is the laser temp sensor
                                                grnLED = 0;                                             // turn led off
                                                continue;                                               // continue through loop
                                            default:                                                    // default if nothing matches
                                                break;                                                  // break from loop
                                        }
                                    case cmd_cuvette:                                                   // case for cmd_cuvette
                                        grnLED = 1;                                                     // turn led on
                                        raspi.printf("%x", cmd_cuvette);                                // return cmd_cuvette to raspi
                                        switch (raspi.getc()) {                                         // set condition for listening to another character
                                            case req_cuvette_temp:                                      // case for req_cuvette_temp
                                                raspi.printf("%x\r\n", req_cuvette_temp);               // return req_cuvette_temp to raspi
                                                readTemp(1);                                            // read the temperature for device 1 which is the cuvette temp sensor
                                                grnLED = 0;                                             // turn the led off
                                                continue;                                               // continue through the loop
                                            case tray_open:                                             // case for tray_open
                                                raspi.printf("%x\r\n", tray_open);                      // return tray_open to raspi
                                                if (trayOpen == 0) {                                    // check to see if the tray is closed
                                                    openTray();                                         // if not, open tray
                                                } else {                                                // otherwise
                                                    raspi.printf("%x\r\n", cuvette_err);                // send a cuvette error to the raspi
                                                }
                                                grnLED = 0;                                             // turn led off
                                                continue;                                               // continue through the loop
                                            case tray_close:                                            // case for tray close
                                                raspi.printf("%x\r\n", tray_close);                     // return tray_close to raspi
                                                if (trayOpen == 1) {                                    // check to see if tray is open
                                                    closeTray();                                        // if not, close tray
                                                } else {                                                // otherwise
                                                    raspi.printf("%x\r\n", cuvette_err);                // send a cuvette error to the raspi
                                                }
                                                grnLED = 0;                                             // turn led off
                                                continue;                                               // continue through loop
                                            default:                                                    // default if nothing matches
                                                break;                                                  // break from loop
                                        }
                                    case cmd_filter_wheel:                                              // case for cmd_filter_wheel
                                        grnLED = 1;                                                     // turn led on
                                        raspi.printf("%x", cmd_filter_wheel);                           // return cmd_filter_wheel to raspi
                                        switch (raspi.getc()) {                                         // set condidition for listening to another character
                                            case filter_select:                                         // case for filter_select
                                                raspi.printf("%x\r\n", filter_select);                  // return filter_select to raspi
                                                filterForward();                                        // move filter wheel forward one filter
                                                filterBack();                                           // move filter wheel reverse one filter (this is just to test the commands)
                                                grnLED = 0;                                             // turn led off
                                                continue;                                               // continue through loop
                                            default:                                                    // default if nothing matches
                                                break;                                                  // break from loop
                                        }
                                    case cmd_cuvette_peltier:
                                        grnLED = 1;                                                     // turn led on
                                        raspi.printf("%x", cmd_cuvette_peltier);                        // return cmd_ccd_peltier to raspi
                                        switch (raspi.getc()) {                                         // set condidition for listening to another character
                                            case cmd_cuvette_pelt_power:
                                                switch (raspi.getc()) {                                 // set condidition for listening to another character
                                                    case 0x00:                                          // case for cmd_ccd_peltier OFF
                                                        raspi.printf("%x\r\n", cmd_cuvette_pelt_power); // return filter_select to raspi
                                                        cuvettePeltA = 0;                               // set PWM A to zero
                                                        cuvettePeltB = 0;                               // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    case 0x01:                                          // case for cmd_cuvette_peltier COOL
                                                        raspi.printf("%x\r\n", cmd_cuvette_pelt_power); // return filter_select to raspi
                                                        cuvettePeltA = 0.5;                             // set PWM A to 0.5
                                                        cuvettePeltB = 0;                               // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    case 0x02:                                          // case for cmd_cuvette_peltier HEAT
                                                        raspi.printf("%x\r\n", cmd_cuvette_pelt_power); // return filter_select to raspi
                                                        cuvettePeltA = 0;                               // set PWM A to 0.5
                                                        cuvettePeltB = 0.5;                             // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    default:
                                                        break;
                                                }
                                                continue;
                                            default:
                                                break;
                                        }
                                    case cmd_ccd_peltier:
                                        grnLED = 1;                                                     // turn led on
                                        raspi.printf("%x", cmd_ccd_peltier);                            // return cmd_ccd_peltier to raspi
                                        switch (raspi.getc()) {                                         // set condidition for listening to another character
                                            case cmd_ccd_pelt_power:
                                                switch (raspi.getc()) {                                 // set condidition for listening to another character
                                                    case 0x00:                                          // case for cmd_ccd_peltier OFF
                                                        raspi.printf("%x\r\n", cmd_ccd_pelt_power);        // return filter_select to raspi
                                                        ccdPeltA = 0;                                   // set PWM A to zero
                                                        ccdPeltB = 0;                                   // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    case 0x01:                                          // case for cmd_ccd_peltier COOL
                                                        raspi.printf("%x\r\n", cmd_ccd_pelt_power);        // return filter_select to raspi
                                                        ccdPeltA = 0.5;                                 // set PWM A to 0.5
                                                        ccdPeltB = 0;                                   // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    case 0x02:                                          // case for cmd_ccd_peltier HEAT
                                                        raspi.printf("%x\r\n", cmd_ccd_pelt_power);        // return filter_select to raspi
                                                        ccdPeltA = 0;                                   // set PWM A to 0.5
                                                        ccdPeltB = 0.5;                                 // set PWM B to zero
                                                        grnLED = 0;                                     // turn led off
                                                        break;
                                                    default:
                                                        break;
                                                }
                                                continue;
                                            default:
                                                break;
                                        }                                    case packet_end:                                                    // case for packed_end
                                        packetFlag = 0;                                                 // set the packetFlag to 0
                                        break;                                                          // break from loop
                                    default:                                                            // default if nothing matches
                                        break;                                                          // break from loop
                                }
                            }
                        default:                                                                        // defailt if nothing matches
                            break;                                                                      // break from loop
                    }
                default:                                                                                // default if nothing matches
                    break;                                                                              // break from loop
            }
        }
    }
}
