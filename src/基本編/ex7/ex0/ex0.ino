void setup(){
  pinMode(3,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
}

void loop(){
  analogWrite(3,255); // R
  analogWrite(5,255); // B
  analogWrite(6,255);  // G
  delay(1000);
}