/**
 * @file    MPR121.h
 * @brief   Device driver - MPR121 capactiive touch IC
 * @author  sam grove
 * @version 1.0
 * @see     http://cache.freescale.com/files/sensors/doc/data_sheet/MPR121.pdf
 *
 * Copyright (c) 2013
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
#ifndef MPR121_H
#define MPR121_H

#include "mbed.h"

/** Using the Sparkfun SEN-10250 BoB
 *
 * Example:
 * @code
 *  #include "mbed.h"
 *  #include "MPR121.h"
 *  
 *  Serial pc(USBTX, USBRX);
 *  DigitalOut myled(LED1);
 *  
 *  #if defined TARGET_LPC1768 || TARGET_LPC11U24
 *    I2C i2c(p28, p27);
 *    InterruptIn irq(p26);
 *    MPR121 touch_pad(i2c, irq, MPR121::ADDR_VSS);
 *  
 *  #elif defined TARGET_KL25Z
 *    I2C i2c(PTC9, PTC8);
 *    InterruptIn irq(PTA5);
 *    MPR121 touch_pad(i2c, irq, MPR121::ADDR_VSS);
 *  
 *  #else
 *    #error TARGET NOT TESTED
 *  #endif
 *  
 *  int main()  
 *  {       
 *      touch_pad.init();
 *      touch_pad.enable();
 *      
 *      while(1)
 *      {
 *          if(touch_pad.isPressed())
 *          {
 *              uint16_t button_val = touch_pad.buttonPressed();
 *              printf("button = 0x%04x\n", button_val);
 *              myled = (button_val>0) ? 1 : 0;
 *          }            
 *      }
 *  }
 * @endcode
 */

/**
 *  @class MPR121
 *  @brief API for the MPR121 capacitive touch IC
 */ 
class MPR121
{
private:
    
    I2C         *_i2c;
    InterruptIn *_irq;
    uint8_t      _i2c_addr;
    volatile uint16_t _button;
    volatile uint32_t _button_has_changed;
    
    /** The interrupt handler for the IRQ pin
     */
    void handler(void);

public:
    
    /**
     *  @enum MPR121_ADDR
     *  @brief Possible terminations for the ADDR pin
     */ 
    enum MPR121_ADDR
    { 
        ADDR_VSS = 0x5A, /*!< ADDR connected to VSS */
        ADDR_VDD,    /*!< ADDR connected to VDD */
        ADDR_SCL,    /*!< ADDR connected to SDA */
        ADDR_SDA     /*!< ADDR connected to SCL */
    };
    
    /**
     *  @enum MPR121_REGISTER
     *  @brief The device register map
     */
    enum MPR121_REGISTER
    {
        ELE0_7_STAT = 0x00,
        ELE8_11_STAT, ELE0_7_OOR_STAT, ELE8_11_OOR_STAT, EFD0LB, EFD0HB, 
        EFD1LB, EFD1HB, EFD2LB, EFD2HB, EFD3LB, EFD3HB, EFD4LB, EFD4HB, EFD5LB, EFD5HB,
        
        EFD6LB = 0x10,
        EFD6HB, EFD7LB, EFD7HB, EFD8LB, EFD8HB, EFD9LB, EFD9HB, EFD10LB,
        EFD10HB, EFD11LB, EFD11HB, EFDPROXLB, EFDPROXHB, E0BV, E1BV,
        
        E2BV = 0x20,
        E3BV, E4BV, E5BV, E6BV, E7BV, E8BV, E9BV, E10BV, E11BV, EPROXBV,
        MHDR, NHDR, NCLR, FDLR, MHDF, 
        
        NHDF = 0x30,
        NCLF, FDLF, NHDT, NCLT, FDLT, MHDPROXR, NHDPROXR, NCLPROXR,
        FDLPROXR, MHDPROXF, NHDPROXF, NCLPROXF, FDLPROXF, NHDPROXT, NCLPROXT,
        
        FDLPROXT = 0x40,
        E0TTH, E0RTH, E1TTH, E1RTH, E2TTH, E2RTH, E3TTH, E3RTH,
        E4TTH, E4RTH, E5TTH, E5RTH, E6TTH, E6RTH, E7TTH,
        
        E7RTH = 0x50,
        E8TTH, E8RTH, E9TTH, E9RTH, E10TTH, E10RTH, E11TTH, E11RTH,
        EPROXTTH, EPROXRTH, DT_DR, CDC_CONFIG, CDT_CONFIG, ECR, CDC0,
        
        CDC1 = 0x60,
        CDC2, CDC3, CDC4, CDC5, CDC6, CDC7, CDC8, CDC9, CDC10, CDC11, CDCPROX, CDT0_CDT1,
        CDT2_CDT3, CDT4_CDT5, CDT6_CDT7, 
        
        CDT8_CDT9 = 0x70,
        CDT10_CDT11, CDTPROX, GPIO_CTRL0, GPIO_CTRL1, GPIO_DATA, GPIO_DIR, GPIO_EN, GPIO_SET,
        GPIO_CLR, GPIO_TOGGLE, AUTO_CFG0, AUTO_CFG1, USL, LSL, TL,
        
        SRST = 0x80
    };
    
    /** Create the MPR121 object
     *  @param i2c - A defined I2C object
     *  @param pin - A defined InterruptIn object
     *  @param i2c_addr - Connection of the address line
     */    
    MPR121(I2C &i2c, InterruptIn &pin, MPR121_ADDR i2c_addr);
    
    /** Clear state variables and initilize the dependant objects
     */
    void init(void);
    
    /** Allow the IC to run and collect user input
     */
    void enable(void);
    
    /** Stop the IC and put into low power mode
     */
    void disable(void);
    
    /** Determine if a new button press event occured
     *  Upon calling the state is cleared until another press is detected
     *  @return 1 if a press has been detected since the last call, 0 otherwise
     */
    uint32_t isPressed(void);
    
    /** Get the electrode status (ELE12 ... ELE0 -> b15 xxx b11 ... b0
     *  The buttons are bit mapped. ELE0 = b0 ... ELE11 = b11 b12 ... b15 undefined
     *  @return The state of all buttons
     */
    uint16_t buttonPressed(void);
    
    /** print the register map and values to the console
     *  @param obj - a Serial object that prints to a console
     */
    void registerDump(Serial &obj) const;
    
    /** Write to a register (exposed for debugging reasons)
     *  Note: most writes are only valid in stop mode
     *  @param reg - The register to be written
     *  @param data - The data to be written
     */
    void writeRegister(MPR121_REGISTER const reg, uint8_t const data) const;
    
    /** Read from a register (exposed for debugging reasons)
     *  @param reg - The register to read from
     *  @return The register contents
     */
    uint8_t readRegister(MPR121_REGISTER const reg) const;
    
};

#endif
