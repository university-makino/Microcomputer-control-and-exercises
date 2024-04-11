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
