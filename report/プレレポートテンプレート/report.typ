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

=== どのような仕組みか

=== どのような入力を取り扱うのか

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に)

=== どのようなピンアサイン (各ピンの役割) か

=== 正しい動作の条件，範囲は何か

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

