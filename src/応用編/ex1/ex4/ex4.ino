// chap5.1.2ex
int ANODEPIN[] = {2, 3, 4, 5, 6, 7, 8, 9};
int CATHODEPIN[] = {10, 11, 12, 14, 15, 16, 17, 18};
int modo_1[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 0, 0, 1, 0, 0},
    {0, 0, 1, 0, 0, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};
int modo_2[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};
int modo_3[8][8] = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1}};
int right[8][8] = {
    {0, 0, 0, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 1, 0},
    {0, 0, 0, 0, 0, 1, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0}};
int left[8][8] = {
    {0, 0, 0, 1, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {0, 1, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1},
    {0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0}};
int up[8][8] = {
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 1, 0, 1, 1, 0, 1, 0},
    {1, 0, 0, 1, 1, 0, 0, 1},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0}};
int down[8][8] = {
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0},
    {1, 0, 0, 1, 1, 0, 0, 1},
    {0, 1, 0, 1, 1, 0, 1, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 1, 1, 0, 0, 0}};
int normal[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 1, 1, 1, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0}};

int switch_Pin = 13;           // タクトスイッチ用ピン
int switch_in;                 // 　タクトスイッチのデジタル値保存用
int preStatus = HIGH;           // タクトスイッチの前回の状態保存用
bool boot_status = true;        // 起動状態保存用(trueは起動状態)
unsigned long startSecond = 0; // ボタンを押したタイミングの秒数保存用
unsigned long count = 0;       // 　ボタンを押した時間の長さ保存用

// x,y,zの初期値保存用
int initialx, initialy, initialz;
int xPin = 19;
int yPin = 20;
int zPin = 21;
// 初期値と入力値の誤差保存用
int inx, iny, inz;
int THRESHOLD = 50;

void setup()
{
    pinMode(switch_Pin, INPUT_PULLUP); // スイッチピンをインプットに指定
    pinMode(xPin, INPUT);
    pinMode(yPin, INPUT);
    pinMode(zPin, INPUT);
    Serial.begin(9600);         // シリアル通信
    delay(1000);                // 初期化処理待ち
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
    // 初期化
    initialx = analogRead(xPin);
    initialy = analogRead(yPin);
    initialz = analogRead(zPin);
}
void loop()
{
    switch_in = digitalRead(switch_Pin); // タクトスイッチの現状態（high or low）を保存
    Serial.println("switch_in");
    Serial.println(switch_in);           // デバッグ用
    // ボタンの処理
    if (switch_in == HIGH && preStatus == LOW)
    {                           // ボタンを押した時
        startSecond = millis(); // ボタンを押し始めたタイミングの秒数を記録（ミリ秒単位）
        count = 0;              // ボタンを押した時間の長さを初期化
    }
    else if (switch_in == LOW && preStatus == HIGH)
    {                                            // ボタンを離した時
        count = (millis() - startSecond) / 1000; // ボタンを押している時間を計算（秒単位）
        Serial.print(count);                     // デバッグ用
        Serial.println("秒");
        // 　ボタンが2秒以上押された時のマトリクスの処理
        if (count >= 2 && boot_status == false)
        {                             // ボタンが2秒以上押された時かつ終了状態
            Serial.println("起動");   // デバッグ用
            showMatrix(modo_1);       // アニメーションの表示
            showMatrix(modo_2);       // アニメーションの表示
            showMatrix(modo_3);       // アニメーションの表示
            count = 0;                // 同じ処理を繰り返さないためにボタンを押した時間の長さを初期化
            boot_status = !boot_status; // 起動状態に切り替え
        }
        else if (count >= 2 && boot_status == true)
        {                             // ボタンが2秒以上押された時かつ起動状態
            Serial.println("終了");   // デバッグ用
            showMatrix(modo_3);       // アニメーションの表示
            showMatrix(modo_2);       // アニメーションの表示
            showMatrix(modo_1);       // アニメーションの表示
            count = 0;                // 同じ処理を繰り返さないためにボタンを押した時間の長さを初期化
            boot_status = !boot_status; // 終了状態に切り替え
        }
    }
    preStatus = switch_in; // タクトスイッチの前状態（high or low）を保存

    if(boot_status){
        showAllow();
    }
}

void showAllow(){
    inx = analogRead(xPin) - initialx;
    iny = analogRead(yPin) - initialy;
    inz = analogRead(zPin) - initialz;
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

void showMatrix(int matrix[8][8])
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