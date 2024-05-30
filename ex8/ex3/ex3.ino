// chap 4 8 1
int usePin[] = {2,3,4,6,7,8,9};
int intMatrix[8][7] = {
    {1, 0, 0, 0, 0, 0, 0}, // 0
    {0, 1, 0, 0, 0, 0, 0}, // 1
    {0, 0, 1, 0, 0, 0, 0}, // 2
    {0, 0, 0, 0, 0, 0, 1}, // 3
    {0, 0, 0, 0, 0, 1, 0}, // 4
    {0, 0, 0, 0, 1, 0, 0}, // 5
    {0, 0, 0, 1, 0, 0, 0}, // 6
    {0, 0, 0, 0, 0, 0, 1}, // 7
};

void setup(){
    for(int a = 0; a < sizeof(usePin); a++){
        pinMode(usePin[a], OUTPUT);
    }
}

void loop(){
  for(int i = 0; i < 8 ; i++){
    for(int a = 0; a < sizeof(usePin); a++){
      digitalWrite(usePin[a], intMatrix[i][a]);
    }
    delay(100);
  }
}