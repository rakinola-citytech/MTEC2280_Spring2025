/*
Rukayat Akinola
Spring'25 - MTEC2280
Midterm Project Version_2

Description: I intend to use a pot to control a servo, with an arm extension. 
The arm extension would act like a real hand obstructing a photocell.
The photocell like an annoyed sibling will return the servo arm away some predetermined degree
*/

#include <ESP32Servo.h>
Servo servo; // create Servo object

//analog sensors (potentiometer,photocell)
const int potPin = 5;
const int photoPin = 6;

//digital sensor (pushButton)
const int buttonPin = 7;

// circuit LED's and their functions
const int ledGreen = 10; 
const int ledRed = 11; 

//timer controls
int currentTime = 0 ;
const int timeInterval = 1000;

//arm extension servo attachment
const int servoPin = 4;

//analog & digital controls
int potRead;
int angle;

int photoRead;
int buttonRead;


void setup() {
  // put your setup code here, to run once:
  pinMode(ledGreen, OUTPUT);
  //pinMode(ledBlue, OUTPUT);
  pinMode(ledRed, OUTPUT);

  servo.attach(servoPin);

  pinMode(potPin, INPUT);
  pinMode(photoPin, INPUT);
  pinMode(buttonPin, INPUT);

  analogReadResolution(8);
  Serial.begin(115200);

}

void loop() {
  
  //potReads & servoControl
  potRead = analogRead(potPin);
  angle = map(potRead, 0, 255, 0, 180);\
  
  /*I introduced a button to control the Potentiometer and servo angle incongurence.
  my intial problem was, I wrote code for independent servo movement 
  it become out of sync with the potentiometer. 
  Now, the servo ignores the potentiometer unless the button is pressed
  */
  if(buttonRead == 1){
    servo.write(angle); 
  }
  //servo.write(angle);
  
  photoRead = analogRead(photoPin);
  buttonRead = digitalRead(buttonPin);

  //variable tracking
  Serial.printf("currentTime = %i, timeInterval = %i \n", currentTime, timeInterval);
  Serial.printf("Potvalue = %i, ServoAngle = %i, button = %i, photoCell = %i \n", potRead, angle, buttonRead, photoRead);

  /*I also truncated the states of the project to just one state
  The photocell did not provide me a lot of ranges to work with.
  So the current system only senses when the arm extension is directly above the photocell.
  The LED in the circuit signal RED (above photocell) or GREEN (not above photocell).
  */
   if((photoRead >= 145) && (photoRead <= 185)){
    currentTime = millis();
    digitalWrite(ledRed, HIGH);
    digitalWrite(ledGreen, LOW);
    if((currentTime >= timeInterval) && (angle > 0)){
       servo.write(angle - angle);
    }
   
  }
  else{
    digitalWrite(ledGreen, HIGH);
    digitalWrite(ledRed, LOW);
  }
  // }
}
