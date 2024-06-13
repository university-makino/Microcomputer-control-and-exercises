
int motorPin = 3;

void setup() {
    pinMode(motorPin, OUTPUT);
    Serial.begin(9600);
}

void loop(){
    for(int i = 0; i < 255; i++){
        analogWrite(motorPin,i);
        delay(4000);
        Serial.println(i);
    }
}