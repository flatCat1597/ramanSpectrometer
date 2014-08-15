#include "stdio.h"
#include "mbed.h"
#include "SPI_TFT_ILI9341.h"
#include "string"
#include "Arial12x12.h"
#include "Arial24x23.h"
#include "Arial28x28.h"
#include "font_big.h"
#include "MPR121.h"

I2C i2c(PB_9, PB_8);
InterruptIn irq(PC_8);
MPR121 touch_pad(i2c, irq, MPR121::ADDR_VSS);

extern unsigned char p1[];  // the mbed logo graphic
DigitalOut LCD_LED(D7);
DigitalOut led1(LED1);

SPI_TFT_ILI9341 TFT(D11, D12, D13, D8, D9, D10,"TFT"); // mosi, miso, sclk, cs, reset, dc

Serial raspi(USBTX, USBRX);

int splashScreen()
{
    double s;
    int i;

    TFT.set_orientation(1);
    TFT.background(Black);
    TFT.foreground(White);
    TFT.cls();

    TFT.set_orientation(0);
    TFT.background(Black);
    TFT.cls();

    TFT.set_orientation(1);
    for (i=0; i<320; i++) {
        s =40 * sin((long double) i / 10 );
        TFT.pixel(i+s,180 + (int)s+(s-i) ,Red);
    }

    for (i=0; i<320; i++) {
        s =40 * sin((long double) i / 10 );
        TFT.pixel(i,180 + (int)s+(s-i) ,Green);
    }

    for (i=0; i<320; i++) {
        s =40 * sin((long double) i / 10 );
        TFT.pixel(i-s,180 + (int)s+(s-i) ,Blue);
    }
    TFT.rect(0,0,320,240,Blue);
    TFT.set_font((unsigned char*) Neu42x35);
    TFT.locate(20,70);
    TFT.printf("meridian"); 
    TFT.locate(110,100);
    TFT.printf("Scientific");
    TFT.set_font((unsigned char*) Arial24x23);
    TFT.locate(30,140);
    TFT.printf("ramanSpectrometer");
    TFT.set_font((unsigned char*) Arial12x12);
    TFT.locate(160,165);
    printf("version0.1a (2014)");
    TFT.foreground(DarkGrey);
    TFT.locate(5,225);
    printf("http://www.meridian-scientific.com");
    return 0;
}

int startupScreen()
{
    TFT.foreground(White);
    TFT.background(Blue);
    TFT.cls();
    TFT.set_font((unsigned char*) Arial24x23);
    TFT.locate(0,0);
    TFT.printf("meridianScientific");
    TFT.locate(0,20);
    TFT.printf("ramanSpectrometer");
    TFT.foreground(Green);
    TFT.set_font((unsigned char*) Arial12x12);
    TFT.locate(0,50);
    printf("> version0.1a (2014)");
    TFT.locate(0,65);
    printf("> system initialization...");
    TFT.locate(10,80);
    printf("waiting for raspiComm..");
    return 0;
}

int shit()
{
    TFT.foreground(White);
    TFT.background(Blue);
    TFT.cls();
    TFT.set_font((unsigned char*) Arial24x23);
    TFT.locate(0,0);
    TFT.printf("meridianScientific");
    TFT.locate(0,20);
    TFT.printf("ramanSpectrometer");
    TFT.foreground(Green);
    TFT.set_font((unsigned char*) Arial12x12);
    return 0;
}

int setScr(){
        TFT.foreground(White);
    TFT.background(Blue);
    TFT.cls();
    TFT.set_font((unsigned char*) Neu42x35);
}

int main()
{
    LCD_LED = 1;

    TFT.claim(stdout);

    touch_pad.init();
    touch_pad.enable();
    touch_pad.registerDump(raspi);

    splashScreen();
    wait(5);
    startupScreen();

    while(1) {
        led1=0;
        if(touch_pad.isPressed()) {
            uint16_t button_val = touch_pad.buttonPressed();
            led1 = (button_val>0) ? 1 : 0;
            raspi.printf("button = 0x%04x\r\n", button_val);
            switch (button_val) {
                case 0:
                    break;
                case 1:
                    setScr();
                    TFT.locate(20,70);
                    TFT.printf("UP"); 
                    TFT.locate(110,100);
                    TFT.printf("ARROW");
                    break;
                case 2:
                    setScr();
                    TFT.locate(20,70);
                    TFT.printf("RIGHT"); 
                    TFT.locate(110,100);
                    TFT.printf("ARROW");
                    break;
                case 4:
                    setScr();
                    TFT.locate(20,70);
                    TFT.printf("DOWN"); 
                    TFT.locate(110,100);
                    TFT.printf("ARROW");
                    break;
                case 8:
                    setScr();
                    TFT.locate(20,70);
                    TFT.printf("LEFT"); 
                    TFT.locate(110,100);
                    TFT.printf("ARROW");
                    break;
                case 16:
                    startupScreen();
                    TFT.locate(20,120);
                    TFT.printf("5");
                    break;
                case 32:
                    startupScreen();
                    TFT.locate(30,120);
                    TFT.printf("6");
                    break;
                case 64:
                    startupScreen();
                    TFT.locate(10,130);
                    TFT.printf("7");
                    break;
                case 128:
                    startupScreen();
                    TFT.locate(20,130);
                    TFT.printf("8");
                    break;
                case 256:
                    startupScreen();
                    TFT.locate(30,130);
                    TFT.printf("9");
                    break;
                default:
                    break;
            }

        }
    }
}
