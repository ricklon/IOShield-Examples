/************************************************************************
//*     IOShield_Oled_Draw_Box_Fill.pde
//*     Draw a point into a line with the ChipKit Basic I/O shield via the potentiometer
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

const int potPin = A0;
const int sw1 = 2;

void setup() 
{
  //Create IO Shield Object
  IOShieldOled.begin();
  //set sw1 pinmode to INPUT
  pinMode(sw1, INPUT);
}

void loop() 
{
  int potVal;
  int pixel;
  int center;
  int range;
  int mySw1State;
  
  mySw1State = digitalRead(sw1);
  center = WIDTH/2;
  range = HEIGHT-1;
  
  potVal = analogRead(potPin);
  if (mySw1State)
  {
     center = HEIGHT/2;
     range = WIDTH-1; 
  }
  
  pixel = map(potVal, 0, 1023, 0, range);

  //Clear the virtual buffer
  IOShieldOled.clearBuffer();

  //IOShieldOled.clearBuffer();
  if (mySw1State)
  {
    IOShieldOled.moveTo(pixel, center);
  }
  else
  {
    IOShieldOled.moveTo(center, pixel);
  }
  IOShieldOled.drawPixel();
  IOShieldOled.updateDisplay();
  delay(100); 
}



