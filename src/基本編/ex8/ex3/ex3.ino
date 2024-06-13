// chap 4 8 1

// ボタンの接続されているピン番号
int buttonPin = 12;

// 使用するLEDのピン番号
int usePin[] = {2, 3, 4, 6, 7, 8, 9};

// LEDの点灯パターンを定義した2次元配列
int intMatrix[8][7] = {
    {1, 0, 0, 0, 0, 0, 0}, // パターン0
    {0, 1, 0, 0, 0, 0, 0}, // パターン1
    {0, 0, 1, 0, 0, 0, 0}, // パターン2
    {0, 0, 0, 0, 0, 0, 1}, // パターン3
    {0, 0, 0, 0, 0, 1, 0}, // パターン4
    {0, 0, 0, 0, 1, 0, 0}, // パターン5
    {0, 0, 0, 1, 0, 0, 0}, // パターン6
    {0, 0, 0, 0, 0, 0, 1}, // パターン7
};

// ボタンの状態を保存する変数
int buttonState = 0;
int oldButtonState = 0;

// ループの停止フラグ
bool stopFlag = true;

void setup() {
  // 使用するピンを出力モードに設定
  for(int a = 0; a < sizeof(usePin)/sizeof(usePin[0]); a++) {
    pinMode(usePin[a], OUTPUT);
  }
  
  // ボタンのピンを入力プルアップモードに設定
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // 8つのパターンを順に実行
  for(int i = 0; i < 8; i++) {
    // 各パターンのLEDの状態を設定
    for(int a = 0; a < sizeof(usePin)/sizeof(usePin[0]); a++) {
      digitalWrite(usePin[a], intMatrix[i][a]);
    }

    // 100回のループを実行
    for(int j = 0; j < 100; j++) {
      do {
        // ボタンの状態を読み取る
        buttonState = digitalRead(buttonPin);

        // ボタンが押された時の処理
        if((buttonState == HIGH) && (oldButtonState == LOW)) {
          stopFlag = !stopFlag; // フラグを反転させる
        }

        // 前回のボタンの状態を保存
        oldButtonState = buttonState;

        delay(1); // 1ミリ秒待機
      } while(stopFlag); // フラグがtrueの間は無限ループ
    }
  }
}
