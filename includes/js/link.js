// link_https_bt
// link_url_protocol_tx



$(document).ready(
	function() {
		// alert($("#link_https_bt").length)
		$("#link_https_bt").click(
			function() {
				$("#link_url_protocol_tx").html(
					$(this).prop("checked") ? "https://" : "http://"
				);
			}
		);
	}
);
