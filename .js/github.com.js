// utils
let repoUrl = $("div.repohead-details-container > h1.public > strong[itemprop=name] > a").attr("href");
let currentUser = $("ul.header-nav.float-right > li:last > a > img").attr("alt").substring(1);

// don't use the (ugly) new font
// $("body").css("font-family", $("body").css("font-family").replace("BlinkMacSystemFont,", ""));

// releases tab
(function() {
	let repoNav = $("nav.reponav");
	if (repoNav.length > 0) {
		let releasesUrl = repoUrl + "/releases";
		let releasesTab = $("<a></a>");
		releasesTab.attr("href", releasesUrl);
		releasesTab.attr("data-selected-links", releasesUrl);
		releasesTab.addClass("js-selected-navigation-item reponav-item");

		let icon = "<svg aria-hidden=\"true\" class=\"octicon octicon-tag\" height=\"16\" version=\"1.1\" viewBox=\"0 0 14 16\" width=\"14\"><path d=\"M7.73 1.73C7.26 1.26 6.62 1 5.96 1H3.5C2.13 1 1 2.13 1 3.5v2.47c0 .66.27 1.3.73 1.77l6.06 6.06c.39.39 1.02.39 1.41 0l4.59-4.59a.996.996 0 0 0 0-1.41L7.73 1.73zM2.38 7.09c-.31-.3-.47-.7-.47-1.13V3.5c0-.88.72-1.59 1.59-1.59h2.47c.42 0 .83.16 1.13.47l6.14 6.13-4.73 4.73-6.13-6.15zM3.01 3h2v2H3V3h.01z\"></path></svg>";
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

		let pathParts = location.pathname.split("/");
		if (pathParts[pathParts.length - 1] == "releases" || pathParts[pathParts.length - 1] == "tags" || pathParts[pathParts.length - 2] == "releases" || pathParts[pathParts.length - 3] == "releases") {
			$("nav.reponav > span:first > a").removeClass("selected");
			releasesTab.addClass("selected");
		}
	}
})();

// add explore link to menu
(function() {
	if (!location.hostname.startsWith("gist")) {
		let lastItem = $(".header-nav[role=navigation] > .header-nav-item:last");

		if (lastItem.prev().find("a.header-nav-link").text() != "Explore") {
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
})();

// linkify branch references in PRs
(function() {
	$("span.commit-ref").each((i, el) => {
		el = $(el);
		let title = el.attr("title");
		if (title) {
			let bits = title.split(":");
			let repo = bits[0];
			let branch = bits[1];
			let link = $("<a></a>");
			link.attr("href", `https://github.com/${repo}/tree/${branch}`);
			el.wrap(link);
		}
	});
	addStyle("span.commit-ref:hover, span.commit-ref:hover span { text-decoration: underline; }");
})();

// linkify issue/pr references in issue titles
(function() {
	let title = $("span.js-issue-title");
	if (/#(\d+)/.test(title.text())) {
		title.html(title.text().replace(/#(\d+)/, `<a href="${repoUrl}/issues/$1">#$1</a>`));
	}
})();

// add edit button to readme
(function() {
	let readme = $("#readme");
	if (!readme.length) return;

	let name = readme.find("h3:first").text().trim();
	let branch = $(".file-navigation > .select-menu.float-left > button > .js-select-button").text();
	let editUrl = `${repoUrl}/edit/${branch}/${name}`;
	
	let div = $("<div></div>");
	div.attr("id", "readme-edit-link");
	div.css("position", "absolute");
	div.css("top", "10px");
	div.css("right", "10px");
	div.css("opacity", "0.2");
	div.css("transition", "opacity 250ms");

	let a = $("<a></a>");
	a.attr("href", editUrl);

	let svg = "<svg class=\"octicon octicon-pencil\" height=\"16\" version=\"1.1\" viewBox=\"0 0 14 16\" width=\"14\"><path d=\"M0 12v3h3l8-8-3-3L0 12z m3 2H1V12h1v1h1v1z m10.3-9.3l-1.3 1.3-3-3 1.3-1.3c0.39-0.39 1.02-0.39 1.41 0l1.59 1.59c0.39 0.39 0.39 1.02 0 1.41z\"></path></svg>";
	a.append(svg);

	div.append(a);

	readme.append(div);

	addStyle(`
		#readme.blob #readme-edit-link { display: none; }
		#readme-edit-link:hover { opacity: 1 !important; }
		`);
})();

// tab size 4
(function() {
	addStyle(`
		.tab-size[data-tab-size='2'],
		.tab-size[data-tab-size='4'],
		.tab-size[data-tab-size='8'],
		.inline-review-comment,
		.gist table.lines {
			tab-size: 4 !important;
		}
		`);
})();

// add avatars to reactions
(function() {
	$(".comment-reactions.has-reactions").each((i, container) => {
		container = $(container);
		let reactionButtons = container.find(".comment-reactions-options .reaction-summary-item[aria-label]");

		reactionButtons.each((i, button) => {
			button = $(button);

			let participantCount = parseInt(button.html().split("</g-emoji>")[1])
			let participants = button.attr("aria-label")
				.replace(/ reacted with.+/, "")
				.replace(/,? and /, ", ")
				.replace(/, \d+ more/, "")
				.split(", ");

			let userPosition = participants.indexOf(currentUser);
			if (participantCount == 1 && userPosition > -1) {
				return;
			}

			if (button.find("div.participants-container").length == 0) {
				button.append("<div class=\"participants-container\"></div>");
			}

			if (userPosition > -1) {
				participants.splice(userPosition, 1);
			}

			let firstThreeParticipants = participants.slice(0, 3);
			let participantsContainer = button.find(".participants-container");

			participantsContainer.html("");
			participantsContainer.css("display", "inline-block");

			firstThreeParticipants.forEach((it) => {
				let link = $("<a></a>");
				link.attr("href", `https://github.com/${it}`);
				
				let img = $("<img>");
				img.attr("src", `https://github.com/${it}.png`);
				img.css("width", "20px");
				img.css("height", "20px");
				img.css("border-radius", "3px");
				img.css("margin-left", "3px");
				img.css("vertical-align", "middle");
				link.append(img);

				participantsContainer.append(link);
			});
		});
	});
})();

// file copy button
(function() {
	if (!$("[data-line-number='1']").length) {
		return;
	}

	let targetSibling = $("#raw-url")
	let fileUrl = targetSibling.attr("href");

	let copyBtn = $("<a></a>");
	copyBtn.text("Copy");
	copyBtn.attr("href", fileUrl);
	copyBtn.addClass("btn btn-sm copy-btn");

	copyBtn.click((e) => {
		e.preventDefault();
		let fileContents = $(".js-file-line-container").get(0).innerText;
		copyToClipBoard(fileContents);
	});

	targetSibling.after(copyBtn);
})();