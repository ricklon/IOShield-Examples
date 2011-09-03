
/************************************************************************
//*     IOShield_Oled_Draw_Rectangle.pde
//*     Draws growing rectangles across the screen.
//*
//*     Example Oled Draw rectangle
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
  //Turn automatic updating off
  //IOShieldOled.setCharUpdate(0);
 
   //Draw Rectangle 
   //Chosing Fill pattern 0
   IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
   IOShieldOled.moveTo(10, 10);
   IOShieldOled.drawFillRect(127,31);
   IOShieldOled.drawRect(127, 31);
   IOShieldOled.updateDisplay();
 
   IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
   IOShieldOled.moveTo(20, 20);
   IOShieldOled.drawFillRect(127,32);
   IOShieldOled.drawRect(127, 32);
   IOShieldOled.updateDisplay(); 
   
  int ix;
  int iy;


  for (ix=0 ; ix < WIDTH ; ix++)
  {
    for (iy=0; iy < HEIGHT; iy++)
    {
     IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
     IOShieldOled.moveTo(0, 0);
     IOShieldOled.drawFillRect(ix,iy);
     IOShieldOled.drawRect(ix, iy);
     IOShieldOled.updateDisplay();
      Serial.print("drawRect: ix =");
      Serial.print(ix);
      Serial.print(" ,iy=");
      Serial.print(iy);
      Serial.println("width = 127, height = 31");
    }
  }
   delay(500);
  
}
