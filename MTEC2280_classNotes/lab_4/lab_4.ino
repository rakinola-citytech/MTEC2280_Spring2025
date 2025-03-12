/*
Spring2025 - MTEC2280
lab_4
*/

// Dimimg and Brightening an LED
// const int ledPin = 4;
// int ms = 30;

// void setup(){

//   pinMode(ledPin, INPUT);
//   Serial.begin(115200);

// } 
// void loop() {
//   // put your main code here, to run repeatedly:
//   for(int i = 0; i < 255; i++){
//     Serial.printf("for loop 1  = %i \n", i);
//     analogWrite(ledPin, i);
//     delay(ms);
//   }
//    for(int i = 255; i > 0; i--){
//     Serial.printf("for loop 2  = %i \n", i);
//     analogWrite(ledPin, i);
//     delay(ms);
//   }
// }

// Piezo Buzzer with Touch Sensor
// const int piezoPin = 21;
// const int touchPin = 10;
// int ms = 30;

// void setup(){
//   analogWriteResolution(piezoPin, 16);
//   Serial.begin(9600);
// }

// void loop(){
//   // tone(piezoPin, 220, 500);
//   // tone(piezoPin, 440, 1000);
//   // tone(piezoPin, 110, 200);
//   // tone(piezoPin, 200, 1000);
//   // tone(piezoPin, 200, 200);

//   int touchvalue = touchRead(touchPin);
//   int mapvalue = map(touchvalue, 32000, 90000, 300, 1000);

//   analogWriteFrequency(piezoPin, mapvalue);
//   Serial.printf("touch = %i, map = %i \n",touchvalue, mapvalue);
//   analogWrite(piezoPin, 127);
// }

// Blinking a LED with no DELAY & using a POT
// const int ledPin = 4;
// const int potPin = 1;

// bool ledState = 0;

// int currentTime = 0;
// int lastTime = 0;
// int timeInterval = 1000;

// void setup(){
//   pinMode(ledPin, OUTPUT);
//   analogReadResolution(10);

//   Serial.begin(115200);
// }
// void loop(){
//   currentTime = millis();
//   int mapvalue = map(analogRead(potPin), 0, 1023, 10, 1000);

//   if(currentTime - lastTime >= mapvalue){
    
//     lastTime = currentTime;
//     ledState = !ledState;
//   }

//   digitalWrite(ledPin, ledState);
//   Serial.printf("ledState = %i, timeInterval = %i, mapvalue = %i, \n",ledState, timeInterval, mapvalue);
// }

//SERVO

#include <ESP32Servo.h>
Servo servo;

const int servoPin = 5;

int angle = 0;
int dir = 1;
int ms = 30;

void setup(){

  servo.attach(servoPin);
  Serial.begin(115200);
}

void loop() {

  angle += dir;
  if(angle >= 180 || angle <= 0){
    dir = -dir;
  }

  Serial.printf("angle = %i \n", angle);
  servo.write(angle); 
  delay(ms);
}


