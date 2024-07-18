//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
Arduino arduino2;

PFont myFont;

int usePin0 = 0; //Arduino A0ピン
int usePin2 = 2;
int useMotorPin1 = 7;
int useMotorPin2 = 9;

//Arduino 及びプログラムの初期設定
void setup(){
    size(600, 250);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P50091"
    );
    
    arduino2 = new Arduino(this, "/dev/cu.usbserial-14P54762", 57600); // Arduinoのシリアルポートを設定

    
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);

    //ピンモードの設定
    arduino.pinMode(usePin0, Arduino.INPUT);
    arduino.pinMode(usePin2, Arduino.INPUT_PULLUP);
    arduino.pinMode(useMotorPin1, Arduino.OUTPUT);
    arduino.pinMode(useMotorPin2, Arduino.OUTPUT);
    
    
    
}

// 入力値の格納用変数
int input0;
int input1;

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    input1 = arduino.digitalRead(usePin2);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);
    text("D2: " + input1, 50, 150);

    // 回している量の表示
    shine(input0/100);

    //モーターの制御
    if(input0 >= 500){
        arduino.digitalWrite(useMotorPin1, Arduino.HIGH);
    }else{
        arduino.digitalWrite(useMotorPin1, Arduino.LOW);
    }
    
    if(input1 == 0){
        
        arduino.digitalWrite(useMotorPin2, Arduino.LOW);
    }else{
        arduino.digitalWrite(useMotorPin2, Arduino.HIGH);
    }
}

int[] usePin = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 };

void shine(int num) {
    for (int i = 0; i < usePin.length; i++) {
        if (i < num) {
            arduino2.digitalWrite(usePin[i], Arduino.HIGH); // 指定された個数だけLEDを点灯
        } else {
            arduino2.digitalWrite(usePin[i], Arduino.LOW); // それ以外のLEDは消灯
        }
    }
}
