////////////////////////////////////////////////
//	Acrobat Help Menu
//
// 保存する時は文字コードをUTF-16で保存してください
// macOSの場合は改行はLF UNIX
// Windowsの場合は改行はCRLF win を指定してください
// インストール先は
//  macOSの場合は
//  /Users/ユーザー名/Library/Application Support/Adobe/Acrobat/DC/JavaScripts
// Windowsの場合は
// 改行をCRLFにした上で
//  32bit Windowsの場合
//  C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Javascripts
//  64bit Windowsの場合
//  C:\Program Files\Adobe\Acrobat DC\Acrobat\Javascripts
//  20240913v4   回転チェックとバージョンチェックを追加
//  20240915v4.1 Readerでエラーにならないように修正
//  20241117 ビューステートにエラー制御を入れた
//   com.cocolog-nifty.quicktimer.icefloe
////////////////////////////////////////////////
menuParent = "Help";
////////////////////////////////////////////////
app.addSubMenu({
	cName: "addHelpSubMenuAdobe",
	cUser: "▼Adobe関連",
	cTooltext: "Adobe関連",
	cParent: menuParent,
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 5
});
app.addSubMenu({
	cName: "addHelpSubMenuUrl",
	cUser: "▼開発関連",
	cTooltext: "ヘルプ関連",
	cParent: menuParent,
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 6
});
app.addSubMenu({
	cName: "addHelpSubMenuCon",
	cUser: "▼コンソール",
	cTooltext: "コンソール関連",
	cParent: menuParent,
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 7
});
app.addSubMenu({
	cName: "addHelpSubMenuSh",
	cUser: "▼ファイル共有",
	cTooltext: "ファイル共有",
	cParent: menuParent,
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 8
});
app.addSubMenu({
	cName: "addHelpSubMenuOpen",
	cUser: "▼設定",
	cTooltext: "設定関連",
	cParent: menuParent,
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 9
});
////////////////////////////////////////////////
app.addMenuItem({
	cName: "OpenURL3",
	cUser: "■Document Cloud",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://acrobat.adobe.com/link/documents/files/\", true);",
	nPos: 53
});
app.addMenuItem({
	cName: "OpenURL4",
	cUser: "■Creative Cloud Assets File",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/files\", true);",
	nPos: 54
});
app.addMenuItem({
	cName: "OpenURL5",
	cUser: "■Creative Cloud Assets Libraries",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/libraries\", true);",
	nPos: 55
});
app.addMenuItem({
	cName: "OpenURL6",
	cUser: "■Creative Cloud Assets XD",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/cloud-documents\", true);",
	nPos: 56
});
app.addMenuItem({
	cName: "OpenURL7",
	cUser: "■Publish Online",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://indd.adobe.com/dashboard\", true);",
	nPos: 57
});
app.addMenuItem({
	cName: "OpenURL8",
	cUser: "■Adobe Lightroom Online",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://lightroom.adobe.com/libraries/\", true);",
	nPos: 58
});
app.addMenuItem({
	cName: "OpenURL9",
	cUser: "■Adobe Fonts",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://fonts.adobe.com/?locale=ja-JP\", true);",
	nPos: 59
});
app.addMenuItem({
	cName: "appHelpOpenDocHelpUserGuide",
	cUser: "■ユーザーガイドを開きます",
	cLabel: "appHelpOpenGuide",
	cTooltext: "appHelpOpenGuide",
	cParent: "addHelpSubMenuAdobe",
	cExec: "appHelpOpenGuide();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 52,
});
app.addMenuItem({
	cName: "OpenURL16",
	cUser: "■Acrobatフォーラム",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://community.adobe.com/t5/acrobat%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0/ct-p/ct-acrobat-jp\", true);",
	nPos: 51
});
app.addMenuItem({
	cName: "OpenURL17",
	cUser: "■Acrobat Readerフォーラム",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://community.adobe.com/t5/acrobat-reader-acrobat-dc-for-mobile%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0/ct-p/ct-acrobat-reader-and-reader-mobile-jp?page=1&sort=latest_replies&lang=all&tabid=all&profile.language=ja#:~:text=Acrobat%20Reader%20/%20Acrobat%20DC%20for%20Mobile%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0\", true);",
	nPos: 50
});
////////////////////////////////////////////
app.addMenuItem({
	cName: "OpenURL1",
	cUser: "リリースノート",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://www.adobe.com/devnet-docs/acrobatetk/tools/ReleaseNotesDC/index.html\", true);",
	nPos: 69
});
app.addMenuItem({
	cName: "OpenURL2",
	cUser: "Acrobat DC SDK Documentation",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://opensource.adobe.com/dc-acrobat-sdk-docs/acrobatsdk/\", true);",
	nPos: 68
});
app.addMenuItem({
	cName: "OpenURL10",
	cUser: "JavaScript API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://opensource.adobe.com/dc-acrobat-sdk-docs/library/jsapiref/JS_API_AcroJS.html\", true);",
	nPos: 67
});
app.addMenuItem({
	cName: "OpenURL11",
	cUser: "Document Services API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://documentcloud.adobe.com/dc-integration-creation-app-cdn/main.html\", true);",
	nPos: 66
});
app.addMenuItem({
	cName: "OpenURL12",
	cUser: "PDF Embed API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://developer.adobe.com/document-services/docs/overview/pdf-embed-api/\", true);",
	nPos: 65
});
app.addMenuItem({
	cName: "OpenURL13",
	cUser: "AdminConsole",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://adminconsole.adobe.com/\", true);",
	nPos: 64
});
app.addMenuItem({
	cName: "appHelpOpenTrustedMenu",
	cUser: "API ReferencePDFを開く",
	cLabel: "appHelpOpenTrustedMenu",
	cTooltext: "appHelpOpenTrustedMenu",
	cParent: "addHelpSubMenuUrl",
	cExec: "appHelpOpenTrustedMenu();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 63
});
app.addMenuItem({
	cName: "OpenURL15",
	cUser: "Adobe Dev SDK",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://developer.adobe.com/console/servicesandapis\", true);",
	nPos: 62
});

app.addMenuItem({
	cName: "OpenURL18",
	cUser: "PrefRef Mac",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Macintosh/index.html\", true);",
	nPos: 61
});

app.addMenuItem({
	cName: "OpenURL19",
	cUser: "PrefRef Win",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Windows/index.html\", true);",
	nPos: 60
});


////////////////////////////////////////////////////////////////////////
app.addMenuItem({
	cName: "appHelpSubPrefOpen",
	cUser: "環境設定パネルを開きます",
	cLabel: "環境設定パネルを開きます",
	cTooltext: "環境設定パネルを開きます",
	cParent: "addHelpSubMenuOpen",
	cExec: "appHelpAddPrintList();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 22,
});
app.addMenuItem({
	cName: "OpenURL23",
	cUser: "JavaScripts フォルダを開きます",
	cParent: "addHelpSubMenuOpen",
	cExec: "appGetJavascriptPath()",
	nPos: 23
});
function appGetJavascriptPath() {
	try {
		var strUserJavascriptDir = app.getPath("user", "javascript");
		var strFilePath = strUserJavascriptDir.replace(/^.*Users/, '/Users');
		app.launchURL("file://" + strFilePath + "", true);
	} catch (error) {
		console.println("メニュー実行エラー（undefined）")
		return;
	}
}
app.addMenuItem({
	cName: "OpenURL24",
	cUser: "Stamps フォルダを開きます",
	cParent: "addHelpSubMenuOpen",
	cExec: "appGetStampsPath()",
	nPos: 24
});
function appGetStampsPath() {
	try {
		var strUserStampstDir = app.getPath("user", "stamps");
		var strFilePath = strUserStampstDir.replace(/^.*Users/, '/Users');
		app.launchURL("file://" + strFilePath + "", true);
	} catch (error) {
		console.println("メニュー実行エラー（undefined）")
		return;
	}
}

app.addMenuItem({
	cName: "appHelpOpenGeneralInfo",
	cUser: "文書のプロパティを開きます",
	cLabel: "appHelpOpenGeneralInfo",
	cTooltext: "appHelpOpenGeneralInfo",
	cParent: "addHelpSubMenuOpen",
	cExec: "appHelpOpenGeneralInfo();",
	cEnable: "event.rc = (event.target != null);",
	cMarked: "event.rc = false",
	nPos: 25,
});
////////////////////////////////////////////////////////////////////////
app.addMenuItem({
	cName: "SharedURL1",
	cUser: "Document Cloud",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://documentcloud.adobe.com/\", true);",
	nPos: 81
});
app.addMenuItem({
	cName: "SharedURL2",
	cUser: "Creative Cloud Assets File",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://assets.adobe.com/files\", true);",
	nPos: 82
});
app.addMenuItem({
	cName: "SharedURL3",
	cUser: "Box",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://app.box.com/\", true);",
	nPos: 83
});
app.addMenuItem({
	cName: "SharedURL4",
	cUser: "DropBox",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://www.dropbox.com/home\", true);",
	nPos: 84
});
app.addMenuItem({
	cName: "SharedURL5",
	cUser: "GoogleDrive",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://drive.google.com/\", true);",
	nPos: 85
});
app.addMenuItem({
	cName: "SharedURL6",
	cUser: "OneDrive",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://onedrive.live.com/\", true);",
	nPos: 86
});
////////////////////////////////////////////////////////////////////////
//
app.addMenuItem({
	cName: "appviewState",
	cUser: "viewState",
	cLabel: "viewState",
	cTooltext: "viewState",
	cParent: "addHelpSubMenuCon",
	cExec: "doViewStatePrint()",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 75
});



app.addMenuItem({
	cName: "appRotationCheckMenu",
	cUser: "PDFページの回転チェック",
	cLabel: "PDFページの回転チェック",
	cTooltext: "PDFページの回転チェック",
	cParent: "addHelpSubMenuCon",
	cExec: "doRotationChk();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 74
});
app.addMenuItem({
	cName: "appVersionCheckMenu",
	cUser: "バージョンチェック",
	cLabel: "バージョンチェック",
	cTooltext: "バージョンチェック",
	cParent: "addHelpSubMenuCon",
	cExec: "doChkVersionChk();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 73
});
app.addMenuItem({
	cName: "appHelpSubPrintMenuList",
	cUser: "メニューリスト出力",
	cTooltext: "メニューリスト出力",
	cLabel: "メニューリスト出力",
	cParent: "addHelpSubMenuCon",
	cExec: "appHelpMenuList();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 72
});
//
app.addMenuItem({
	cName: "AppOpenConsole",
	cUser: "デバッガーを開く",
	cLabel: "デバッガーを開く",
	cTooltext: "デバッガーを開く",
	cParent: "addHelpSubMenuCon",
	cExec: "console.show();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 71
});
////////////////
function doRotationChk() {
	console.show();
	console.println("\n");
	var numAllPage = this.numPages;
	var strOutPut = "";
	for (var nPage = 0; nPage < numAllPage; nPage++) {
		var numPageRotation = this.getPageRotation(nPage);
		var numPrintPageNo = (nPage + 1);
		var strPrintPageNo = numPrintPageNo.toString();
		var strLeadingZero = "000" + strPrintPageNo;
		var strSetPage = strLeadingZero.slice(-4);
		if (numPageRotation == 0) {
			var strOutPut = strOutPut + ("ページ番号: " + strSetPage + "\t回転:   " + numPageRotation + "\t天地／上下\n");
		}
		else if (numPageRotation == 90) {
			var strOutPut = strOutPut + ("ページ番号: " + strSetPage + "\t回転:  " + numPageRotation + "\t天地／右左\n");
		}
		else if (numPageRotation == 180) {
			var strOutPut = strOutPut + ("ページ番号: " + strSetPage + "\t回転: " + numPageRotation + "\t天地／下上\n");
		}
		else if (numPageRotation == 270) {
			var strOutPut = strOutPut + ("ページ番号: " + strSetPage + "\t回転: " + numPageRotation + "\t天地／左右\n");
		}
		else {
			var strOutPut = strOutPut + ("エラーPDFのページ回転構造に問題があります\n");
			var strOutPut = strOutPut + ("ページ番号: " + strSetPage + "\t回転: " + numPageRotation + "\n");
		}
	}
	var rectCropBox = this.getPageBox("Crop", 0);
	var CropBoxSizeHeight = rectCropBox[1] - rectCropBox[0] - 36;
	var CropBoxSizeWidth = rectCropBox[2] - rectCropBox[3] - 36;
	console.println(strOutPut);
	this.addAnnot({ page: 0, type: "Text", print: false, point: [CropBoxSizeWidth, CropBoxSizeHeight], name: "PDFページの回転チェック", author: "PDFページの回転チェック", subject: "PDFページの回転チェック", contents: strOutPut, noteIcon: "Help" });
	if (app.viewerType == "Exchange-Pro") {
	var strFilePath = this.path;
	var docReport = new Report();
	var strVerString = "Adobe\xAE Acrobat\xAE PDFページの回転チェック\n";
	docReport.writeText(strVerString);
	docReport.writeText(strFilePath);
	docReport.divide();
	docReport.writeText(strOutPut);
	docReport.divide();
	docReport.open("PDFページの回転チェック");
	}
}

////////////////
function doChkVersionChk() {
	console.show();
	console.clear();
	console.println("");

	var strVersionText = "Adobe\xAE Acrobat\xAE " + app.viewerVersion + " " + app.viewerType + "\n";
	strVersionText += "Variation: " + app.viewerVariation + "\n";
	strVersionText += "Type: " + app.viewerType + "\n";
	strVersionText += "Platform: " + app.platform + "\n";
	strVersionText += "Language: " + app.language + "\n";
	strVersionText += "PlugIns: " + app.numPlugIns + "\n";
	var numCntPr = app.printerNames.length;
	for (var i = 0; i < numCntPr; i++) {
		strVersionText += "Printer: " + app.printerNames[i] + "\n";
	}
	console.println(strVersionText);
	if (app.viewerType == "Exchange-Pro") {
	var docReport = new Report();
	var strVerString = "Adobe\xAE Acrobat\xAE " + app.viewerVersion + " " + app.viewerType + "\n";
	docReport.writeText(strVerString);
	docReport.writeText("Variation: " + app.viewerVariation);
	docReport.divide();
	docReport.writeText(strVersionText);
	docReport.divide();
	try {
		var strSetValue = identity.name;
	} catch (e) {
		var strSetValue = "Not configured";
	}
	docReport.writeText("Name: " + strSetValue);
	try {
		var strSetValue = identity.loginName;
	} catch (e) {
		var strSetValue = "Not configured";
	}
	docReport.writeText("LoginName: " + strSetValue);
	try {
		var strSetValue = identity.email;
	} catch (e) {
		var strSetValue = "Not configured";
	}
	docReport.writeText("eMail: " + strSetValue);
	try {
		var strSetValue = identity.corporation;
	} catch (e) {
		var strSetValue = "Not configured";
	}
	docReport.writeText("Corporation: " + strSetValue);
	docReport.open("バージョンレポート");
	}
};
////////////////////////////////////////////////////////////////////////
appTrustedMenu = app.trustedFunction(
	function (argMenuName) {
		app.beginPriv();
		app.execMenuItem(argMenuName);
		app.endPriv();
	}
);
function appHelpOpenTrustedMenu() {
	try {
		var cResponse = app.response({
			cQuestion: "開きたいPDFのURLを入力",
			cTitle: "よろしければOKしてください",
			cDefault: "https://quicktimer.cocolog-nifty.com/icefloe/files/acrobatsdk_jsdevguide.pdf",
			bPassword: false,
			cLabel: "Response:"
		});
		if (cResponse == null) {
			console.println("メニュー実行エラー（null）");
			return;
		} else if (cResponse == "undefined") {
			console.println("メニュー実行エラー（undefined）")
			return;
		} else if (cResponse == "null") {
			console.println("メニュー実行エラー（null text）")
			return;
		}
		else
			var myURL = encodeURI(cResponse);
		app.openDoc({ cPath: myURL, cFS: "CHTTP" });
	} catch (error) {
		console.println("メニュー実行エラー");
	}
}
/////////////////////////////////////////////////
function appHelpOpenGeneralInfo() {
	try {
		app.execMenuItem('GeneralInfo');
	} catch (error) {
		console.println("メニュー実行エラー");
	}
}
function appHelpOpenGuide() {
	try {
		app.execMenuItem('DocHelpUserGuide');
	} catch (error) {
		app.launchURL("https://helpx.adobe.com/jp/acrobat/user-guide.html");
	}
}
function appInfoMesAlert() {
	app.alert({
		//メッセージ本文
		//cMsg: "ユーザー情報を設定してください",
		cMsg: "ユーザー情報を\n\n設定してください",
		//ダイアログのタイトル
		cTitle: "ユーザー情報の入力",
		//アイコンの種類　0〜3
		nIcon: 3,
		//ボタングループの種類　0〜3
		nType: 0
	});
}
function appHelpAddPrintList() {
	appInfoMesAlert();
	//	app.execMenuItem('GeneralPrefs');
	app.execMenuItem('GeneralPrefs');
}
////////////////////////////////////////////////////////////////
function appHelpMenuList() {
	console.show();
	if (app.viewerType == "Exchange-Pro") {
	var docReport = new Report();
	}
	////app.execMenuItem("CommentApp");
	function FancyMenuList(m, nLevel) {
		var s = "";
		for (var i = 0; i < nLevel; i++) s += " ";
		console.println(s + "+-" + m.cName);
		if (app.viewerType == "Exchange-Pro") {
		docReport.writeText(s + "+-" + m.cName);
		}
		if (m.oChildren != null)
			for (var i = 0; i < m.oChildren.length; i++)
				FancyMenuList(m.oChildren[i], nLevel + 1);
	}
	var m = app.listMenuItems();
	for (var i = 0; i < m.length; i++) FancyMenuList(m[i], 0);
	console.println("##############\n");
	if (app.viewerType == "Exchange-Pro") {
	docReport.divide();
	}
	var menuItems = app.listMenuItems();
	for (var i in menuItems)
		console.println(menuItems[i] + "\n");
	if (app.viewerType == "Exchange-Pro") {
	docReport.writeText(menuItems[i] + "\n");
	}
	console.println("##############\n")
	if (app.viewerType == "Exchange-Pro") {
	docReport.divide();
	}
	var botItem = app.listToolbarButtons();
	for (var i in botItem)
		console.println(botItem[i] + "\n");
	if (app.viewerType == "Exchange-Pro") {
	docReport.writeText(botItem[i] + "\n");
	}
	console.println("\n##############\n" + botItem);
	if (app.viewerType == "Exchange-Pro") {
	docReport.divide();
	docReport.open("メニュー項目一覧");
	}
/*
console.println("");
console.println("");
var listMenuArray = app.listMenuItems();
for (var numCntNo in listMenuArray) {
console.println(listMenuArray[numCntNo] + "\n");
}
*/

}

function doViewStatePrint() {
	var objActiveDocs = app.activeDocs;
	var numCntDoc = objActiveDocs.length;
	if (numCntDoc === 0) {
		console.clear();
		console.show();
		console.println("ドキュメントを開いてから実行してください");
		return;
	}
	var objActiveDoc = objActiveDocs[0];
	console.clear();
	console.show();
	var viewStateDictStr = objActiveDoc.viewState.toSource();
	var viewStateDict = eval(viewStateDictStr);
	for (var itemkey in viewStateDict) {
		if (viewStateDict.hasOwnProperty(itemkey)) {
			console.println(itemkey + ": " + viewStateDict[itemkey]);
		}
	}
}
