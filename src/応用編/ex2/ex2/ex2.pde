// chap3_5
import processing.serial.*;
import cc.arduino.*;

Arduino motorArduino;
Arduino sensorArduino;
PFont myFont;

// Arduinoのピン
int motorPoworPin = 3;
int motorDirectionPin = 5;
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
    sensorArduino = new Arduino(this, "/dev/cu.usbserial-14P54810");
    
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
    println("accX: " + accX + ", accY: " + accY + ", accZ: " + accZ);

    // 動作を判定
    status = checkMoveStatus(accX, accY, accZ);

    // モーターを出力
    if (status == MoveStatus.FORWARD) {
        motorArduino.digitalWrite(motorPoworPin, Arduino.HIGH);
        motorArduino.digitalWrite(motorDirectionPin, Arduino.LOW);
    } else if (status == MoveStatus.BACKWARD) {
        motorArduino.digitalWrite(motorPoworPin, Arduino.HIGH);
        motorArduino.digitalWrite(motorDirectionPin, Arduino.HIGH);
    } else if (status == MoveStatus.STOP) {
        motorArduino.digitalWrite(motorPoworPin, Arduino.LOW);
        motorArduino.digitalWrite(motorDirectionPin, Arduino.LOW);
    }

    // テキストの描画
    text("status: " + status, 50, 50);

    fill(255);
}

final int THRESHOLD = 100;
final int DEADZONE = 100;

MoveStatus checkMoveStatus(int accX, int accY, int accZ) {
    if (accX > THRESHOLD + DEADZONE) {
        return MoveStatus.FORWARD;
    }
    if (accX < THRESHOLD - DEADZONE && accX > 0) {
        return MoveStatus.STOP;
    }

    if (accX > -THRESHOLD + DEADZONE && accX < 0) {
        return MoveStatus.STOP;
    }
    if (accX < -THRESHOLD - DEADZONE) {
        return MoveStatus.BACKWARD;
    }
    return MoveStatus.STOP;
}
