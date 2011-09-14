/************************************************************************
//*     IOShield_Oled_Draw_Point.pde
//*     Draws point across the screen.
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

void setup()
{
  Serial.begin(9600);
  IOShieldOled.begin();
}

void loop()
{
  
  //Clear the virtual buffer
  IOShieldOled.clearBuffer();
  
  //q: With automatic update on, does it check if draw is needed or not?
  //a: It only updates the character areas. Graphics are not effected.
  //Turn automatic updating off
  //IOShieldOled.setCharUpdate(0);
 
   
  int ix;
  int iy;

  for (ix=0; ix < WIDTH; ix++)
  {
     //IOShieldOled.clearBuffer();
     IOShieldOled.moveTo(ix, HEIGHT/2);
     IOShieldOled.drawPixel();
     IOShieldOled.updateDisplay();
     delay(100); 
  }

  for (ix=0 ; ix < WIDTH ; ix = ix+2)
  {
    for (iy=0; iy < HEIGHT; iy = iy+2)
    { 
     IOShieldOled.clearBuffer();
     IOShieldOled.moveTo(ix, iy);
     IOShieldOled.drawPixel();
     IOShieldOled.updateDisplay();
     delay(100);
    }
  }
   delay(250);
}
