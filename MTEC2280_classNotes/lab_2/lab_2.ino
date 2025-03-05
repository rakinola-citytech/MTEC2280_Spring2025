/*
Spring2025 - MTEC2280
Lab_2 
*/


//rgb LED buttonPin
// const int pinRGB = 38
// int brightness = 4;
// int delayTime = 500;
// void setup() {
//   // put your setup code here, to run once:
// }

// void loop() {
//   // put your main code here, to run repeatedly:
//   rgbLedWrite(pinRGB, brightness, brightness, brightness);
//   delay(delayTime);
//   rgbLedWrite(pinRGB, brightness, 0, 0);
//   delay(delayTime);
//   rgbLedWrite(pinRGB, 0, brightness, 0);
//   delay(delayTime);
//   rgbLedWrite(pinRGB, 0, 0, brightness);
//   delay(delayTime);

// }

//pull_up button INPUT
// const int buttonPin = 9;
// bool buttonState;

// void setup(){
//   pinMode(buttonPin, INPUT_PULLUP);
//   Serial.begin(115200);
// }

// void loop(){
//   buttonState = !digitalRead(buttonPin);
//   Serial.print("buttonState = ");
//   Serial.print(buttonState);
//   Serial.println();
// }

const int buttonPin = 9;
const int ledPin = 4;

bool buttonState = 0;
bool lastButtonState = 0;
bool toggle = 0;
bool fallingToggle = 0;

void setup(){
  pinMode (buttonPin, INPUT_PULLUP);
  pinMode(ledPin, OUTPUT);

  Serial.begin(115200);
}

void loop(){
  buttonState = !digitalRead(buttonPin);

  if (buttonState && !lastButtonState){
    toggle = !toggle;
  }
   if (!buttonState && lastButtonState){
    Serial.printf("Button = %i, Toggle = %i, Falling = %i \n", buttonState, toggle, fallingToggle);    fallingToggle = !fallingToggle;
  }

  lastButtonState = buttonState;
  digitalWrite(ledPin, toggle);
  
}



