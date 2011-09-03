/************************************************************************
//*     IOShieldLEDPotScrollSwitch.pde
//*     Scroll the leds on ChipKit Basic I/O shield via the potentiometer
//*     Turns off and on the LEDs on pins 26-33 on the basic I/O SHield in sequence
//*     Switch inverts the mode
//*
//*
//*
//*             Copyright (c) 2011 by Rick Anderson and Mark Sproul
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


int LEDPins[] = {26,27,28,29,30,31,32,33};
#define kNUMLEDS  8
const int potPin = A0;
const int sw1 = 2;



//#define NUMLEDS sizeof(LEDPins) gives 32 as answer

int ledState = LOW;             // Global ledState used to set the LED
int  gCurrentPin  =  0;

void setup() 
 {
  Serial.begin(9600);
  Serial.println("Setup: LEDTest");
  Serial.print("NUMLEDS: ");
  Serial.println(kNUMLEDS);
  
  // set the LED pins as output:
 for(int ii; ii < kNUMLEDS; ii++) 
  {
    pinMode(LEDPins[ii], OUTPUT);    
    // set the LED with the ledState of the variable:
    digitalWrite(LEDPins[ii], HIGH);
    delay(500);
    digitalWrite(LEDPins[ii], LOW);
    Serial.print("LEDPins: setting: ");
    Serial.print(ii);  
    Serial.print(" : ");
    Serial.println(LEDPins[ii]);
  }
  Serial.println("LEDPins: done set as output");
  pinMode(sw1, INPUT);
}



void loop() 
 {
int potVal;
int  newPin;

  potVal = analogRead(potPin);
  newPin = map(potVal, 0, 1023, 0, 7);
  if (newPin != gCurrentPin)
  {
    digitalWrite(LEDPins[gCurrentPin], digitalRead(sw1));   
    digitalWrite(LEDPins[newPin], !digitalRead(sw1));   
    gCurrentPin  =   newPin;
    
  }
  
  
}
