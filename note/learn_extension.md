# VSCode拡張機能に関わる学習

- [Extension API](https://code.visualstudio.com/api)
- 何ができるのか、把握に努めることは大事

## モチベーション

- VSCode拡張機能については、昔から関心のあったトピックであったため、実用性のため効率的にやるより、じっくり理解に努めよう
- なるべくリファレンスの説明には目を通そう(打ち覚えがいいかな)

## Overview

- 拡張機能のビルド・実行・デバッグ・テスト・公開について
- Extension APIによって恩恵を受ける方法
- ガイドとコードサンプルのありか
- ベストプラクティスのためのUXガイドライン

### 拡張機能で何ができるか?

- 色やアイコンテーマを変えられる
- UIにカスタムコンポーネントを追加できる
- WebViewでカスタムページを表示できる
- 新しいプログラミング言語のサポートを追加できる
- ランタイムへのデバッグをサポートできる

### どうやって拡張機能を作る?

- 良い拡張機能を作るには、多大な時間と努力が必要だ
- Get Started: 非常に基本的なサンプル
- 拡張機能でできること: 膨大なAPIから小さいカテゴリに分け、詳細トピックへの動線を示す
- UXガイドライン: ユーザー体験を向上させるベストプラクティス
- 言語拡張: プログラミング言語サポートの説明
- テストと公開: テストと公開のより深い説明
- Advancedトピック: Extension Host, リモート開発環境, GitHub Codespaces, Proposed API
- リファレンス: VSCode API, Contribution Pointsの網羅的なリファレンス

## 始めよう

### あなたの最初の拡張機能

- 拡張機能の開発には `Node.js` と `Git` が必要
- `Yeoman`, `VS Code Extension Generator` を使う

```bash
npm install -g yo generator-code
yo code # ここから始まる
```

### 拡張機能の解剖

- どのようにして動いているのか?
- VSCode 1.74.0から、`package.json` の `commands`に宣言されたコマンドは呼び出される際に `activationEvents` の `onCommand` に登録されていなくても自動で呼び出されうようになった
  - このとき、拡張機能が初めてアクティブになる
- `contributes.commands` でコマンドパレットに表示されるようになる
- TypeScriptソース内の `commands.registerCommand` で実際の関数の実体を登録できる(コマンドID指定)

### マニフェストファイル

- `package.json` 必須 (拡張機能マニフェストになる)
  - Node用の設定とVSCode用の設定が混在するので最初は理解しずらい
  - `publisher`: 発行者
  - `name`: 拡張機能名
  - 拡張機能のIDは `<publisher>.<name>` となる
  - `main`: 拡張機能のエントリーポイントとなるプログラム
  - `activationEvents`: 拡張機能が活性化する契機
    - ただし、`onLanguage` さえも特別な事情がない限りは設定不要になった
  - `engines`: VSCodeの必要バージョン等を記載

### 拡張機能のエントリーファイル

- `activate`, `deactivate` 関数がエクスポートされる
- `activate`: Activation Eventの後に呼び出される
- `deactivate`: 拡張機能が非活性になったときに呼び出される
  - 多くの場合、あまり必要がない
- VSCode extension APIは `@types/vscode` に宣言されている
- 以下に説明や例がたくさんあるので見てみてね
  - Extension Guide Listing
  - vs-code-extension-samples
  - UX Guidelines
- Help: Report Issueで、拡張機能を選択してバグ報告をしてもらうことができる
  - GitHub Issue連携もできそう
- 統合テストができるよ
- マーケットプレイスに公開できるよ
- 継続的インテグレーションのセットアップができるよ

## 拡張機能でできること

- Contribution Points
- VSCode API
- 拡張機能で用いることのできる機能
- さらに詳しいトピックへのリンク
- 拡張機能のアイデア

### 共通の機能

- コマンドの登録
- 設定
- キーバインド
- コンテキストメニュー
- ワークスペースまたはグローバルデータの保存
- 通知の表示
- ユーザー入力を扱うためのQuick Pickの利用
- システムファイルやフォルダの選択
- 長い処理へのProgress API

### テーマ

- エディタの色
- UIの色
- 既存のTextMate themを持ち込む
- カスタムアイコン

### 宣言的な言語機能

- 以下はコードを書かずともよい
  - カッコのマッチ
  - 自動インデント
  - シンタックスハイライト
  - スニペット
  - 新言語であることを伝える
  - 言語に追加・置き換えしたものができる
  - grammar injectionにより既存文法を拡張できる
  - 既存のTextMate grammarを移植する

### プログラマティックな言語機能

- ホバー
- 定義にジャンプ
- エラー診断
- インテリセンス
- CodeLens
  - 変更箇所・エラー・追加情報の表示
- `vscode.languages.*` APIに定義されている
  - 直接呼んでもいいし、Language Server Protocol経由でVSCodeに接続してもいい
- language featuresの項でユースケースを説明しているよ
- アイデア
  - APIのサンプルusageを表示するなど
  - スペルやリントエラーをdiagnosticsを使って表示
  - 新しいコードフォーマッターの登録
  - 文脈に応じたインテリセンス
  - 折りたたみ、パンくず、アウトライン

### ワークベンチの拡張機能

- ファイルエクスプローラー上での右クリックアクション
- TreeView APIを用いたカスタムエクスプローラー
- Webview APIを用いたカスタムインターフェース
  - HTML, CSS, JavaScriptで構築
- アイデア
  - ファイルエクスプローラーでのカスタムコンテキストメニュー
  - サイドメニューにおける新しいインタラクティブなツリービュー
  - アクティビティバーのカスタムビュー
  - ステータスバーに情報を表示
  - カスタムコンテンツを表示するためのWebview
  - ソース管理の機能を追加するための方法や設定を追加する

### デバッグ

- VSCodeのデバッグ機能を活用することができる
