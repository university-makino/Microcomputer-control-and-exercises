// chap3_4

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int on = 0; //LED の輝度
int usePin = 3; //Arduino D3 ピンの使用

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
    //マウスのボタンが押された時の処理
    if (mousePressed == true) {
        on+= 8; //輝度を 8 加算
        if (on > 255) {
            on = 255;
        }
    } else {
        on-= 8; //輝度を 8 減算
        if (on < 0) {
            on = 0;
        }
    }

    if(on>0){
        background(255);
        fill(0);
        text("ON" , 100, 120);
    } else {
        background(0);
        fill(255);
        text("OFF" , 100, 120);
    }

    //指定されたピンにアナログ値を出力
    arduino.analogWrite(usePin,on);

}
