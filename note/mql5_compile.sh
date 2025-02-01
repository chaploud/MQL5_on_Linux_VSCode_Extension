#!/bin/bash

# TODO: ディレクトリ・プロジェクトを指定してコンパイルする場合、ログファイル等の出方やエラーの出方
# TODO: コンパイルログとLSPとの統合でVSCodeにうまく連携する
# TODO: ファイルまでのパスに空白が含まれた場合はエラーにする

# Usage:

# MetaEditor64.exe /compile:"path" [/include:"path"] [/project] [/log] [/s]

# /compile:"path" - source file, folder or project file path
# /project - compile project file
# /include:"path" - path to MQL4/MQL5 folder
# /log - create compilation log file
# /s - check a program syntax without comilation

# NOTE: とりあえずうまく動いたコード
# export MT5="${HOME}/.mt5/drive_c/Program Files/MetaTrader 5"
# export TARGET_FILE="MQL5/Experts/Examples/MACD/MACDSample.mq5"
# export LOG_FILE="MQL5/Experts/Examples/MACD/MACDSample.log"
# cd "${MT5}" || exit
# WINPREFIX=${HOME}/.mt5 wine "MetaEditor64.exe" /compile:"${TARGET_FILE}" /log
# cat ${LOG_FILE}

# オプション
# path = ファイル、フォルダ、プロジェクトファイルのパス(必須)
# project = プロジェクトファイルをコンパイルするかどうか
# include = インクルードパスの追加
# log = ログファイルの作成(必須)
# s = コンパイルせずにプログラムの構文をチェックする
# WINEPREFIX = Wineのプレフィックスのパス
# MT5 = MetaTrader 5のインストールディレクトリ
# TARGET = MT5からの相対パスで指定したコンパイル対象のファイルパス


print_usage() {
  echo "Usage: mql5_compile.sh TARGET [-c] [-p] [-i INCLUDE_PATH]"
  echo "TARGET: path to source file, folder or project file"
  echo "Options:"
  echo "  -c  Syntax check without compilation"
  echo "  -p  Compile project file"
  echo "  -i  Pass INCLUDE_PATH"
}

# 環境変数の確認(存在しない場合はデフォルトのパスを設定)
if [ -z "${WINEPREFIX}" ]; then
  WINEPREFIX="${HOME}/.mt5"
fi

if [ -z "${MT5}" ]; then
  MT5="${WINEPREFIX}/drive_c/Program Files/MetaTrader 5"
fi

if [ -z "${MetaEditor}" ]; then
  MetaEditor="${MT5}/MetaEditor64.exe"
fi

ENV_CHECK_OK=true

if [ ! -d "${WINEPREFIX}" ]; then
  echo "WINEPREFIX='${WINEPREFIX}' is not found."
  ENV_CHECK_OK=false
fi

if [ ! -d "${MT5}" ]; then
  echo "MT5='${MT5}' is not found."
  ENV_CHECK_OK=false
fi

if [ ! -f "${MetaEditor}" ]; then
  echo "MetaEditor='${MetaEditor}' is not found."
  ENV_CHECK_OK=false
fi

if [ "${ENV_CHECK_OK}" = false ]; then
  exit 1
fi

TARGET_FILE=$1

if [ -z "${TARGET_FILE}" ]; then
  echo "Usage: mql5_compile.sh path [-c] [-p] [-i include_path]"
  exit 1
fi

shift

while getopts ":c:p:i" opt; do
  case ${opt} in
    c)
      SYNTAX_CHECK=true
      ;;
    p)
      PROJECT=true
      ;;
    i)
      INCLUDE=$OPTARG
      ;;
    \?)
      echo "Usage: mql5_compile.sh path [-c] [-p] [-i include_path]"
      exit 1
  esac
done

# コマンドの構築
COMMAND="WINEPREFIX=${WINEPREFIX} wine ${MetaEditor} /compile:\"${TARGET_FILE}\" /log"

if [ "${SYNTAX_CHECK}" = true ]; then
  COMMAND="${COMMAND} /s"
fi

if [ "${PROJECT}" = true ]; then
  COMMAND="${COMMAND} /project"
fi

if [ -n "${INCLUDE}" ]; then
  COMMAND="${COMMAND} /include:\"${INCLUDE}\""
fi

eval "${COMMAND}"

# ログファイルの表示
# TODO: フォルダ対象やプロジェクトファイルの場合はログファイルはどういう形式になるのか?
LOG="${TARGET_FILE%.*}.log"

if [ ! -f "${LOG}" ]; then
  echo "Log file '${LOG}' is not found."
  exit 1
fi

cat "${LOG}"

# MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: compiling 'MACDSample.mq5'
# MQL5\Experts\Examples\MACD\MACDSample.mq5(12,1) : error 109: '#propert' - invalid preprocessor command
# MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Object.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Object.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\StdLibErr.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh
# MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh
# MQL5\Experts\Examples\MACD\MACDSample.mq5 : information: including C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh
# MQL5\Experts\Examples\MACD\MACDSample.mq5(12,1) : error 175: '#propert' - expressions are not allowed on a global scope
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh(12,27) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\OrderInfo.mqh(12,27) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh(12,34) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\HistoryOrderInfo.mqh(12,34) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh(12,30) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\PositionInfo.mqh(12,30) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh(12,26) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\DealInfo.mqh(12,26) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh(25,23) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\Trade.mqh(25,23) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh(12,28) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\SymbolInfo.mqh(12,28) : error 239: 'CObject' - syntax error
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh(12,29) : error 116: 'CObject' - declaration without type
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh(12,29) : error 239: 'CObject' - syntax error
# MQL5\Experts\Examples\MACD\MACDSample.mq5(39,22) : error 254: empty class 'CAccountInfo' cannot be used
# C:\Program Files\MetaTrader 5\MQL5\Include\Trade\AccountInfo.mqh : information: info    see declaration of class 'CAccountInfo'
# Result: 17 errors, 0 warnings

# VSCodeのProblemsの仕様を理解して、コンパイルエラーをVSCodeに表示するようにする