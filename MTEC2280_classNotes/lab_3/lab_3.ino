/*
MTEC2280 - Spring2025
Lab_3
*/

//const int pinRGB = 38;

const int potPin = 2;
const int ledPin = 4;
const int numReads = 24; //number of reading in average
int reading[numReads];
int count = 0;


void setup() {
  // put your setup code here, to run once:
  analogReadResolution(11);
  Serial.begin(115200);

}

void loop() {
  // put your main code here, to run repeatedly:
  // int adcVal = analogRead(potPin);
  // Serial.printf("Pot = %i \n ", adcVal);
  // delay(500);

    if(analogRead(potPin) > 1000)  //if touchVal goes above threshold...
    {
      digitalWrite(ledPin, HIGH);    //turn on LED
    }
    else
    {
      digitalWrite(ledPin, LOW);    //turn off LED
    }

    reading[count] = analogRead(potPin);
    count++;

    if (count >= numReads){
      count = 0;
    }
    int sum = 0;
    for(int i = 0; i < numReads; i++){
      sum += reading[i];
    }

    int analogValue = sum / numReads;
    //map(input value, input low, input high, output low, output high)
    int mapVal = map(analogValue, 0, 1619, 0, 255);

    //rgbLedWrite(38, mapVal, 0, 0);  //set built-in rgbLED red level
    Serial.printf("ADC raw = %i \t ADC averaged = %i \t ADC mapped = %i \n", analogRead(potPin), analogValue, mapVal);
}

// const int touchPin = 11;  //can use any pin labelled TOUCH on ESP32
// const int ledPin = 4;

// int touchThreshold = 50000; //set this value based on measured touch threshold, adjust as needed

// void setup() 
// {
//   pinMode(ledPin, OUTPUT);
//   Serial.begin(115200);
// }

// void loop() 
// {
//   int touchVal = touchRead(touchPin); //read capacitive touch value

//   if (touchVal >= touchThreshold)  //if touchVal goes above threshold...
//   {
//     digitalWrite(ledPin, 1);    //turn on LED
//   }
//   else
//   {
//     digitalWrite(ledPin, 0);    //turn off LED
//   }

//   //adjust map values based on read input and desired output
//   //map(input value, input low, input high, output low, output high)
//   int mapVal = map(touchVal, 31110, 170000, 0, 1000);

//   Serial.printf("Touch Read = %i \t Touch Mapped = %i \n", touchVal, mapVal);
// }
