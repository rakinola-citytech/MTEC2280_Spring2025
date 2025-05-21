/*
Rukayat Akinola
Final Project Submission

HOW IT SHOULD WORK: 
The sketch draws a boundaried gameboard that house three doors labeled "DOOR".
The player character is a much smaller white square controlled by the joystick.
The button is the joystick allows the player to choose between three orientation
of the doors in the scene by cycling through and array of DOOR co-ordinates.
The extra button should allow the player to similarly port through the doors in the scene.
From the top most door to the center scene door and from there to the bottom most door
in the scene, the cycle repeats. There's a golden snitch that appears in the scene on 10 second intervals. 
The player can "caught" the snitch (periodically appearing yellow square) by pressing the extra button

FUNCTIONALITY CUTS: 
The full intent of the project was to teleport around the scene to caught a golden object
that randomly appears but time constraints caused me to focus on functionality isn't of scale and true gameplay. 
*/


import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port object

boolean rxFlag = true;  //toggles sensor receive(rx) from arduino
boolean firstContact = false;
int numSensors = 5;
int[] val = {0, 0, 0, 0, 0};

//end of port stuff
int width = 900;
int height = 650;

int lowestBound = 20;

//playerMovement
int xAxis;
int yAxis;

int pot_1;
int pot_2;

int potCenterX;
int potCenterY;

//doors & stuff
int b_1;
int b_2;

int [] doorOneX = {30, 840, 150};
int [] doorOneY = {50, 50, 80};

int [] doorTwoX = {830, 350, 450};
int [] doorTwoY = {250, 300, 250};

int [] doorThreeX = {350, 840, 750};
int [] doorThreeY = {570, 570, 530};

boolean checkOneX;
boolean checkOneY;
boolean checkTwoX;
boolean checkTwoY;
boolean checkThreeX;
boolean checkThreeY;

//caught stuff
boolean appear;

int [] xPos = {645, 800, 300};
int [] yPos = {200, 600, 200};

boolean checkXpos;
boolean checkYpos;

int time;
int next;

//setup
void setup() {
  size(900,650);
  
  xAxis = width/2;
  yAxis = height/2;
  
  potCenterX = 484;
  potCenterY = 490;
  
  checkOneX = false;
  checkOneY = false;
  checkTwoX = false;
  checkTwoY = false;
  checkThreeX = false;
  checkThreeY = false;
  
  appear = false;
  next = 0;
  
  //Serial Port setup
  printArray(Serial.list()); // this line prints the port list to the console
  String portName = Serial.list()[2]; //change the number in the [] for the port you need
  myPort = new Serial(this, portName, 115200);  //open selected port at given baud rate
  myPort.bufferUntil('\n');  // read bytes into a buffer until you get a linefeed (ASCII 10)
}

void draw() {
   if(!firstContact)  //draw text only if we haven't made first contact
  {
    background(0);  //set background color based on pot sensor values
    fill(255);
    text("WAITING FOR FIRST CONTACT", width/2, height/2);
  }
  else{
    background(127);
    //serial coms value print
    println(b_1, b_2, pot_1, pot_2, time, next);
    
    //drawDoors 
    drawDoors(doorOneX[b_1], doorTwoX[b_1], doorThreeX[b_1], doorOneY[b_1], doorTwoY[b_1], doorThreeY[b_1]);
    println(checkOneX, checkOneY, doorOneX[b_1], doorOneY[b_1]);
    println(checkTwoX, checkTwoY, doorTwoX[b_1], doorTwoY[b_1]);
    println(checkThreeX, checkThreeY, doorThreeX[b_1], doorThreeY[b_1]);
    //enterDoors
    enterDoors();
    
    //caught
    if(time == 1){
      appear = true;
    }
    else{
      appear = false;
    }
    drawSnitch();
    
    //playerMove
    if(pot_1 > (potCenterX + 5))
      xAxis += 1; 
    if(pot_1 < (potCenterX - 5))
      xAxis -= 1; 
    if(pot_2 > (potCenterY + 5))
      yAxis += 1; 
    if(pot_2 < (potCenterY - 5))
      yAxis -= 1; 
    drawPlayer();
    
  }
}

// add portConnect
void serialEvent(Serial myPort) 
{
  if (!firstContact)  //if we have not yet made first contact...
  {
    firstContact = true;  //...then this is our first contact, set it to TRUE
  }
  String myString = myPort.readStringUntil('\n');  // read the serial buffer
  //print(myString);  //print contents of serial buffer (note we are NOT using println since this message contains lineFeed)
  val = int(split(myString, ','));  // split the string at the commas and convert the sections into integers
  //println(val);  //print val array to monitor
  
  if (val.length >= numSensors) //store sensors values once we have received all of them
  {
    b_1 = val[0];
    b_2 = val[1];
    
    pot_1 = val[2];
    pot_2 = val[3];
    
    time = val[4];
    //next = val[5];
    
  }
  myPort.write('A');  //send char 'A' if you want to receive more sensor data
}

void drawDoors(int d1X, int d2X, int d3X, int d1Y, int d2Y, int d3Y){
  background(127);
    //draw Door One
  fill(0);
  text("DOOR", d1X, d1Y-5);
  rect(d1X, d1Y, 30, 30);
  
  //draw Door Two
  text("DOOR", d2X, d2Y-5);
  rect(d2X, d2Y, 30, 30);
  
  //draw Door Three
  text("DOOR", d3X, d3Y-5);
  rect(d3X, d3Y, 30, 30);
  
  //gamebounds
  noFill();
  rect(15, 15, 870, 620);
  
}

void drawPlayer(){
  xAxis = constrain(xAxis, 20, width-50);
  yAxis = constrain(yAxis, 20, height-50);
  //draw player in the center
  fill(255);
  rect(xAxis, yAxis, 20, 20);
  println(xAxis, yAxis);
}

void enterDoors(){
  if(xAxis >= doorOneX[b_1] && xAxis <= doorOneX[b_1]+30){
    checkOneX = true;
  }
  else
    checkOneX = false;
  if(yAxis >= doorOneY[b_1] && yAxis <= doorOneY[b_1]+30){
    checkOneY = true;
  }
  else
    checkOneY = false;
  if(xAxis >= doorTwoX[b_1] && xAxis <= doorTwoX[b_1]+30){
    checkTwoX = true;
  }
  else
    checkTwoX = false;
  if(yAxis >= doorTwoY[b_1] && yAxis <= doorTwoY[b_1]+30){
    checkTwoY = true;
  }
  else
    checkTwoY = false;
  if(xAxis >= doorThreeX[b_1] && xAxis <= doorThreeX[b_1]+30){
    checkThreeX = true;
  }
  else
    checkThreeX = false;
  if(yAxis >= doorThreeY[b_1] && yAxis <= doorThreeY[b_1]+30){
    checkThreeY = true;
  }
  else
    checkThreeY = false;

  if((checkOneX) && (checkOneY) && (b_2 == 1)){
    xAxis = doorTwoX[b_1]-2;
    yAxis = doorTwoY[b_1]-2;
  }
  if((checkTwoX) && (checkTwoY) && (b_2 == 1)){
    xAxis = doorThreeX[b_1]-2;
    yAxis = doorThreeY[b_1]-2;
  }
  if((checkThreeX) && (checkThreeY) && (b_2 == 1)){
    xAxis = doorOneX[b_1]-2;
    yAxis = doorOneY[b_1]-2;
  }
}
void drawSnitch(){
  if (appear){
    println("here");
    color c = color(255,255,0);
    fill(c);
    rect(xPos[next], yPos[next], 25, 25);
  }
  if(xAxis >= xPos[next] && xAxis<= xPos[next]+25){
    checkXpos = true;
  }
  else
    checkXpos = false;
  if(yAxis >= yPos[next] && yAxis <= yPos[next]+25){
    checkYpos = true;
  }
  else
    checkYpos = false;
    
  if(checkXpos && checkYpos && (b_2 == 1) && (next < 2)){
    text("NICE", xPos[next]-5, yPos[next]-5);
    next += 1;
    //text("PLEASE RESTART GAME!!", 30, 30);
  }
  if(checkXpos && checkYpos && (b_2 == 1) && (next == 2)){
    text("NICE", xPos[next]-5, yPos[next]-5);
    next = 0;
  }
}

    
