/*
Rukayat Akinola
Spring'25 - MTEC2280
Midterm Project Proposal & WIP

Description: I intend to use a pot to control a servo, with an arm extension. 
The arm extension would act like a real hand obstructing a photocell.
The photocell like an annoyed sibling will return the servo arm away some predetermined degree
*/

#include <ESP32Servo.h>
Servo servo; // create Servo object

const int potPin = 2;
const int photoPin = 1;

const int ledPin = 4;
const int servoPin = 5;

int potvalue;
int photovalue;


void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  servo.attach(servoPin);

  pinMode(potPin, INPUT);
  pinMode(photoPin, INPUT);


  analogReadResolution(8);
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:

  potvalue = analogRead(potPin);
  photovalue = analogRead(photoPin);
  int angle = map(potvalue, 0, 255, 0, 180);
  
  Serial.printf("Potpin = %i, ServoAngle = %i, Photocell = %i, \n", potvalue, angle, photovalue);
  servo.write(potvalue); 

  //note: for WIP the photocell is not yet connected to the servoMotor
  // if(photovalue > 100){
  //   digitalWrite(ledPin, HIGH);
  //   delay(500);
  // }
  // else {
  //   digitalWrite(ledPin, LOW);
  // }


}