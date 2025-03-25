/*
Rukayat Akinola
Processing Assignment #1

Concept:
The intial screen is a blank face drawn by function, buttonReleased()
When the button is pressed, the eyes should open
(visually, it fills in the pupils)
and the mouth should change shape and color
while, revealing the word "NO!"
*/

import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class
int buttonRead = 0; // creates variable for data coming from serial port

void setup() {
  size(800,600);
  background(127);
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
  
}

void draw(){
   if (myPort.available() > 0) // If data is available,...
  { 
    buttonRead = myPort.read();       // ...read it and store it in val
  }

  buttonReleased();
  
  //On buttonPress redraw face with pupils and new mouth
  // Include the letter "NO!" close to the mouth
  if (buttonRead == 1){
      background(127);
      
      fill(255);
      //draw the head
      ellipse(400, 300, 150, 150);

      //draw the eyes
      ellipse(375, 275, 30, 30);
      ellipse(325, 275, 30, 30);
      
      //black
      fill(0);
    
    //draw the pupils
    ellipse(320, 275, 10, 10);
    ellipse(370, 275, 10, 10);
    
    //red with some transperancy
    fill(255, 0, 0, 75);
    
    //draw open mouth
    arc(350, 315, 50, 80, 0, PI);
    line(325, 315, 375, 315);
    
    textSize(50);
    text ("NO!", 225, 340); 
  }
}

void buttonReleased(){
  if(buttonRead == 0){
     background(127);
  
    //white
    fill(255);
  
    //draw the head
    ellipse(400, 300, 150, 150);

    //draw the eyes
    ellipse(375, 275, 30, 30);
    ellipse(325, 275, 30, 30);

    //draw the mouth
    arc(350, 325, 80, 50, 0, 3.14);
    line(310, 325, 390, 325);
  } 
}
