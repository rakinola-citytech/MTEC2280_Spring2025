/*
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
|||||||||||||||||||||||||||||||||||||||||||
||        "Serial HandShaking"           ||
|||||||||||||||||||||||||||||||||||||||||||

  - Bi-Directional Serial Communication between Microcontroller & Processing
  - Tansmits(Tx) and Receives (Rx) serial data
  - Uses serialEvent method to:
    - Receive sensor data from microcontroller
    - Transmit commands to microcontroller

  REFERENCE:
  https://processing.org/reference/libraries/serial/Serial_bufferUntil_.html
  https://processing.org/reference/libraries/serial/Serial_serialEvent_.html
<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
*/
import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port object

boolean rxFlag = true;  //toggles sensor receive(rx) from arduino
boolean firstContact = false;
int numSensors = 2;
int x;
int y;  
int xPos, yPos;
int[] val = {0, 0};

void setup() 
{
  size(500, 500);
  textAlign(CENTER, CENTER);
  textSize(16);
  strokeWeight(12);
  stroke(255);
  xPos = width/2;
  yPos = height/2;

  printArray(Serial.list());
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 115200);
  myPort.bufferUntil('\n');  // read bytes into a buffer until you get a linefeed (ASCII 10)
}

void draw() 
{
  if(!firstContact)  //draw text only if we haven't made first contact
  {
    background(0);  //set background color based on pot sensor values
    fill(255);
    text("WAITING FOR FIRST CONTACT", width/2, height/2);
  }
  else
  {
    background(127);
    
    if (x > 120)
    {
      xPos++;
    }
    if (x < 120)
    {
      xPos--;
    }
    if (y < 122)
    {
      yPos++;
    }
    if (y > 122)
    {
      yPos--;
    }
    
    xPos = constrain(xPos, 0, width);
    yPos = constrain(yPos, 0, height);
    circle(xPos, yPos, 30);
  }
}

void mousePressed()
{
  //if mouse is pressed within the pause button
  if(dist(mouseX, mouseY, width/2, height - 60) < 50 && mousePressed)
  {
    rxFlag = !rxFlag; //toggle rxFlag
  }
}

/*
  serialEvent method is called automatically by Processing whenever the buffer 
  reaches the byte value set in the bufferUntil() method in the setup():
*/

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
    x = val[0];
    y = val[1];
  }
    myPort.write('A');  //send char 'A' if you want to receive more sensor data
}
