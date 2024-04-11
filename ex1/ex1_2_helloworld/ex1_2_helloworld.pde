// chap3_2

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

//Arduino 及びプログラムの初期設定
void setup(){
    size(300, 100);
    arduino = new Arduino(
        this, 
        "/dev/cu.usbserial-14P54810"
    );
    
    myFont = loadFont("CourierNewPSMT-48.vlw"); // フォントの指定
    textFont(myFont, 30); // フォントサイズの指定
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120); // 背景の色
    text("Hello World", 15, 50); // 文字, x座標, y座標
}
