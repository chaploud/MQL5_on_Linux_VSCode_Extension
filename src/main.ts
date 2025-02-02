"use strict";

import * as vscode from "vscode";
import * as fs from "fs";

// 機能
// コンパイル
// 文法チェック
// コード上にエラーを表示
// 補完
// 定義へジャンプ
// importした関数なども補完
// docstringをホバーで表示
// デバッグ機能はむずかしい(これはMetaEditorおよびMT5側でやってもらうしかない)

function getConfig() {
  const config = vscode.workspace.getConfiguration("mql5-linux");
  return {
    WINEPREFIX: config.get("WINEPREFIX"),
    MT5: config.get("MT5_directory"),
    MetaEditor: config.get("MetaEditor_path"),
    deleteLog: config.get("delete_compile_log"),
  };
}

function Compile() {
  console.log("Compile");
}

Compile();
