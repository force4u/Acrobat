var cResponse = app.response({
		cQuestion: "文字を入力（2文字）",
		cTitle: "スタンプ文字入力",
		cDefault: "依頼",
		bPassword:false,
		cLabel:"文字を2文字まで入力可能です:"
		});
event.value = cResponse;
