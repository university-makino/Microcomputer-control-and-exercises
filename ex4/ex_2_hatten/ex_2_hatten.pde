// chap3_5

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;

// 不感帯の閾値
/*
int threshold1 = 300;
int threshold2 = 400;
int threshold3 = 480;
int threshold4 = 540;
*/

int blackThreshold = 860;
int grayThreshold2 = 520;
int grayThreshold1 = 122;
int whiteThreshold = 60;

// 不感帯の幅
int hysteresis = 20;

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
  
  // 状態の計算と表示
  String status = getStatus(inputValue);
  text("Status: " + status, 50, 150);
}

// 入力値から状態を計算する関数
String getStatus(int input) {
  
  String status = "";
  
  if (input > whiteThreshold + hysteresis){
    status = "white";
  }
  if(input > grayThreshold1 + hysteresis){
    status = "gray";
  }
  if (input > grayThreshold2 + hysteresis){
    status = "gray";
  }
  if (input > blackThreshold + hysteresis){
    status = "black";
  }
  
  
  if (input < blackThreshold - hysteresis ){
    status = "gray";
  }
  if (input < grayThreshold2 - hysteresis ){
    status = "gray";
  }
  if (input < grayThreshold1 - hysteresis ){
    status = "white";
  }
  if (input < whiteThreshold - hysteresis ){
    status = "white";
  }
  
  
  
  return status;
  
}

// 90 4.8
// 37 7g