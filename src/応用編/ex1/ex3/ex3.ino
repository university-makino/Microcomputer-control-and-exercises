// chap5.1.1ex
int ANODEPIN[] = {2, 3, 4, 5, 6, 7, 8, 9};
int CATHODEPIN[] = {10, 11, 12, 14, 15, 16, 17, 18};
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
    
int xPin = 19;
int yPin = 20;
int zPin = 21;

// x,y,zの初期値保存用
int initialx, initialy, initialz;

// 初期値と入力値の誤差保存用
int inx, iny, inz;
int THRESHOLD = 50;

void setup()
{
    pinMode(xPin, INPUT);
    pinMode(yPin, INPUT);
    pinMode(zPin, INPUT);
    Serial.begin(9600);
    delay(1000); // 初期化処理待ち
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
    inx = analogRead(xPin) - initialx;
    iny = analogRead(yPin) - initialy;
    inz = analogRead(zPin) - initialz;
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
    for (int cat = 0; cat < 8; cat++)
    {
        for (int ano = 0; ano < 8; ano++)
        {
            digitalWrite(ANODEPIN[ano], matrix[ano][cat]);
        }
        // 三項演算子を他の式でもできる
        digitalWrite(CATHODEPIN[cat], LOW);
        delay(1);
        digitalWrite(CATHODEPIN[cat], HIGH);
    }
}