/************************************************************************
//*     IOShield_Oled_Draw_Box_Fill.pde
//*     Draws boxes across the screen.
//*
//*     Example Hello Oled sketch
//*             Copyright (c) 2011 by Rick Anderson
//*
//*
//************************************************************************
//*     this code is based on example code from the Digilent Basic I/O shield examples
//*
//*     This library is free software; you can redistribute it and/or
//*     modify it under the terms of the GNU Lesser General Public
//*     License as published by the Free Software Foundation; either
//*     version 2.1 of the License, or (at your option) any later version.
//*
//*     This library is distributed in the hope that it will be useful,
//*     but WITHOUT ANY WARRANTY; without even the implied warranty of
//*     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.//* See the GNU
//*     Lesser General Public License for more details.
//*
//*     You should have received a copy of the GNU Lesser General
//*     Public License along with this library; if not, write to the
//*     Free Software Foundation, Inc., 59 Temple Place, Suite 330,
//*     Boston, MA  02111-1307  USA
//*
//*
//************************************************************************
*/

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
    // delay(100);
    }
  }
   delay(250);
}
