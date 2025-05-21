/*Rukayat Akinola
Final Project WIP#1

Project Updates:
Moving serial transmission from bytes to strings
Implemented XY Joystick
Fixed Array Out of Bounds Problem, well kinda
Mapped joystick to gameboard bounds but joystick moves very quickly and erractically



----------------------------- PROGRAM BEGINS HERE -----------------------------------------------*/
import processing.serial.*; //imports Serial library from Processing

Serial myPort; // creates object from Serial class
String myString = null; // create array of bytes for incoming serial port data

int lf = 10; //ASCII linefeed, newline equals 10

int[] val;

//playerMovement
int xAxis;
int yAxis;

int pot_1;
int pot_2;

boolean b_1;
boolean b_2;

int[] doorX = new int[3];
int[] doorY = new int[3];

int[] doorChangeX = new int[3];
int[] doorChangeY = new int[3];

int randX;
int randY;

boolean canMoveDoors = false;

void setup() {
  size(900,650);
  background(127);
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
  
  doorChangeX[0] = 30;
  doorChangeY[0] = 60;
  
  doorChangeX[1] = 800;
  doorChangeY[1] = 250;
  
  doorChangeX[2] = 350;
  doorChangeY[2] = 600;
}

void draw() {
  portConnect();
  background(127);
  drawDoors();
  drawPlayer(xAxis, yAxis);
  playerMove();
  if((!b_1) || (!b_2)){
    println("entered");
    if((xAxis == doorChangeX[0]+1) || (yAxis == doorChangeY[0]+1)) {
      xAxis = doorChangeX[1];
      yAxis = doorChangeY[1];
    }
    else if((xAxis == doorChangeX[1]+1) || (yAxis == doorChangeY[1]+1)){
      xAxis = doorChangeX[2];
      yAxis = doorChangeY[2];
    }
    else if((xAxis == doorChangeX[2]+1) || (yAxis == doorChangeY[2]+1)) {
      xAxis = doorChangeX[0];
      yAxis = doorChangeY[0];
    }
  }
}

void drawDoors(){
    //draw Door One
  fill(0);
  text("DOOR", 25, 55);
  rect(30, 60, 20, 20);
  
  //draw Door Two
  text("DOOR", 795, 245);
  rect(800, 250, 20, 20);
  
  //draw Door Three
  text("DOOR", 345, 595);
  rect(350, 600, 20, 20);
  
  noFill();
  rect(15, 15, 870, 620);
  
}

void playerMove(){
   //playerMovement
  //xMove
  xAxis = pot_1;
  println("x coordinates");
  println(val[2], pot_1, xAxis);
  //yMove
  yAxis = pot_2;
  println("y coordinates");
  println(val[3], pot_2, yAxis);
}

void drawPlayer(int xAxis, int yAxis){
  //draw player in the center
  fill(255);
  rect(xAxis, yAxis, 20,20);
  
  //println(xAxis, yAxis);
  
}


void portConnect(){
 if (myPort.available() > 0 ) //if there is data on UART serial port...
  {
    myString = myPort.readStringUntil(lf);  //read ASCII data into string until LINE FEED
    if (myString != null) //if the string contains data...
    {
      println(myString);  //print myString to serial monitor, only for debugging
      val = int(split(myString, ','));  //split string into array elements @ comma, cast into integer
      println(val);  //print val to serial monitor, only for debugging
      
      pot_1 = int(map(val[2], 0, 1023, 20, 900-40));
      pot_2 = int(map(val[3], 0, 1023, 20, 650-40));
      
      //casting Byte button values to boolean
      b_1 = boolean(val[0]);
      b_2 = boolean(val[1]);
      
      println("button reads");
      println(b_1, b_2);
    }
  }
}
