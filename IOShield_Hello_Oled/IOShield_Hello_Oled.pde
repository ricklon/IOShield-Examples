/************************************************************************
//*     IOShield_Hello_Oled.pde
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

#define height 128
#define width 32

void setup()
{
  IOShieldOled.begin();
}

void loop()
{
  
  //Clear the virtual buffer
  IOShieldOled.clearBuffer();
  
  //Chosing Fill pattern 0
 // IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
  
  //q: With automatic update on, does it check if draw is needed or not? 
  //Turn automatic updating off
 // IOShieldOled.setCharUpdate(0);
  
  
    IOShieldOled.clearBuffer();
    IOShieldOled.setCursor(0, 0);
    IOShieldOled.putString("Hello Oled A");
    IOShieldOled.setCursor(1, 1);
    IOShieldOled.putString("Hello Oled B");
    IOShieldOled.setCursor(2, 2);
    IOShieldOled.putString("Hello Oled C");
 //   IOShieldOled.updateDisplay();
   delay(20000);
  
}
