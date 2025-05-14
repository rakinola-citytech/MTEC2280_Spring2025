import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port object

boolean rxFlag = true;  //toggles sensor receive(rx) from arduino
boolean firstContact = false;
int numSensors = 4;
int[] val = {0, 0, 0, 0};

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
int doorChange = 0;

int b_1;
int b_2;

int [] doorOneX = {25, 840, 350};
int [] doorOneY = {60, 100, 250};

int [] doorTwoX = {850, 450, 450};
int [] doorTwoY = {250, 325, 325};

int [] doorThreeX = {350, 840, 200};
int [] doorThreeY = {600, 600, 500};

void setup() {
  size(900,650);
  
  xAxis = width/2;
  yAxis = height/2;
  
  potCenterX = 484;
  potCenterY = 490;
  
  
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
    println(b_1, b_2, pot_1, pot_2);
    //gamebounds
    noFill();
    rect(15, 15, 870, 620);
    
    //door stuff
    moveDoors();
    println("doorChange = ", doorChange);
    
    if(doorChange == 0){
      //draw Door One
      fill(0);
      text("DOOR", doorOneX[doorChange] - 5, doorOneY[doorChange] - 5);
      rect(doorOneX[doorChange], doorOneY[doorChange], 20, 20);
    }
     else if(doorChange == 1){
      //draw Door One
      fill(0);
      text("DOOR", doorOneX[doorChange] - 5, doorOneY[doorChange] - 5);
      rect(doorOneX[doorChange], doorOneY[doorChange], 20, 20);
    }
     else if(doorChange == 2){
      //draw Door One
      fill(0);
      text("DOOR", doorOneX[doorChange] - 5, doorOneY[doorChange] - 5);
      rect(doorOneX[doorChange], doorOneY[doorChange], 20, 20);
    }
    
      

  
    //draw Door Two
    //text("DOOR", d2X - 5, d2Y - 5);
    //rect(d2X, d2Y, 20, 20);
  
    //draw Door Three
    //text("DOOR", d3X - 5, d3Y - 5);
    //rect(d3X, d3Y, 20, 20);
    
    
    //GameBounds();
    //drawDoors(doorOneX[doorChange],doorTwoX[doorChange],doorThreeX[doorChange], 
    //doorOneY[doorChange],doorTwoY[doorChange],doorThreeY[doorChange]);
    //if((b_1 == 1) && (doorChange < 2)){
    //  doorChange += 1;
    //  drawDoors(doorOneX[doorChange],doorTwoX[doorChange],doorThreeX[doorChange], 
    //  doorOneY[doorChange],doorTwoY[doorChange],doorThreeY[doorChange]);
    //}
    //else
    //  doorChange = 0;
    //moveDoors();
    
    //if(pot_1 > (potCenterX + 5))
    //  xAxis += 1; 
    //if(pot_1 < (potCenterX - 5))
    //  xAxis -= 1; 
    //if(pot_2 > (potCenterY + 5))
    //  yAxis += 1; 
    //if(pot_2 < (potCenterY - 5))
    //  yAxis -= 1; 
    //drawPlayer();
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
  }
  myPort.write('A');  //send char 'A' if you want to receive more sensor data
  println(b_1, b_2, pot_1, pot_2);
}
void GameBounds(){
  //draw game boundaries
  noFill();
  rect(15, 15, 870, 620);
}

void drawDoors(int d1X, int d2X, int d3X, int d1Y, int d2Y, int d3Y){
  background(127);
    //draw Door One
  fill(0);
  text("DOOR", d1X - 5, d1Y - 5);
  rect(d1X, d1Y, 20, 20);
  
  //draw Door Two
  text("DOOR", d2X - 5, d2Y - 5);
  rect(d2X, d2Y, 20, 20);
  
  //draw Door Three
  text("DOOR", d3X - 5, d3Y - 5);
  rect(d3X, d3Y, 20, 20);
}

//int playerMoveX(){
//  if(pot_1 > (potCenterX + 5))
//    xAxis += 1; 
//  if(pot_1 < (potCenterX - 5))
//    xAxis -= 1; 
    
//  return(xAxis);
//}

//int playerMoveY(){
//  if(pot_2 > (potCenterY + 5))
//    yAxis += 1; 
//  if(pot_2 < (potCenterY - 5))
//    yAxis -= 1; 
    
//  return(yAxis);
//}

void drawPlayer(){
  xAxis = constrain(xAxis, 20, width-50);
  yAxis = constrain(yAxis, 20, height-50);
  //draw player in the center
  fill(255);
  rect(xAxis, yAxis, 20, 20);
  println(xAxis, yAxis);
}

void moveDoors(){
  if((b_2 == 0) && (doorChange < 2))
    doorChange += 1;
  else
    doorChange = 0;
}
