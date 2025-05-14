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
int b_1;
int b_2;

int [] doorOneX = {25, 840, 150};
int [] doorOneY = {50, 50, 80};

int [] doorTwoX = {850, 350, 450};
int [] doorTwoY = {250, 300, 250};

int [] doorThreeX = {350, 840, 750};
int [] doorThreeY = {600, 600, 530};

int checkOneX;
int checkOneY;
int checkTwoX;
int checkTwoY;
int checkThreeX;
int checkThreeY;

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
    
    //drawDoors 
    drawDoors(doorOneX[b_1], doorTwoX[b_1], doorThreeX[b_1], doorOneY[b_1], doorTwoY[b_1], doorThreeY[b_1]);
    println(checkTwoX, checkTwoY, doorTwoX[b_1], doorTwoY[b_1]);
    //enterDoors
    enterDoors();
    
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
  }
  myPort.write('A');  //send char 'A' if you want to receive more sensor data
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
  checkOneX = constrain(doorOneX[b_1], doorOneX[b_1]-2, doorOneX[b_1]+2);
  checkOneY = constrain(doorOneY[b_1], doorOneY[b_1]-2, doorOneY[b_1]+2);
  checkTwoX = constrain(doorTwoX[b_1], doorTwoX[b_1]-2, doorTwoX[b_1]+2);
  checkTwoY = constrain(doorTwoY[b_1], doorTwoY[b_1]-2, doorTwoY[b_1]+2);
  checkThreeX = constrain(doorThreeX[b_1], doorThreeX[b_1]-2, doorThreeX[b_1]+2);
  checkThreeY = constrain(doorThreeY[b_1], doorThreeY[b_1]-2, doorThreeY[b_1]+2);

  if((xAxis == checkOneX) && (yAxis == checkOneY) && (b_2 == 0)){
    xAxis = doorTwoX[b_1];
    yAxis = doorTwoY[b_1];
  }
  if((xAxis == checkTwoX) && (yAxis == checkTwoY) && (b_2 == 0)){
    xAxis = doorThreeX[b_1];
    yAxis = doorThreeY[b_1];
  }
  if((xAxis == checkThreeX) && (yAxis == checkThreeY) && (b_2 == 0)){
    xAxis = doorOneX[b_1];
    yAxis = doorOneY[b_1];
  }
}

    
