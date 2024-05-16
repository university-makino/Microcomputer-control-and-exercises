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
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54810");
  
  // フォントの読み込みと設定
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont, 30);
  
  // フレームレートの設定
  frameRate(30);
}

int plusCount = 0;
int animationStatus = 0;
String animationString = "";

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int inputValue = arduino.analogRead(analogPin0);
  
  // 入力値の表示
  text("A0: " + inputValue, 50, 100);
  text("animation: " + animationString, 50, 150);
  
  // 入力に応じてアニメーションを更新
  if(inputValue > 800) {
    plusCount++;
    if(plusCount >= 15){
      plusCount = 0;
      animationStatus = constrain(animationStatus + 1, 0, 5);
      updateAnimation();
    } 
  } else {
    plusCount = 0;
  }
}

// アニメーションを更新
void updateAnimation() {
  animationString = getAnimationString(animationStatus);
  text("animation: " + animationString, 50, 150);
}


String getAnimationString(int status){
  switch(status){
    case 0:
      return ".";
    case 1:
      return "o";
    case 2:
      return "0";
    case 3:
      return "O";
    case 4:
      return "0";
    case 5:
      animationStatus = -1;
      return "o";
    default:
      return "";
  }
}
