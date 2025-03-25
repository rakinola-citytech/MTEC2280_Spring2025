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
  my intial problem was when I wrote code for independent servo movement 
  it become out of sync with the potentiometer. 
  Now, the servo ignores the potentiometer unless the button is pressed
  This allows me to always reset the Potentiometer to 0, to re-sync it with the servo angle. 
  */
  if(buttonRead == 1){
    servo.write(angle); 
  }
  
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
    
    /* While included a 1000 millis (1 second) timer. 
    I don't feel it too necessary for the circuit.
    The angle > 0 logic, however allows the circuit to ignore input that isn't the arm extension.
    So, the angle doesn't attempt to return to 0 from other interferences. 
    */
    if((currentTime >= timeInterval) && (angle > 0)){
       servo.write(angle - angle);
    }
   
  }
  else{
    //reset timer
    currentTime = 0;

    //reset LED light signals for range
    digitalWrite(ledGreen, HIGH);
    digitalWrite(ledRed, LOW);
  }
  // }
}
