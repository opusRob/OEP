
function postRemove(intPostId) {	
	if (confirm("Are you sure you want to delete this item?")) {
		try {
			$("#post_id").val(intPostId);
			$("#post_form").submit();
		} catch(e) {
			$("#post_id").val("");
		}
	}
}
