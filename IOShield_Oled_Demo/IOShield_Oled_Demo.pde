
#include <IOShieldTemp.h>
#include <IOShieldOled.h>
#include <Wire.h>

void setup()
{
   Serial.begin(9600);
   Serial.println("Start");
    //Initialize Configuration register for onshot with 10 bit
  //resolution
  IOShieldTemp.config(IOSHIELDTEMP_ONESHOT | IOSHIELDTEMP_RES10);
  IOShieldOled.begin();
}

void loop()
{
  int irow;
  int ib;
  uint8_t temp[2];
  char buff[16];
  char tempstr[32];

/*  
  //Get Temperature
  Serial.println("calling gettemp");
  IOShieldTemp.getTemp(temp);
  Serial.println("backfro gettemp");
  itoa((int)temp[0], buff,10);
  Serial.println(buff);

  strcpy(tempstr, buff);

  itoa((int)temp[1], buff ,10);
  strcat(tempstr,".");
  strcat(tempstr, buff);
  strcat(tempstr," C");
  
Serial.print("temp: ");  
Serial.println(tempstr);  
*/
  //Clear the virtual buffer
  IOShieldOled.clearBuffer();
  
  //Chosing Fill pattern 0
  IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(0));
  //Turn automatic updating off
  IOShieldOled.setCharUpdate(0);
  
  //Draw a rectangle over wrting then slide the rectagle
  //down slowly displaying all writting
  for(irow = 0; irow < IOShieldOled.rowMax; irow++)
  {

    IOShieldOled.clearBuffer();
    IOShieldOled.setCursor(0, 0);
    IOShieldOled.putString("chipKIT");
    IOShieldOled.setCursor(0, 1);
//    IOShieldOled.putString("Basic I/O Shield");
//    IOShieldOled.setCursor(0, irow++);
    IOShieldOled.putString("by Digilent");
    IOShieldOled.setCursor(0, 2);
    IOShieldOled.putString(tempstr);
    
    IOShieldOled.moveTo(0, irow);
    IOShieldOled.drawFillRect(127,31);
    IOShieldOled.moveTo(0, irow);
    IOShieldOled.drawLine(127,irow);
    IOShieldOled.updateDisplay();
//    delay(10);
  }

  delay(4000);

  // Draw a rectangle in center of screen
  // Display the 8 different patterns availible
  for(ib = 1; ib < 8; ib++)
  {
    IOShieldOled.clearBuffer();
    
    IOShieldOled.setFillPattern(IOShieldOled.getStdPattern(ib));
    IOShieldOled.moveTo(55, 1);
    IOShieldOled.drawFillRect(75, 27);
    IOShieldOled.drawRect(75, 27);
    IOShieldOled.updateDisplay();
    
    delay(1000);
  }
}
