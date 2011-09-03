/************************************************************************
//*     IOShieldLEDPotScrollSwitchRefresh.pde
//*     Blink the leds on ChipKit Basic I/O shield
//*     Turns off and on the LEDs on pins 26-33 on the basic I/O SHield
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

long previousMillis = 0;        // will store last time LED was updated
long interval = 1000;           // interval at which to blink (milliseconds)
int LEDPins[] = {26,27,28,29,30,31,32,33};
int numleds = 8;

//#define NUMLEDS sizeof(LEDPins) gives 32 as answer

int ledState = LOW;             // Global ledState used to set the LED


void setup() {
  Serial.begin(9600);
  Serial.println("Setup: LEDTest");
  Serial.print("NUMLEDS: ");
  Serial.println(numleds);
  
  // set the LED pins as output:
 for(int ii; ii < numleds; ii++) {
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
}

void loop() {
   unsigned long currentMillis = millis();
 
   if(currentMillis - previousMillis > interval) {
   
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   
       // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    }
    else {
      ledState = LOW;
    }
    for (int ii; ii < numleds; ii++) {
        digitalWrite(LEDPins[ii], ledState);            
    } 
    Serial.print("loop: state change: ");
    Serial.println(ledState);
  }
  
  
}
