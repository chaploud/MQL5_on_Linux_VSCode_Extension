# 開発ノート

- [参考ページ](https://zenn.dev/daifukuninja/articles/13a35a8bb3a4a1)
- <https://github.com/L-I-V/MQL-Tools>

## 作業内容

```
$ npm install -g yo generator-code
$ yo code

# ここからyoの質問 ? => 回答
? What type of extension do you want to create?  => New Language Support

Enter the URL (http, https) or the file path of the tmLanguage grammar or press ENTER to start with a new grammar.
? URL or file to import, or none for new: => ()

? What's the name of your extension? => MQL5
? What's the identifier of your extension? => mql5
? What's the description of your extension? => MQL5 Language Support

Enter the id of the language. The id is an identifier and is single, lower-case name such as 'php', 'javascript'
? Language id: => mql5

Enter the name of the language. The name will be shown in the VS Code editor mode selector.
? Language name: => MQL5

Enter the file extensions of the language. Use commas to separate multiple entries (e.g. .ruby, .rb)
? File extensions: => .mq5,.mqh

Enter the root scope name of the grammar (e.g. source.ruby)
? Scope names: => source.mql5

? Initialize a git repository? => No
```

## 設計

- どのディレクトリでも対応できるようにする
- コンパイラのパス設定くらいは要求する
- 補完を完璧にこなす
- includeした関数なども補完対象に含める
- Ubuntuで動かすため、色々と工夫が必要

## MetaEditor.exe

```text
Usage:

MetaEditor64.exe /compile:"path" [/include:"path"] [/project] [/log] [/s]

/compile:"path" - source file, folder or project file path
/project - compile project file
/include:"path" - path to MQL4/MQL5 folder
/log - create compilation log file
/s - check a program syntax without comilation
```

- 動いた事例

````powershell
WINEPREFIX=${HOME}/.mt5 wine powershell  # wine版PowerShell導入済み
> cd "C:\Program Files\MetaTrader 5"
> $FileToCompile = "MQL5\Experts\Examples\MACD\MACDSample.mq5"
> .\MetaEditor64.exe /compile:"$FileToCompile" /log ```

- 上記により、 `C:\Program Files\MetaTrader 5\MQL5\Experts\Examples\MACD\MACDSample.log` に以下のようなコンパイルエラーログファイルが作成される

- 注意点として、まず、`MetaTrader 5`ディレクトリにいること(途中の空白パスもまずい?)
- コンパイル対象パスに空白が含まれるとなにも起こらずログファイルも生成されない
- MetaEditorのCLIが失敗してもなんらコマンドエラーとして表示されない
  - ファイルが存在しない場合も同様
- ログファイルはソースコードと同じディレクトリに生成されるため、フォルダ対象にしたりしたらどうなる?
  - 読み出した上で対象行に飛べるように工夫するなどしたほうがよい

```log
MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: compiling 'MACDSample.mq5'
MQL5\Experts\Examples\MACD\MACDSample.mq5(12,1) : error 109: '#propert' - invalid preprocessor command
MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Object.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Object.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\StdLibErr.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh
MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh
MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh
MQL5\Experts\Examples\MACD\MACDSample.mq5(12,1) : error 175: '#propert' - expressions are not allowed on a global scope
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh(12,27) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh(12,27) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh(12,34) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh(12,34) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh(12,30) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh(12,30) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh(12,26) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh(12,26) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh(25,23) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh(25,23) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh(12,28) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh(12,28) : error 239: 'CObject' - syntax error
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh(12,29) : error 116: 'CObject' - declaration without type
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh(12,29) : error 239: 'CObject' - syntax error
MQL5\Experts\Examples\MACD\MACDSample.mq5(39,22) : error 254: empty class 'CAccountInfo' cannot be used
C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh : information: info    see declaration of class 'CAccountInfo'
Result: 17 errors, 0 warnings
````

### Wineでの実行例

```bash
pushd .
export MT5="${HOME}/.mt5/drive_c/Program Files/MetaTrader 5"
export TARGET_FILE="MQL5\Experts\Examples\MACD\MACDSample.mq5"
cd "${MT5}"
WINPREFIX=${HOME}/.mt5 wine "MetaEditor64.exe" /compile:"${TARGET_FILE}" /log
popd
```
