// ライブラリの実装 //
#import "@preview/codelst:2.0.1": sourcecode


//フォント設定//
#let gothic  = "YuMincho"

//本文フォント//
#set text(11pt, font: gothic, lang: "ja") 

//タイトル・見出しフォント//
#set heading(numbering: "1.1")
#let heading_font(body) = {
  show regex("[\p{scx: Han}\p{scx: Hira}\p{scx: Kana}]"): set text(font: gothic)
  body
}
#show heading: heading_font

// ページ設定 //
#set page(
    paper: "a4",
    margin: (x: 25mm, y: 25mm),
    columns: 1,
    //fill: 背景色,
    numbering: "1",
    number-align: center,
    header: [
        #set text(8pt)
    ]
)

// 数式の表示の仕方を表示 //
#set math.equation(numbering: "(1)")

//本文ここから//
= 演習の目的
実験を通して、加速度センサ KXM52-1050の使い方と仕組みの習得を目的とする。

= 演習の使用部品
== @加速度センサ の電子部品 ( 加速度センサ KXM52-1050) を次のような点から調べなさい。

#figure(
  image("./img/加速度センサ.png",width: 50%),
  caption: "加速度センサ"
)<加速度センサ>

=== どのような部品か
加速度の測定を目的とした慣性センサの1つで、3次元の慣性運動（直行3軸方向の並進運動）を検出する。
利用用途としては、ビルや橋梁などの建造物の傾斜や地震時の傾き計測にも利用される @acc_marubun 。

=== どのような仕組みか

KXM52-1050の加速度センサーはMEMS静電容量方式の加速度センサーであり、固定電極と可動電極、スプリングから構成されている。加速度が加わっていない状態では、固定電極と可動電極の間の距離は同じである。加速度がかかると可動電極が移動し、固定電極との位置関係に変化が生じ、電極間静電容量が変化する @acc_techweb 。

=== どのような入力を取り扱うのか

加速度センサは、加速度を検出するため、物体の3軸の加速度を感知し、物体の動きを検出ができる。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

KXM52-1050のデータシートによると、以下のような特性がある@acc_datasheet 。
- 電源電圧(Vdd)	2.7V～5.5V(標準3.3V)
- 測定レンジ	±2g
- 感度	(Vdd/5) V/g
- 0G出力	(Vdd/2) V


出力電圧をv(V)、加速度をa(単位はg)とすると、出力電圧と加速度の関係は @出力の式 であらわされる。

$ v = a * v_d/5 * v_d/2 $<出力の式>

例えば、Vddが5V、加速度が1gのときは、aに1を代入して、3.5Vの電圧が出力される。


=== どのようなピンアサイン (各ピンの役割) か <H_加速度センサーピンアサイン>
KXR94-1050をそのままの使用は難しいため、基盤に半田付けし、使いやすくモジュール化したものを用いる。
しかし、KXR94-1050は廃盤となっており、代替品としてKXR94-2050がある @acc_akitsuki_datasheet 。
今回は、KXR94-2050とあまり違いがないと仮定をして、KXR94-2050のピンアサインを @H_加速度センサーピンアサイン @加速度センサーピンアサイン に示す。

- Vdd: 電源電圧
- Enable: センサの有効/無効を制御するピン
- GND: グラウンド (接地)
- Vmux: センサの出力レンジを制御するピン
- Out Z: Z軸方向の加速度を出力するピン
- Out Y: Y軸方向の加速度を出力するピン
- Out X: X軸方向の加速度を出力するピン
- Self Test: セルフテストを実行するピン

#figure(
  grid(
    columns: 1,
    image("./img/加速度センサーピンアサイン1.png",width: 75%),
    image("./img/加速度センサーピンアサイン2.png",width: 75%)
  ),
  caption: "加速度センサーピンアサイン"
)<加速度センサーピンアサイン>

=== 正しい動作の条件，範囲は何か
秋月電子によると、以下のような仕様がある @acc_akitsuki 。
- 電源電圧min.:2.5V
- 電源電圧max.:5.25V
- 加速度チャンネル:3
- 測定加速度max.:±2g
- 測定項目:加速度
- インターフェイス:アナログ
- 実装タイプ:スルーホール
- パッケージ:DIP8

#pagebreak() // ページを分ける

= 課題内容

== 物体の傾きや動きを計測する 

=== 実験その１ (動作確認)
ブレッドボードを以下のようにした場合，アナログ入力はどのような値をとるか調べ，グラフに表
しなさい．また，どの部分がどの場合か，グラフ上に示しなさい．

- ブレッドボードを卓上に置いたとき
- 左に傾けたとき
- 手前に傾けたとき
- ブレッドボードを裏返したとき

*回路図*

@実験1回路図 は、実験その1の回路図を示す。
加速度センサをアナログ入力に接続して、加速度センサの傾きや動きを測定する装置を作成する。

加速度センサに5Vの電源を供給し、出力電圧をアナログ入力に接続する。
A0,A1,A2 はそれぞれ X軸、Y軸、Z軸の加速度を出力するピンである。
センサの動きや傾きを検知し、センサ内部の抵抗値が変化し、アナログ入力の値が変化する。

#figure(
  image("./img/実験1回路図.png",width: 70%),
  caption: "実験1回路図 傾きや動きを測定する装置"
)<実験1回路図>

#pagebreak() // ページを分ける

*プログラム*

@値の取得をするソースコード1 ,  @値の取得をするソースコード2 , @値の取得をするソースコード3 は、実験その1で使用したアナログ入力値を取得するソースコードを示す。

#figure(
  sourcecode[```c

// writeFile
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

PFont myFont;
int usePin0 = 0;
int usePin1 = 1;
int usePin2 = 2;
String Label0 = "array0";
String Label1 = "array1";
String Label2 = "array2";
int[] array0 = new int[0];
int[] array1 = new int[0];
int[] array2 = new int[0];
int input0, input1, input2;
boolean isRecording = false;

  ```],
  caption: "値の取得をするソースコード (1-3)"
)<値の取得をするソースコード1>

#figure(
  sourcecode[```c
// setup Method
void setup(){
    size(600, 250);
    arduino = new Arduino(this, "/dev/cu.usbserial-14P54810",57600);
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    input1 = arduino.analogRead(usePin1);
    input2 = arduino.analogRead(usePin2);
    // show analog input values
    fill(255);
    text( "A0 x = " + input0, 15, 30);
    text( "A1 y = " + input1, 15, 60);
    text( "A2 z = " + input2, 15, 90);
    // visualise analog input values
    noStroke();
    rect( 235, 10, (input0)/4, 20);
    rect(235,40,(input1)/4,20); 
    rect(235,70,(input2)/4,20); 
    stroke( 255, 0, 0);
    line( 235, 5, 235, 125);
    line( 490, 5, 490, 125);
    if( isRecording ){
        // If it’s Recording, use array to store data.  
        array0 = append( array0, input0); 
        array1 = append( array1, input1); 
        array2 = append( array2, input2); 
        // display it’s recording
        text( "Recording...", 40, 180);
        text( "Press any key to End Recording",40, 210);
        if(second()%2 ==1 ){
        fill(255,0,0);
        ellipse( 25, 170, 9,9);
        }
      } else {
      // If it’s not Recording, show how to use.
      text( "Press Esc key to Exit", 40, 180); 
      text( "Press any key to Record", 40, 210);
    }
}
    

  ```],
  caption: "値の取得をするソースコード (2-3)"
)<値の取得をするソースコード2>

#figure(
  sourcecode[```c
      
void keyPressed() {
    if( isRecording ){
        // making contents of csv file 
        String[] lines = new String[array0.length +1 ];
        lines[0] = "Steps," + Label0 + ","+Label1+","+Label2;
        for (int i = 0; i < array0.length; i++) { 
            lines[i+1] = (i+1) + "," + array0[i] +"," + array1[i] + "," + array2[i];
        }
        // making filename  
        String filename = "Rec" + year();
        if( month() < 10 ){ filename += "0";}
        filename += month();
        if( day() < 10 ){ filename += "0";}
        filename += day() + " ";
        if( hour() < 10 ){ filename += "0";}
        filename += hour();
        if( minute() < 10 ){ filename += "0";}
        filename += minute();
        if( second() < 10 ){ filename += "0";}
        filename += second() + ".csv";
        saveStrings(filename, lines); 
        // Initializing
        array0 = expand(array0, 0); 
        array1 = expand(array1, 0); 
        array2 = expand(array2, 0); 
        isRecording = false;
    } else {
        // Switch on
        isRecording = true; 
    }
}
// write file
  ```],
  caption: "値の取得をするソースコード (3-3)"
)<値の取得をするソースコード3>

- プログラムの概要
センサから ArduinoA0 A1 A2 ピンへの入力値をアナログ入力として読み込む。読み込んだ値を数値として表示し、CSVに書き込みを行う。
- プログラムの説明
  - 1–17 行目: プログラムに必要な変数の宣言および定義またはライブラリのインポートを行う。
  - 20–25 行目: Arduino およびプログラムの初期設定
    - 21 行目で画面表示に用いるウィンドウサイズを横 600px,縦 250px と定義している。
    - 22 行目で"/dev/cu.usbserial-14P54810"のポートと 57600 の速度で通信する arduino インスタンスを生成する．
    - 24 行目でフォントを読み込む。
    - 25 行目でフレームレートを 30 としている．
  - 27–62 行目：プログラムの動作
    - 29–31 行目でアナログ入力を読み込むための変数 input0, input1, input2 を宣言している。
    - 34–44 行目で表示の設定を行う。
    - 45–61 行目で レコーディングを行うための処理を行う。
  - 64–94 行目で 入力されたkeyにおける処理を行う。
    - 入力をされたら、CSVファイルに書き込む処理を行う。

*結果* 

今回の実験の軸の定義としては @加速度センサの軸 のように定義する。
1番ピンを右下にして4番ピンを右上にして、X軸、Y軸を図のように定義する。
Z軸については、図に対して垂直な方向をZ軸とする。
軸の定義は、データシートをもとにしている。
左に傾けた時は、ｘ軸方向に正の向きに傾けた時と定義をする。
手前に傾けた時は、ｙ軸方向に正の向きに傾けた時と定義をする。

#figure(
  image("./img/加速度センサの軸.png",width: 50%),
  caption: "加速度センサの軸"
)<加速度センサの軸>

実験結果は、@加速度センサを傾けた時のグラフ に示す。

#figure(
  image("./img/実験1のグラフ.png",width: 80%),
  caption: "加速度センサを傾けた時のグラフ"
)<加速度センサを傾けた時のグラフ>

角度を変化させず、動作をさせず、水平に保った場合はx軸,y軸は500前後の値を示す。z軸は750前後の値を示す。
角度の瞬間的な変化を出力するのではなく、傾けた分だけ値が増減する。また、角度を水平にしない限り最初の値に戻らない。 
同じ大きさの角度に傾けた場合ほぼ同じ大きさの値を示す。 

*考察*

値はブレッドボードの角度の変化をした場合その角度の変化を検知して値が変化すると考えられる。
KXM52-1050の加速度センサーはMEMS静電容量方式の加速度センサーであり、固定電極と可動電極、スプリングから構成されている。加速度が加わっていない状態では、固定電極と可動電極の間の距離は同じである。加速度がかかると可動電極が移動し、固定電極との位置関係に変化が生じ、電極間静電容量が変化する。  

そのため、角度を傾けた場合、重力加速度を受け可動電極が一定の方向に移動し静電容量が変化するため、角度の変化を検出しない時に0に戻らず、一定の大きさの静電容量を維持し続ける。 

卓上に置いた時にz軸の値だけ大きくなっているのはセンサに掛かっている力が重力だけでz軸に対して掛かっているためであると考えられる。

=== 実験その２ (３軸方向の識別)
ブレッドボードを以下の方向に，急激に動かした場合，アナログ入力はどのような値をとるか調べ，
グラフに表しなさい．また，どの部分がどの方向か，グラフ上に示しなさい．

- 奥に動かしたとき(突き刺すような動き)
- 右に動かしたとき
- 上に動かしたとき

*回路図・プログラム*

回路図・プログラムは実験その1と同じである。

#pagebreak() // ページを分ける

*結果*

実験結果は、@加速度センサを動かした時のグラフ に示す。

#figure(
  image("./img/実験2のグラフ.png",width: 80%),
  caption: "加速度センサを動かした時のグラフ"
)<加速度センサを動かした時のグラフ>

値はブレッドボードが速度変化をした場合その動作の変化を検知して値が変化する。
角度を変化させず、動作をさせず、水平に保った場合はx軸,y軸は500前後の値を示す。z軸は750前後の値を示す。 
動作の瞬間的な変化を出力する。 
同じような速度で動かした場合ほぼ同じ大きさの値を示す。
動作を始めた時は値がその軸の方向に大きくなるが、動作を終了した時は一度、軸の逆の方向に大きくなり、最初の値に戻る。

*考察*

KXM52-1050の加速度センサーはMEMS静電容量方式の加速度センサーであり、固定電極と可動電極、スプリングから構成されている。加速度が加わっていない状態では、固定電極と可動電極の間の距離は同じである。加速度がかかると可動電極が移動し、固定電極との位置関係に変化が生じ、電極間静電容量が変化する。 

そのため、各軸に対して加速度を与えられるため、可動電極が一定の方向に移動し静電容量が変化する。その後、加速度が与えられないと元の位置に可動電極が戻るため、値は元の値に戻る。 

また、急激に物体に加速度を与えた後、動作を止めるため逆方向に力を加えるため、慣性の法則が働く。ゆえに、狙った力と逆の作用が見られる。 

卓上に置いた時にz軸の値だけ大きくなっているのはセンサに掛かっている力が重力だけでz軸に対して掛かっているからである。 

今回の実験において、 KXM52-1050の仕様書と比較をして、同じ動作を行なっていた。 

#pagebreak() // ページを分ける

=== 発展その1 (傾きを用いたアニメーション制御) 
@発展その1の加速度センサの動作イメージ @発展その1の記号の動作イメージ のように，加速度センサを用いて，傾けた向きに傾きの大きさだけ記号が動く(加速度センサの傾きをトレースする) ようにしなさい．また，平らな場所に置くと記号が中央に戻るようにしなさい．

#figure(
  image("./img/発展その1の加速度センサの動作イメージ.png",width: 50%),
  caption: "発展1の加速度センサの動作イメージ"
)<発展その1の加速度センサの動作イメージ>

#figure(
  image("./img/発展その1の記号の動作イメージ.png",width: 50%),
  caption: "発展1の記号の動作イメージ"
)<発展その1の記号の動作イメージ>


*回路図*

回路図は実験その1と同じである。

#pagebreak() // ページを分ける

*プログラム*

@加速度センサの傾きを用いたアニメーション制御のソースコード は、加速度センサの傾きをトレースするソースコードを示す。

#figure(
  sourcecode[```java
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int analogPin1 = 1;
int analogPin2 = 2;

void setup() {
  size(600, 300);
  
  // Arduinoの初期化
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54810");
  
  // フォントの読み込みと設定
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont, 30);
  
  // フレームレートの設定
  frameRate(30);
}

int prevX = 0;
int prevY = 0;

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int x = arduino.analogRead(analogPin0);
  int y = arduino.analogRead(analogPin1);
  int z = arduino.analogRead(analogPin2);
  
  // 平滑化フィルターをかける
  float smoothness = 0.2; // 平滑化の度合いを調整する値
  x = (int)(x * smoothness + (1 - smoothness) * prevX);
  y = (int)(y * smoothness + (1 - smoothness) * prevY);
  
  fill(255);
  text("o", 300+( -1 * (x-536)), 150+ (y-488));//横
  
  // 前回の値を更新する
  prevX = x;
  prevY = y;
}

  ```],
  caption: "加速度センサの傾きを用いたアニメーション制御のソースコード"
)<加速度センサの傾きを用いたアニメーション制御のソースコード>


- プログラムの概要
センサから ArduinoA0 A1 A2 ピンへの入力値をアナログ入力として読み込む。読み込んだ値をもとに、記号を動かすアニメーションを行う。
- プログラムの説明
  - 1–10 行目: プログラムに必要な変数の宣言および定義またはライブラリのインポートを行う。
  - 12–24 行目: Arduino およびプログラムの初期設定
    - 13 行目で画面表示に用いるウィンドウサイズを横 600px,縦 300px と定義している。
    - 16 行目で"/dev/cu.usbserial-14P54810"のポートと 57600 の速度で通信する arduino インスタンスを生成する．
    - 19 行目でフォントを読み込む。
    - 23 行目でフレームレートを 30 としている．
  - 26–27 行目で以前の値を保持するための変数 prevX, prevY を宣言している。
  - 29–48 行目：プログラムの動作
    - 30 行目で背景色を設定する。
    - 33–35 行目でアナログ入力を読み込むための変数 x, y, z を宣言している。
    - 38–40 行目で平滑化フィルターをかける。
    - 43 行目で記号を表示する。
    - 46–47 行目で前回の値を更新する。

*結果*

記号を中央に寄せるために、ブレットボードを机に置いている時の値を引き、値の差分を出し、画面の中央座標を足し中心に持っていった。 

X軸方向が逆に反応していたのを修正するために、x軸の値に-1かけるて動作を反転させた。

そのままの値をアニメーションにするとがたつきが起きたが、フィルターをかけると滑らかに動くようになった。 

*考察*

センサーのデータは5Vのデータを0~1024までの値として受け取る。 
負の値を取らないため、なにも傾けていない状態を中央値の500ぐらいを取り、そこからの変化をしている。 

したがって、中央値の500を引くと、差分が出てくる。その差分を中央座標からの変化量と照らし合わせるとうまく動作する。 

センサを右に傾けたとき記号は左動き、センサを左に傾けたとき記号は右に動いた。また、センサをY軸方向に傾けたとき、記号は傾けた向きと同様に動いた。この事象からX軸方向は逆向きに反応している。したがってX軸に-1をかけると傾けた向きと同じ動作をする。 


実験1、2からもわかるようにセンサを動かしていない時でも測定値は多少変わってしまう。そのため、その値のまま記号を動かすようにアニメーションを作るとがたつきが起きてしまった。しかし、平滑化フィルタを使い値を平均化するとがたつきがなくなり滑らかに動くアニメーションを作れる。 

一つ前の値に0.2を掛け、受け取った値に0.8をかけ、その二つの値を足し平均化するようにした。 

=== 発展その2(移動速度を用いたアニメーション制御)
実験その２で作成したグラフを参考に，急激に動かした方向を検出した場合，画面上の記号が検出
した方向に動いた後，中央に戻るようにしなさい．

*回路図*

回路図は実験その1と同じである。

#pagebreak() // ページを分ける

*プログラム* 

@移動速度を用いたアニメーション制御のソースコード1 , @移動速度を用いたアニメーション制御のソースコード2 は、移動速度を用いたアニメーション制御のソースコードを示す。

#figure(
  sourcecode[```java

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

// Arduinoのピン
int analogPin0 = 0;
int analogPin1 = 1;

void setup() {
  size(600, 300);
  
  // Arduinoの初期化
  arduino = new Arduino(this, "/dev/cu.usbserial-14P54810");
  
  // フォントの読み込みと設定
  myFont = loadFont("CourierNewPSMT-48.vlw");
  textFont(myFont, 30);
  
  // フレームレートの設定
  frameRate(30);
}

// 前回の値を保持する変数
int prevX = 0;
int prevY = 0;
int count = 0;
String status = "None";
final float SMOOTHNESS = 0.2;
final int THRESHOLD = 70;

void draw() {
  background(120);
  
  // アナログピンからの入力を取得
  int x = readAndSmooth(analogPin0, prevX);
  int y = readAndSmooth(analogPin1, prevY);
  
  // 状態を更新
  if (status != "None" && count < 30) {
    count++;
  } else {
    count = 0;
    status = getStatus(x, y);
  }
  
  // 状態に応じて表示位置を変更
  displayStatus(status);
  
  // 前回の値を更新する
  prevX = x;
  prevY = y;
}
  ```],
  caption: "移動速度を用いたアニメーション制御のソースコード (1-2)"
)<移動速度を用いたアニメーション制御のソースコード1>

#figure(
  sourcecode[```java
// アナログピンからの入力を取得し、平滑化する
int readAndSmooth(int pin, int prevValue) {
  int value = arduino.analogRead(pin);
  return (int)(value * SMOOTHNESS + (1 - SMOOTHNESS) * prevValue);
}

// 状態を取得する
String getStatus(int x, int y) {
  if (prevX - x > THRESHOLD) {
    return "Left";
  } else if (prevX - x < -THRESHOLD) {
    return "Right";
  } else if (prevY - y > THRESHOLD) {
    return "Down";
  } else if (prevY - y < -THRESHOLD) {
    return "Up";
  }
  return "None";
}

// 状態に応じて表示位置を変更する
void displayStatus(String status) {
  fill(255);
  switch (status) {
    case "Left":
      text("o", 230, 150);
      break;
    case "Right":
      text("o", 370, 150);
      break;
    case "Up":
      text("o", 300, 70);
      break;
    case "Down":
      text("o", 300, 220);
      break;
    default:
      text("o", 300, 150);
      break;
  }
}

  ```],
  caption: "移動速度を用いたアニメーション制御のソースコード (2-2)"
)<移動速度を用いたアニメーション制御のソースコード2>

- プログラムの概要
センサから ArduinoA0 A1 A2 ピンへの入力値をアナログ入力として読み込む。読み込んだ値をもとに、移動速度を検出し、記号を動かすアニメーションを行う。
- プログラムの説明
  - 1–9 行目: プログラムに必要な変数の宣言および定義またはライブラリのインポートを行う。
  - 11–23 行目: Arduino およびプログラムの初期設定
    - 12 行目で画面表示に用いるウィンドウサイズを横 600px,縦 300px と定義している。
    - 15 行目で"/dev/cu.usbserial-14P54810"のポートと 57600 の速度で通信する arduino インスタンスを生成する．
    - 18 行目でフォントを読み込む。
    - 22 行目でフレームレートを 30 としている．
  - 26–27 行目で以前の値を保持するための変数 prevX, prevY を宣言している。
  - 28–29 行目で状態を保持するための変数 count, status を宣言している。
  - 30–31 行目で平滑化の度合いを調整する値 SMOOTHNESS, 閾値を設定する値 THRESHOLD を宣言している。
  - 33–53 行目：プログラムの動作
    - 30 行目で背景色を設定する。
    - 37–38 行目でアナログ入力を読み込むための変数 x, y を宣言している。
    - 41–45 行目で状態を更新する。1秒ほど状態を確認しその状態が続いた場合、状態を更新する。
    - 49行目で状態に応じて表示位置を変更する。
    - 52–53 行目で前回の値を更新する。
  - 57–60 行目でアナログピンからの入力を取得し、平滑化する関数 readAndSmooth を定義している。
  - 62–75 行目で状態を取得する関数 getStatus を定義している。
  - 77–84 行目で状態に応じて表示位置を変更する関数 displayStatus を定義している。

*結果*

閾値を使い、どの方向に動かしたか判断する。 
慣性による逆方向の入力を受け付けないために一度閾値を超えたら1秒間入力を無視する。 

閾値を超えるのが、+70と-70の値を超えた場合、その方向に動いたと判断する。

*考察*

急激に動かすと慣性による逆方向への力がはたらいてしまい、急に動かした方向とは逆の方向にも検知してしまう。これを防ぐために一度閾値を超えたら一定時間記号を止めると、動かした方向のみをはっきり検知できる。

=== まとめ

今回の実験では、加速度センサを用いて、センサの動きや傾きを検知し、センサ内部の抵抗値が変化し、アナログ入力の値が変化を確認した。また、その値をもとにアニメーションを制御するプログラムを作成した。
アニメーションを制御するプログラムを作成し、センサの動きや傾きを視覚的に確認できた。また、センサの動きや傾きを検知し、センサの動作原理を理解できた。

#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

