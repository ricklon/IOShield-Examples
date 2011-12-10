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
#include <IOShieldTemp.h>
#include <IOShieldOled.h>
#include <Wire.h>

#define HEIGHT 32
#define WIDTH 128

const int potPin = A0;

void setup()
{
  Serial.begin(9600);
  //Initialize Configuration register for onshot with 10 bit
  //resolution
  IOShieldTemp.config(IOSHIELDTEMP_ONESHOT | IOSHIELDTEMP_RES10);
  //Init IOSHield Oled
  IOShieldOled.begin();
}

void loop()
{
  char tempBuffer[16];
  char buff[16];
  char tempstr[32];
  int potVal;
  String tempCString;
  


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
  float tempC = IOShieldTemp.getTemp();
  tempCString = floatToString(tempC,DEC);
  tempCString.toCharArray(tempBuffer,7);
  IOShieldOled.putString(tempBuffer);
  IOShieldOled.putString(" C");
   
    
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

String floatToString(double number, uint8_t digits) 
{ 
  String resultString = "";
  // Handle negative numbers
  if (number < 0.0)
  {
     resultString += "-";
     number = -number;
  }

  // Round correctly so that print(1.999, 2) prints as "2.00"
  double rounding = 0.5;
  for (uint8_t i=0; i<digits; ++i)
    rounding /= 10.0;
  
  number += rounding;

  // Extract the integer part of the number and print it
  unsigned long int_part = (unsigned long)number;
  double remainder = number - (double)int_part;
  resultString += int_part;

  // Print the decimal point, but only if there are digits beyond
  if (digits > 0)
    resultString += "."; 

  // Extract digits from the remainder one at a time
  while (digits-- > 0)
  {
    remainder *= 10.0;
    int toPrint = int(remainder);
    resultString += toPrint;
    remainder -= toPrint; 
  } 
  return resultString;
}


