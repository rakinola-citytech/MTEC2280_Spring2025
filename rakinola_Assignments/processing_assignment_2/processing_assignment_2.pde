/*
Rukayat Akinola
Processing Assignment #2

Concept:
The player is a white small square that moves around the canvas use 2 potentiometers,
potOne controls the xAxis & potTwo controls the  yAxis.
The additional two button would serve has the controls to the three doors in the scene
The doors function like portals would in adventure games. When the player is directly on top of a door
When the hit the button_1 they will be teleported to another door in the scene. 
Or the player can randomize the locations of doors in the scene with button_2

Functionality Achieved:
Pot_1 and Pot_2 have been mapped to the x & Y axis of the player
but I keep receiving an out of bounds error that breaks it functionality

button_1  and button_2 allow the player to teleport from the doorOne to doorTwo,
doorTwo to doorThree, and etc. 
before the limitation of the pot array error sets-in again. 
the button_2 is currently not programmed to the randomized door location settings

Note: 
I've realized that this is a lot of functionality for a short class assignment
would like to revisit for a final project or more robust project. 
*/
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
  //pot_1 = int(map(val[2], -128, 127, 0, 255));
  xAxis = pot_1;
  println("x coordinates");
  println(val[2], pot_1, xAxis);
  //yMove
  //pot_2 = int(map(val[3], -128, 127, 0, 255));
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

void moveDoors(){
  if(canMoveDoors){
      for(int i = 0; i < 3; i++){
        //typecast float to int
        randX = int(random(25, 855));
        doorX[i] = randX;
        randY = int(random(25, 615));
        doorY[i] = randY;
        //println(i);
        //println(randX, randY);
      }
  }
 
  println(doorX);
  println(doorY);
  //redraw doors
  //draw Door One
  fill(0);
  text("DOOR", doorX[0]-5, doorY[0]-5);
  rect(doorX[0], doorY[0], 20, 20);
  
  //draw Door Two
  text("DOOR", doorX[1]-5, doorY[1]-5);
  rect(doorX[1], doorY[1], 20, 20);
 
  //draw Door Three
  text("DOOR", doorX[2]-5, doorY[2]);
  rect(doorX[2], doorY[2], 20, 20);
  
  noFill();
  rect(15, 15, 820, 620);
  
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
      
      pot_1 = int(map(val[2], 0, 1023, 20, width-30));
      pot_2 = int(map(val[3], 0, 1023, 20, height-30));
      
      //casting Byte button values to boolean
      b_1 = boolean(val[0]);
      b_2 = boolean(val[1]);
      
      println("button reads");
      println(b_1, b_2);
  }
}




  
