const int buzzer = 6;
const int trig_pin = 4;
const int echo_pin = 5;
float timing = 0.0;
float distance = 0.0;

void setup()
{
  pinMode(echo_pin, INPUT);
  pinMode(trig_pin, OUTPUT);
  pinMode(buzzer, OUTPUT);
  
  digitalWrite(trig_pin, LOW);
  digitalWrite(buzzer, LOW);
    
  Serial.begin(115200);
}

void loop()
{
  digitalWrite(trig_pin, HIGH);
  delay(10);
  digitalWrite(trig_pin, LOW);
  
  timing = pulseIn(echo_pin, HIGH);
  distance = (timing * 0.017) / 2;
  
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.print("cm | ");
  Serial.print(distance / 2.54);
  Serial.println("in");
  
    
  if (distance >= 1024) {
  	tone(buzzer, 500);
  } else {
  	noTone(buzzer);
  }
  
}