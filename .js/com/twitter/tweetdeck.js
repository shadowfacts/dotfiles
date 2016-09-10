// go directly to links, bypassing t.co
(function() {
	$("a[data-full-url]").each((i, el) => {
		el = $(el);
		el.attr("href", el.attr("data-full-url"));
	});

	$(".js-chirp-container").each((i, container) => {
		let observer = new MutationObserver((mutations) => {
			mutations.forEach((mutation) => {
				mutation.addedNodes.forEach((it) => {
					$(it).find("a[data-full-url]").each((i, el) => {
						el = $(el);
						el.attr("href", el.attr("data-full-url"));
					});
				});
			});
		});
		observer.observe(container, { childList: true });
	});
})();