// chap3_5

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int analogPin1 = 1;
int analogPin2 = 2;

void setup() {
  size(600, 300);
  
  // Arduinoの初期化
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54810");
  
  // フォントの読み込みと設定
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont, 30);
  
  // フレームレートの設定
  frameRate(30);
}

int prevX = 0;
int prevY = 0;

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int x = arduino.analogRead(analogPin0);
  int y = arduino.analogRead(analogPin1);
  int z = arduino.analogRead(analogPin2);
  
  // 平滑化フィルターをかける
  float smoothness = 0.2; // 平滑化の度合いを調整する値
  x = (int)(x * smoothness + (1 - smoothness) * prevX);
  y = (int)(y * smoothness + (1 - smoothness) * prevY);
  
  fill(255);
  text("o", 300+( -1 * (x-536)), 150+ (y-488));//横
  
  // 前回の値を更新する
  prevX = x;
  prevY = y;
}
