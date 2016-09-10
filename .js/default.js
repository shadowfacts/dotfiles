function addStyle(style) {
	$("body").after(`<style>${style}</style>`);
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