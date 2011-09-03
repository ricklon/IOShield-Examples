
#include <IOShieldOled.h>

#define HEIGHT 32
#define WIDTH 128
#define CUBESIZE 4

void setup()
{
  Serial.begin(9600);
  IOShieldOled.begin();

}

void loop()
{
     
  int ix;
  int iy;

  //Clear the virtual buffer
  IOShieldOled.clearBuffer();
  //IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
  //q: With automatic update on, does it check if draw is needed or not? 
  //Turn automatic updating off
  //IOShieldOled.setCharUpdate(0);
 
  for (ix=0 ; ix < WIDTH ; ix = ix+2*CUBESIZE)
  {
    for (iy=0; iy < HEIGHT; iy = iy+2*CUBESIZE)
    { 
    // IOShieldOled.clearBuffer();
     IOShieldOled.moveTo(ix, iy);
     IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(1));
     IOShieldOled.drawFillRect(ix+CUBESIZE, iy+CUBESIZE);
     IOShieldOled.drawRect(ix+CUBESIZE, iy+CUBESIZE);
     IOShieldOled.updateDisplay();
     delay(100);
    }
  }
   delay(250);
}
