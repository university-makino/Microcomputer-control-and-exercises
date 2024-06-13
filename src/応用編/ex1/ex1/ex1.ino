//アノードコモン
// chap5.1.1
int ANODEPIN[] = {2, 3, 4, 5, 6, 7, 8, 9};
int CATHODEPIN[] = {10, 11, 12, 14, 15, 16, 17, 18};
int mat_A[8][8] = {
    {0, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 1, 0, 0, 0, 0, 0},
    {1, 1, 1, 0, 0, 0, 1, 0},
    {0, 0, 1, 1, 1, 0, 0, 1},
    {0, 0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 0},
    {0, 1, 0, 0, 0, 0, 1, 0},
    {1, 0, 0, 0, 0, 0, 0, 1}};
int mat_B[8][8] = {
    {0, 1, 1, 0, 0, 0, 1, 0},
    {1, 1, 1, 0, 0, 0, 0, 1},
    {0, 0, 1, 1, 1, 0, 0, 1},
    {0, 0, 1, 1, 1, 1, 1, 0},
    {0, 0, 1, 1, 1, 1, 1, 0},
    {0, 0, 0, 1, 0, 0, 1, 0},
    {0, 0, 0, 0, 1, 1, 0, 0},
    {0, 0, 0, 1, 0, 0, 0, 0}};
void setup()
{
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
}
void loop()
{
    unsigned long ms = millis();
    if ((ms / 1000) % 2 == 1)
    {
        showMatrix(mat_A);
    }
    else
    {
        showMatrix(mat_B);
    }
}
void showMatrix(int matrix[8][8])
{
    for (int ano = 0; ano < 8; ano++)
    {
        for (int cat = 0; cat < 8; cat++)
        {
            digitalWrite(CATHODEPIN[cat], (matrix[ano][cat] == 0 ? 1 : 0));
        }
        // 三項演算子を他の式でもできる
        digitalWrite(ANODEPIN[ano], HIGH);
        delay(3);
        digitalWrite(ANODEPIN[ano], LOW);
    }
}