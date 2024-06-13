// chap3_5

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 3; //Arduino D3 ピンの使用
int usePin1 = 9; //Arduino D9 ピンの使用
int on0=0,on1=0;

//Arduino 及びプログラムの初期設定
void setup(){
    size(250, 250);
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
    //右クリックまたは左クリックされた時
    if (on0 == 1 || on1 == 1) {
        background(255);
        fill(0);
        text("ON" , 100, 120);
    } else {
        background(0);
        fill(255);
        text("OFF" ,100, 120);
    }

    //指定されたピンにアナログ値を出力
    arduino.analogWrite(usePin0, on0 * 255);
    arduino.analogWrite(usePin1, on1 * 255);
}

void mousePressed() {
    //マウスの左ボタンが押された時
    if(mouseButton==LEFT){
        on0 = 1;
    }
    //マウスの右ボタンが離された時
    if(mouseButton==RIGHT){
        on1 = 1;
    }
}

void mouseReleased() {
    //マウスの左ボタンが離された時
    if(mouseButton==LEFT){
        on0 = 0;
    }
    //マウスの右ボタンが離された時
    if(mouseButton==RIGHT){
        on1 = 0;
    }
}
