// chap3 7 2:

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino; 
PFont myFont;

int usePin0 = 0; //Arduino A0 ピンの使用
int usePin1 = 2; //Arduino D2 ピンの使用

//Arduino 及びプログラムの初期設定
void setup(){
    size(400, 200);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P54810"
    );
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);

    //ピンモードを入力モードに指定 
    arduino.pinMode(usePin0,Arduino.INPUT);
    arduino.pinMode(usePin1,Arduino.INPUT);
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);

    //アナログ入力値の表示
    String analog0 = "Analog0 = " + arduino.analogRead(usePin0);

    //デジタル入力値の表示
    String digital0 = "Digital0 = " + arduino.digitalRead(usePin1);
    text(analog0, 15, 30); 
    text(digital0, 15, 90); 
}

