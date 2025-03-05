/*
Akinola Rukayat
Spring2025 - MTEC2280
Assignment_1
*/

//randomNumber variable, pattern change counter, and pattern 3 & 4 count variable
long randNum;
int choice = 0;

//button pin number
const int buttonPin = 18;

// button variables
int buttonValue = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  //ESP pins setup
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(buttonPin, INPUT);

  //randomNumber generator setup 
  //this setup should ensures a different number generatered each time
  //note: this isn't 100% effective
  randomSeed(analogRead(0));
}

void loop() {
  //button input check & choice counter
  buttonValue = digitalRead(buttonPin);
  Serial.print("choice = ");
  Serial.print(choice);
  Serial.println();
  Serial.print("buttonPin = ");
  Serial.print(buttonValue);
  Serial.println();
  delay(500);


  //cycle through the four pattern with each button press
  if((buttonValue == 1) && (choice < 5)){
    choice += 1;
  }
  //reset counter
  if((buttonValue == 1) && (choice == 5)){
    choice = 0;
  }
  
  //pattern one (Using a randomNumber generator to choose the pins)
  if(choice == 1){
    randNum = random(4,8); //interval [4,8] = 4,5,6,7
    Serial.print("randNum = ");
    Serial.print(randNum);
    Serial.println();
    digitalWrite(randNum, HIGH);
    delay(500);
    digitalWrite(randNum, LOW);
  }
  //pattern two(LED 4,5 on - LED 6,7 on -  LED 4,5 off - LED 6,7 off)
  else if(choice == 2){
    digitalWrite(4,HIGH);
    digitalWrite(5,HIGH);
    delay(500);
    digitalWrite(6,HIGH);
    digitalWrite(7,HIGH);
    delay(500);
    digitalWrite(4,LOW);
    digitalWrite(5,LOW);
    delay(500);
    digitalWrite(6,LOW);
    digitalWrite(7,LOW);
  }
  //pattern three(turn all the LED on from 4 through 7 using a  for loop)
  else if(choice == 3){
    for(int i = 4; i < 8; i++){
      Serial.print("i = ");
      Serial.print(i);
      Serial.println();
      digitalWrite(i, HIGH);
      delay(500);
    }
  }
  //pattern four(turn all the LED off from 7 through 4 using a  for loop)
  else if(choice == 4){
     for(int i = 7; i > 3; i--){
      Serial.print("i = ");
      Serial.print(i);
      Serial.println();
      digitalWrite(i,LOW);
      delay(500);
    }
  }
  else{
    //note: this is the default state, at choice = 0.
    digitalWrite(4, LOW);
    digitalWrite(5, LOW);
    digitalWrite(6, LOW);
    digitalWrite(7, LOW);
  }



  
  
    
  
 
}
