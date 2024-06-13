int motorPin = 3;
int distanceSensorPin = 0;

int distance = 0;
int DISTANCE_THRESHOLD = 400;
String status = "";


void setup() {
    pinMode(motorPin, OUTPUT);
    pinMode(distanceSensorPin, INPUT);
    Serial.begin(9600);
}

void loop(){
    distance = analogRead(distanceSensorPin);
    Serial.println(distance);
    if(distance < DISTANCE_THRESHOLD - 50){
        status = "forward";
    }
    if(distance > DISTANCE_THRESHOLD + 50){
        status = "backward";
    }

    if(status == "forward"){
        analogWrite(motorPin, 255);
    }else if(status == "backward"){
        analogWrite(motorPin, 0);
    }

    delay(100);
}