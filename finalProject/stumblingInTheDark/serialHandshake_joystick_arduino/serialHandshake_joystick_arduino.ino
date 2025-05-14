/*
Rukayat Akinola
final Project 
*/


const int xPin = 1;
const int yPin = 2;

int xRead = 0;
int yRead = 0;

//Serial Rx Data Variable
int inByte = 0;

void setup() 
{
  Serial.begin(115200);
  analogReadResolution(8);
  establishContact(); //establish first contact via Serial
}

void loop() 
{
  if (Serial.available() > 0) //if there is data received on the serial port
  {
    // if (inByte == 'A')
    // {
      inByte = Serial.read(); //store data in variable
      xRead = analogRead(xPin);
      yRead = analogRead(yPin);
      Serial.print(xRead);
      Serial.print(',');            //send comma character
      Serial.print(yRead);
      Serial.print(',');            //send comma character
      Serial.println();             //newline, end of message
    // }
  }
}

void establishContact() //user-defined function for establishing 1st contact with other serial device
{
  while (Serial.available() <= 0) //if there is nothing received on the serial port
  {
    Serial.println("Hello");  // send an initial string with "New Line" at end, using println()   
    delay(300); //wait 300 milliseconds
  }
}