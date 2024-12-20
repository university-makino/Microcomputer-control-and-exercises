// chap3_5
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int motorPin = 3;

void setup() {
    size(600, 300);
    
    //Arduinoの初期化
    arduino = new Arduino(this, "/dev/cu.usbserial-14P50091");
    
    //フォントの読み込みと設定
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    
    //フレームレートの設定
    frameRate(30);
}

String status = "stop";

void draw() {
    background(120);

    // モーターを出力
    if (status == "forward") {
        arduino.digitalWrite(motorPin, Arduino.HIGH);
    } else if (status == "stop") {
        arduino.digitalWrite(motorPin, Arduino.LOW);
    }

    // テキストの描画
    text("status: " + status, 50, 50);

    fill(255);
}

// マウスの動作でモーターを制御
void mousePressed() {
    if (status == "stop") {
        status = "forward";
    } else {
        status = "stop";
    }
}
