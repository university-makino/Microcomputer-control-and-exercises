// chap3_5

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int digitalPin2 = 2;

void setup() {
  size(600, 250);
  
  // Arduinoの初期化
  arduino = new Arduino(this, "/dev/cu.usbserial-AI02PP00");
  
  // フォントの読み込みと設定
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont, 30);
  
  // フレームレートの設定
  frameRate(30);
}


void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int inputValue = arduino.analogRead(analogPin0);
  
  // 入力値の表示
  text("A0: " + inputValue, 50, 100);
  
  if(inputValue > 800) {
    // デジタルピンの出力をHIGHにする
    arduino.digitalWrite(digitalPin2, Arduino.HIGH);
    delay(2000);
    arduino.digitalWrite(digitalPin2, Arduino.LOW);
  } else {
    // デジタルピンの出力をLOWにする
    arduino.digitalWrite(digitalPin2, Arduino.LOW);
  }
}

