/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		param url.page default = 1;

		//dump(var = request.cb_requestContext, expand = false);

		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "blog"}, true);
		request.aryPosts = entityLoad("Post", {PostType = request.aryPostType}, "post_update_create_datetime_dt DESC");

		request.cfcUtilities = createObject("component", "includes.cfc.Utilities");

		event.setView("blog/index");
	}
	function item(event,rc,prc) {
		request.aryPost = entityLoadByPK("Post", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")));
		request.strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation;
		request.strImageContent = "";
		event.setView("blog/item");
	}
	function add(event,rc,prc) {
		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "blog"}, true);
		request.aryPost = entityNew("Post");
		request.strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation;
		event.setView("blog/blog");
	}
	function edit(event,rc,prc) {
		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "blog"}, true);
		request.aryPost = entityLoad("Post", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")), true);
		request.strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation;
		event.setView("blog/blog");
	}
	function save(event,rc,prc) {
		if (val(arguments.rc.post_id))
			request.aryPost = entityLoadByPK("Post", val(arguments.rc.post_id));
		else
			request.aryPost = entityNew("Post");

		if (NOT structKeyExists(arguments.rc, "post_image_upload_tx"))
			arguments.rc.post_image_upload_tx = "";

		local.strLargeFileName = createObject("component", "includes.cfc.Utilities").processServerImage(
			strImageFileName = request.aryPost.getPost_large_image_file_name_tx()
			, bolDeleteImage = structKeyExists(arguments.rc, "post_delete_image_bt") AND arguments.rc.post_delete_image_bt
			, strImageUploadFieldName = "post_image_upload_tx"
			, post_image_upload_tx = arguments.rc.post_image_upload_tx
			, strImageType = "blog"
			, strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation
		);
		local.strSmallFileName = createObject("component", "includes.cfc.Utilities").processServerImage(
			strImageFileName = request.aryPost.getPost_small_image_file_name_tx()
			, bolDeleteImage = structKeyExists(arguments.rc, "post_delete_image_bt") AND arguments.rc.post_delete_image_bt
			, strImageUploadFieldName = "post_image_upload_tx"
			, post_image_upload_tx = arguments.rc.post_image_upload_tx
			, strImageType = "blog"
			, strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation
			, stcImageProperties = {
				intWidth = 150
				, intHeight = 150
			}
		);

		request.aryPost.setPost_headline_tx(arguments.rc.post_headline_tx);
		request.aryPost.setPost_body_tx(arguments.rc.post_body_tx);
		request.aryPost.setPost_large_image_file_name_tx(local.strLargeFileName);
		request.aryPost.setPost_small_image_file_name_tx(local.strSmallFileName);
		request.aryPost.setPostType(entityLoadByPK("PostType", arguments.rc.post_post_type_id));

		if (val(arguments.rc.post_id)) {
			request.aryPost.setUpdatedByUser(entityLoadByPK("User", session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_id));
			request.aryPost.setPost_update_datetime_dt(now());
		} else {
			request.aryPost.setCreatedByUser(entityLoadByPK("User", session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_id));
			request.aryPost.setPost_create_datetime_dt(now());
		}

		entitySave(request.aryPost, NOT val(arguments.rc.post_id));
		ormFlush();

		setNextEvent("blog.index");

	}
	function remove(event,rc,prc) {
		request.aryPost = entityLoadByPK("Post", val(arguments.rc.post_id));
		local.strFullLargeFilePath = expandPath(application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx());
		local.strFullSmallFilePath = expandPath(application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation & request.aryPost.getPost_small_image_file_name_tx());

		if (fileExists(local.strFullLargeFilePath))
			fileDelete(local.strFullLargeFilePath);
		if (fileExists(local.strFullSmallFilePath))
			fileDelete(local.strFullSmallFilePath);

		entityDelete(request.aryPost);
		ormFlush();

		setNextEvent("blog.index");
	}
}
