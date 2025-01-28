#!/bin/bash

MT5_PATH="${HOME}/.mt5/drive_c/Program Files/MetaTrader 5"
cd "${MT5_PATH}" || exit
# TODO: コンパイルの結果が得られない
env WINEPREFIX="${HOME}/.mt5" wine MetaEditor64.exe /compile:"MQL5/Experts/Examples/MACD/MACD Sample.mq5" /s