////////////////////////////////////////////////
//
//
//
//
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
	cExec: "app.launchURL(\"https://documentcloud.adobe.com/\", true);",
	nPos: 3
});
app.addMenuItem({
	cName: "OpenURL4",
	cUser: "■Creative Cloud Assets File",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/files\", true);",
	nPos: 4
});
app.addMenuItem({
	cName: "OpenURL5",
	cUser: "■Creative Cloud Assets Libraries",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/libraries\", true);",
	nPos: 5
});
app.addMenuItem({
	cName: "OpenURL6",
	cUser: "■Creative Cloud Assets XD",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://assets.adobe.com/cloud-documents\", true);",
	nPos: 6
});
app.addMenuItem({
	cName: "OpenURL7",
	cUser: "■Publish Online",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://indd.adobe.com/dashboard\", true);",
	nPos: 7
});
app.addMenuItem({
	cName: "OpenURL8",
	cUser: "■Adobe Lightroom Online",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://lightroom.adobe.com/libraries/\", true);",
	nPos: 8
});
app.addMenuItem({
	cName: "OpenURL9",
	cUser: "■Adobe Fonts",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://fonts.adobe.com/?locale=ja-JP\", true);",
	nPos: 9
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
	nPos: 10,
});
app.addMenuItem({
	cName: "OpenURL16",
	cUser: "■Acrobatフォーラム",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://community.adobe.com/t5/acrobat%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0/ct-p/ct-acrobat-jp\", true);",
	nPos: 11
});
app.addMenuItem({
	cName: "OpenURL17",
	cUser: "■Acrobat Readerフォーラム",
	cParent: "addHelpSubMenuAdobe",
	cExec: "app.launchURL(\"https://community.adobe.com/t5/acrobat-reader-acrobat-dc-for-mobile%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0/ct-p/ct-acrobat-reader-and-reader-mobile-jp?page=1&sort=latest_replies&lang=all&tabid=all&profile.language=ja#:~:text=Acrobat%20Reader%20/%20Acrobat%20DC%20for%20Mobile%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A9%E3%83%A0\", true);",
	nPos: 12
});



////////////////////////////////////////////
app.addMenuItem({
	cName: "OpenURL1",
	cUser: "リリースノート",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://www.adobe.com/devnet-docs/acrobatetk/tools/ReleaseNotesDC/index.html\", true);",
	nPos: 1
});
app.addMenuItem({
	cName: "OpenURL2",
	cUser: "Acrobat DC SDK Documentation",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://opensource.adobe.com/dc-acrobat-sdk-docs/acrobatsdk/\", true);",
	nPos: 2
});
app.addMenuItem({
	cName: "OpenURL10",
	cUser: "JavaScript API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://opensource.adobe.com/dc-acrobat-sdk-docs/library/jsapiref/JS_API_AcroJS.html\", true);",
	nPos: 10
});
app.addMenuItem({
	cName: "OpenURL11",
	cUser: "Document Services API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://documentcloud.adobe.com/dc-integration-creation-app-cdn/main.html\", true);",
	nPos: 11
});
app.addMenuItem({
	cName: "OpenURL12",
	cUser: "PDF Embed API",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://developer.adobe.com/document-services/docs/overview/pdf-embed-api/\", true);",
	nPos: 12
});
app.addMenuItem({
	cName: "OpenURL14",
	cUser: "AdminConsole",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://adminconsole.adobe.com/\", true);",
	nPos: 14
});
app.addMenuItem({
	cName: "appHelpOpenTrustedMenu",
	cUser: "API Referenceを開く",
	cLabel: "appHelpOpenTrustedMenu",
	cTooltext: "appHelpOpenTrustedMenu",
	cParent: "addHelpSubMenuUrl",
	cExec: "appHelpOpenTrustedMenu();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 13,
});
app.addMenuItem({
	cName: "OpenURL15",
	cUser: "Adobe Dev SDK",
	cParent: "addHelpSubMenuUrl",
	cExec: "app.launchURL(\"https://developer.adobe.com/console/servicesandapis\", true);",
	nPos: 14
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
		var strUserJavascriptDir = app.getPath("user","javascript");
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
	nPos: 23
});

function appGetStampsPath() {
	try {
		var strUserStampstDir = app.getPath("user","stamps");
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
	nPos: 1
});
app.addMenuItem({
	cName: "SharedURL2",
	cUser: "Creative Cloud Assets File",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://assets.adobe.com/files\", true);",
	nPos: 2
});
app.addMenuItem({
	cName: "SharedURL3",
	cUser: "Box",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://app.box.com/\", true);",
	nPos: 3
});
app.addMenuItem({
	cName: "SharedURL4",
	cUser: "DropBox",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://www.dropbox.com/home\", true);",
	nPos: 4
});
app.addMenuItem({
	cName: "OpenURL5",
	cUser: "GoogleDrive",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://drive.google.com/\", true);",
	nPos: 5
});
app.addMenuItem({
	cName: "OpenURL6",
	cUser: "OneDrive",
	cParent: "addHelpSubMenuSh",
	cExec: "app.launchURL(\"https://onedrive.live.com/\", true);",
	nPos: 6
});
////////////////////////////////////////////////////////////////////////
app.addMenuItem({
	cName: "appHelpSubPrintMenuList",
	cUser: "メニューリスト出力",
	cTooltext: "メニューリスト出力",
	cLabel: "メニューリスト出力",
	cParent: "addHelpSubMenuCon",
	cExec: "appHelpMenuList();",
	cEnable: "event.rc = true",
	cMarked: "event.rc = false",
	nPos: 2
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
	nPos: 1
});
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
			cDefault: "https://opensource.adobe.com/dc-acrobat-sdk-docs/acrobatsdk/pdfs/acrobatsdk_jsdevguide.pdf#2",
			bPassword:false,
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
	////app.execMenuItem("CommentApp");
	function FancyMenuList(m, nLevel) {
		var s = "";
		for (var i = 0; i < nLevel; i++) s += " ";
		console.println(s + "+-" + m.cName);
		if (m.oChildren != null)
			for (var i = 0; i < m.oChildren.length; i++)
				FancyMenuList(m.oChildren[i], nLevel + 1);
	}
	var m = app.listMenuItems();
	for (var i = 0; i < m.length; i++) FancyMenuList(m[i], 0);
	console.println("##############\n")
	var menuItems = app.listMenuItems()
	for (var i in menuItems)
		console.println(menuItems[i] + "\n")
	console.println("##############\n")
	var botItem = app.listToolbarButtons()
	for (var i in botItem)
		console.println(botItem[i] + "\n")
	console.println("\n##############\n" + botItem)
}

