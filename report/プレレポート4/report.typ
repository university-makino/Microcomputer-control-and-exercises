// ライブラリの実装 //
#import "@preview/codelst:2.0.1": sourcecode
#import "@preview/i-figured:0.2.4"

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

// 図の表示の仕方を表示 //
// #show heading: i-figured.reset-counters.with(level: 2)
// #show figure: i-figured.show-figure.with(level: 2)


//タイトルページここから//
#align(right, text()[
  #text[提出日]#datetime.today().display("[year]年[month]月[day]日")
])
#v(150pt)
#align(center, text(30pt)[
  #heading_font[*プレ・レポート4*]
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

// 目次
#outline(
    title: "目次",
    depth: 2,
    indent: auto,
)
#pagebreak()

// 図表
// #i-figured.outline(
//   title: "zu",
//   depth: 2,
//   indent: auto,
// )
// #pagebreak()


//本文ここから//
= プレ・レポート（課題 4）
== @H_LEDダイオード @LEDダイオード の電子部品 ( フルカラーLED OSTA5131A) を次のような点から調べなさい。 <H_LEDダイオード>

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

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) <H_LEDダイオード_data>

OptoSupplyによると、赤色は2.8Vぐらいを加えると最大光量に達成するが、緑と青色は、3.8Vぐらいを加えると最大光量に達成する @rgbled_datasheet 。
@H_LEDダイオード_data @LEDダイオードグラフ は、電圧が増加すると光量が増加する。グラフの形としては指数関数的に増加している。

#figure(
  image("./img/LEDダイオードグラフ.png",width: 50%),
  caption: "LEDダイオードグラフ"
)<LEDダイオードグラフ>

=== どのようなピンアサイン (各ピンの役割) か <H_LEDダイオード_pin>

OptoSupplyによると、LEDのピンアサインは、緑が1番、青が2番、GNDが3番, 赤が4番である @rgbled_datasheet 。
@H_LEDダイオード_pin @LEDダイオードピンアサイン は、ピンアサインを示している。

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

== @H_LEDアレイ @LEDアレイ の電子部品 ( LEDアレイ C-551SRD) を次のような点から調べなさい。 <H_LEDアレイ>

#figure(
  image("./img/LEDアレイ.png",width: 50%),
  caption: "LEDアレイ"
)<LEDアレイ>

=== どのような部品か

数字情報の表示に特化したデジタル表示モジュール。表示する数字の形状部に発光ダイオード（LED）を配しているため、大変視認性に優れている。「LED数字表示器」や「7セグLED」と呼ばれる場合もある @led7seg_rohm 。

=== どのような仕組みか <H_LEDアレイ_仕組み>
値を表示するデジット部分と、そのデジット部分を表示するためのLEDが組み合わさったもの。7セグメントLEDは、7つのLEDを組み合わせて数字を表示するデバイスである。7つのLEDは、それぞれが1つのセグメントを表し、数字を表示するためには、それぞれのセグメントを点灯させ数字を表示する。

@H_LEDアレイ_仕組み @7セグメントLED各部の名称 は、7セグメントLEDの各部の名称を示している。

#figure(
  image("./img/7セグメントLED各部の名称.png",width: 50%),
  caption: "7セグメントLED各部の名称"
)<7セグメントLED各部の名称>

=== どのような入力を取り扱うのか

電流を入力として取り扱う。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) <H_LEDアレイ_data>

PARALIGHTによると、LEDの立ち上がり電圧は1.6Vとなっており、それ以降は素早く光量が増加していく @led7seg_datasheet 。

@H_LEDアレイ_data @LEDアレイグラフ は、電圧が増加すると電流値が増加する。グラフの形としては指数関数的に増加している。

#figure(
  image("./img/LEDアレイグラフ.png",width: 50%),
  caption: "LEDアレイグラフ"
)<LEDアレイグラフ>

=== どのようなピンアサイン (各ピンの役割) か <H_LEDアレイ_pin>

@H_LEDアレイ_pin @LEDアレイピンアサイン は、ピンアサインを示している。

カソードコモンの7セグメントLEDであるため、各セグメントのアノードには電圧を加えると点灯する。また、カソードは共通である。
一つ一つのLEDには、それぞれのセグメントに対応するピンがある。

#figure(
  image("./img/LEDアレイピンアサイン.png",width: 80%),
  caption: "LEDアレイピンアサイン"
)<LEDアレイピンアサイン>


=== 正しい動作の条件，範囲は何か

秋月電子通商によると、以下の通りとなる @led7seg_akituki 。

- セグメント数:7
- 桁数:1
- 色:赤
- 光度:10mcd
- 順電圧:1.8V
- 順電流max.:30mA
- 逆電圧:5V
- 表面色:黒
- コモンタイプ:カソードコモン
- 文字幅:8mm
- 文字高さ:14.2mm
- 許容損失max.:60mW
- 動作温度min.:-35℃
- 動作温度max.:85℃
- 実装タイプ:スルーホール
- 長さ:19mm
- 幅:12.7mm
- 高さ:8mm


#pagebreak() // ページを分ける



== @H_DCモーター @DCモーター の電子部品 ( DCモーター FA-130RA) を次のような点から調べなさい。<H_DCモーター>

#figure(
  image("./img/DCモーター.png",width: 50%),
  caption: "DCモーター"
)<DCモーター>

=== どのような部品か
DCモーターは、直流電源を用いて回転運動を行うモーターである。モーターを回すと、モーターの軸に取り付けた部品を回転できる。
ラジコンや模型の動力源として使われる @dc_motor_akituki 。

=== どのような仕組みか
FA-130RAはブラシ付きモーターである。ブラシ付きモーターは、モーターの回転子に巻かれたコイルに電流を流すことで、回転子に磁界を発生させ、それによって回転子を回転させる。ブラシ付きモーターは、モーターの回転子に巻かれたコイルに電流を流すことで、回転子に磁界を発生させ、それによって回転子を回転させる。
シンプルな構造だが、ブラシレスDCモータのブラシと整流子は常に接触したまま回転し、摩耗するため、定期的な交換といったメンテナンスが必要である @dc_motor_aspina 。

=== どのような入力を取り扱うのか
電流を入力として取り扱う。
マイコンの電流そのままではモーターを動かすことができないため、モータードライバなどを介して外部電源でモーターを制御する。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) <H_DCモーター_data>

MERCURY MOTORによると、DCモーターの回転数は、電流が上昇するとトルクが上昇する。 @dc_motor_datasheet 。

@H_DCモーター_data @DCモーターグラフ は、電圧が増加すると回転数が増加する。グラフの形としては線形的に増加している。

#figure(
  image("./img/DCモーターグラフ.png",width: 50%),
  caption: "DCモーターグラフ"
)<DCモーターグラフ>


=== どのようなピンアサイン (各ピンの役割) か <H_DCモーター_pin>

特にピンアサインなどはないが、モーターの端子には、電流を流すための端子がある。
電流の向きによって回転方向が変わる。

@H_DCモーター_pin @DCモーターの端子 は、DCモーターの端子を表している。

#figure(
  image("./img/DCモーターピンアサイン.png",width: 50%),
  caption: "DCモーターの端子"
)<DCモーターの端子>

=== 正しい動作の条件，範囲は何か

秋月電子通商によると、以下の通りとなる @dc_motor_akituki 。

- 定格電圧:1.5V
- 無負荷回転数:9100rpm
- 無負荷電流:0.2A
- 定格負荷回転数:6990rpm
- 定格負荷電流:0.66A
- 定格負荷トルク[gf・cm]:6.0gf・cm
- 定格負荷出力:0.43W
- 停動トルク[gf・cm]:26gf・cm
- 停動電流:2.2A
- 端子部形状:ラグ
- 軸径:2mm
- 軸形状:丸
- 長辺:24.8mm
- 短辺:20.1mm
- 高さ:15mm

#pagebreak() // ページを分ける

== @H_トランジスタ @トランジスタ の電子部品 ( トランジスタ 2SC2120Y) を次のような点から調べなさい。<H_トランジスタ>

#figure(
  image("./img/トランジスタ.jpg",width: 50%),
  caption: "トランジスタ"
)<トランジスタ>

=== どのような部品か <H_トランジスタとは>

トランジスタは、電気信号を増幅したりスイッチングしたりする機能を持っている。
ラジオの場合、空中を伝わってきた極めて微弱な信号を拡大（増幅）して、スピーカーを鳴らす。
また、あらかじめ決められた信号が来た時だけトランジスタが動作するスイッチの役割も果たす @transistor_rohm 。

@H_トランジスタとは @トランジスタとは は、トランジスタの基本機能を示している。

#figure(
  image("./img/トランジスタとは.png",width: 90%),
  caption: "トランジスタとは"
)<トランジスタとは>

=== どのような仕組みか <H_トランジスタの仕組み>

トランジスタは、PN接合により構成され、ベースに電流を流すことで、コレクタ-エミッタ間に電流が流れる
ベース-エミッタ間に順方向電圧（VBE）を印加すると、エミッタの電子（-の電荷）がベースに流れ込み、一部の電子がベースの正孔（+の電荷）と結合する。これが、ベースの微小電流（IB）となる。
ベース（P型半導体）は構造的に薄く作られており、エミッタからベースに流入してきた電子の多くはコレクタに抜け出す。
コレクタ-エミッタ間電圧（VCE）によって電子（-の電荷）が誘導されてコレクタ電極方向に移動する。これがコレクタ電流ICとなる @transistor_rohm 。

@H_トランジスタの仕組み @トランジスタの仕組み は、トランジスタの基本的な仕組みを示している。

#figure(
  image("./img/トランジスタの仕組み.png",width: 50%),
  caption: "トランジスタの仕組み"
)<トランジスタの仕組み>

=== どのような入力を取り扱うのか

ベース、エミッタ間の電流を入力として取り扱う。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) <H_トランジスタ_data>

JIANGSU CHANGJIANG ELECTRONICS TECHNOLOGYによると、トランジスタの電流増幅率は、ベース電流が増加すると、コレクタ電流が増加する @transister_datasheet 。

@H_トランジスタ_data @トランジスタグラフ1 は、Ic-Vbeの特性を示している。
エミッタ接地トランジスタの静特性で、コレクタ電流ICとベース-エミッタ間電圧VBEの関係を表した特性である。
ベース・エミッタ間の電圧Vbeを変化させたときのコレクタ電流Icの変化を示している。
0.7V以上のVbeで急激にIcが増加する。立ち上がりの部分が急激なため、トランジスタのスイッチング特性として利用される。

@H_トランジスタ_data @トランジスタグラフ2 は、Ic-Vceの特性を示している。
静特性(IC-VCE特性)はコレクタ電流Icとコレクタエミッタ間電圧VCEの関係を示している。静特性(IC-VCE特性)とは、あるコレクタエミッタ間電圧Vceにおいて流すことが可能なコレクタ電流Icの能力を示したものである。
Ibの電流を流したときに、Vceを変化させたときのIcの変化を示している。
Ibにそこそこの電流が流れていないと、Icはほとんど流れない。Ibに十分な電流が流れていると、Icはほぼ一定の値を取る。この二つの特性を見ることで、トランジスタの特性をざっくり理解することができる。

#figure(
  image("./img/トランジスタグラフ1.png",width: 50%),
  caption: "トランジスタグラフ1"
)<トランジスタグラフ1>

#figure(
  image("./img/トランジスタグラフ2.png",width: 50%),
  caption: "トランジスタグラフ2"
)<トランジスタグラフ2>


=== どのようなピンアサイン (各ピンの役割) か <H_トランジスタ_pin>

JIANGSU CHANGJIANG ELECTRONICS TECHNOLOGYによると、トランジスタのピンアサインは、エミッタが1番、コレクタが2番、ベースが3番である @transister_datasheet 。

@H_トランジスタ_pin @トランジスタピンアサイン は、トランジスタのピンアサインを示している。

#figure(
  image("./img/トランジスタピンアサイン.png",width: 50%),
  caption: "トランジスタピンアサイン"
)<トランジスタピンアサイン>


=== 正しい動作の条件，範囲は何か

秋月電子通商によると、以下の通りとなる @transistor_akituki 。

- 接合構造:NPN
- コレクターエミッター間電圧:30V
- コレクターベース間電圧:35V
- エミッターベース間電圧:5V
- コレクター電流:800mA
- コレクターエミッター飽和電圧:0.5V
- ベースエミッター間電圧:0.8V
- 許容損失max.:600mW
- 直流電流増幅率min.:160
- 直流電流増幅率max.:320
- トランジション周波数:100MHz
- 実装タイプ:スルーホール
- パッケージ:TO-92
- パッケージタイプ:TO92

#pagebreak() // ページを分ける

== @H_ダイオード @ダイオード の電子部品 (ダイオード 11EQS04) を次のような点から調べなさい。 <H_ダイオード>

#figure(
  image("./img/ダイオード.jpg",width: 50%),
  caption: "ダイオード"
)<ダイオード>

=== どのような部品か

電流を一定方向に通す半導体素子。電流が一方向にしか流れない性質を利用して、整流器や電圧安定器などに使用される。

=== どのような仕組みか <H_ダイオード仕組み>

金属と半導体との接合によって生じるショットキー障壁を利用したダイオード。
pnダイオードと仕組みは似ていて、P型チャネルは電子を多く含み、N型チャネルは電子を少なく含む。このため、純電流を流すことで、P型チャネルからN型チャネルに電子が流れ、電子が流れることで電流が流れる。しかし、逆電流になると、電子が電極側に集まり、PN結合部に空白地帯が発生して、電気が流れなくなる。
この仕組みを応用して、ショットキーダイオードを作成して、整流を行なっている。

@H_ダイオード仕組み @ダイオード仕組み は、ダイオードの仕組みを示している。

#figure(
  image("./img/ダイオード仕組み.png",width: 70%),
  caption: "ダイオード仕組み"
)<ダイオード仕組み>

=== どのような入力を取り扱うのか

ベース、エミッタ間の電流を入力として取り扱う。

=== 入力に応じて出力がどう変化するのか (データシートや仕様書を参考に) <H_ダイオード_data>

アノードに正の電圧を加えると、キャリアがアノードに向かって移動し、電流が流れる。逆に、アノードに負の電圧を加えると、キャリアがアノードに向かって移動できなくなり、電流が流れなくなる。

@H_ダイオード_data @ダイオードグラフ は、電圧が増加すると電流値が増加する。グラフの形としては指数関数的に増加している。
立ち上がり電圧は0.4Vである。

#figure(
  image("./img/ダイオードグラフ.png",width: 50%),
  caption: "ダイオードグラフ"
)<ダイオードグラフ>

=== どのようなピンアサイン (各ピンの役割) か <H_ダイオード_pin>

KYOCERAによると、ダイオード帯がついている側がカソードで、帯がついていない側がアノードである@transister_datasheet 。

@H_ダイオード_pin @ダイオードピンアサイン は、トランジスタのピンアサインを示している。

#figure(
  image("./img/ダイオードピンアサイン.png",width: 40%),
  caption: "ダイオードピンアサイン"
)<ダイオードピンアサイン>


=== 正しい動作の条件，範囲は何か

秋月電子通商によると、以下の通りとなる @transistor_akituki 。

- 構造:ショットキー接合
- 素材:シリコン
- ピーク耐圧:40V
- 平均順電流:1A
- ピーク順電流:40A
- 順電圧:0.55V
- 実装タイプ:スルーホール
- パッケージ:アキシャルリード
- パッケージタイプ:アキシャルリード

#pagebreak() // ページを分ける


== フルカラーLED を扱う上で、「RGB」・「カソードコモン、アノードコモン」という用語を知っておく必要がある。これらはどういう意味か？レポートで考察することも考慮の上、調べてまとめなさい、なお、「LED アレイ」は7 セグメントLED7、 セグメントディスプレイなどとも呼ばれる．


アノードコモンは、アノードが共通であることを示している。アノードコモンの場合、5V電圧を共通部に接続し、各セグメントに対してGNDを接続することで、各セグメントを点灯させることができる。
また、カソードコモンは、カソードが共通であることを示している。カソードコモンの場合、GNDを共通部に接続し、各セグメントに対して5V電圧を接続することで、各セグメントを点灯させることができる。


#pagebreak() // ページを分ける

// bibファイルの指定 //
#bibliography("./bibliography.bib")

