/*
Rukayat Akinola
Processing Assignment #1 

Concept:
The intial screen is a blank face
On mousePressed, the eyes should open (
visually, it fills in the pupils)
and the mouth should change shape and color
while, revealing the word "NO!"


NOTE: 
This half of the programming controls and collects 
the button inputs passed into variable buttonRead. 
*/

const int buttonPin = 7;
int buttonRead = 0;

//software timer variables
int lastTime = 0;
int currentTime = 0;
int timerInterval = 20; //not reliable with values less than 20ms

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPin, INPUT);

  Serial.begin(115200);     // Start serial communication @ 115200 baud rate
}

void loop() {
  // put your main code here, to run repeatedly:
   //we don't want or need to send updates to serial port so often, so use a timer:
   currentTime = millis(); //read current elapsed time
   if (currentTime - lastTime >= timerInterval)  //if we have reached our timer interval...
   {
    lastTime = currentTime; //store current time as last time so we know when timer last occured
    buttonRead = digitalRead(buttonPin);
    
    //Serial. printf("button = %i \n", buttonRead);
    Serial.write(buttonRead);
   }
}
