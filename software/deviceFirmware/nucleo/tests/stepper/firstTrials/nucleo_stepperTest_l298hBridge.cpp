#include "mbed.h"

const int motorwait=5;

DigitalIn button(USER_BUTTON);
DigitalOut ledPin(LED1);
DigitalOut motorPin1(D2);
DigitalOut motorPin2(D3);
DigitalOut motorPin3(D4);
DigitalOut motorPin4(D5);


int big()
{
    while(1) {
        wait_ms(1);
        ledPin = !ledPin;
        motorPin1 = 0;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 1;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 1;
        motorPin4= 1;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 1;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 1;
        motorPin3= 1;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 1;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 1;
        motorPin2= 1;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 1;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 1;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 1;
        wait_ms(motorwait);
    }
}

int small(int dir)
{
    if (dir == 1) {
        ledPin = !ledPin;
        motorPin1= 1;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 1;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 1;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 1;
        wait_ms(motorwait);
    }
    if (dir == 0) {
        ledPin = !ledPin;
        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 1;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 0;
        motorPin3= 1;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 0;
        motorPin2= 1;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);

        motorPin1= 1;
        motorPin2= 0;
        motorPin3= 0;
        motorPin4= 0;
        wait_ms(motorwait);
    }
    return 0;
}

int main()
{
    while(1) {
        int c=0;
        int z=0;
        while (c < 75) {
            c++;
            small(1);
        }
        c=0;
        while (z < 75) {
            z++;
            small(0);
        }
        z=0;
    }
}

