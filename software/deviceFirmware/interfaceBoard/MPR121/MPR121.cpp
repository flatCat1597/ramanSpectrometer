/**
 * @file    MPR121.cpp
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

#include "MPR121.h"
#include "mbed_debug.h"

#define DEBUG 1
    
MPR121::MPR121(I2C &i2c, InterruptIn &pin, MPR121_ADDR i2c_addr)
{
    _i2c = &i2c;
    _irq = &pin;
    _i2c_addr = (i2c_addr << 1);
    
    return;
}

void MPR121::init(void)
{
    // set the i2c speed
    _i2c->frequency(400000);
    // irq is open-collector and active-low
    _irq->mode(PullUp);
    
    // setup and registers - start with POR values (must be in stop mode)
    MPR121::writeRegister(SRST, 0x63); //REG 0x80
    
    // Baseline Filtering Control Register (changes response sensitivity)
    // http://cache.freescale.com/files/sensors/doc/app_note/AN3891.pdf
    MPR121::writeRegister(MHDR, 0x1);  //REG 0x2B
    MPR121::writeRegister(NHDR, 0x1);  //REG 0x2C
    MPR121::writeRegister(NCLR, 0x0);  //REG 0x2D
    MPR121::writeRegister(FDLR, 0x0);  //REG 0x2E
    MPR121::writeRegister(MHDF, 0x1);  //REG 0x2F
    MPR121::writeRegister(NHDF, 0x1);  //REG 0x30
    MPR121::writeRegister(NCLF, 0xFF); //REG 0x31
    MPR121::writeRegister(FDLF, 0x2);  //REG 0x32
    
    // Touch / Release Threshold
    // cache.freescale.com/files/sensors/doc/app_note/AN3892.pdf
    for(int i=0; i<(12*2); i+=2) // touch
    {
        MPR121::writeRegister(static_cast<MPR121_REGISTER>(E0TTH+i), 0x20); //REG 0x41...0x58 odd
    }
    for(int i=0; i<(12*2); i+=2) // release
    {
        MPR121::writeRegister(static_cast<MPR121_REGISTER>(E0RTH+i), 0x10); //REG 0x41...0x58 even
    }
    
    // Debounce Register DR=b6...4, DT=b2...0
    MPR121::writeRegister(DT_DR, 0x11); //REG 0x5B
    
    // Filter and Global CDC CDT Configuration (sample time, charge current)
    MPR121::writeRegister(CDC_CONFIG, 0x10); //REG 0x5C default 10
    MPR121::writeRegister(CDT_CONFIG, 0x20); //REG 0x5D default 24
    
    // Auto-Configuration Registers
    // http://cache.freescale.com/files/sensors/doc/app_note/AN3889.pdf
    MPR121::writeRegister(AUTO_CFG0, 0x33); // REG 0x7B
    MPR121::writeRegister(AUTO_CFG1, 0x07); // REG 0x7C
    MPR121::writeRegister(USL, 0xc9);       // REG 0x7D((3.3-.07)/3.3) * 256
    MPR121::writeRegister(LSL, 0x83);       // REG 0x7E((3.3-.07)/3.3) * 256 * 0.65f
    MPR121::writeRegister(TL,  0xb5);       // REG 0x7F((3.3-.07)/3.3) * 256 * 0.9f
    // 255 > USL > TL > LSL > 0
    
    // Electrode Configuration Register - enable all 12 and start
    MPR121::writeRegister(ECR, 0x8f);
    
    return;
}

void MPR121::enable(void)
{
    _button = 0;
    _button_has_changed = 0;
    // enable the 12 electrodes - allow disable to put device into
    //  lower current consumption mode
    MPR121::writeRegister(ECR, 0x8f);
    // and attach the interrupt handler
    _irq->fall(this, &MPR121::handler);
    
    return;
}

void MPR121::disable(void)
{
    // detach the interrupt handler
    _irq->fall(NULL);
    _button = 0;
    _button_has_changed = 0;
    //  put the device in low current consumption mode - dont re-init registers
    MPR121::writeRegister(ECR, 0x0);
    MPR121::writeRegister(AUTO_CFG0, 0x0); // REG 0x7B
    MPR121::writeRegister(AUTO_CFG1, 0x0); // REG 0x7C
    
    return;
}

uint32_t MPR121::isPressed(void)
{
    return _button_has_changed;
}

uint16_t MPR121::buttonPressed(void)
{
    _button_has_changed = 0;
    return _button;
}

void MPR121::registerDump(Serial &obj) const
{
    uint8_t reg_val = 0;
    
    for(int i=0; i<0x80; i++)
    {
        reg_val = MPR121::readRegister(static_cast<MPR121_REGISTER>(i));
        obj.printf("Reg 0x%02x: 0x%02x \n", i, reg_val);
    }
    
    return;
}

void MPR121::handler(void)
{
    uint16_t reg_val = 0, oor_val = 0;
    // read register 0 and 1
    reg_val  = MPR121::readRegister(ELE0_7_STAT);
    reg_val |= MPR121::readRegister(ELE8_11_STAT) << 8;
    // 2 and 3
    oor_val  = MPR121::readRegister(ELE0_7_OOR_STAT);
    oor_val |= MPR121::readRegister(ELE8_11_OOR_STAT) << 8;
    
    // debugging stuff and errors - if OOR fails someone was touching the pad during auto-config
    //  Just reboot until they're not doing this
    if((0 != oor_val) && DEBUG)
    {
        debug("MPR121 OOR failure - 0x%04x\n", oor_val);
        wait(0.1f);
        NVIC_SystemReset();
    }
   
    _button = reg_val;
    _button_has_changed = 1;
    
    return;
}

void MPR121::writeRegister(MPR121_REGISTER const reg, uint8_t const data) const
{
    char buf[2] = {reg, data};
    uint8_t result = 0;
    
    result = _i2c->write(_i2c_addr, buf, 2);
    
    if(result && DEBUG)
    {
        debug("I2C write failed\n");
    }
    
    return;
}

uint8_t MPR121::readRegister(MPR121_REGISTER const reg) const
{
    char buf[1] = {reg}, data = 0;
    uint8_t result = 1;
    
    result &= _i2c->write(_i2c_addr, buf, 1, true);
    result &= _i2c->read(_i2c_addr, &data, 1); 
    
    if(result && DEBUG)
    {
        debug("I2C read failed\n");
    }
    
    return data;
}
