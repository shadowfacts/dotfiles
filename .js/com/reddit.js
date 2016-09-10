// replace RES expando icons with reddit ones
(function() {
	function fixExpandos() {
		$("a.expando-button").each((i, el) => {
			el = $(el);
			if (!el.hasClass("selftext") && !el.hasClass("video")) {
				el.removeClass("image");
				el.removeClass("gallery");
				el.addClass("video");
				el.click(() => {
					el.removeClass("image");
					el.removeClass("gallery");
					el.addClass("video");
				});
			}
		});
	}
	setTimeout(fixExpandos, 50);
})();
