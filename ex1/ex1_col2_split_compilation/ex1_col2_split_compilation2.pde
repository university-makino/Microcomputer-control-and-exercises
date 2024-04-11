// chap3_4

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
