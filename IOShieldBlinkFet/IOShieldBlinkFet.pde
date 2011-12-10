#include <Wire.h>

// constants won't change. Used here to 
// set pin numbers:
const int ledPin =  33;      // the number of the LED pin
const int pwmFetJ8 = 6;
int count = 0;
// Variables will change:
int ledState = LOW;             // ledState used to set the LED
int fetState = 0;
long previousMillis = 0;        // will store last time LED was updated
int potPin = A0;

// the follow variables is a long because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
long interval = 500;           // interval at which to blink (milliseconds)

void setup() {
  // set the digital pin as output:
  pinMode(ledPin, OUTPUT);   
  pinMode(pwmFetJ8, OUTPUT);
  Serial.begin(9600);  
}

void loop()
{
  // here is where you'd put code that needs to be running all the time.

  // check to see if it's time to blink the LED; that is, if the 
  // difference between the current time and last time you blinked 
  // the LED is bigger than the interval at which you want to 
  // blink the LED.
  unsigned long currentMillis = millis();
 
   interval = analogRead(A0);
 
  if(currentMillis - previousMillis > interval) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW)
    {
      ledState = HIGH;
      fetState = HIGH;
      Serial.println(count++);
    }
    else
    {
      ledState = LOW;
      fetState = LOW;
    }

    // set the LED with the ledState of the variable:
    digitalWrite(ledPin, ledState);

    digitalWrite(6, fetState);

    
  }
}

