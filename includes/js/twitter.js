
$(document).ready(
	function() {
		twttr.widgets.createTimeline(
			global.twitterTimelineID,
			document.getElementById("twitter_div"),
			{
				height: 400,
				chrome: "noheader nofooter noborders noscrollbar",
				tweetLimit: 3
			}
		);
	}
);

twttr.events.bind(
	'rendered',
	function (event) {
		$("div#twitter_div iframe#" + event.target.id).contents().find("ol.h-feed:first").children("li.h-entry").each(
			function(i) {
				if (i > 0)
					$(this).css("border-top", "solid 1px #eee");
			}
		);
	}
);