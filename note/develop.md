# 開発ノート

- [参考ページ](https://zenn.dev/daifukuninja/articles/13a35a8bb3a4a1)
- <https://github.com/L-I-V/MQL-Tools>

## 作業内容

```
$ npm install -g yo generator-code
$ yo code

# ここからyoの質問 ? => 回答
? What's the name of your extension? => MQL5 on Linux
? What's the identifier of your extension? => mql5-on-linux
? What's the description of your extension? => MQL5 Language Support for Linux
? Initialize a git repository? => Yes
? Which bundler to use? => unbundled
? Which package manager to use? => npm
```

## ビルドなどのコマンド

```bash
npm run vscode:prepublish # ビルド成果物をoutディレクトリに出力
npm run compile # 動作的には↑と同じ
npm run watch # 変更があれば即座にビルド
npm run pretest # テスト前にビルドとリントを行う
npm run format # コードの整形
npm run lint # 静的解析
npm run test # vscode-testを用いたテスト
```

## ディレクトリの説明

```
  .
  ├── .vscode/  # VSCodeで本プロジェクトを扱う際の設定
  ├── .vscode-test/  # ビルド済みテストツールが格納される(ignore)
  ├── node_modules/  # 依存ライブラリが格納される(ignore)
  ├── out/  # ビルド済み拡張機能が格納される(ignore)
  ├── CHANGELOG.md  # マケプレに載せるチェンジログ
  ├── README.md  # GitHubリポジトリの表紙かつマケプレの説明表紙
  ├── assets/  # データファイルを置く場所
  │    └── images/  # 画像データ
  │         └── mql5-logo.png  # 拡張機能のアイコン
  ├── eslint.config.mjs  # eslintの設定ファイル
  ├── language-configuration.json  # カッコやコメントなどの言語設定
  ├── note/
  │    ├── develop.md  # 本ファイル。開発メモ
  │    ├── metaeditor.md  # MetaEditorのコマンドメモ書き
  │    ├── mql5_compile.sh  # MetaEditorのWine実行シェル
  │    └── wine_manual.txt  # Wineのマニュアルの写し
  ├── package-lock.json  # バージョン管理自動生成ロックファイル
  ├── package.json  # ライブラリや拡張機能の設定等をすべて記載
  ├── src/  # 開発するソースコードの格納場所
  │    ├── extension.ts  # 拡張機能のエントリーポイント
  │    └── test/  # テストコードを格納
  │         └── extension.test.ts
  ├── syntaxes/  # シンタックスハイライトの設定(tmLanguage)
  │    ├── mql5.out.tmLanguage.json  # 拡張機能の出力のハイライト
  │    └── mql5.tmLanguage.json  # MQL5言語のハイライト
  ├── tsconfig.json  # 用いるTypeScriptについての設定
  └── vsc-extension-quickstart.md
```

## 拡張機能のデバッグ

- `F5` キーで拡張機能を読み込んだウィンドウが開く
  - コマンドパレットでコマンド呼び出しできる
  - ソースコードにブレークポイントを置いて調査することができる
  - デバッグコンソールへの出力も確認することができる
- `*.ts` ファイルを変更したら、拡張機能を読み込んだウィンドウをリロードしたら反映される
- `node_modules/@types/vscode/index.d.ts` にAPIが書かれているよ
  - ただし2万行あるよ!

## 拡張機能のテスト

- Extension Test Runnerをインストールしてね
- コマンドパレットから Tasks: Run Taskを選んで `watch` してね
- 左端のアクティビティバーから `Testing` を選び、該当するテストの再生ボタンを押せばOK
- `**.test.ts` というファイルに反応するよ
- `test`ディレクトリ以下にサブディレクトリを作ってもOK

## UXガイドラインがあるから読んでみて

- [Follow UX guidelines](https://code.visualstudio.com/api/ux-guidelines/overview) to create extensions that seamlessly integrate with VS Code's native interface and patterns.

## 拡張機能のサイズと起動時間を短くするTIPS

- Reduce the extension size and improve the startup time by [bundling your extension](https://code.visualstudio.com/api/working-with-extensions/bundling-extension).

## マーケットプレースへの公開・アップデートの仕方

- [Publish your extension](https://code.visualstudio.com/api/working-with-extensions/publishing-extension) on the VS Code extension marketplace.

## 継続的インテグレーションのTIPS

- Automate builds by setting up [Continuous Integration](https://code.visualstudio.com/api/working-with-extensions/continuous-integration).

## ユーザーからの声をGitHubとマーケットプレースで共有

- Integrate to the [report issue](https://code.visualstudio.com/api/get-started/wrapping-up#issue-reporting) flow to get issue and feature requests reported by users.

## 設計

- どのディレクトリでも対応できるようにする
- コンパイラのパス設定くらいは要求する
- 補完を完璧にこなす
- includeした関数なども補完対象に含める
- Ubuntuで動かすため、色々と工夫が必要
