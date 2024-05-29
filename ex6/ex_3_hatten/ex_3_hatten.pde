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
int count = 0;
String status = "None";

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int x = arduino.analogRead(analogPin0);
  int y = arduino.analogRead(analogPin1);
  //int z = arduino.analogRead(analogPin2);
  
  println(x);
  
  // 平滑化フィルターをかける
  float smoothness = 0.2; // 平滑化の度合いを調整する値
  x = (int)(x * smoothness + (1 - smoothness) * prevX);
  y = (int)(y * smoothness + (1 - smoothness) * prevY);
  
  fill(255);
   //text("o", 300+( -1 * (x-536)), 150+ (y-488));//横

  if(status != "None" && count < 30){
    count++;
  }else{
    count = 0;
    status = getStatus(x, y);
  }
  
  println(status);

  if(status == "Left"){
    text("o", 230, 150);
  }else if(status == "Right"){
    text("o", 370, 150);
  }else if(status == "Up"){
    text("o", 300, 70);
  }else if(status == "Down"){
    text("o", 300, 220);
  }else{
    text("o", 300, 150);
  }
  
  // 前回の値を更新する
  prevX = x;
  prevY = y;
}

String getStatus(int x , int y){
  
  println(prevX - x);
  println(prevY - y);
  
  if(prevX - x > 70){
    return "Left";
  }else if(prevX - x < -70){
    return "Right";
  }else if(prevY - y > 70){
    return "Down";
  }else if(prevY - y < -70){
    return "Up";
  }

  return "None";
}
