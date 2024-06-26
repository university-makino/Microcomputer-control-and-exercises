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
実験を通して、LEDマトリクス TOM-1588BH-Bの使い方と仕組みの習得を目的とする。

= 演習の使用部品
== @LEDマトリクス の電子部品 ( LEDマトリクス TOM-1588BH-B) を次のような点から調べなさい。

#figure(
  image("./img/LEDマトリクス.png",width: 50%),
  caption: "LEDマトリクス"
)<LEDマトリクス>

=== どのような部品か

8列8行のドットマトリックスディスプレイで、赤色の発光ダイオードを64個搭載している。 
8列8行のLEDで構成されており、各LEDは各列で共通のアノードと各行で共通のカソードを持っている。
電光掲示板や電子時計などに使用される。

=== どのような仕組みか

TOM-1588BH-Bは廃盤となっており、データシートが見つからなかったため、代わりに後継機であるTOM-1588AMG-N について調査した。
@LEDマトリクス回路図 に示すように、各LEDはアノードとカソードに接続されており、アノードに正の電圧を加え、カソードに接地することでLEDを点灯させる @led_matix_oasistek_dataheet。
各LEDは行と列の交点に配置されており、行と列の交点に電圧を加えることで、特定のLEDのみを点灯させることができる。

#figure(
  image("./img/LEDマトリクス回路図.png",width: 50%),
  caption: "LEDマトリクス回路図"
)<LEDマトリクス回路図>

=== どのような入力を取り扱うのか

電圧を入力として取り扱う。各LEDに対してアノードに正の電圧を加え、カソードに接地することでLEDを点灯させる。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) 

一つ一つのLEDは独立して制御されるため、入力に応じて出力が変化する。各LEDに対してアノードに正の電圧を加え、カソードに接地することでLEDを点灯させる。

=== どのようなピンアサイン (各ピンの役割) か 

@LEDマトリクスピンアサイン に示すように、8列8行のLEDマトリクスには、各列に対してアノードが、各行に対してカソードが接続されている。
実際のピンアサインと光る位置は綺麗に並んでいる訳ではないため、ピンアサインを確認しながら接続する必要がある。

#figure(
  image("./img/LEDマトリクスピンアサイン.png",width: 90%),
  caption: "LEDマトリクスピンアサイン"
)<LEDマトリクスピンアサイン>

=== 正しい動作の条件，範囲は何か

- ピーク順⽅向電流（1/10 デューティ サイクル、0.1ms パルス幅）: 80mA
- ドットあたりの消費電⼒ : 75mW
- 連続順⽅向電流 : 20mA
- 推奨動作電流 : 12mA
- 逆電圧 : 5V
- 動作温度範囲 : -25°C 〜 +85°C
- 保管温度範囲 : -30°C 〜 +85°C
- 鉛フリーはんだ温度（座⾯下1/16インチ）: 260°C 3秒

#pagebreak() // ページを分ける

= 課題内容

== フルカラーLEDを光らせる

=== 実験その１ (動作確認)

*回路図* 

*プログラム*

*実験結果*


*考察*


=== まとめ


#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

