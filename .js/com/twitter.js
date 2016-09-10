// go directly to links, bypassing t.co
(function() {
	$("a[data-expanded-url]").each((i, el) => {
		el = $(el);
		el.attr("href", el.attr("data-expanded-url"));
	});
	$("ol.stream-items").each((i, list) => {
		let observer = new MutationObserver((mutations) => {
			mutations.forEach((mutation) => {
				mutation.addedNodes.forEach((it) => {
					$(it).find("a[data-expanded-url]").each((i, el) => {
						el = $(el);
						el.attr("href", el.attr("data-expanded-url"));
					});
				});
			});
		});
		observer.observe(list, { childList: true });
	})
})();