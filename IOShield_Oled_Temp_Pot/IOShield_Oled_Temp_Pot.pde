/************************************************************************
//*     IOShield_Oled_Temp_Pot.pde
//*     Demo of Temperature, and Potentiometer values displayed on Oled
//*
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
#include <IOShieldTemp.h>

#define HEIGHT 32
#define WIDTH 128

const int potPin = A0;

void setup()
{
  Serial.begin(9600);
  //Initialize Configuration register for onshot with 10 bit
  //resolution
  IOShieldTemp.config(ONESHOT | RES10);
  //Init IOSHield Oled
  IOShieldOled.begin();
}

void loop()
{
  uint8_t temp[2];
  char buff[16];
  char tempstr[32];
  int potVal;

  //q: With automatic update on, does it check if draw is needed or not? 
  //Turn automatic updating on
  IOShieldOled.setCharUpdate(true);
  
  // Clear the virtual buffer
  // Doing this cause a lot of flicker for this sketch
  // IOShieldOled.clearBuffer();
  IOShieldOled.setCursor(0, 0);
  IOShieldOled.putString("Temp:          ");
  IOShieldOled.setCursor(6, 0);
  //Get Temperature
  IOShieldTemp.getTemp(temp); 
  itoa((int)temp[0], buff,10);
  strcpy(tempstr, buff);
  itoa((int)temp[1], buff ,10);
  strcat(tempstr,".");
  strcat(tempstr, buff);
  // Spaces after the C blank the not clear characters
  strcat(tempstr," C");
  IOShieldOled.putString(tempstr);
    
  //Get Potentiomter value
  potVal = analogRead(potPin);
  itoa(potVal, buff,10);
  strcpy(tempstr, buff);
  IOShieldOled.setCursor(0, 3);
  IOShieldOled.putString("potVal:       ");
  IOShieldOled.setCursor(8, 3);
  IOShieldOled.putString(tempstr);
  //Since only characters are used it doesn't need updateDisplay if updateChar is on
  //IOShieldOled.updateDisplay(); 


   delay(100);
}
