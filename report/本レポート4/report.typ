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
実験を通して、フルカラーLED OSTA5131Aの使い方と仕組みの習得を目的とする。

= 演習の使用部品

== @LEDダイオード の電子部品 ( フルカラーLED OSTA5131A) を次のような点から調べなさい。

#figure(
  image("./img/LEDダイオード.png",width: 50%),
  caption: "LEDダイオード"
)<LEDダイオード>

=== どのような部品か
オプトサプライのフルカラーRGBLED。発光色を混ぜるとフルカラーを表現可能となる @rgbled_akituki 。

=== どのような仕組みか
フルカラーLEDには、それぞれ赤、緑、青で発光する半導体の小さな板（LEDチップ）が入っており、それぞれのLEDチップに流す電流の大きさを変えてそれぞれの色の光の強度を変え、3色の混合割合を変えると、発光色を変化させる  。

=== どのような入力を取り扱うのか
電流を入力として取り扱う。

#pagebreak() // ページを分ける

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) 

OptoSupplyによると、赤色は2.8Vぐらいを加えると最大光量に達成するが、緑と青色は、3.8Vぐらいを加えると最大光量に達成する @rgbled_datasheet 。
@LEDダイオードグラフ は、電圧が増加すると光量が増加する。グラフの形としては指数関数的に増加している。

#figure(
  image("./img/LEDダイオードグラフ.png",width: 50%),
  caption: "LEDダイオードグラフ"
)<LEDダイオードグラフ>

=== どのようなピンアサイン (各ピンの役割) か 

OptoSupplyによると、LEDのピンアサインは、緑が1番、青が2番、GNDが3番, 赤が4番である @rgbled_datasheet 。
@LEDダイオードピンアサイン は、ピンアサインを示している。

#figure(
  image("./img/LEDダイオードピンアサイン.png",width: 50%),
  caption: "LEDダイオードピンアサイン"
)<LEDダイオードピンアサイン>

=== 正しい動作の条件，範囲は何か

秋月電子通商によると、以下の通りとなる @rgbled_akituki 。

-  種別:砲弾型
-  色:赤・緑・青
-  ドミナント波長:赤635nm・緑525nm・青470nm
-  ドミナント波長赤:635nm
-  ドミナント波長緑:525nm
-  ドミナント波長青:470nm
-  光度:赤2000mcd・緑7000mcd・青2500mcd
-  光度赤:2000mcd
-  光度緑:7000mcd
-  光度青:2500mcd
-  順電圧:赤2V・緑3.6V・青3.6V
-  順電圧赤:2V
-  順電圧緑:3.6V
-  順電圧青:3.6V
-  順電流max.:赤30mA・緑30mA・青30mA
-  順電流max.赤:30mA
-  順電流max.緑:30mA
-  順電流max.青:30mA
-  逆電圧:赤5V・緑5V・青5V
-  逆電圧赤:5V
-  逆電圧緑:5V
-  逆電圧青:5V
-  許容損失max.:赤75mW・緑105mW・青105mW
-  許容損失max.赤:75mW
-  許容損失max.緑:105mW
-  許容損失max.青:105mW
-  半減角:30°
-  動作温度min.:-30℃
-  動作温度max.:85℃
-  構成:カソードコモン
-  端子部形状:ピン
-  実装タイプ:スルーホール
-  長さ:8.7mm
-  径:5mm


#pagebreak() // ページを分ける

= 課題内容

== フルカラーLEDを光らせる

=== 実験その１ (動作確認)

アナログ出力は以下の表4.2 のようになる. 表に従いフルカラーLED の各ピンへのアナログ出力値
に対してフルカラーLED が何色に発光するかを確認しなさい。あわせて @フルカラーLEDの発光色のアナログ出力値 の空欄箇所を埋めなさい。

// Definition of table format
#figure(
  table(
    columns: 4 * (1fr,),
    align: (x, y) => if x == 0 or y == 0 { left } else { center },

    table.cell(colspan: 3, "アナログ出力"), table.cell(colspan: 1, "状態"),
    [赤],[緑],[青],[],
    [255],[255],[255],[白],
    [0],[0],[0],[黒],
    [255],[0],[0],[赤],
    [],[],[],[緑],
    [],[],[],[水色],
    [255],[0],[255],[],
    [255],[100],[0],[],
  ),
  caption: [フルカラーLED の発光色のアナログ出力値],
) <フルカラーLEDの発光色のアナログ出力値>


*回路図* 

*プログラム*

*実験結果*

*考察*

=== 発展その1(ランダム関数の導入)

1 秒ごとに、フルカラーLED の発光色がランダムに変わるようにしなさい.

*回路図* 

*プログラム*

*実験結果*

*考察*

=== 発展その2(map 関数の導入)

好きな色を3 色選び、一定時間ごとにフルカラーLED が選んだ色に少しずつ変わるようにしなさい。
  例: 青(B) → (中間色M) →赤(R) → (中間色Y) →緑(G) → (中間色C) →青(B)
@光の三原色 は、光の三原色を示している。

#figure(
  image("./img/光の三原色.png",width: 50%),
  caption: "光の三原色"
)<光の三原色>

*回路図* 

*プログラム*

*実験結果*

*考察*

=== まとめ

#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

