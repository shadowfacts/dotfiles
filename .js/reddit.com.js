// replace RES expando icons with reddit ones
(function() {
	$("a.expando-button").each((i, el) => {
		el = $(el);
		if (!el.hasClass("selftext") && !el.hasClass("video")) {
			el.addClass("video");
			el.click(() => {
				if (el.hasClass("expanded")) {
					el.addClass("video");
				} else {
					el.addClass("video");
				}
			});
		}
	});
})();
