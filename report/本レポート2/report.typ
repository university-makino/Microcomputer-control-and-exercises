// ライブラリの実装 //
#import "@preview/codelst:2.0.1": sourcecode

//フォント設定//
#let gothic  = "serif"

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




#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

