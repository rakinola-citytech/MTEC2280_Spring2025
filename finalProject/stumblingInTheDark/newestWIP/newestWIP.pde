import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port object

boolean rxFlag = true;  //toggles sensor receive(rx) from arduino
boolean firstContact = false;
int numSensors = 4;
//int x;
//int y;  
//int xPos, yPos;
int[] val = {0, 0, 0, 0};

/// end of port stuff

//int width = 900;
//int height = 650;

//int lowestBound = 20;

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

void setup() {
  size(900,650);
  
  xAxis = width/2;
  yAxis = height/2;
  
  potCenterX = 485;
  potCenterY = 491;
  
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
    //data print
    //println(b_1, b_2, pot_1, pot_2);
    
    background(127);
    drawDoors();
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
  println(val);  //print val array to monitor
  
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

void drawDoors(){
  background(127);
    //draw Door One
  fill(0);
  text("DOOR", 25, 70);
  rect(30, 75, 20, 20);
  
  //draw Door Two
  text("DOOR", 845, 270);
  rect(850, 275, 20, 20);
  
  //draw Door Three
  text("DOOR", 345, 595);
  rect(350, 600, 20, 20);
  
  noFill();
  rect(15, 15, 870, 620);
  
}

void drawPlayer(){
  //draw player in the center at setup
  
  xAxis = constrain(xAxis, 20, width-50);
  yAxis = constrain(yAxis, 20, height-50);
  fill(255);
  rect(xAxis, yAxis, 20, 20);
  println(xAxis, yAxis);
  
  //playerMovement
  //xMove
  if((xAxis > 20) && (xAxis < 850)){
    if(pot_1 > (potCenterX + 5)){
      xAxis += 1;
    }
    if(pot_1 < (potCenterX - 5)){
      xAxis -= 1;
    }

  }
  else{
    if(xAxis <= 20){
      xAxis = 20 + 1;
    }
    if(xAxis >=  (width - 40)){
        xAxis = (width - 41);
    }
  }
    
  //yMove
  if((yAxis > 20) && (yAxis < 600)){
     if(pot_2 > (potCenterY - 5)){
      yAxis -= 1; 
     }
    if(pot_2 > (potCenterY + 5)){
      yAxis += 1;
    }
  }
  else{
    if(yAxis <= 20){
       yAxis = 20 + 1;
    }
    if(yAxis >=  height - 40){
        yAxis = (height - 41);
    }
  }
}
