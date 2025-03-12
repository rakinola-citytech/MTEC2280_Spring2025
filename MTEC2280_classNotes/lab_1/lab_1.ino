/*
Akinola Rukayat
Spring'25 - MTEC2280
Lab_1
*/

int count = 0; //global variable, script wide-scope
int pin = 4;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); //starts serial comms at spec, Baud Spec
  pinMode(pin, OUTPUT);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  
  // if (count <= 10){
  //   Serial.println("Hello World!!");
  //   count += 1;
  //   delay(500); //wait time in milliseconds
  // }
  // else {
  //   Serial.println("GoodBye World!!");
  // }

  digitalWrite(pin, HIGH);
  delay(500);
  

  


}
