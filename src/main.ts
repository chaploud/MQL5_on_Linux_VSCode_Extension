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

function Compile() {
  vscode.commands.executeCommand("workbench.action.tasks.build");
}
