// 使用するピンを定義
const int ANODEPIN[] = {2, 3, 4, 5, 6, 7, 8, 9};
const int CATHODEPIN[] = {10, 11, 12, 14, 15, 16, 17, 18};

// 各方向のパターンマトリックスを定義
const int modo_1[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 0, 0, 1, 0, 0},
    {0, 0, 1, 0, 0, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};
const int modo_2[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};
const int modo_3[8][8] = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1}};
const int right[8][8] = {
    {0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0}};
const int left[8][8] = {
    {0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0}};
const int up[8][8] = {
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 1, 0, 1, 1, 0, 1, 0},
    {1, 0, 0, 1, 1, 0, 0, 1},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0}};
const int down[8][8] = {
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {1, 0, 0, 1, 1, 0, 0, 1},
    {0, 1, 0, 1, 1, 0, 1, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0}};
const int normal[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};

// タクトスイッチ用ピンを定義
const int switch_Pin = 13;

// タクトスイッチの状態を保持する変数
int switch_in;
int preStatus = HIGH;

// 起動状態を保持する変数
bool boot_status = true;

// ボタンを押したタイミングの時間を保持する変数
unsigned long startSecond = 0;
unsigned long count = 0;

// x, y, z の初期値と閾値を定義
int initialx, initialy, initialz;
const int xPin = 19;
const int yPin = 20;
const int zPin = 21;
const int THRESHOLD = 50;

// 初期化関数
void setup()
{
    pinMode(switch_Pin, INPUT_PULLUP);
    pinMode(xPin, INPUT);
    pinMode(yPin, INPUT);
    pinMode(zPin, INPUT);
    Serial.begin(9600);
    delay(1000);

    setupPins(); // ピンの初期化を行う関数

    // 初期値を取得
    initialx = analogRead(xPin);
    initialy = analogRead(yPin);
    initialz = analogRead(zPin);
}

// ループ関数
void loop()
{
    handleButtonPress(); // ボタンの状態を処理する関数

    if (boot_status)
    {
        showArrow();
    }
}

// ピンの初期化を行う関数
void setupPins()
{
    for (int ano = 0; ano < 8; ano++)
    {
        pinMode(ANODEPIN[ano], OUTPUT);
        digitalWrite(ANODEPIN[ano], LOW);
    }
    for (int cat = 0; cat < 8; cat++)
    {
        pinMode(CATHODEPIN[cat], OUTPUT);
        digitalWrite(CATHODEPIN[cat], HIGH);
    }
}

// ボタンの状態を処理する関数
void handleButtonPress()
{
    switch_in = digitalRead(switch_Pin);
    Serial.println("switch_in");
    Serial.println(switch_in);

    if (switch_in == HIGH && preStatus == LOW)
    {
        startSecond = millis();
        count = 0;
    }
    else if (switch_in == LOW && preStatus == HIGH)
    {
        count = (millis() - startSecond) / 1000;
        Serial.print(count);
        Serial.println("秒");

        if (count >= 2)
        {
            if (!boot_status)
            {
                Serial.println("起動");
                showStartupAnimation();
                boot_status = true;
            }
            else
            {
                Serial.println("終了");
                showShutdownAnimation();
                boot_status = false;
            }
            count = 0;
        }
    }
    preStatus = switch_in;
}

// 起動アニメーションを表示する関数
void showStartupAnimation()
{
    showMatrix(modo_1);
    showMatrix(modo_2);
    showMatrix(modo_3);
}

// 終了アニメーションを表示する関数
void showShutdownAnimation()
{
    showMatrix(modo_3);
    showMatrix(modo_2);
    showMatrix(modo_1);
}

// 矢印を表示する関数
void showArrow()
{
    int inx = analogRead(xPin) - initialx;
    int iny = analogRead(yPin) - initialy;
    int inz = analogRead(zPin) - initialz;
    Serial.print("x:");
    Serial.print(inx);
    Serial.print(" y:");
    Serial.print(iny);
    Serial.print(" z:");
    Serial.println(inz);

    if (inx > THRESHOLD)
    {
        showMatrix(left);
    }
    else if (inx < -THRESHOLD)
    {
        showMatrix(right);
    }
    else if (iny > THRESHOLD)
    {
        showMatrix(down);
    }
    else if (iny < -THRESHOLD)
    {
        showMatrix(up);
    }
    else
    {
        showMatrix(normal);
    }
}

// マトリックスを表示する関数
void showMatrix(const int matrix[8][8])
{
    for (int i = 0; i < 30; i++)
    {
        for (int cat = 0; cat < 8; cat++)
        {
            for (int ano = 0; ano < 8; ano++)
            {
                digitalWrite(ANODEPIN[ano], matrix[ano][cat]);
            }
            digitalWrite(CATHODEPIN[cat], LOW);
            delay(1);
            digitalWrite(CATHODEPIN[cat], HIGH);
        }
    }
}
