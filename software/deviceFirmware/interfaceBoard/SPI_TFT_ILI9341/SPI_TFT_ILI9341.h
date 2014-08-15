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
 
 /* change the char position handling
  * use pixel (x,y) instadt of colum row */
 

#ifndef MBED_SPI_TFT_ILI9341_H
#define MBED_SPI_TFT_ILI9341_H

#include "mbed.h"
#include "GraphicsDisplay.h"

#define RGB(r,g,b)  (((r&0xF8)<<8)|((g&0xFC)<<3)|((b&0xF8)>>3)) //5 red | 6 green | 5 blue


/* some RGB color definitions                                                 */
#define Black           0x0000      /*   0,   0,   0 */
#define Navy            0x000F      /*   0,   0, 128 */
#define DarkGreen       0x03E0      /*   0, 128,   0 */
#define DarkCyan        0x03EF      /*   0, 128, 128 */
#define Maroon          0x7800      /* 128,   0,   0 */
#define Purple          0x780F      /* 128,   0, 128 */
#define Olive           0x7BE0      /* 128, 128,   0 */
#define LightGrey       0xC618      /* 192, 192, 192 */
#define DarkGrey        0x7BEF      /* 128, 128, 128 */
#define Blue            0x001F      /*   0,   0, 255 */
#define Green           0x07E0      /*   0, 255,   0 */
#define Cyan            0x07FF      /*   0, 255, 255 */
#define Red             0xF800      /* 255,   0,   0 */
#define Magenta         0xF81F      /* 255,   0, 255 */
#define Yellow          0xFFE0      /* 255, 255,   0 */
#define White           0xFFFF      /* 255, 255, 255 */
#define Orange          0xFD20      /* 255, 165,   0 */
#define GreenYellow     0xAFE5      /* 173, 255,  47 */


/** Display control class, based on GraphicsDisplay and TextDisplay
 *
 * Example:
 * @code
 * #include "stdio.h"
 * #include "mbed.h"
 * #include "SPI_TFT_ILI9341.h"
 * #include "string"
 * #include "Arial12x12.h"
 * #include "Arial24x23.h"
 * 
 *
 *
 * // the TFT is connected to SPI pin 5-7 and IO's 8-10
 * SPI_TFT_ILI9341 TFT(p5, p6, p7, p8, p9, p10,"TFT"); // mosi, miso, sclk, cs, reset, dc
 * If your display need a signal for switch the backlight use a aditional IO pin in your program 
 *
 * int main() {
 *     TFT.claim(stdout);      // send stdout to the TFT display 
 *     //TFT.claim(stderr);      // send stderr to the TFT display
 *
 *     TFT.background(Black);    // set background to black
 *     TFT.foreground(White);    // set chars to white
 *     TFT.cls();                // clear the screen
 *     TFT.set_font((unsigned char*) Arial12x12);  // select the font
 *     
 *     TFT.set_orientation(0);
 *     printf("  Hello Mbed 0");
 *     TFT.set_font((unsigned char*) Arial24x23);  // select font 2
 *     TFT.locate(48,115);
 *     TFT.printf("Bigger Font");
 *  }
 * @endcode
 */
 class SPI_TFT_ILI9341 : public GraphicsDisplay {
 public:

  /** Create a SPI_TFT object connected to SPI and three pins
   *
   * @param mosi pin connected to SDO of display
   * @param miso pin connected to SDI of display
   * @param sclk pin connected to RS of display 
   * @param cs pin connected to CS of display
   * @param reset pin connected to RESET of display
   * @param dc pin connected to WR of display
   * the IM pins have to be set to 1110 (3-0) 
   */ 
  SPI_TFT_ILI9341(PinName mosi, PinName miso, PinName sclk, PinName cs, PinName reset, PinName dc, const char* name ="TFT");
    
  /** Get the width of the screen in pixel
   *
   * @returns width of screen in pixel
   *
   */    
  virtual int width();

  /** Get the height of the screen in pixel
   *
   * @returns height of screen in pixel 
   *
   */     
  virtual int height();
    
  /** Draw a pixel at x,y with color 
   *  
   * @param x horizontal position
   * @param y vertical position
   * @param color 16 bit pixel color
   */    
  virtual void pixel(int x, int y,int colour);
    
  /** draw a circle
   *
   * @param x0,y0 center
   * @param r radius
   * @param color 16 bit color                                                                 *
   *
   */    
  void circle(int x, int y, int r, int colour); 
  
  /** draw a filled circle
   *
   * @param x0,y0 center
   * @param r radius
   * @param color 16 bit color                                                                 *
   */    
  void fillcircle(int x, int y, int r, int colour); 
 
    
  /** draw a 1 pixel line
   *
   * @param x0,y0 start point
   * @param x1,y1 stop point
   * @param color 16 bit color
   *
   */    
  void line(int x0, int y0, int x1, int y1, int colour);
    
  /** draw a rect
   *
   * @param x0,y0 top left corner
   * @param x1,y1 down right corner
   * @param color 16 bit color
   *                                                   *
   */    
  void rect(int x0, int y0, int x1, int y1, int colour);
    
  /** draw a filled rect
   *
   * @param x0,y0 top left corner
   * @param x1,y1 down right corner
   * @param color 16 bit color
   *
   */    
  void fillrect(int x0, int y0, int x1, int y1, int colour);
    
  /** setup cursor position
   *
   * @param x x-position (top left)
   * @param y y-position 
   */   
  virtual void locate(int x, int y);
    
  /** Fill the screen with _backgroun color
   *
   */   
  virtual void cls (void);   
    
  /** calculate the max number of char in a line
   *
   * @returns max columns
   * depends on actual font size
   *
   */    
  virtual int columns(void);
    
  /** calculate the max number of columns
   *
   * @returns max column
   * depends on actual font size
   *
   */   
  virtual int rows(void);
    
  /** put a char on the screen
   *
   * @param value char to print
   * @returns printed char
   *
   */
  virtual int _putc(int value);
    
  /** draw a character on given position out of the active font to the TFT
   *
   * @param x x-position of char (top left) 
   * @param y y-position
   * @param c char to print
   *
   */    
  virtual void character(int x, int y, int c);
    
  /** paint a bitmap on the TFT 
   *
   * @param x,y : upper left corner 
   * @param w width of bitmap
   * @param h high of bitmap
   * @param *bitmap pointer to the bitmap data
   *
   *   bitmap format: 16 bit R5 G6 B5
   * 
   *   use Gimp to create / load , save as BMP, option 16 bit R5 G6 B5            
   *   use winhex to load this file and mark data stating at offset 0x46 to end
   *   use edit -> copy block -> C Source to export C array
   *   paste this array into your program
   * 
   *   define the array as static const unsigned char to put it into flash memory
   *   cast the pointer to (unsigned char *) :
   *   tft.Bitmap(10,40,309,50,(unsigned char *)scala);
   */    
  void Bitmap(unsigned int x, unsigned int y, unsigned int w, unsigned int h,unsigned char *bitmap);
    
    
   /** paint a 16 bit BMP from filesytem on the TFT (slow) 
   *
   * @param x,y : position of upper left corner 
   * @param *Name_BMP name of the BMP file with drive: "/local/test.bmp"
   *
   * @returns 1 if bmp file was found and painted
   * @returns  0 if bmp file was found not found
   * @returns -1 if file is no bmp
   * @returns -2 if bmp file is no 16 bit bmp
   * @returns -3 if bmp file is to big for screen 
   * @returns -4 if buffer malloc go wrong
   *
   *   bitmap format: 16 bit R5 G6 B5
   * 
   *   use Gimp to create / load , save as BMP, option 16 bit R5 G6 B5
   *   copy to internal file system or SD card           
   */      
    
  int BMP_16(unsigned int x, unsigned int y, const char *Name_BMP);  
    
    
    
  /** select the font to use
   *
   * @param f pointer to font array 
   *                                                                              
   *   font array can created with GLCD Font Creator from http://www.mikroe.com
   *   you have to add 4 parameter at the beginning of the font array to use: 
   *   - the number of byte / char
   *   - the vertial size in pixel
   *   - the horizontal size in pixel
   *   - the number of byte per vertical line
   *   you also have to change the array to char[]
   *
   */  
  void set_font(unsigned char* f);
   
  /** Set the orientation of the screen
   *  x,y: 0,0 is always top left 
   *
   * @param o direction to use the screen (0-3)  
   *
   */  
  void set_orientation(unsigned int o);
  
  
  /** read out the manufacturer ID of the LCD
   *  can used for checking the connection to the display
   *  @returns ID
   */ 
  int Read_ID(void);
  
  
    
  SPI _spi;
  DigitalOut _cs; 
  DigitalOut _reset;
  DigitalOut _dc;
  unsigned char* font;
  
  
  
   
protected:

  /** Set draw window region to whole screen
   *
   */  
  void WindowMax (void);


  /** draw a horizontal line
   *
   * @param x0 horizontal start
   * @param x1 horizontal stop
   * @param y vertical position
   * @param color 16 bit color                                               
   *
   */
  void hline(int x0, int x1, int y, int colour);
    
  /** draw a vertical line
   *
   * @param x horizontal position
   * @param y0 vertical start 
   * @param y1 vertical stop
   * @param color 16 bit color
   */
  void vline(int y0, int y1, int x, int colour);
    
  /** Set draw window region
   *
   * @param x horizontal position
   * @param y vertical position
   * @param w window width in pixel
   * @param h window height in pixels
   */    
  virtual void window (unsigned int x,unsigned int y, unsigned int w, unsigned int h);
    
 
    
  /** Init the ILI9341 controller 
   *
   */    
  void tft_reset();
    
   /** Write data to the LCD controller
   *
   * @param dat data written to LCD controller
   * 
   */   
  //void wr_dat(unsigned int value);
  void wr_dat(unsigned char value);
    
  /** Write a command the LCD controller 
   *
   * @param cmd: command to be written   
   *
   */   
  void wr_cmd(unsigned char value);
    
   /** Start data sequence to the LCD controller
   * 
   */   
  //void wr_dat_start();
    
  /** Stop of data writing to the LCD controller
   *   
   */  
  //void wr_dat_stop();
    
  /** write data to the LCD controller
   *
   * @param data to be written 
   *                                           *
   */    
  //void wr_dat_only(unsigned short dat);
    
  /** Read byte from the LCD controller
   *
   * @param cmd comand to controller
   * @returns data from LCD controller
   *  
   */    
   char rd_byte(unsigned char cmd);
    
  
  int rd_32(unsigned char cmd);  
    
    
  /** Write a value to the to a LCD register
   *
   * @param reg register to be written
   * @param val data to be written
   */   
  //void wr_reg (unsigned char reg, unsigned char val);
    
  /** Read a LCD register
   *
   * @param reg register to be read
   * @returns value of the register 
   */    
  //unsigned short rd_reg (unsigned char reg);
    
  unsigned char spi_port; 
  unsigned int orientation;
  unsigned int char_x;
  unsigned int char_y;
  PinName clk;
 
    
};

#endif
