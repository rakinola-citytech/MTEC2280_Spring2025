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

//playerMovement
int xAxis = 450;
int yAxis = 325;

int pot_1;
int pot_2;

int currentX = 0;
int currentY = 0;

//doors & stuff
int b_1;
int b_2;

//int[] doorX = new int[3];
//int[] doorY = new int[3];

//int[] doorChangeX = new int[3];
//int[] doorChangeY = new int[3];

//int randX;
//int randY;

//boolean canMoveDoors = false;

void setup() {
  size(900, 650);
  background(127);
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
  
  //doorChangeX[0] = 30;
  //doorChangeY[0] = 60;
  
  //doorChangeX[1] = 800;
  //doorChangeY[1] = 250;
  
  //doorChangeX[2] = 350;
  //doorChangeY[2] = 600;
}

void draw() {
  portConnect();
  
  background(127);
  drawDoors();
  drawPlayer(playerMoveX(), playerMoveY());
  //playerMove();
  //if((!b_1) || (!b_2)){
  //  println("entered");
  //  if((xAxis == doorChangeX[0]+1) || (yAxis == doorChangeY[0]+1)) {
  //    xAxis = doorChangeX[1];
  //    yAxis = doorChangeY[1];
  //  }
  //  else if((xAxis == doorChangeX[1]+1) || (yAxis == doorChangeY[1]+1)){
  //    xAxis = doorChangeX[2];
  //    yAxis = doorChangeY[2];
  //  }
  //  else if((xAxis == doorChangeX[2]+1) || (yAxis == doorChangeY[2]+1)) {
  //    xAxis = doorChangeX[0];
  //    yAxis = doorChangeY[0];
  //  }
  //}
}

void drawDoors(){
  fill(0);
  
  //draw Door One
  text("DOOR", 20, 55);
  rect(25, 60, 20, 20);
  
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
//void playerMove(){
//   //playerMovement
//  //xMove
//  //pot_1 = int(map(val[2], -128, 127, 0, 255));
//  xAxis = pot_1;
//  println("x coordinates");
//  println(val[2], pot_1, xAxis);
//  //yMove
//  //pot_2 = int(map(val[3], -128, 127, 0, 255));
//  yAxis = pot_2;
//  println("y coordinates");
//  println(val[3], pot_2, yAxis);
//}

//void moveDoors(){
//  if(canMoveDoors){
//      for(int i = 0; i < 3; i++){
//        //typecast float to int
//        randX = int(random(25, 855));
//        doorX[i] = randX;
//        randY = int(random(25, 615));
//        doorY[i] = randY;
//        //println(i);
//        //println(randX, randY);
//      }
//  }
 
//  println(doorX);
//  println(doorY);
//  //redraw doors
//  //draw Door One
//  fill(0);
//  text("DOOR", doorX[0]-5, doorY[0]-5);
//  rect(doorX[0], doorY[0], 20, 20);
  
//  //draw Door Two
//  text("DOOR", doorX[1]-5, doorY[1]-5);
//  rect(doorX[1], doorY[1], 20, 20);
 
//  //draw Door Three
//  text("DOOR", doorX[2]-5, doorY[2]);
//  rect(doorX[2], doorY[2], 20, 20);
  
//  noFill();
//  rect(15, 15, 820, 620);
  
//}

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

int playerMoveX(){
  if(pot_1 > 735)
    xAxis += 1;
    
  else if(pot_1 < 725)
    xAxis -= 1;
    
  else
    xAxis += 0;
  
  println(xAxis);
  return(xAxis);
}

int playerMoveY(){
  if(pot_2 > 746)
    yAxis += 1;
    
  if(pot_2 < 730)
    yAxis -= 1;
    
  else
      yAxis += 0;
  
  println(yAxis);
  return(yAxis);
}

void drawPlayer(int x, int y){
  //draw player in the center
  fill(255);
  rect(x, y, 20,20);
  
  //println(xAxis, yAxis);
  
}


void enterDoors(int x, int y){
  if((x == 25) && (y == 60))
    drawPlayer(xAxis+850, yAxis+250);
}





  
