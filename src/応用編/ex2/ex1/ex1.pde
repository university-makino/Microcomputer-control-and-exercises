// chap3_5
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int motorForwardPin = 3;
int motorBackwardPin = 5;

enum MoveStatus{
    STOP,
    FORWARD,
    BACKWARD
};

void setup() {
    size(600, 300);
    
    //Arduinoの初期化
    arduino = new Arduino(this, "/dev/cu.usbserial-14P50091");
    
    //フォントの読み込みと設定
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    
    //フレームレートの設定
    frameRate(30);
}

MoveStatus status = MoveStatus.STOP;

void draw() {
    background(120);

    // モーターを出力
    if (status == MoveStatus.FORWARD) {
        arduino.digitalWrite(motorForwardPin, Arduino.HIGH);
        arduino.digitalWrite(motorBackwardPin, Arduino.LOW);
    } else if (status == MoveStatus.BACKWARD) {
        arduino.digitalWrite(motorForwardPin, Arduino.LOW);
        arduino.digitalWrite(motorBackwardPin, Arduino.HIGH);
    } else if (status == MoveStatus.STOP) {
        arduino.digitalWrite(motorForwardPin, Arduino.LOW);
        arduino.digitalWrite(motorBackwardPin, Arduino.LOW);
    }

    // テキストの描画
    text("status: " + status, 50, 50);

    fill(255);
}

// マウスの動作でモーターを制御
void mousePressed() {
    // 右クリックを押したら前進・後退を切り替える
    if (mouseButton == RIGHT) {
        if (status == MoveStatus.FORWARD) {
            status = MoveStatus.BACKWARD;
        } else if (status == MoveStatus.BACKWARD) {
            status = MoveStatus.FORWARD;
        } 
    } else {
        if (status == MoveStatus.STOP) {
            status = MoveStatus.FORWARD;
        } else  {
            status = MoveStatus.STOP;
        } 
    }
}
