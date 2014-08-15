#include "mbed.h"

//  ***   BE SURE TO TEST BEFORE AND AFTER FOR 'IDLING'... CLEAR THE CCD EVERY OTHER FRAME TO TRY AND ELIMINATE NOISE BUILDUP
//From http://www.ing.iac.es/~docs/ins/das/ins-das-29/integration.html
//"Idling" vs. integrating
//Charge from light leaks and thermal noise builds up on the detector between observations. If this charge is integrated by the detector, it may not be completely
//cleared away by the clear cycle of the next observation. In that case, the observation will be contaminated by extra counts. (Often, this appears as a ramp in the
//background leading up to a saturated region in the low-numbered rows.)
//To avoid this problem, the detector is made to clear itself continuously between observations. This is called "idling", and is reported as such on the mimic.

PwmOut shiftGate(PB_8);
PwmOut icg(PB_3);
PwmOut masterClock(PB_4);
AnalogIn imageIn(A0);
AnalogOut imageOut(A5);
DigitalOut myled(LED1);
Serial raspi(USBTX, USBRX);

int masterFreq_period = 2;      //microseconds
int masterFreq_width  = 1;      //microseconds
int icgFreq_period    = 500000; //microseconds
int icgFreq_width     = 250000; //microseconds    <------------- LOWER THIS NUMBER TO INCREASE SENSITIVITY
int shiftGate_delay   = 287;    //microseconds
int shiftGate_period  = 200;    //microseconds
int shiftGate_width   = 100;    //microseconds

#define MV(x) ((0xFFF*x)/3300)

int main()
{
    // set the masterClock
    masterClock.period_us(masterFreq_period);
    masterClock.pulsewidth_us(masterFreq_width);

    // set the ICG clock and have it start 82.76ms after the shiftGate - this will sync the clocks up so the ICQ is going low slightly before the shiftGate is going high
    icg.period_us(icgFreq_period);
    icg.pulsewidth_us(icgFreq_width);  //          <------------- LOWER THIS NUMBER TO INCREASE SENSITIVITY

    // set the shiftGate and have it start 15us after the masterClock - this will sync the clocks up so the shiftGate is going high just as a clock cycle is going high
    wait_us(shiftGate_delay);
    shiftGate.period_us(shiftGate_period);
    shiftGate.pulsewidth_us(shiftGate_width);

    raspi.baud(921600);
    // do something while it's having fun..
    while(1) {
//        wait(.0001);
//        uint16_t meas = imageIn.read_u16();
//        if (meas < MV(1000)) {
//            myled = 1;
//            printf("BINGO: %d \r\n", meas);
//        }
//        myled = 0;
        imageOut.write(imageIn.read());
    }
}

