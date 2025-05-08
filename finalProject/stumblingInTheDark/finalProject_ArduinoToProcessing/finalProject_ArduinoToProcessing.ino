/*
Rukayat Akinola

finalProject
Ardunio to Processing Serial Write Script

*/

//Define Pins
const int buttonPin_3 = 1;
const int buttonPin_4  = 2;
const int buttonPin_1 = 20;
const int buttonPin_2 = 21;

//Button Variables
bool buttonState_1 = 0;
bool buttonState_2 = 0;
bool buttonState_3 = 0;
bool buttonState_4 = 0;

//Software Timer Variables
int lastTime = 0;
int currentTime = 0;
int timerInterval = 20; //not reliable with values less than 20ms

void setup() 
{
  //set button pin modes to Input with internal Pullup resistors
  pinMode(buttonPin_3, INPUT_PULLUP); 
  pinMode(buttonPin_4, INPUT_PULLUP);
  pinMode(buttonPin_1, INPUT_PULLUP); 
  pinMode(buttonPin_2, INPUT_PULLUP);
  
  //analogReadResolution(10); 
  Serial.begin(115200); //start serial comm @ 115200 baud rate
}

void loop() 
{
  //read button state on pins [NOTE: logic is inverted due to Pullup config]
  buttonState_1 = !digitalRead(buttonPin_1);
  buttonState_2 = !digitalRead(buttonPin_2);
  buttonState_3 = !digitalRead(buttonPin_3);
  buttonState_4 = !digitalRead(buttonPin_4);

  /*
    printf() is only for debugging, not for UART-to-Processing communication
    Do not use Serial.printf() and Serial.print() code below at the same time!
  */
  Serial.printf("%i \t %i \t %i \t %i \n", buttonState_3, buttonState_4, buttonState_1, buttonState_2);

  currentTime = millis(); //read current elapsed time
  if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...
  {
    lastTime = currentTime; //store current time as lastTime so we know when timer last triggered

    //Send Data to Processing via Serial UART using print() and Comma Separation
    // Serial.print(buttonState_1);  //send 1st message
    // Serial.print(',');            //send comma character
    // Serial.print(buttonState_2);  //send 2nd message
    // Serial.print(',');            //send comma character
    // Serial.print(buttonState_3);     //send 3rd message
    // Serial.print(',');            //send comma character
    // Serial.print(buttonState_4);     //send 4th message
    // Serial.print(',');            //send comma character
    // Serial.print('\n');           //send "Line Feed", or "New Line" character, since we are using println()
  }
}