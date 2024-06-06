// ピンの設定
int motorPin = 3;
int xPin = 0;
int yPin = 1;
int zPin = 2;

// 状態を保存する変数
String status = "";

// 加速度センサーの閾値
int DISTANCE_THRESHOLD = 100;

// 加速度センサーの値を保存する変数
long x = 0;
long y = 0;
long z = 0;
// ノルムを保存する変数
double norm = 0;
// 値を中央に持ってくるための値
int X_HALF_VALUE = 530;
int Y_HALF_VALUE = 495;
int Z_HALF_VALUE = 744;

void setup() {
    // ピンの設定
    pinMode(motorPin, OUTPUT);
    pinMode(xPin, INPUT);
    pinMode(yPin, INPUT);
    pinMode(zPin, INPUT);

    // シリアル通信の設定
    Serial.begin(9600);
}

void loop(){
    
    // 加速度センサーの値を取得 0を中央にするため平らな時の値を引く
    x = analogRead(xPin) - X_HALF_VALUE;
    y = analogRead(yPin) - Y_HALF_VALUE;
    z = analogRead(zPin) - Z_HALF_VALUE;

    // ノルムを計算　（角度の大きさを取ればいいので、各加速度の大きさを混ぜてしまう）
    norm = valueMaxMin(sqrt(x*x + y*y + z*z), 1024, 0);
    // Debugプリント
    Serial.println("x: " + String(x) + " y: " + String(y) + " z: " + String(z) + " norm: " + String(norm));

    // ノルムの値によって状態を変更 （ふかんたい）
    if(norm < DISTANCE_THRESHOLD - 50){
        status = "backward";
    }
    if(norm > DISTANCE_THRESHOLD + 50){
        status = "forward";
    }

    // 状態によってモーターを制御
    if(status == "forward"){
        analogWrite(motorPin, 255);
    }else if(status == "backward"){
        analogWrite(motorPin, 0);
    }

    delay(100);
}

// 値を最大値と最小値の間に収める関数
int valueMaxMin(int value, int max, int min){
    if(value > max){
        return max;
    }else if(value < min){
        return min;
    }else{
        return value;
    }
}