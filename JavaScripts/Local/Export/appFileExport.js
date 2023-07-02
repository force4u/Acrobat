// com.cocolog-nifty.quicktimer.icefloe
////////////////////////////////////////////////

////////////////メニュー実行時のファンクションs
function expptx() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.pptx';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite: true,cConvID:'com.adobe.acrobat.pptx',bCopy:false});
}
function expxlsx() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.xlsx';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite: true,cConvID:'com.adobe.acrobat.xlsx',bCopy:false});
}
function expdocx() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.docx';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite: true,cConvID:'com.adobe.acrobat.docx',bCopy:false});
}
function expdoc() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.doc';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite: true,cConvID:'com.adobe.acrobat.doc',bCopy:false});
}
function exprtf() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.rtf';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite: true,cConvID:'com.adobe.acrobat.rtf',bCopy:false});
}
function expps() {
  var strPath = this.path;
  if (strPath.indexOf("/Acrobat.com/") !== -1) {
    throw new Error("エラー:クラウドドキュメントは書き出しできません");
  }
  var strSavePath = strPath + '.ps';
  this.saveAs({cPath:strSavePath, bPromptToOverwrite:false,cConvID:'com.adobe.acrobat.ps',bCopy:false});
}






////////////////メニュー部
//////////ファイルメニューを宣言
var menuParent = "addExportSubMenu";
/////////////////////////////DCの時はメニューを出す
if (app.viewerType == "Reader") {
app.addMenuItem({
  cName: "expxlsx",
  cUser: "【DC機能】EXLX（Excelに書き出し）",
  cTooltext: "Excelに書き出し",
  cLabel: "Excelに書き出し",
  cParent: menuParent,
  cExec: "expxlsx()",
  cEnable: "event.rc = (false);",
  cMarked: "event.rc = false",
  nPos: 0
});
}
if (app.viewerType == "Exchange-Pro") {
app.addMenuItem({
  cName: "expxlsx",
  cUser: "EXLX（Excelに書き出し）",
  cTooltext: "Excelに書き出し",
  cLabel: "Excelに書き出し",
  cParent: menuParent,
  cExec: "expxlsx()",
  cEnable: "event.rc = (event.target != null);",
  cMarked: "event.rc = false",
  nPos: 0
});
}
if (app.viewerType == "Reader") {
  app.addMenuItem({
    cName: "expptx",
    cUser: "【DC機能】PPTX（PowerPoint）",
    cTooltext: "PowerPointに書き出し",
    cLabel: "PowerPointに書き出し",
    cParent: menuParent,
    cExec: "expptx()",
    cEnable: "event.rc = (false);",
    cMarked: "event.rc = false",
    nPos: 1
  });
}
if (app.viewerType == "Exchange-Pro") {
  app.addMenuItem({
    cName: "expptx",
    cUser: "PPTX（PowerPoint）",
    cTooltext: "PowerPointに書き出し",
    cLabel: "PowerPointに書き出し",
    cParent: menuParent,
    cExec: "expptx()",
    cEnable: "event.rc = (event.target != null);",
    cMarked: "event.rc = false",
    nPos: 1
  });
}

  app.addMenuItem({
    cName: "expdocx",
    cUser: "Word(docx)",
    cTooltext: "Wordに書き出し",
    cLabel: "Wordに書き出し",
    cParent: menuParent,
    cExec: "expdocx()",
    cEnable: "event.rc = (event.target != null);",
    cMarked: "event.rc = false",
    nPos: 2
  });
