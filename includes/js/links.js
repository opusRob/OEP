
function linkRemove(intLinkId) {	
	if (confirm("Are you sure you want to delete this item?")) {
		try {
			$("#link_id").val(intLinkId);
			$("#links_form").submit();
		} catch(e) {
			$("#link_id").val("");
		}
	}
}
