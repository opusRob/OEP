$(document).ready(
	function() {
		$("#post_body_tx").on(
			"input change keyup paste"
			, function() {
				$("#post_body_char_length").html($("#post_body_tx").val().length);
			}
		);
	}
);
