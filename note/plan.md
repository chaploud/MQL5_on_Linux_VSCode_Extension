# 設計

- どのディレクトリでも対応できるようにする
- コンパイラのパス設定くらいは要求する
- 補完を完璧にこなす
- includeした関数なども補完対象に含める
- Ubuntuで動かすため、色々と工夫が必要

## 想定

- ms-vscode.cpptoolsを前提とする
  - 依存関係に含める
- formatterはC++言語機能を使う

```json
"[mql5]": {
  "editor.defaultFormatter": "ms-vscode.cpptools"
}
```

## 広報

- MQL5コミュニティーの記事に紹介記事を書こう
