// ピンの指定
const int redPin = 3;
const int greenPin = 6;
const int bluePin = 5;
// ピンのセットアップ
void setup()
{
    pinMode(redPin, OUTPUT);
    pinMode(greenPin, OUTPUT);
    pinMode(bluePin, OUTPUT);
}

void loop()
{
    // グラデーションを行うループ
    fadeColor(0, 0, 255, 255, 0, 255, 2000);
    fadeColor(255, 0, 255, 255, 0, 0, 2000);
    fadeColor(255, 0, 0, 255, 255, 0, 2000);
    fadeColor(255, 255, 0, 0, 255, 0, 2000);
    fadeColor(0, 255, 0, 0, 255, 255, 2000);
    fadeColor(0, 255, 255, 0, 0, 255, 2000);
}

void fadeColor(int r1, int g1, int b1, int r2, int g2, int b2, int duration)
{
    // グラデーションの初期設定
    int steps = 255;
    // グラデーションを行う間隔を設定
    int stepDelay = duration / steps;

    // グラデーション開始
    for (int i = 0; i <= steps; i++)
    {
        // 0〜255の切り替えをr1~r2までの幅と同じスケールで変わっていくようにしてくれる
        int r = map(i, 0, steps, r1, r2);
        int g = map(i, 0, steps, g1, g2);
        int b = map(i, 0, steps, b1, b2);

        // 表示して
        analogWrite(redPin, r);
        analogWrite(greenPin, g);
        analogWrite(bluePin, b);
        // 短い間隔で止まる
        delay(stepDelay);
    }
}
