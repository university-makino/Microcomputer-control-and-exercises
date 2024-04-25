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

// 入力値の格納用変数
int input0;

// 不感帯の閾値
int div1 = 300;
int div2 = 400;
int div3 = 480;
int div4 = 540;

// 状態の格納用変数
String status = "";

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);

    // 不感帯の設定
    if(input0 > div1 + 10){
        status = "0"; 
        
        if(input0 > div2 + 10){
            status = "1"; 

            if(input0 > div3 + 10){
                status = "2"; 

                if(input0 > div4 + 10){
                    status = "3"; 
                } else if(input0 < div4 - 10){
                    status = "2";
                }
            }else if(input0 < div3 - 10){
                status = "1";
            }
        }else if(input0 < div2 - 10){
            status = "0";
        }
    }else if(input0 < div1 - 10){
        status = "empty";
    }
    
    // 状態の表示
    text("Status: " + status, 50, 150);
}
