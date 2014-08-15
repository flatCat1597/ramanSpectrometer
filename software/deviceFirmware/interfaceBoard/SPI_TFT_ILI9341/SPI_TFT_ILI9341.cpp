/* mbed library for 240*320 pixel display TFT based on ILI9341 LCD Controller
 * Copyright (c) 2013 Peter Drescher - DC2PD
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
// 12.06.13 fork from SPI_TFT code because controller is different ...
// 14.07.13 Test with real display and bugfix 
// 18.10.13 Better Circle function from Michael Ammann
// 22.10.13 Fixes for Kinetis Board - 8 bit spi
// 26.01.14 Change interface for BMP_16 to also use SD-cards

#include "SPI_TFT_ILI9341.h"
#include "mbed.h"

#define BPP         16                  // Bits per pixel    
         
//extern Serial pc;
//extern DigitalOut xx;     // debug !!

SPI_TFT_ILI9341::SPI_TFT_ILI9341(PinName mosi, PinName miso, PinName sclk, PinName cs, PinName reset, PinName dc, const char *name)
    : _spi(mosi, miso, sclk), _cs(cs), _reset(reset), _dc(dc), GraphicsDisplay(name)
{
    clk = sclk;
    orientation = 0;
    char_x = 0;
    tft_reset();
}

int SPI_TFT_ILI9341::width()
{
    if (orientation == 0 || orientation == 2) return 240;
    else return 320;
}


int SPI_TFT_ILI9341::height()
{
    if (orientation == 0 || orientation == 2) return 320;
    else return 240;
}


void SPI_TFT_ILI9341::set_orientation(unsigned int o)
{
    orientation = o;
    wr_cmd(0x36);                     // MEMORY_ACCESS_CONTROL
    switch (orientation) {
        case 0:
            _spi.write(0x48);
            break;
        case 1:
            _spi.write(0x28);
            break;
        case 2:
            _spi.write(0x88);
            break;
        case 3:
            _spi.write(0xE8);
            break;
    }
    _cs = 1; 
    WindowMax();
} 


// write command to tft register

void SPI_TFT_ILI9341::wr_cmd(unsigned char cmd)
{
    _dc = 0;
    _cs = 0;
    _spi.write(cmd);      // mbed lib
    _dc = 1;
}



void SPI_TFT_ILI9341::wr_dat(unsigned char dat)
{
   _spi.write(dat);      // mbed lib
}



// the ILI9341 can read 

char SPI_TFT_ILI9341::rd_byte(unsigned char cmd)
{
    char r;
    _dc = 0;
    _cs = 0;
    _spi.write(cmd);      // mbed lib
    _cs = 1;
    r = _spi.write(0xff);
    _cs = 1;    
    return(r);
}

// read 32 bit
int SPI_TFT_ILI9341::rd_32(unsigned char cmd)
{
    int d;
    char r;
    _dc = 0;
    _cs = 0;
    d = cmd;
    d = d << 1;
    _spi.format(9,3);    // we have to add a dummy clock cycle
    _spi.write(d);
    _spi.format(8,3);   
    _dc = 1;
    r = _spi.write(0xff);
    d = r;
    r = _spi.write(0xff);
    d = (d << 8) | r;
    r = _spi.write(0xff);
    d = (d << 8) | r;
    r = _spi.write(0xff);
    d = (d << 8) | r;
    _cs = 1;    
    return(d);
}

int  SPI_TFT_ILI9341::Read_ID(void){
    int r;
    r = rd_byte(0x0A);
    r = rd_byte(0x0A);
    r = rd_byte(0x0A);
    r = rd_byte(0x0A);
    return(r);
}


// Init code based on MI0283QT datasheet

void SPI_TFT_ILI9341::tft_reset()
{
    _spi.format(8,3);                  // 8 bit spi mode 3
    _spi.frequency(10000000);          // 10 Mhz SPI clock
    _cs = 1;                           // cs high
    _dc = 1;                           // dc high 
    _reset = 0;                        // display reset

    wait_us(50);
    _reset = 1;                       // end hardware reset
    wait_ms(5);
     
    wr_cmd(0x01);                     // SW reset  
    wait_ms(5);
    wr_cmd(0x28);                     // display off  

    /* Start Initial Sequence ----------------------------------------------------*/
     wr_cmd(0xCF);                     
     _spi.write(0x00);
     _spi.write(0x83);
     _spi.write(0x30);
     _cs = 1;
     
     wr_cmd(0xED);                     
     _spi.write(0x64);
     _spi.write(0x03);
     _spi.write(0x12);
     _spi.write(0x81);
     _cs = 1;
     
     wr_cmd(0xE8);                     
     _spi.write(0x85);
     _spi.write(0x01);
     _spi.write(0x79);
     _cs = 1;
     
     wr_cmd(0xCB);                     
     _spi.write(0x39);
     _spi.write(0x2C);
     _spi.write(0x00);
     _spi.write(0x34);
     _spi.write(0x02);
     _cs = 1;
           
     wr_cmd(0xF7);                     
     _spi.write(0x20);
     _cs = 1;
           
     wr_cmd(0xEA);                     
     _spi.write(0x00);
     _spi.write(0x00);
     _cs = 1;
     
     wr_cmd(0xC0);                     // POWER_CONTROL_1
     _spi.write(0x26);
     _cs = 1;
 
     wr_cmd(0xC1);                     // POWER_CONTROL_2
     _spi.write(0x11);
     _cs = 1;
     
     wr_cmd(0xC5);                     // VCOM_CONTROL_1
     _spi.write(0x35);
     _spi.write(0x3E);
     _cs = 1;
     
     wr_cmd(0xC7);                     // VCOM_CONTROL_2
     _spi.write(0xBE);
     _cs = 1; 
     
     wr_cmd(0x36);                     // MEMORY_ACCESS_CONTROL
     _spi.write(0x48);
     _cs = 1; 
     
     wr_cmd(0x3A);                     // COLMOD_PIXEL_FORMAT_SET
     _spi.write(0x55);                 // 16 bit pixel 
     _cs = 1;
     
     wr_cmd(0xB1);                     // Frame Rate
     _spi.write(0x00);
     _spi.write(0x1B);               
     _cs = 1;
     
     wr_cmd(0xF2);                     // Gamma Function Disable
     _spi.write(0x08);
     _cs = 1; 
     
     wr_cmd(0x26);                     
     _spi.write(0x01);                 // gamma set for curve 01/2/04/08
     _cs = 1; 
     
     wr_cmd(0xE0);                     // positive gamma correction
     _spi.write(0x1F); 
     _spi.write(0x1A); 
     _spi.write(0x18); 
     _spi.write(0x0A); 
     _spi.write(0x0F); 
     _spi.write(0x06); 
     _spi.write(0x45); 
     _spi.write(0x87); 
     _spi.write(0x32); 
     _spi.write(0x0A); 
     _spi.write(0x07); 
     _spi.write(0x02); 
     _spi.write(0x07);
     _spi.write(0x05); 
     _spi.write(0x00);
     _cs = 1;
     
     wr_cmd(0xE1);                     // negativ gamma correction
     _spi.write(0x00); 
     _spi.write(0x25); 
     _spi.write(0x27); 
     _spi.write(0x05); 
     _spi.write(0x10); 
     _spi.write(0x09); 
     _spi.write(0x3A); 
     _spi.write(0x78); 
     _spi.write(0x4D); 
     _spi.write(0x05); 
     _spi.write(0x18); 
     _spi.write(0x0D); 
     _spi.write(0x38);
     _spi.write(0x3A); 
     _spi.write(0x1F);
     _cs = 1;
     
     WindowMax ();
     
     //wr_cmd(0x34);                     // tearing effect off
     //_cs = 1;
     
     //wr_cmd(0x35);                     // tearing effect on
     //_cs = 1;
      
     wr_cmd(0xB7);                       // entry mode
     _spi.write(0x07);
     _cs = 1;
     
     wr_cmd(0xB6);                       // display function control
     _spi.write(0x0A);
     _spi.write(0x82);
     _spi.write(0x27);
     _spi.write(0x00);
     _cs = 1;
     
     wr_cmd(0x11);                     // sleep out
     _cs = 1;
     
     wait_ms(100);
     
     wr_cmd(0x29);                     // display on
     _cs = 1;
     
     wait_ms(100);
     
 }


void SPI_TFT_ILI9341::pixel(int x, int y, int color)
{
    wr_cmd(0x2A);
    _spi.write(x >> 8);
    _spi.write(x);
    _cs = 1;
    wr_cmd(0x2B);
    _spi.write(y >> 8);
    _spi.write(y);
    _cs = 1;
    wr_cmd(0x2C);  // send pixel
    #if defined TARGET_KL25Z  // 8 Bit SPI
    _spi.write(color >> 8);
    _spi.write(color & 0xff);
    #else 
    _spi.format(16,3);                            // switch to 16 bit Mode 3
    _spi.write(color);                              // Write D0..D15
    _spi.format(8,3);
    #endif
    _cs = 1;
}


void SPI_TFT_ILI9341::window (unsigned int x, unsigned int y, unsigned int w, unsigned int h)
{
    wr_cmd(0x2A);
    _spi.write(x >> 8);
    _spi.write(x);
    _spi.write((x+w-1) >> 8);
    _spi.write(x+w-1);
    
    _cs = 1;
    wr_cmd(0x2B);
    _spi.write(y >> 8);
    _spi.write(y);
    _spi.write((y+h-1) >> 8);
    _spi.write(y+h-1);
    _cs = 1;
}


void SPI_TFT_ILI9341::WindowMax (void)
{
    window (0, 0, width(),  height());
}



void SPI_TFT_ILI9341::cls (void)
{
    int pixel = ( width() * height());
    WindowMax();
    wr_cmd(0x2C);  // send pixel
    #if defined TARGET_KL25Z  // 8 Bit SPI
    unsigned int i;
    for (i = 0; i < ( width() * height()); i++){
        _spi.write(_background >> 8);
        _spi.write(_background & 0xff);
        }
    
    #else 
    _spi.format(16,3);                            // switch to 16 bit Mode 3
    unsigned int i;
    for (i = 0; i < ( width() * height()); i++)
        _spi.write(_background);
    _spi.format(8,3);    
    #endif                         
    _cs = 1; 
}


void SPI_TFT_ILI9341::circle(int x0, int y0, int r, int color)
{

    int x = -r, y = 0, err = 2-2*r, e2;
    do {
        pixel(x0-x, y0+y,color);
        pixel(x0+x, y0+y,color);
        pixel(x0+x, y0-y,color);
        pixel(x0-x, y0-y,color);
        e2 = err;
        if (e2 <= y) {
            err += ++y*2+1;
            if (-x == y && e2 <= x) e2 = 0;
        }
        if (e2 > x) err += ++x*2+1;
    } while (x <= 0);

}

void SPI_TFT_ILI9341::fillcircle(int x0, int y0, int r, int color)
{
    int x = -r, y = 0, err = 2-2*r, e2;
    do {
        vline(x0-x, y0-y, y0+y, color);
        vline(x0+x, y0-y, y0+y, color);
        e2 = err;
        if (e2 <= y) {
            err += ++y*2+1;
            if (-x == y && e2 <= x) e2 = 0;
        }
        if (e2 > x) err += ++x*2+1;
    } while (x <= 0);
}


void SPI_TFT_ILI9341::hline(int x0, int x1, int y, int color)
{
    int w;
    w = x1 - x0 + 1;
    window(x0,y,w,1);
    wr_cmd(0x2C);  // send pixel
    #if defined TARGET_KL25Z  // 8 Bit SPI
    int j;
    for (j=0; j<w; j++) {
        _spi.write(color >> 8);
        _spi.write(color & 0xff);
    } 
    #else 
    _spi.format(16,3);                            // switch to 16 bit Mode 3
    int j;
    for (j=0; j<w; j++) {
        _spi.write(color);
    }
    _spi.format(8,3);
    #endif
    _cs = 1;
    WindowMax();
    return;
}

void SPI_TFT_ILI9341::vline(int x, int y0, int y1, int color)
{
    int h;
    h = y1 - y0 + 1;
    window(x,y0,1,h);
    wr_cmd(0x2C);  // send pixel
    #if defined TARGET_KL25Z  // 8 Bit SPI
    for (int y=0; y<h; y++) {
        _spi.write(color >> 8);
        _spi.write(color & 0xff);
    } 
    #else 
    _spi.format(16,3);                            // switch to 16 bit Mode 3
    for (int y=0; y<h; y++) {
        _spi.write(color);
    }
    _spi.format(8,3);
    #endif
    _cs = 1;
    WindowMax();
    return;
}



void SPI_TFT_ILI9341::line(int x0, int y0, int x1, int y1, int color)
{
    //WindowMax();
    int   dx = 0, dy = 0;
    int   dx_sym = 0, dy_sym = 0;
    int   dx_x2 = 0, dy_x2 = 0;
    int   di = 0;

    dx = x1-x0;
    dy = y1-y0;

    if (dx == 0) {        /* vertical line */
        if (y1 > y0) vline(x0,y0,y1,color);
        else vline(x0,y1,y0,color);
        return;
    }

    if (dx > 0) {
        dx_sym = 1;
    } else {
        dx_sym = -1;
    }
    if (dy == 0) {        /* horizontal line */
        if (x1 > x0) hline(x0,x1,y0,color);
        else  hline(x1,x0,y0,color);
        return;
    }

    if (dy > 0) {
        dy_sym = 1;
    } else {
        dy_sym = -1;
    }

    dx = dx_sym*dx;
    dy = dy_sym*dy;

    dx_x2 = dx*2;
    dy_x2 = dy*2;

    if (dx >= dy) {
        di = dy_x2 - dx;
        while (x0 != x1) {

            pixel(x0, y0, color);
            x0 += dx_sym;
            if (di<0) {
                di += dy_x2;
            } else {
                di += dy_x2 - dx_x2;
                y0 += dy_sym;
            }
        }
        pixel(x0, y0, color);
    } else {
        di = dx_x2 - dy;
        while (y0 != y1) {
            pixel(x0, y0, color);
            y0 += dy_sym;
            if (di < 0) {
                di += dx_x2;
            } else {
                di += dx_x2 - dy_x2;
                x0 += dx_sym;
            }
        }
        pixel(x0, y0, color);
    }
    return;
}


void SPI_TFT_ILI9341::rect(int x0, int y0, int x1, int y1, int color)
{

    if (x1 > x0) hline(x0,x1,y0,color);
    else  hline(x1,x0,y0,color);

    if (y1 > y0) vline(x0,y0,y1,color);
    else vline(x0,y1,y0,color);

    if (x1 > x0) hline(x0,x1,y1,color);
    else  hline(x1,x0,y1,color);

    if (y1 > y0) vline(x1,y0,y1,color);
    else vline(x1,y1,y0,color);

    return;
}



void SPI_TFT_ILI9341::fillrect(int x0, int y0, int x1, int y1, int color)
{

    int h = y1 - y0 + 1;
    int w = x1 - x0 + 1;
    int pixel = h * w;
    window(x0,y0,w,h);
    wr_cmd(0x2C);  // send pixel 
    #if defined TARGET_KL25Z  // 8 Bit SPI
    for (int p=0; p<pixel; p++) {
        _spi.write(color >> 8);
        _spi.write(color & 0xff);
    }
   #else
    _spi.format(16,3);                            // switch to 16 bit Mode 3
    for (int p=0; p<pixel; p++) {
        _spi.write(color);
    }
    _spi.format(8,3);
    #endif
    _cs = 1;
    WindowMax();
    return;
}


void SPI_TFT_ILI9341::locate(int x, int y)
{
    char_x = x;
    char_y = y;
}



int SPI_TFT_ILI9341::columns()
{
    return width() / font[1];
}



int SPI_TFT_ILI9341::rows()
{
    return height() / font[2];
}



int SPI_TFT_ILI9341::_putc(int value)
{
    if (value == '\n') {    // new line
        char_x = 0;
        char_y = char_y + font[2];
        if (char_y >= height() - font[2]) {
            char_y = 0;
        }
    } else {
        character(char_x, char_y, value);
    }
    return value;
}


void SPI_TFT_ILI9341::character(int x, int y, int c)
{
    unsigned int hor,vert,offset,bpl,j,i,b;
    unsigned char* zeichen;
    unsigned char z,w;

    if ((c < 31) || (c > 127)) return;   // test char range

    // read font parameter from start of array
    offset = font[0];                    // bytes / char
    hor = font[1];                       // get hor size of font
    vert = font[2];                      // get vert size of font
    bpl = font[3];                       // bytes per line

    if (char_x + hor > width()) {
        char_x = 0;
        char_y = char_y + vert;
        if (char_y >= height() - font[2]) {
            char_y = 0;
        }
    }
    window(char_x, char_y,hor,vert); // char box
    wr_cmd(0x2C);  // send pixel
    #ifndef TARGET_KL25Z  // 16 Bit SPI 
    _spi.format(16,3);   
    #endif                         // switch to 16 bit Mode 3
    zeichen = &font[((c -32) * offset) + 4]; // start of char bitmap
    w = zeichen[0];                          // width of actual char
     for (j=0; j<vert; j++) {  //  vert line
        for (i=0; i<hor; i++) {   //  horz line
            z =  zeichen[bpl * i + ((j & 0xF8) >> 3)+1];
            b = 1 << (j & 0x07);
            if (( z & b ) == 0x00) {
               #ifndef TARGET_KL25Z  // 16 Bit SPI 
                _spi.write(_background);
               #else
                _spi.write(_background >> 8);
                _spi.write(_background & 0xff);
                #endif
            } else {
                #ifndef TARGET_KL25Z  // 16 Bit SPI
                _spi.write(_foreground);
                #else
                _spi.write(_foreground >> 8);
                _spi.write(_foreground & 0xff);
                #endif
            }
        }
    }
    _cs = 1;
    #ifndef TARGET_KL25Z  // 16 Bit SPI
    _spi.format(8,3);
    #endif
    WindowMax();
    if ((w + 2) < hor) {                   // x offset to next char
        char_x += w + 2;
    } else char_x += hor;
}


void SPI_TFT_ILI9341::set_font(unsigned char* f)
{
    font = f;
}



void SPI_TFT_ILI9341::Bitmap(unsigned int x, unsigned int y, unsigned int w, unsigned int h,unsigned char *bitmap)
{
    unsigned int  j;
    int padd;
    unsigned short *bitmap_ptr = (unsigned short *)bitmap;
    #if defined TARGET_KL25Z  // 8 Bit SPI
        unsigned short pix_temp;
    #endif
    
    unsigned int i;
    
    // the lines are padded to multiple of 4 bytes in a bitmap
    padd = -1;
    do {
        padd ++;
    } while (2*(w + padd)%4 != 0);
    window(x, y, w, h);
    bitmap_ptr += ((h - 1)* (w + padd));
    wr_cmd(0x2C);  // send pixel
    #ifndef TARGET_KL25Z  // 16 Bit SPI 
    _spi.format(16,3);
    #endif                            // switch to 16 bit Mode 3
    for (j = 0; j < h; j++) {         //Lines
        for (i = 0; i < w; i++) {     // one line
            #if defined TARGET_KL25Z  // 8 Bit SPI
                pix_temp = *bitmap_ptr;
                _spi.write(pix_temp >> 8);
                _spi.write(pix_temp);
                bitmap_ptr++;
            #else
                _spi.write(*bitmap_ptr);    // one line
                bitmap_ptr++;
            #endif
        }
        bitmap_ptr -= 2*w;
        bitmap_ptr -= padd;
    }
    _cs = 1;
    #ifndef TARGET_KL25Z  // 16 Bit SPI 
    _spi.format(8,3);
    #endif
    WindowMax();
}


// local filesystem is not implemented in kinetis board , but you can add a SD card

int SPI_TFT_ILI9341::BMP_16(unsigned int x, unsigned int y, const char *Name_BMP)
{

#define OffsetPixelWidth    18
#define OffsetPixelHeigh    22
#define OffsetFileSize      34
#define OffsetPixData       10
#define OffsetBPP           28

    char filename[50];
    unsigned char BMP_Header[54];
    unsigned short BPP_t;
    unsigned int PixelWidth,PixelHeigh,start_data;
    unsigned int    i,off;
    int padd,j;
    unsigned short *line;

    // get the filename
    i=0;
    while (*Name_BMP!='\0') {
        filename[i++]=*Name_BMP++;
    }
    filename[i] = 0;  
    
    FILE *Image = fopen((const char *)&filename[0], "rb");  // open the bmp file
    if (!Image) {
        return(0);      // error file not found !
    }

    fread(&BMP_Header[0],1,54,Image);      // get the BMP Header

    if (BMP_Header[0] != 0x42 || BMP_Header[1] != 0x4D) {  // check magic byte
        fclose(Image);
        return(-1);     // error no BMP file
    }

    BPP_t = BMP_Header[OffsetBPP] + (BMP_Header[OffsetBPP + 1] << 8);
    if (BPP_t != 0x0010) {
        fclose(Image);
        return(-2);     // error no 16 bit BMP
    }

    PixelHeigh = BMP_Header[OffsetPixelHeigh] + (BMP_Header[OffsetPixelHeigh + 1] << 8) + (BMP_Header[OffsetPixelHeigh + 2] << 16) + (BMP_Header[OffsetPixelHeigh + 3] << 24);
    PixelWidth = BMP_Header[OffsetPixelWidth] + (BMP_Header[OffsetPixelWidth + 1] << 8) + (BMP_Header[OffsetPixelWidth + 2] << 16) + (BMP_Header[OffsetPixelWidth + 3] << 24);
    if (PixelHeigh > height() + y || PixelWidth > width() + x) {
        fclose(Image);
        return(-3);      // to big
    }

    start_data = BMP_Header[OffsetPixData] + (BMP_Header[OffsetPixData + 1] << 8) + (BMP_Header[OffsetPixData + 2] << 16) + (BMP_Header[OffsetPixData + 3] << 24);

    line = (unsigned short *) malloc (2 * PixelWidth); // we need a buffer for a line
    if (line == NULL) {
        return(-4);         // error no memory
    }

    // the bmp lines are padded to multiple of 4 bytes
    padd = -1;
    do {
        padd ++;
    } while ((PixelWidth * 2 + padd)%4 != 0);

    window(x, y,PixelWidth ,PixelHeigh);
    wr_cmd(0x2C);  // send pixel
    #ifndef TARGET_KL25Z // only 8 Bit SPI 
    _spi.format(16,3);  
    #endif                          // switch to 16 bit Mode 3
    for (j = PixelHeigh - 1; j >= 0; j--) {               //Lines bottom up
        off = j * (PixelWidth  * 2 + padd) + start_data;   // start of line
        fseek(Image, off ,SEEK_SET);
        fread(line,1,PixelWidth * 2,Image);       // read a line - slow 
        for (i = 0; i < PixelWidth; i++) {        // copy pixel data to TFT
        #ifndef TARGET_KL25Z // only 8 Bit SPI
            _spi.write(line[i]);                  // one 16 bit pixel
        #else  
            _spi.write(line[i] >> 8);
            _spi.write(line[i]);
        #endif    
        } 
     }
    _cs = 1;
    _spi.format(8,3);
    free (line);
    fclose(Image);
    WindowMax();
    return(1);
}
