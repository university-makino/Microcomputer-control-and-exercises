// chap3_6

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 9; //Arduino D9 ピンの使用
int usePin1 = 3; //Arduino D3 ピンの使用

//Arduino 及びプログラムの初期設定
void setup(){
    size(350, 100);
    arduino = new Arduino(
        this, 
        "/dev/cu.usbserial-14P54810",
        57600
    );
    
    myFont = loadFont("CourierNewPSMT-48.vlw"); // フォントの指定
    textFont(myFont, 30); // フォントサイズの指定
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120); // 背景色を灰色に設定

    int sec = second(); //秒を返す変数
    String secString = "sec"  + sec; // "sec 14"などの文字列を作成

    // 0から255までの値を変化させる
    float amt = float(sec) / 59;
    float value = lerp(0, 255, amt);
    String valString = "value" + value;
    int outValue = round(value);
    arduino.analogWrite(usePin0, outValue);

    // 2秒毎にLEDの点灯・消灯を切り替える
    if( sec % 2 == 0 ){
        arduino.digitalWrite(usePin1, Arduino.LOW);
    } else {
        arduino.digitalWrite(usePin1, Arduino.HIGH);
    }
    text(secString, 15, 50);
    text(valString, 15, 80);
}

// 終了時の処理
void exit() {
    arduino.analogWrite(usePin0, 0);
    arduino.digitalWrite(usePin1, Arduino.LOW);
    super.exit();
}
