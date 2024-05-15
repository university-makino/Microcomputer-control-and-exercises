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

//タイトルページここから//
#align(right, text()[
  #text[提出日]#datetime.today().display("[year]年[month]月[day]日")
])
#v(150pt)
#align(center, text(30pt)[
  #heading_font[*プレ・レポート3*]
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
== @焦電センサ の電子部品 ( 焦電センサ AMN31111) を次のような点から調べなさい。

#figure(
  image("./img/焦電センサ.png",width: 50%),
  caption: "焦電センサ"
)<焦電センサ>

=== どのような部品か
センサ自身からLEDなどの光を発光するのではなく、周囲と温度差のある人（物）が動く際におこる赤外線の変化量を検出するセンサである。温度差を検出するため、体温を持つ人体の検出に適している @red_maruta_about。

=== どのような仕組みか

センサに赤外線が入射すると、温度変化が生じ、焦電素子（セラミクス）の表面温度が上がり、焦電効果により表面電荷が発生する。
@焦電センサ仕組み に示すように、焦電素子の表面には、吸着浮遊イオンが存在している。
このため安定時の電荷の中和状態がくずれ感知素子表面の電荷と、吸着浮遊イオン電荷の緩和時間が異なるため、アンバランスとなり、結びつく相手のない電荷が生じる。この発生した表面電荷をセンサ内部品で電気信号として取りだし、出力信号として利用する @red_maruta_about。

#figure(
  image("./img/焦電センサ仕組み.png",width: 50%),
  caption: "焦電センサ仕組み"
)<焦電センサ仕組み>

=== どのような入力を取り扱うのか

焦電センサは、赤外線の変化量を検出するため、人体から発生する熱量(赤外線)を感知し、人体の動きを検出することができる。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

Panasonicのデータシートによると、以下のような特性がある@red_datasheet 。

@焦電センサタイミングチャート に示すように、焦電センサは、人体の動きを検知すると、出力電圧が変化する。この出力電圧の変化を利用して、人体の動きを検知することができる。
しかし、開始最大30秒間は安定しないため、安定した出力を得るためには、30秒以上の時間をかける必要がある。

#figure(
  image("./img/焦電センサタイミングチャート.png",width: 75%),
  caption: "焦電センサタイミングチャート"
)<焦電センサタイミングチャート>


=== どのようなピンアサイン (各ピンの役割) か

Panasonicのデータシートによると、以下のようなピンアサインがある @red_datasheet 。
+ Vdd (デジタル出力)
+ GND
+ Vcc (5V 電源電圧)

#figure(
  image("./img/焦電センサピンアサイン.png",width: 75%),
  caption: "距離センサーのピンアサイン"
)<distance_sensor_pin>

=== 正しい動作の条件，範囲は何か
marutsuのサイトによると、以下のような仕様がある @red_marutsu 。
- パッケージ:TO-5
- タイプ:標準検出タイプ
- 検出性能:標準検出タイプ
- 消費電力:100μA
- 消費電流:170μA
- 出力タイプ:デジタル
- 動作電圧:3～6V
- レンズ色:黒
- レンズ素材:ポリエチレン
- 検出距離:5m
- 定格検出:距離	最大5m

#pagebreak() // ページを分ける



// bibファイルの指定 //
#bibliography("./bibliography.bib")

