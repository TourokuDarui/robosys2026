# robosys2026
このリポジトリはロボットシステム学の授業で利用するリポジトリです。いくつかのソフトウェアパッケージを公開しています。

# kryptosコマンド
![test](https://github.com/TourokuDarui/robosys2026/actions/workflows/test.yml/badge.svg)

漢字・ひらがな・カタカナを含む日本語テキストをローマ字に変換し、シーザー暗号で暗号化・復号することができます。

標準入力（パイプ）とファイル指定の両方に対応しています。

## 特徴

- 日本語（漢字・かな）対応
  - pykakasi を使用して漢字やひらがな・カタカナをヘボン式ローマ字に変換してから暗号化します。
- 標準入出力（パイプ）対応
  - cat や echo などの出力をパイプ（|）で受け取り、変換結果を標準出力へ流せます。
- 柔軟なシフト設定
  - -s オプションでずらす文字数を自由に指定できます。


## 必要なソフトウェア
- Python
  - テスト済みバージョン: 3.10〜3.14
- pykakasi

## テスト環境
- Ubuntu 24.04 LTS

## インストール方法

### 1. リポジトリをクローンします
git clone [https://github.com/TourokuDarui/robosys2026.git](https://github.com/TourokuDarui/robosys2026.git)
```bash
cd robosys2026
```
　　
### 2. 依存ライブラリをインストールします
```bash
pip install -r requirements.txt
```
※ externally-managed-environment エラーが出る場合は、以下を実行してください
```bash
pip install --user --break-system-packages -r requirements.txt
```

### 3.実行権限を付与し、パスの通ったディレクトリ（~/.local/bin など）に配置します
```bash
chmod +x kryptos
mkdir -p ~/.local/bin
cp kryptos ~/.local/bin/kryptos
```

## 使用例

### 1. 標準入力（パイプ）から暗号化・復号する
暗号化（デフォルトのシフト数: 3）
```bash
echo "明日の15時に東京駅で待ち合わせしましょう。" | kryptos
#出力例: dvklwdqr15mlqlwrxnbxhnlghpdfkldzdvhvklpdvkbrx。
```

パイプでつないで復号（-d オプション）
```bash
echo "明日の15時に東京駅で待ち合わせしましょう。" | kryptos | kryptos -d
#出力例: ashitano15jinitoukyouekidemachiawaseshimashou。 
```

### 2. シフト数を指定する（-s / --shift）
10文字ずらして暗号化
```bash
echo "Hello, WSL!" | kryptos -s 10
```

10文字ずらした暗号を復号
```bash
echo "Rovvy, GCV!" | kryptos -d -s 10
```

### 3.ファイルを指定して変換する
ファイルを暗号化して別ファイルに保存
```bash
kryptos input.txt > encrypted.txt
```

暗号化ファイルを復号して画面に表示
```bash
kryptos -d encrypted.txt
```

| オプション | 説明 |
|:---:|:---:|
|file|入力ファイルのパス（省略時は標準入力から読み込みます）|
|-s, --shift|ずらす文字数（デフォルト: 3）|
|-d, --decrypt|復号モードで実行します|
|-h, --help|ヘルプメッセージを表示します|

## 仕様・注意事項
- 暗号化の際に日本語を一度ローマ字へ変換するため、復号後のテキストは元の漢字・かなではなくローマ字表記になります。

- アルファベット以外の文字（数字・記号・句読点・改行）は変換されずそのまま保持されます。

- 漢字の読み変換および句読点の変換（「。」「、」→「.」「,」）は pykakasi の変換仕様に準拠します（例：「15時」は 15toki として変換されます）。

- 本ツールは学習および古典暗号の体験を目的としています。機密情報の保護には使用しないでください。

## 謝辞

- 本ソフトウェアの日本語ローマ字変換機能には [pykakasi](https://github.com/miurahr/pykakasi) を使用しています。
- 実装およびテストコードの作成にあたっては、AIアシスタント（Gemini）の助言を参考にしました。
- このパッケージは、aaa由来のコード（© 2025 Hoge Fuge）を利用しています。
- このパッケージのコードの一部は、下記のスライド（CC BY-SA 4.0 by Taro Suzuki）のものを、本人の許可を得て自身の著作としたものです。
- https://github.com/tarolab-cit/lectures/tree/main/robosys2026

## 著作権とLICENSE
- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されます。
- © 2026 Taisei Yamazaki





