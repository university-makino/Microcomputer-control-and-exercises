import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int analogPin1 = 1;

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

// 前回の値を保持する変数
int prevX = 0;
int prevY = 0;
int count = 0;
String status = "None";
final float SMOOTHNESS = 0.2;
final int THRESHOLD = 70;

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int x = readAndSmooth(analogPin0, prevX);
  int y = readAndSmooth(analogPin1, prevY);
  
  // 状態を更新
  if (status != "None" && count < 30) {
    count++;
  } else {
    count = 0;
    status = getStatus(x, y);
  }
  
  // 状態に応じて表示位置を変更
  displayStatus(status);
  
  // 前回の値を更新する
  prevX = x;
  prevY = y;
}

// アナログピンからの入力を取得し、平滑化する
int readAndSmooth(int pin, int prevValue) {
  int value = arduino.analogRead(pin);
  return (int)(value * SMOOTHNESS + (1 - SMOOTHNESS) * prevValue);
}

// 状態を取得する
String getStatus(int x, int y) {
  if (prevX - x > THRESHOLD) {
    return "Left";
  } else if (prevX - x < -THRESHOLD) {
    return "Right";
  } else if (prevY - y > THRESHOLD) {
    return "Down";
  } else if (prevY - y < -THRESHOLD) {
    return "Up";
  }
  return "None";
}

// 状態に応じて表示位置を変更する
void displayStatus(String status) {
  fill(255);
  switch (status) {
    case "Left":
      text("o", 230, 150);
      break;
    case "Right":
      text("o", 370, 150);
      break;
    case "Up":
      text("o", 300, 70);
      break;
    case "Down":
      text("o", 300, 220);
      break;
    default:
      text("o", 300, 150);
      break;
  }
}
