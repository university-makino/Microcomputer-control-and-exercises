// chap3 1

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

//Arduino 及びプログラムの初期設定
void setup(){
    size(200, 100);
    arduino = new Arduino(
    this, ”/dev/cu.usbserial-14P54810”);
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
}
