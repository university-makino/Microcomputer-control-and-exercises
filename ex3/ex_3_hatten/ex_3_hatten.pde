// chap3_5

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int analogPin1 = 1;

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
  int inputValue0 = arduino.analogRead(analogPin0);
  int inputValue1 = arduino.analogRead(analogPin1);
  
  // 入力値の表示
  text("A0: " + inputValue0, 50, 100);
  text("A1: " + inputValue1, 50, 125);
  
  // 状態の計算と表示
  Boolean lightStatus = getLightStatus(inputValue1);
  Boolean gravityStatus = getGravityStatus(inputValue0);
  Boolean status = (lightStatus && gravityStatus);
  
  text("LightStatus: " + lightStatus , 50, 150);
  text("GravityStatus: " + gravityStatus , 50, 175);
  text("Status: " + (status ? "LED ON" : "LED OFF") , 50, 200);
  
  arduino.digitalWrite(12,status ? Arduino.HIGH : Arduino.LOW);
}

// 入力値から状態を計算する関数
Boolean getLightStatus(int input) {
  
  // 不感帯の閾値
  int lightThreshold = 600;
  Boolean status = false;
  
  if( input < lightThreshold + hysteresis){
    status = true;
  } 
  if( input > lightThreshold - hysteresis){
    status = false;
  }
  
  return status;
}

Boolean getGravityStatus(int input){
  // 不感帯の閾値
  int gravityThreshold = 520;

  Boolean status = false;
  
  if( input < gravityThreshold + hysteresis){
    status = false;
  } 
  if( input > gravityThreshold - hysteresis){
    status = true;
  }
  
  return status;
  
}

// 90 4.8
// 37 7g
