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

//本文ここから//
= プレ・レポート（課題 2）

== 目的
実験を通して、距離センサ GP2Y0A21YK0Fの使い方と仕組みを習得することを目的とする。

== @DistanceSensor の電子部品 ( 距離センサ GP2Y0A21YK0F) を次のような点から調べなさい。

#figure(
  image("./img/距離センサ.png",width: 50%),
  caption: "距離センサ"
)<DistanceSensor>

=== どのような部品か
シャープの赤外線を使用した測距モジュールである。赤外線LEDとPSD(position sensitive detector)を使用して、非接触で距離を検出することができる@distance_sensor_akituki 。


=== どのような仕組みか
発光側の赤外光が物体に反射して受光すると距離に応じて出力電圧が変化する。この出力電圧で距離を検出することができる。測定距離を測る方法はPDS方式を採用している。PSD方式は三角測量の要領で距離を検出するもので @PSD のように発光素子から出た光が対象物に当たって戻ってきた反射光を検出する。対象物が近いとPSDへの光の入射角度は大きく、逆に遠いと入射角度は小さくなる。この角度の違いで出力電圧が変化するため、距離の情報を得ることができる@national_university_infrared_sensor 。

#figure(
  image("./img/PSD.png",width: 50%),
  caption: "PSD方式"
)<PSD>

=== どのような入力を取り扱うのか

距離センサーから出力された光を受光し、その出力電圧を取り扱う。
出力電圧は距離に応じて変化する。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

SHARPのデータシートによると、以下のような特性がある@distance_sensor_datasheet 。

@distance_sensor_chart をみると、38.3ms±9.6ms毎に出力電圧を出力する。
最初のタイミングは測定をされていないため、不安定な値を出力されるが、2回目以降は安定した値を出力する。

#figure(
  image("./img/距離センサタイミングチャート.png",width: 75%),
  caption: "距離センサタイミングチャート"
)<distance_sensor_chart>

出力電圧は距離に応じて変化する。距離が近いほど出力電圧は大きくなり、遠いほど小さくなる。距離と出力電圧の関係は @distance_sensor_output に示す。
グラフは比例関係ではなく、反比例な関係がある。
しかし、距離が近すぎるとうまく測定をすることができないため注意が必要である。

#figure(
  image("./img/距離センサー距離測定特性.png",width: 75%),
  caption: "距離センサ距離測定特性"
)<distance_sensor_output>

=== どのようなピンアサイン (各ピンの役割) か

SHARPのデータシートによると、以下のものを扱う@distance_sensor_datasheet 。
+ 出力電圧
+ GND
+ Vcc (5V 電源電圧)

#figure(
  grid(
    columns: 2,
    image("./img/距離センサーピンアサイン1.png",width: 75%),
    image("./img/距離センサーピンアサイン2.png",width: 75%)
  ),
  caption: "距離センサーのピンアサイン"
)<distance_sensor_pin>

=== 正しい動作の条件，範囲は何か
秋月電子のサイトによると、以下のような仕様がある @distance_sensor_akituki 。
- 電源電圧min. : 4.5V
- 電源電圧max. : 5.5V
- 測定距離min. : 0.1m
- 測定距離max. : 0.8m
- 測定方式 : 赤外線PSD
- 測定項目 : 距離
- インターフェイス : アナログ
- 動作温度min. : -10℃
- 動作温度max. : 60℃
- 長辺 : 44.5mm
- 短辺 : 13.5mm
- 高さ : 18.9mm

#pagebreak() // ページを分ける

= 課題内容

== 物体とセンサとの距離をはかる 

=== 実験その1 (部品動作の理解) 距離センサからの距離が以下のような場合、アナログ入力はどのような値をとるか調べなさい。
- 卓上に上向きに置き，天井までに物体がないとき
- センサから 50cm のところに手をかざしたとき
- センサから 20cm のところに手をかざしたとき
- センサから 10cm のところに手をかざしたとき

@実験1回路図 は、実験1の回路図を示す。
距離センサをアナログ入力に接続して、距離センサと対象物との距離を測定する装置を作成する。

#figure(
  image("./img/実験1回路図.png",width: 70%),
  caption: "実験1回路図"
)<実験1回路図>

@値の取得をするソースコード は、実験1で使用したアナログ入力値を取得するソースコードを示している。

#figure(
  sourcecode[```c
//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 0; //Arduino A0ピン

//Arduino 及びプログラムの初期設定
void setup(){
    size(600, 250);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P54810"
    );
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}

// 入力値の格納用変数
int input0;

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);
}
  ```],
  caption: "値の取得をするソースコード"
)<値の取得をするソースコード>

- プログラムの概要
センサから ArduinoA0 ピンへの入力値をアナログ入力として読み込む。読み込んだ値を数値として表示する。
- プログラムの説明
  - 1～7 行目: プログラムに必要な変数の宣言および定義またはライブラリのインポートを行う。
  - 8 行目で ArduinoA0 ピンの使用を usePin0 = 0 として定義している。
  - 11～20 行目: Arduino およびプログラムの初期設定
    - 10 行目で画面表示に用いるウィンドウサイズを横 600px,縦 250px と定義している。
    - 11 行目で"/dev/cu.usbserial-14P54810"のポートと 57600 の速度で通信する arduino インスタンスを生成する．
    - 14 行目でフレームレートを 30 としている．
  - 23～32 行目：プログラムの動作
    - 23 行目で入力用の変数 input0 を宣言している。
    - 27 行目で背景色を灰色に設定する。
    - 28 行目で ArduinoA0 ピンのアナログ入力を input0 に入れる。
    - 31 行目で input0 を数値として表示する．

@距離センサーの距離とマイコンへのアナログ入力値の関係値 をみると、距離センサに物体を近づければ、マイコンのアナログ入力値が高くなる。出力される値は距離と比例的な関係ではない。

#figure(
  image("./img/距離センサーの距離とマイコンへのアナログ入力値の関係値.png",width: 75%),
  caption: "距離センサ距離測定特性"
)<距離センサーの距離とマイコンへのアナログ入力値の関係値>

=== 実験その2 (動作可能範囲の確認) 
プレレポートから距離センサには動作可能範囲があり、ある一定条件下では正しいアナログ値が得られないことが分かる。そこで動作不可能範囲についてもアナログ入力値を調べ、動作可能範囲、不可能範囲の両方を含むグラフを作成しなさい。

装置、プログラムは実験その1と同じものを使用する。

@距離とマイコンへのアナログ入力値の対数グラフ_動作可能範囲の確認 をみると、距離センサは近くなる程、値が増えていくはずだが、10cmより近づくと減っていく。 
また、80cmより遠くなると値は同じになってしまう。 
そのため、測定可能範囲は50mm~800mm程度だと考えられる。 
プレレポートで検索した情報と一致している。

#figure(
  image("./img/距離とマイコンへのアナログ入力値の対数グラフ(動作可能範囲の確認).png",width: 75%),
  caption: "距離センサ距離測定特性"
)<距離とマイコンへのアナログ入力値の対数グラフ_動作可能範囲の確認>

=== 発展その1 (距離センサを用いた状態識別) 
距離センサへの入力値により、ある2つの状態を「distant」もしくは「close」と識別して表示させなさい。また、ある2つの状態 (例えば，パソコンの全高より高いか低いか)」は自分で決め、これを実現する境界値と不感帯を導き出して使用しなさい。

装置は実験その1と同じものを使用する。
@距離センサを用いた状態識別するソースコード は、発展その1で使用した距離センサを用いた状態識別するソースコードを示している。

#figure(
  sourcecode[```c
//プログラムに必要な変数の宣言及び定義
import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
PFont myFont;

int usePin0 = 0; //Arduino A0ピン
int usePin1 = 3; //Arduino A1ピン

//Arduino 及びプログラムの初期設定
void setup(){
    size(600, 250);
    arduino = new Arduino(
        this,
        "/dev/cu.usbserial-14P54810"
    );
    myFont = loadFont("CourierNewPSMT-48.vlw");
    textFont(myFont, 30);
    frameRate(30);
}

// 入力値の格納用変数
int input0;

// 不感帯の閾値
int closeDiv = 330;
int distantDiv = 270;

// 状態の格納用変数
String status = "";

//プログラム本体 (以下を繰り返し実行)
void draw(){
    background(120);
    input0 = arduino.analogRead(usePin0);
    
    //入力値を表示
    text("A0: " + input0, 50, 100);

    // 不感帯の設定
    if(input0 > closeDiv){
        status = "close"; 
    }

    if(input0 < distantDiv){
        status = "distant";
    }

    // 状態の表示
    text("Status: " + status, 50, 150);
}
  ```],
  caption: "距離センサを用いた状態識別するソースコード"
)<距離センサを用いた状態識別するソースコード>

- プログラムの概要
センサから ArduinoA0 ピンへの入力値をアナログ入力として読み込む。読み込んだ値を数値として表示し、その値によって状態を識別する。
- プログラムの説明
  - 1～9 行目: プログラムに必要な変数の宣言および定義またはライブラリのインポートを行う。
  - 8,9行目で Arduino A0, D3 ピンの使用を usePin0 = 0 , usePin1 = 3 として定義している。
  - 12～21 行目: Arduino およびプログラムの初期設定
    - 10 行目で画面表示に用いるウィンドウサイズを横 600px,縦 250px と定義している。
    - 11 行目で"/dev/cu.usbserial-14P54810"のポートと通信する arduino インスタンスを生成する．
    - 14 行目でフレームレートを 30 としている．
  - 23～52 行目：プログラムの動作
    - 24 行目で入力用の変数 input0 を宣言している。
    - 27,28 行目で閾値を設定している。
    - 30 行目で状態を格納する変数 status を宣言している。
    - 35 行目で背景色を灰色に設定する。
    - 36 行目で ArduinoA0 ピンのアナログ入力を input0 に入れる。
    - 39 行目で input0 を数値として表示する．
    - 42～48 行目で入力値によって状態を識別する。不感帯を作成し、その範囲内で状態を識別する。
    - 51 行目で状態を表示する。

今回、MacBookAirのディスプレイの高さを閾値とし、閾値より高いか低いかで状態を識別する。

閾値:300(macbookのディスプレイの高さより低いか高いかで推定を行う。約20cm) 
不感帯:270~330 

不感帯をこれより狭めた状態で、センサと物体の距離を20cm前後を保つと、状態が安定しない。 逆に不感帯を大きくすると測りたい距離を正確に測れなくなる。

=== 発展その2 (状態識別を用いた LED 点灯制御)
第3章で用いたLEDを使い、一定距離以上近づくと、LED が点灯するようにしなさい. また、「一定距離」が何を指すかを自分で決め、これを実現する境界値と不感帯を導き出して使用しなさい。

@実験2回路図 は、発展その2の回路図を示す。
装置は実験その1にLEDを追加して使用する。

#figure(
  image("./img/実験2回路図.png",width: 75%),
  caption: "実験2回路図"
)<実験2回路図>


@距離センサを用いた状態識別してLED表示するソースコード は、発展その2で使用した距離センサを用いた状態識別してLED表示するソースコードを示している。
発展その1で作成したソースコードの51と52行目の間に挿入する。

#figure(
  sourcecode[```c
// 状態に応じた処理
if(status.equals("close")){
    //close の時の処理
    arduino.analogWrite(usePin1, 255);
}else if(status.equals("distant")){ 
    //distant の時の処理
    arduino.analogWrite(usePin1, 0);
}
  ```],
  caption: "距離センサを用いた状態識別してLED表示するソースコード"
)<距離センサを用いた状態識別してLED表示するソースコード>

- プログラムの概要
センサから ArduinoA0 ピンへの入力値をアナログ入力として読み込む。読み込んだ値を数値として表示し、その値によって状態を識別する。
- プログラムの説明
  - 2行目でstatusがcloseか判定をする。
  - 4行目でusePin1に5Vを出力する。
  - 6行目でstatusがdistantか判定をする。
  - 8行目でusePin1に0Vを出力する。

閾値:300(macbookのディスプレイの低いところから高いところまでの距離) 
不感帯:400~600 

不感帯をこれより狭めた状態で、センサと物体の距離を20cm前後を保つと、状態が安定しない。 逆に不感帯を大きくすると測りたい距離を正確に測れなくなる。
LEDを追加したので、センサと物体の距離が一定以上近づくとLEDが点灯するようになった。

#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

