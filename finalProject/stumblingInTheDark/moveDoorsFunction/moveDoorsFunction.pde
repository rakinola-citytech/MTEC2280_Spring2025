int [] doorOneX = {25, 840, 350};
int [] doorOneY = {60, 100, 250};

int doorChange;

int lastTime;
int currentTime;
int timeInterval = 1;

void setup(){
  size(900, 650);
  
  doorChange = 0;
  
  //game boundd
  noFill();
  rect(15, 15, 870, 620);
}

void draw(){
  
  //if(keyReleased() == true){
  //  println("entered");
  //  doorChange += 1;
  //  println("doorChange  = ", doorChange);
  //}  
  currentTime = millis();
  keyReleased();
  println("doorChange  = ", doorChange);
  
  
  fill(0);
  text("DOOR", doorOneX[doorChange] - 5, doorOneY[doorChange] - 5);
  rect(doorOneX[doorChange], doorOneY[doorChange], 20, 20);
}

void keyReleased(){
  lastTime = currentTime;
  //keyCode = Space bar
  if((keyCode == 32) && (doorChange < 2) && (currentTime-lastTime == 1)){
          doorChange += 1;
  }
  //else
    //doorChange = 0;
}
