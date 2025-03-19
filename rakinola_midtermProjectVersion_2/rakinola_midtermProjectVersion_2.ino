/*
Rukayat Akinola
Spring'25 - MTEC2280
Midterm Project Version_2

Description: I intend to use a pot to control a servo, with an arm extension. 
The arm extension would act like a real hand obstructing a photocell.
The photocell like an annoyed sibling will return the servo arm away some predetermined degree

Detailed Expected Interaction:

*/

#include <ESP32Servo.h>
Servo servo; // create Servo object

//analog sensors (potentiometer,photocell)
const int potPin = 5;
const int photoPin = 6;

//digital sensor (pushButton)
const int buttonPin = 7;

// circuit LED's and their functions
const int ledGreen = 9; //signals pot & servo angle 45-90 degress for 2 seconds
const int ledBlue = 10; //signals pot & servo angle 90-135 degress for 2 seconds
const int ledRed = 11; //signals pot & servo angle directly on top of photocell 

//timer controls
int currentTime = 0;
int lastTime = 0;
const int timeInterval = 3000;

const int servoPin = 4;

//analog & digital controls
int potRead;
int angle;

int photoRead;
int buttonRead;


void setup() {
  // put your setup code here, to run once:
  pinMode(ledGreen, OUTPUT);
  pinMode(ledBlue, OUTPUT);
  pinMode(ledRed, OUTPUT);

  servo.attach(servoPin);

  pinMode(potPin, INPUT);
  pinMode(photoPin, INPUT);
  pinMode(buttonPin, INPUT);

  analogReadResolution(8);
  Serial.begin(115200);

}

void loop() {
  //start system timer
  currentTime = millis();
  
  //potReads & servoControl
  potRead = analogRead(potPin);
  angle = map(potRead, 0, 255, 0, 180);

  if(buttonRead == 1){
    servo.write(angle); 
  }
  //servo.write(angle);
  
  photoRead = analogRead(photoPin);
  buttonRead = digitalRead(buttonPin);
  trigger = map()

  //variable tracking
  //Serial.printf("currentTime = %i, lastTime= %i, timeInterval = %i \n", currentTime, lastTime, timeInterval);
  Serial.printf("Potvalue = %i, ServoAngle = %i, button = %i, photoCell = %i \n", potRead, angle, buttonRead, photoRead);


  //Program State Machine
  //State ONE: some servo movement but still far from target(the photoCell)
  //This movement suggest a softer push back to 0 degrees

  // if((photoRead >200 45 && potvalue <= 75)){
  //   digitalWrite(ledGreen, HIGH);
  //   currentTime = millis();
  //   if(currentTime >= timeInterval){
  //     for(int i = angle; i > 0; i-=5){
  //       servo.write(i);
  //     }
  //   }
  //  }

  // State TWO: much closer servo movement not too far from target(the photoCell)
  // This movement suggest a harder warning push back to 0 degrees

  if((photoRead >= 197 && photoRead <= 250)){
    lastTime = currentTime;
    digitalWrite(ledGreen, HIGH);
    if((currentTime - lastTime >= timeInterval) && (angle > 0)){
      for(int i = angle; i > 0; i-=20){
        servo.write(i);
      }
    }
  }

  //State THREE: servo arm extention is directly above of the target(the photoCell)
  //This movement suggest a harder warning push back to 0 degrees

  // if((angle >= 165 && angle <= 180)){
  //   digitalWrite(ledRed, HIGH);
  //   currentTime = millis();
  //   if((currentTime >= timeInterval) && (angle > 0)){
  //     servo.write(angle - angle);
  //     //analogWrite(potPin, potvalue -= potvalue);
  //   }
  // }
  else{
    digitalWrite(ledGreen, LOW);
    digitalWrite(ledRed, HIGH);
  }
  // }


}
