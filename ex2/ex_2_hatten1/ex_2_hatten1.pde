// chap3_5

//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 0; //Arduino A0ピン

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

int input0;

int closeDiv = 600;
int distantDiv = 200;

String status = "";

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);

    // 
    if(input0 > closeDiv){
        status = "close"; 
    }

    if(input0 < distantDiv){
        status = "distant";
    }

    text("Status: " + status, 50, 150);


    if(status.equals("close")){
        //Statusの表示
        text("Status: " + status, 50, 150);
        
    }else if(status.equals("distant")){ 
        //distant の時の処理
        text("Status: " + status, 50, 150);

    }

    
}
