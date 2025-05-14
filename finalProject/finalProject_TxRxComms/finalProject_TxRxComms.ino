/*
Rukayat Akinola

- finalProject
- Ardunio and Processing Serial Communication
- Bi-Directional Serial Communication between Microcontroller & Processing
- Tansmits(Tx) and Receives(Rx) Serial Data

*/

//Define Pins
const int adcPin_1 = 1;
const int adcPin_2 = 2;
const int buttonPin_1 = 20;
const int buttonPin_2 = 21;
int countButton = 0;

//Button Variables
bool buttonState_1 = 0;
bool buttonState_2 = 0;

bool lastButtonState = 0; //previous button state
//bool lastButtonState_2= 0; //previous button state

//Pot Variables
int adcRead_1 = 0;
int adcRead_2 = 0;

//Serial Rx Data Variable
int inByte = 0;

void setup() 
{
  pinMode(buttonPin_1, INPUT_PULLUP); //set pin modes
  pinMode(buttonPin_2, INPUT_PULLUP);
  //pinMode(ledPin, OUTPUT);
  //digitalWrite(ledPin, 0);  //turn off led
  analogReadResolution(10);  //set analog resolution to 0-1023 range
  Serial.begin(115200); //start serial comm @ 115200 baud rate
  //establishContact(); //establish first contact via Serial
}

void loop() 
{
  // ------------------ ardunio test Begins here -------------------------------------
  // //Serial monitor data check for Arduino
  // adcRead_1 = analogRead(adcPin_1); //read analog pot values
  // adcRead_2 = analogRead(adcPin_2);
  // buttonState_1 = !digitalRead(buttonPin_1);  //read button states
  // buttonState_2 = !digitalRead(buttonPin_2);
  // //Serial.printf("%i \t %i \t", buttonState_1, buttonState_2);
  // //Serial.printf("%i \n", countButton);

  // if (buttonState_1 == 1 && lastButtonState == 0) //rishing
  // {
  //   countButton += 1;
  // }
  // if (countButton > 2)
  // {
  //   countButton = 0;
  // }
  // lastButtonState = buttonState_1;
  // Serial.printf("Button = %i _ lastButton = %i _ button2 = %i _ count = %i\n", buttonState_1, lastButtonState, buttonState_2, countButton);

//  ------------------ ardunio test Ends here -------------------------------------
  if (Serial.available() > 0) //if there is data received on the serial port
  {
    inByte = Serial.read(); //store data in variable
    //if (inByte == 'A')  //if stored byte is equal to char 'A'
    //{
      //digitalWrite(ledPin, 1);  //turn on LED
      adcRead_1 = analogRead(adcPin_1); //read analog pot values
      adcRead_2 = analogRead(adcPin_2);
      buttonState_1 = !digitalRead(buttonPin_1);  //read button states
      buttonState_2 = !digitalRead(buttonPin_2);
      
      if(buttonState_1 == 1 && lastButtonState == 0) //rishing
      {
        countButton += 1;
      }
      if(countButton > 2)
      {
        countButton = 0;
      }
      lastButtonState = buttonState_1;
      //lastButtonStat_2 = buttonState_2;

      Serial.print(countButton);  //send 1st message
      Serial.print(',');            //send comma character
      Serial.print(buttonState_2);  //send 2nd message
      Serial.print(',');            //send comma character
      Serial.print(adcRead_1);      //send 3rd message
      Serial.print(',');            //send comma character
      Serial.print(adcRead_2);      //send 4th message
      Serial.print(',');            //send comma character
      Serial.print('\n');           //send "Line Feed", or "New Line" character (you could use println() instead)

    // else if (inByte == 'B') //if stored byte is equal to char 'B'
    // {
    //   digitalWrite(ledPin, 0);  //turn off LED
    //   Serial.println("Sensor Update Paused..."); //send string message with "New Line" at end, using println()        
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
