// don't use the (ugly) new font
// $("body").css("font-family", $("body").css("font-family").replace("BlinkMacSystemFont,", ""));

// releases tab
let repoNav = $("nav.reponav");
if (repoNav.length > 0) {
	let repoUrl = $("div.repohead-details-container > h1.public > strong[itemprop=name] > a").attr("href");
	let releasesUrl = repoUrl + "/releases";
	let releasesTab = $("<a></a>");
	releasesTab.attr("href", releasesUrl);
	releasesTab.attr("data-selected-links", releasesUrl);
	releasesTab.addClass("js-selected-navigation-item reponav-item");

	let icon = $("<svg aria-hidden=\"true\" class=\"octicon octicon-tag\" height=\"16\" version=\"1.1\" viewBox=\"0 0 14 16\" width=\"14\"><path d=\"M7.73 1.73C7.26 1.26 6.62 1 5.96 1H3.5C2.13 1 1 2.13 1 3.5v2.47c0 .66.27 1.3.73 1.77l6.06 6.06c.39.39 1.02.39 1.41 0l4.59-4.59a.996.996 0 0 0 0-1.41L7.73 1.73zM2.38 7.09c-.31-.3-.47-.7-.47-1.13V3.5c0-.88.72-1.59 1.59-1.59h2.47c.42 0 .83.16 1.13.47l6.14 6.13-4.73 4.73-6.13-6.15zM3.01 3h2v2H3V3h.01z\"></path></svg>");
	releasesTab.append(icon);

	releasesTab.append("      Releases");

	let counter = $("<span></span>");
	counter.text("0");
	counter.addClass("counter");
	releasesTab.append(counter);

	repoNav.append(releasesTab);

	$.ajax({
		url: "https://api.github.com/repos" + repoUrl + "/releases",
		dataType: "text",
		success: (data) => {
			let json = JSON.parse(data);
			counter.text(json.length);
		}
	});

	if (location.pathname.endsWith("/releases")) {
		$("nav.reponav > span:first > a").removeClass("selected");
		releasesTab.addClass("selected");
	}
}

// add explore link to menu
if (!location.hostname.startsWith("gist")) {
	let lastItem = $(".header-nav[role=navigation] > .header-nav-item:last");

	if (lastItem.find("a.header-nav-link").text() != "Explore") {
		let exploreItem = $("<li></li>");
		exploreItem.addClass("header-nav-item");
		let exploreLink = $("<a></a>");
		exploreLink.addClass("header-nav-link");
		exploreLink.attr("href", "/explore");
		exploreLink.text("Explore");
		exploreItem.append(exploreLink);
		lastItem.before(exploreItem);
	}
}

// linkify branch references in PRs
$("span.commit-ref").each((i, el) => {
	el = $(el);
	let bits = el.attr("title").split(":");
	let repo = bits[0];
	let branch = bits[1];
	let link = $("<a></a>");
	link.attr("href", `https://github.com/${repo}/tree/${branch}`);
	el.wrap(link);
});
$("body").after("<style>span.commit-ref:hover, span.commit-ref:hover span { text-decoration: underline; }</style>");