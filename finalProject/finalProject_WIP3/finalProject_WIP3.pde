/*
Rukayat Akinola
Final Project WIP#2

Implemented XY Joystick
Fixed Array Out of Bounds Problems
Implemented Player Moving Between Doors

----------------------------- PROGRAM BEGINS HERE -----------------------------------------------*/

import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class

String myString = null; // create array of bytes for incoming serial port data

int lf = 10; //ASCII linefeed, newline equals 10

int[] val;

//sketch sizes
int width = 900;
int height = 650;

int lowestBound = 20;

//playerMovement
int xAxis = 450;
int yAxis = 325;

int pot_1;
int pot_2;

int potCenterX = 746;
int potCenterY = 710;

//doors & stuff
int b_1;
int b_2;

void setup(){
  size(900, 650);
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
  
}

void draw(){
  portConnect();
  println(xAxis, yAxis);
  
  //game protocol
  background(127);
  drawDoors();
  if(((xAxis > lowestBound) && (xAxis < width - 50)) && ((yAxis > lowestBound) && (yAxis < height - 50))){
    //println("entered");
    drawPlayer(playerMoveX(),playerMoveY());
  }
  else{
    if(xAxis <= 20){
       xAxis = lowestBound + 1;
    }
    if(xAxis >=  width - 50){
        xAxis = (width - 51);
    }
    if(yAxis <= 20){
       yAxis = lowestBound + 1;
    }
    if(yAxis >=  height - 50){
        yAxis = (height - 51);
    }
    //drawPlayer(xAxis, yAxis);
  }
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
      b_1 = val[0];
      b_2 = val[1];
      
      //potentiometer variables
      pot_1 = val[2]; 
      pot_2 = val[3];
      
      //println("button reads");
      println(b_1, b_2, pot_1, pot_2);
    }
  }
}

void drawDoors(){
  fill(0);
  
  //draw Door One
  text("DOOR", lowestBound, 55);
  rect(lowestBound + 5, 60, 20, 20);
  
  //draw Door Two
  text("DOOR", width-55, 245);
  rect(width-50, 250, 20, 20);
  
  //draw Door Three
  text("DOOR", 345, height-55);
  rect(350, height-50, 20, 20);
  
  //gameboard Boundary
  noFill();
  rect(lowestBound - 5, lowestBound - 5, width - 30, height - 30);
  
}

int playerMoveX(){
  if(pot_1 > (potCenterX + 8)){
    xAxis += 1;
  }
  else if (pot_1 < (potCenterX - 8)){
    xAxis -= 1;
  }
  
  //println(xAxis);
  return (xAxis);
}

int playerMoveY(){
  if(pot_2 > (potCenterY + 8)){
    yAxis += 1;
  }
  else if (pot_2 < (potCenterY - 8)){
    yAxis -= 1;
  }
  //println(yAxis);
  return (yAxis);
}

void drawPlayer(int x, int y){
  //drawPlayer
  fill(255);
  rect(x, y, 20, 20);
  
 // println(x, y);
}
