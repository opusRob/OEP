/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		param url.page default = 1;

		//dump(var = request.cb_requestContext, expand = false);

		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "news"}, true);
		request.aryPosts = entityLoad("Post", {PostType = request.aryPostType});

		event.setView("news/index");
	}
	function item(event,rc,prc) {
		request.aryPost = entityLoadByPK("Post", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")));
		event.setView("news/item");
	}
	function add(event,rc,prc) {
		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "news"}, true);
		request.aryPost = entityNew("Post");
		event.setView("news/news");
	}
	function edit(event,rc,prc) {
		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "news"}, true);
		request.aryPost = entityLoad("Post", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")), true);
		event.setView("news/news");
	}
	function save(event,rc,prc) {
		if (val(arguments.rc.post_id))
			request.aryPost = entityLoadByPK("Post", val(arguments.rc.post_id));
		else
			request.aryPost = entityNew("Post");

		request.aryPost.setPost_headline_tx(arguments.rc.post_headline_tx);
		request.aryPost.setPost_preview_tx(arguments.rc.post_preview_tx);
		request.aryPost.setPost_body_tx(arguments.rc.post_body_tx);
		request.aryPost.setPostType(entityLoadByPK("PostType", arguments.rc.post_post_type_id));

		if (val(arguments.rc.post_id)) {
			request.aryPost.setUpdatedByUser(entityLoadByPK("User", 1));
			request.aryPost.setPost_update_datetime_dt(now());
		} else {
			request.aryPost.setCreatedByUser(entityLoadByPK("User", 1));
			request.aryPost.setPost_create_datetime_dt(now());
		}

		entitySave(request.aryPost, NOT val(arguments.rc.post_id));
		ormFlush();

		setNextEvent("news.index");

	}
	function remove(event,rc,prc) {
		request.aryPost = entityLoadByPK("Post", val(arguments.rc.post_id));

		entityDelete(request.aryPost);
		ormFlush();

		setNextEvent("news.index");
	}
}
