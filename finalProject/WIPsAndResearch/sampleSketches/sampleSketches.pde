/*
Rukayat Akinola
Final Project WIP#1

Implemented XY Joystick
Fixed Array Out of Bounds Problems
Implemented Player Moving Between Doors

----------------------------- PROGRAM BEGINS HERE -----------------------------------------------*/

import processing.serial.*; //imports Serial library from Processing
Serial myPort; // creates object from Serial class
String myString = null; // create array of bytes for incoming serial port data
int lf = 10; //ASCII linefeed, newline equals 10
int[] val;
//size 
int width = 900;
int height = 650;

//Player Movement
int xAxis;
int yAxis;

int button1;
int button2;

void setup(){
  size(900, 650);
  background(127);
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
}

void draw(){
  portConnect();
  
  background(127);
  drawDoors();
  drawPlayer(xAxis, yAxis);
  
}

void portConnect(){
 if (myPort.available() > 0 ) //if there is data on UART serial port...
  {
    myString = myPort.readStringUntil(lf);  //read ASCII data into string until LINE FEED
    
    if (myString != null) //if the string contains data...
    {
      println(myString);  //print myString to serial monitor, only for debugging
      val = int(split(myString, ','));  //split string into array elements @ comma, cast into integer
      //println(val);  //print val to serial monitor, only for debugging
      
      //button variables
      button1 = val[0];
      button2 = val[1];
      
      //potentiometer variables
      xAxis = int(map(val[2], 0, 1023, 25, 850));
      yAxis = int(map(val[3], 0, 1023, 25, 600));
      
      //print val to serial monitor, only for debugging
      println(button1, button2, xAxis, yAxis);
    }
  }
}

void drawDoors(){
  fill(0);
  
  //draw Door One
  text("DOOR", 25, 55);
  rect(30, 60, 20, 20);
  
  //draw Door Two
  text("DOOR", 845, 245);
  rect(850, 250, 20, 20);
  
  //draw Door Three
  text("DOOR", 345, 595);
  rect(350, 600, 20, 20);
  
  //gameboard Boundary
  noFill();
  rect(15, 15, 870, 620);
  
}

void drawPlayer(int x, int y){
  //draw player in the center
  fill(255);
  rect(x, y, 20,20);
}
