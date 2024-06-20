// chap3_5
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int motorForwardPin = 3;
int motorBackwardPin = 5;
int accSensorPinX = 0;
int accSensorPinY = 1;
int accSensorPinZ = 2;

MoveStatus status = MoveStatus.STOP;
int preValueX = 0;
int preValueY = 0;
int preValueZ = 0;

enum MoveStatus{
    STOP,
    FORWARD,
    BACKWARD
};

void setup() {
    size(600, 300);
    
    //Arduinoの初期化
    motorArduino = new Arduino(this, "/dev/cu.usbserial-14P50091");
    sensorArduino = new Arduino(this, "/dev/cu.usbmodem1411");
    
    //フォントの読み込みと設定
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    
    //フレームレートの設定
    frameRate(30);

    // センサの初期状態を取得
    preValueX = sensorArduino.analogRead(accSensorPinX);
    preValueY = sensorArduino.analogRead(accSensorPinY);
    preValueZ = sensorArduino.analogRead(accSensorPinZ);
}

void draw() {
    background(120);

    // センサを読み込む
    int accX = sensorArduino.analogRead(accSensorPinX) - preValueX;
    int accY = sensorArduino.analogRead(accSensorPinY) - preValueY;
    int accZ = sensorArduino.analogRead(accSensorPinZ) - preValueZ;

    // 動作を判定
    status = checkMoveStatus(accX, accY, accZ);

    // モーターを出力
    if (status == MoveStatus.FORWARD) {
        motorArduino.digitalWrite(motorForwardPin, Arduino.HIGH);
        motorArduino.digitalWrite(motorBackwardPin, Arduino.LOW);
    } else if (status == MoveStatus.BACKWARD) {
        motorArduino.digitalWrite(motorForwardPin, Arduino.LOW);
        motorArduino.digitalWrite(motorBackwardPin, Arduino.HIGH);
    } else if (status == MoveStatus.STOP) {
        motorArduino.digitalWrite(motorForwardPin, Arduino.LOW);
        motorArduino.digitalWrite(motorBackwardPin, Arduino.LOW);
    }

    // テキストの描画
    text("status: " + status, 50, 50);

    fill(255);
}

final int THRESHOLD = 100;
final int DEADZONE = 30;

MoveStatus checkMoveStatus(int accX, int accY, int accZ) {
    if (accX > THRESHOLD + DEADZONE) {
        return MoveStatus.FORWARD;
    }
    if (accX < THRESHOLD - DEADZONE) {
        return MoveStatus.STOP;
    }

    if (accX > -THRESHOLD + DEADZONE) {
        return MoveStatus.STOP;
    }
    if (accX < -THRESHOLD - DEADZONE) {
        return MoveStatus.BACKWARD;
    }
}
