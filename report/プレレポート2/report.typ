//フォント設定//
#let gothic  = "Hiragino Kaku Gothic Pro"

//本文フォント//
#set text(11pt, font: gothic, lang: "ja") 

//タイトル・見出しフォント//
#set heading(numbering: "1.1")
#let heading_font(body) = {
  show regex("[\p{scx: Han}\p{scx: Hira}\p{scx: Kana}]"): set text(font: gothic)
  body
}
#show heading: heading_font

//タイトルページここから//
#align(right, text()[
  #text[提出日]#datetime.today().display("[year]年[month]月[day]日")
])
#v(150pt)
#align(center, text(30pt)[
  #heading_font[*プレ・レポート2*]
])
// #align(center, text(14pt)[
//   #heading_font[*サブタイトル*]
// ])
#v(1fr)
#align(right)[
  #table(
    columns:(auto, auto),
    align: (right, left),
    stroke: none,
    [講義名],[マイコン制御および演習],
    [担当教員],[伊藤 暢浩先生],
    [],[],
    [学籍番号],[k22120],
    [所属],[情報科学部 情報科学科],
    [学年],[3年],
    [氏名],[牧野遥斗]
  )
]
#pagebreak()

//本文ここから//
= プレ・レポート（課題 2）
== @DistanceSensor の電子部品 ( 距離センサ GP2Y0A21YK0F) を次のような点から調べなさい。

#figure(
  image("./img/距離センサ.png",width: 50%),
  caption: "距離センサ"
)<DistanceSensor>

=== どのような部品か
シャープの赤外線を使用した測距モジュールである。赤外線LEDとPSD(position sensitive detector)を使用して、非接触で距離を検出することができる@distance_sensor_akituki 。


=== どのような仕組みか
発光側の赤外光が物体に反射して受光すると距離に応じて出力電圧が変化する。この出力電圧で距離を検出することができる。測定距離を測る方法はPDS方式を採用している。PSD方式は三角測量の要領で距離を検出するもので @PSD のように発光素子から出た光が対象物に当たって戻ってきた反射光を検出する。対象物が近いとPSDへの光の入射角度は大きく、逆に遠いと入射角度は小さくなる。この角度の違いで出力電圧が変化するため、距離の情報を得ることができる。

#figure(
  image("./img/PSD.png",width: 50%),
  caption: "PSD方式"
)<PSD>

=== どのような入力を取り扱うのか

距離センサーから出力された光をPSDで受光し、その出力電圧を取り扱う。

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

== @PressureSensor の電子部品 ( 感圧センサ ALPHA-MF01-N221-A01 ) を次のような点から調べなさい。

#figure(
  image("./img/圧力センサ.png",width: 50%),
  caption: "圧力センサ"
)<PressureSensor>

=== どのような部品か

=== どのような仕組みか

=== どのような入力を取り扱うのか

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

=== どのようなピンアサイン (各ピンの役割) か

=== 正しい動作の条件，範囲は何か

#pagebreak() // ページを分ける

== @PhotoReflector の電子部品 ( フォトリフレクタ RPR-220) を次のような点から調べなさい。

#figure(
  image("./img/フォトリフレクタ.png",width: 50%),
  caption: "フォトリフレクタ"
)<PhotoReflector>

=== どのような部品か

=== どのような仕組みか

=== どのような入力を取り扱うのか

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

=== どのようなピンアサイン (各ピンの役割) か

=== 正しい動作の条件，範囲は何か

#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

