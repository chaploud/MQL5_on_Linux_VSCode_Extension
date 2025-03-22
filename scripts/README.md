# scripts

- 全部手動でやるのは現実的ではない
- 関数主体でクローリング・スクレイピングする

## 関数の表から

- Function: 関数名
- Action: 説明
- Section: タグづけする

## Functionのリンク先

- 関数のインターフェースをコピーして貼り付け
- 引数の後ろの説明は、残しておいてもよい
- Parametersの説明を引数名と対応するセクションから切り出し、docstringにする
- ENUM_ACCOUNT_INFO_DOUBLEとかのリンクがあれば、訪れ、その直下にあるテーブルをenum形式として格納する
- その説明はその上にFor the function AccountInfoDouble()とかあるやつ
- Identifierがメンバー, Descriptionがコメント
- さらに入れ子のENUMやClassもあるな...

- 一旦手作業でヘッダーファイル作ってみるか
