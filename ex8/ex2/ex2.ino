// chap 4 8 1
int usePin[] = {2,3,4,6,7,8,9};
int intMatrix[10][7] = {
    {1, 1, 1, 1, 1, 1, 0}, // 0
    {0, 0, 1, 1, 0, 0, 0}, // 1
    {1, 1, 0, 1, 1, 0, 1}, // 2
    {0, 1, 1, 1, 1, 0, 1}, // 3
    {0, 0, 1, 1, 0, 1, 1}, // 4
    {0, 1, 1, 0, 1, 1, 1}, // 5
    {1, 1, 1, 0, 1, 1, 1}, // 6
    {0, 0, 1, 1, 1, 1, 0}, // 7
    {1, 1, 1, 1, 1, 1, 1}, // 8
    {0, 0, 1, 1, 1, 1, 1}  // 9
};
void setup(){
    for(int a = 0; a < sizeof(usePin); a++){
        pinMode(usePin[a], OUTPUT);
    }
}

void loop(){
  int min = (millis() / 1000) % 10;
  for(int a = 0; a < sizeof(usePin); a++){
    digitalWrite(usePin[a], intMatrix[min][a]);
  }
}