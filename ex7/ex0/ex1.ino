void setup(){
  pinMode(3,OUTPUT);
}

void loop(){

  int r = random(0,255);
  int b = random(0,255);
  int g = random(0,255);

  analogWrite(3,r); // R
  analogWrite(5,b); // B
  analogWrite(6,g);  // G
  delay(1000);
}