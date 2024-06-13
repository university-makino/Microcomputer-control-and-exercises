// chap 4 8 0
int usePin[] = {2,3,4,6,7,8,9};

void setup(){
    Serial.begin(9600);
    for(int i = 0; i < 7; i++){
        pinMode(usePin[i], OUTPUT);
    }
}

void loop(){
    //13～18 行目のコメント文をそれぞれ外したり付けたりして調べる
    digitalWrite(usePin[0], HIGH);
    digitalWrite(usePin[1], HIGH);
    digitalWrite(usePin[2], HIGH);
    digitalWrite(usePin[3], HIGH);
    digitalWrite(usePin[4], HIGH);
    digitalWrite(usePin[5], HIGH);
    digitalWrite(usePin[6], HIGH);
}