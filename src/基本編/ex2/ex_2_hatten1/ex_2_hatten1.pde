// chap3_5

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 0; //Arduino A0ピン
int usePin1 = 3; //Arduino A1ピン

//Arduino 及びプログラムの初期設定
void setup(){
    size(600, 250);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P54810"
    );
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}

// 入力値の格納用変数
int input0;

// 不感帯の閾値
int closeDiv = 600;
int distantDiv = 400;

// 状態の格納用変数
String status = "";

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);

    // 不感帯の設定
    if(input0 > closeDiv){
        status = "close"; 
    }

    if(input0 < distantDiv){
        status = "distant";
    }

    // 状態の表示
    text("Status: " + status, 50, 150);

    // 状態に応じた処理
    if(status.equals("close")){
        //close の時の処理
        arduino.analogWrite(usePin1, 255);
    }else if(status.equals("distant")){ 
        //distant の時の処理
        arduino.analogWrite(usePin1, 0);
    }
}
