// chap3_3

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int ledPin = 13; //Arduino D13 ピンの使用 LのLEDと連携している
color bgColor = color(0);

//Arduino 及びプログラムの初期設定
void setup(){
    size(250, 150);
    arduino = new Arduino(
        this, 
        "/dev/cu.usbserial-14P54810",
        57600
    );

    //ピンモードを出力モードに指定
    arduino.pinMode(ledPin,Arduino.OUTPUT);
    
    myFont = loadFont("CourierNewPSMT-48.vlw"); // フォントの指定
    textFont(myFont, 30); // フォントサイズの指定
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(bgColor);
}

//マウスのボタンが押された時の関数
void mousePressed(){
    //指定されたピンにデジタル値を出力
    arduino.digitalWrite(ledPin,Arduino.HIGH);
    bgColor = color(255, 0, 0);
}


//マウスのボタンから手を離した時の関数
void mouseReleased(){
    //指定されたピンにデジタル値を出力
    arduino.digitalWrite(ledPin,Arduino.LOW);
    bgColor = color(0);
}
