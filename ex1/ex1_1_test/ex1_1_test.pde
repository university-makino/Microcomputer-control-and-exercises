// chap3 1

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;

//Arduino 及びプログラムの初期設定
void setup(){
    size(200, 100); // X, Yの大きさ
    arduino = new Arduino(
      this,
      "/dev/cu.usbserial-14P54810"
    );
}

//プログラム本体 (以下を繰り返し実行)
void draw(){
    // RGBで色指定をすることができる
    background(0,128,255); // R, G, Bの値
}
