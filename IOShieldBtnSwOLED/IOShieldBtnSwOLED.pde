 /************************************************************************
//*     IOShieldBtnSwOled.pde
//*     Use the buttons and switches to turn draw blocks on and off for the OLED on the ChipKit Basic I/O shield
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

long previousMillis = 0;        // will store last time LED was updated
long interval = 50;           // interval at which to blink (milliseconds)
int LEDPins[] = { 26,27,28,29,30,31,32,33};
int btns[] = { 37,36,34,4};
int swts[] = { 35,8,7,2};
const int potPin = A0;

int  gCurrentPin  =  0;
//int numleds = 8;

#define NUMLEDS sizeof(LEDPins)/sizeof(int)
#define NUMBTS 4
#define NUMSWTS 4

#define HEIGHT 32
#define WIDTH 128
#define CUBESIZE 4

int ledState = LOW;             // Global ledState used to set the LED


void setup() {
  Serial.begin(9600);
  Serial.println("Setup: LEDTest");
  Serial.print("NUMLEDS: ");
  Serial.println(NUMLEDS);

  // set the LED pins as output:
  for(int ii; ii < NUMLEDS; ii++) {
    pinMode(LEDPins[ii], OUTPUT);    
    // set the LED with the ledState of the variable:
    digitalWrite(LEDPins[ii], HIGH);
    delay(150);
    digitalWrite(LEDPins[ii], LOW);
    Serial.print("LEDPins: setting: ");
    Serial.print(ii);  
    Serial.print(" : ");
    Serial.println(LEDPins[ii]);
  }
  Serial.println("LEDPins: done set as output");
  //Initialize Configuration register for onshot with 10 bit
  //resolution
  IOShieldTemp.config(IOSHIELDTEMP_ONESHOT | IOSHIELDTEMP_RES10);
  //Iniiialize IOShieldOled
  IOShieldOled.begin();
}

void loop() 
{
  boolean dodraw;
  int ii; 
  boolean btnStatus[NUMBTS];
  boolean swtStatus[NUMSWTS];

  //Read buttons
  for (ii = 0; ii < NUMBTS; ii++)
  {
    btnStatus[ii] = digitalRead(btns[ii]);
  }
  //Read Switches
  for (ii = 0; ii < NUMSWTS; ii++)
  {
    swtStatus[ii] = digitalRead(swts[ii]);
  }

  //Check events
  /*
    for (ii = 0; ii < NUMBTS; ii++)
   {
   if (btnStatus[ii] == HIGH)
   {
   
   }
   }
   */

  if (swtStatus[0])
  {
    doPotScrollLED();
  }
  if (swtStatus[1])
  {
    doBoxFlll();
  }
  if(swtStatus[2])
  {
    doBlinkHelloRowLED();
  }
  else
  {
    for (int ii; ii < NUMLEDS; ii++)
    {
      digitalWrite(LEDPins[ii], LOW);            
    } 
  }
  if (swtStatus[3])
  {
    doPotTemp();
  }

  demo();


}


void doPotScrollLED()
{
  while(digitalRead(swts[0])) 
  {
 int potVal;
 int  newPin;

  potVal = analogRead(potPin);
  newPin = map(potVal, 0, 1023, 0, 7);
  if (newPin != gCurrentPin)
  {
    digitalWrite(LEDPins[gCurrentPin], digitalRead(btns[0]));   
    digitalWrite(LEDPins[newPin], !digitalRead(btns[0]));   
    gCurrentPin  =   newPin;
  }
  }
  
}

void doBoxFlll()
{
  //Clear the virtual buffer
  IOShieldOled.clearBuffer();

  //q: With automatic update on, does it check if draw is needed or not? 
  //Turn automatic updating off
  //IOShieldOled.setCharUpdate(0);

  int ix;
  int iy;

  for (ix=0 ; ix < WIDTH ; ix = ix+2*CUBESIZE)
  {
    for (iy=0; iy < HEIGHT; iy = iy+2*CUBESIZE)
    { 
      //IOShieldOled.clearBuffer();
      IOShieldOled.moveTo(ix, iy);
      IOShieldOled.drawRect(ix+CUBESIZE, iy+CUBESIZE);
      IOShieldOled.updateDisplay();
    }
  }
  //delay(250);
}

void doBlinkHelloRowLED()
{
  unsigned long currentMillis = millis();

  if(currentMillis - previousMillis > interval)
  {

    // save the last time you blinked the LED 
    previousMillis = currentMillis;   
    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    }
    else {
      ledState = LOW;
    }
    for (int ii; ii < NUMLEDS; ii++) 
    {
      digitalWrite(LEDPins[ii], ledState);            
    } 
    Serial.print("loop: state change: ");
    Serial.println(ledState);
  }



}

void doPotTemp()
{

  //- no longerneeded: uint8_t temp[2];
  float tempC;
  String tempCString;
  char tempBuffer[16];
  char buff[16];
  char tempstr[32];
  int potVal;

   IOShieldOled.clearBuffer();
   IOShieldOled.updateDisplay();
  //q: With automatic update on, does it check if draw is needed or not? 
  //Turn automatic updating on
  IOShieldOled.setCharUpdate(true);
  
   while(digitalRead(swts[3])) 
  { 
  
  // Clear the virtual buffer
  // Doing this cause a lot of flicker for this sketch
  // IOShieldOled.clearBuffer();
  IOShieldOled.setCursor(0, 0);
  IOShieldOled.putString("Temp:          ");
  IOShieldOled.setCursor(6, 0);
  
  //Get Temperature: orig
  tempC = IOShieldTemp.getTemp();
  tempCString = floatToString(tempC,DEC);
  tempCString.toCharArray(tempBuffer,7);
  IOShieldOled.putString(tempBuffer);
  IOShieldOled.putString(" C");
  
  
  //Get Temperature: orig
  /* Function no longer defined
  IOShieldTemp.getTemp(temp); 
  itoa((int)temp[0], buff,10);
  strcpy(tempstr, buff);
  itoa((int)temp[1], buff ,10);
  strcat(tempstr,".");
  strcat(tempstr, buff);
  // Spaces after the C blank the not clear characters
  strcat(tempstr," C");
  //IOShieldOled.putString(tempstr);
   IOShieldOled.putString(tempC);
   */
    
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
      IOShieldOled.clearBuffer();
      IOShieldOled.updateDisplay();
}

void demo()
{


    IOShieldOled.setCursor(0, 0);
    IOShieldOled.putString("++ chipKIT ++");
    IOShieldOled.setCursor(0, 1);
    IOShieldOled.putString("++ Fubar Labs ++");
    IOShieldOled.setCursor(0, 2);
    IOShieldOled.putString("++ Digilent ++");
    IOShieldOled.setCursor(0, 3);
    IOShieldOled.putString("++ Microchip ++");
    IOShieldOled.updateDisplay();
   
  
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



