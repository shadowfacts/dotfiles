function addStyle(style) {
	let el = $("style#dotjs-style");
	if (!el.length) {
		$("body").after(`<style id="dotjs-style">${style}</style>`);
	} else {
		$("style#dotjs-style").append(style);
	}
}

function copyToClipBoard(text) {
	let textArea = $("<textarea></textarea>");
	textArea.css("opacity", "0");
	textArea.css("position", "fixed");
	textArea.val(text);
	$("body").append(textArea);

	textArea.select();
	document.execCommand("copy");
	textArea.remove();
}