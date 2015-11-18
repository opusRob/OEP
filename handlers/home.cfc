/**
* I am a new handler
*/
component{

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	IMPLICIT FUNCTIONS: Uncomment to use
	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	*/

	function index(event,rc,prc){

		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "news"}, true);
		request.aryNews = entityLoad("Post", {PostType = request.aryPostType}, "post_update_create_datetime_dt DESC", {maxResults = 3});

		request.aryPostType = entityLoad("PostType", {post_type_code_tx = "blog"}, true);
		request.aryBlog = entityLoad("Post", {PostType = request.aryPostType}, "post_update_create_datetime_dt DESC", {maxResults = 3});

		request.aryLinks = entityLoad("Link", {}, "link_update_create_datetime_dt DESC", {maxResults = 20});


		event.setView("home/index");
	}



}
