/*
Akinola Rukayat
Spring2025 - MTEC2280
Assignment_2
note: same logic as assignment_1 but here the button is a toggle
*/

//randomNumber variable, pattern change counter, and pattern 3 & 4 count variable
long randNum;
int choice = 0;

//button pin number
const int buttonPin = 9;

// button variables
bool buttonValue;
bool toggle;
bool lastButtonState;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);

  //ESP pins setup
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);

  //randomNumber generator setup 
  //this setup should ensures a different number generatered each time
  //note: this isn't 100% effective
  randomSeed(analogRead(0));
}

void loop() {
  //button input check & choice counter
  buttonValue = !digitalRead(buttonPin);
 
  if(buttonValue && !lastButtonState){
    toggle = !toggle;
  }

  Serial.printf("buttonState = %i, toggle = %i, choice = %i \n", buttonValue, toggle, choice);
  delay(500);
  lastButtonState = buttonValue;


  //cycle through the four pattern with each button press
  if((toggle == 1) && (choice < 5)){
    choice += 1;
  }
  //reset counter
  if((toggle == 1) && (choice > 4)){
    choice = 0;
  }
  
  //pattern one (Using a randomNumber generator to choose the pins)
  if(choice == 1){
    randNum = random(4,8); //interval [4,8] = 4,5,6,7
    Serial.printf("randNum = %i \n", randNum);
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
      Serial.printf("i = %i \n", i);
      digitalWrite(i, HIGH);
      delay(500);
    }
  }
  //pattern four(turn all the LED off from 7 through 4 using a  for loop)
  else if(choice == 4){
     for(int i = 7; i > 3; i--){
      Serial.printf("i = %i \n", i);
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
