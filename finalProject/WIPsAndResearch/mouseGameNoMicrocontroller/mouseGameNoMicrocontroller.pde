/*
Rukayat Akinola
Processing Assignment #2 second copy

Concept:
The player is a white small square that moves around the canvas use 2 potentiometers,
potOne controls the xAxis & potTwo controls the  yAxis.
The additional two button would serve has the controls to the three doors in the scene
The doors function like portals would in adventure games. When the player is directly on top of a door
When the hit the button they will be teleported to another door in the scene. 
*/
int width = 900;
int height = 650;

//playerMovement
int xAxis = 450;
int yAxis = 325;
int currentX = 0;
int currentY = 0;


int[] doorX = new int[3];
int[] doorY = new int[3];

int randX;
int randY;

boolean canMoveDoors = false;

void setup() {
  size(900,650);
  background(127);
  
}

void draw() {
  
  background(127);
  drawDoors();
  drawPlayer();
  /*
  if(canMoveDoors){
    moveDoors();
  }*/
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
  //draw player in the center
  fill(255);
  rect(xAxis, yAxis, 20, 20);
  println(xAxis, yAxis);
  
  //playerMovement
  //xMove
  if((xAxis >= 20) && (xAxis <= 860)){
    if((keyPressed == true) && (keyCode == LEFT))
      xAxis -= 1;
    else if((keyPressed == true) && (keyCode == RIGHT))
      xAxis += 1;
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
  if((yAxis >= 20) && (yAxis <= 610)){
     if((keyPressed == true) && (keyCode == UP))
      yAxis -= 1; 
    else if((keyPressed == true) && (keyCode == DOWN))
      yAxis += 1;
  }
  else
    if(yAxis <= 20){
       yAxis = 20 + 1;
    }
    if(yAxis >=  height - 40){
        yAxis = (height - 41);
    }
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
/*
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
  rect(15, 15, 870, 620);
*/
}
void keyReleased(){
  //ASCII code for spaceBar = 32
  if(key == 32){
    //println("space");
    canMoveDoors = true;
    moveDoors();
  }
  else{
    canMoveDoors = false;
  }
}


  
