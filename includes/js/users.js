
function userRemove(intUserId) {	
	if (confirm("Are you sure you want to delete this user?")) {
		try {
			$("#user_id").val(intUserId);
			$("#users_form").submit();
		} catch(e) {
			$("#user_id").val("");
		}
	}
}
