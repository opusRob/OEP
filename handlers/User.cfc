/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		param url.page default = 1;

		request.aryUsers = entityLoad("User");
		//request.intUserCount = arrayLen(request.aryUsers);
		/*request.aryUsers = entityLoad(
			//name = "User"
			//, filterCriteria = {}
			//, sortOrder = {"user_last_name_tx ASC"}
			//, options = {
			"User"
			, {
				offset = (url.page * 10) + 1
				, maxResults = 10
			}
		);*/
		//request.aryUsers = ORMExecuteQuery("* FROM users", false, {offset = (url.page * 10) + 1, maxResults = 10});
		//request.intUserCount = ORMExecuteQuery("COUNT(user_id) FROM users", true);

		event.setView("user/index");
	}
	function add(event,rc,prc) {
		request.aryUser = entityNew("User");
		event.setView("user/user");
	}
	function edit(event,rc,prc) {
		request.aryUser = entityLoad("User", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")), true);
		event.setView("user/user");
	}
	function save(event,rc,prc) {
		if (val(arguments.rc.user_id))
			request.aryUser = entityLoadByPK("User", val(arguments.rc.user_id));
		else
			request.aryUser = entityNew("User");

		request.aryUser.setUser_last_name_tx(arguments.rc.user_last_name_tx);
		request.aryUser.setUser_first_name_tx(arguments.rc.user_first_name_tx);
		request.aryUser.setUser_middle_name_tx(arguments.rc.user_middle_name_tx);
		request.aryUser.setUser_google_username_tx(arguments.rc.user_google_username_tx);
		request.aryUser.setUser_is_admin_bt(structKeyExists(arguments.rc, "user_is_admin_bt") ? arguments.rc.user_is_admin_bt : false);
		request.aryUser.setUser_active_bt(structKeyExists(arguments.rc, "user_active_bt") ? arguments.rc.user_active_bt : false);

		if (val(arguments.rc.user_id)) {
			request.aryUser.setUpdatedByUser(entityLoadByPK("User", 1));
			request.aryUser.setUser_update_datetime_dt(now());
		} else {
			request.aryUser.setCreatedByUser(entityLoadByPK("User", 1));
			request.aryUser.setUser_create_datetime_dt(now());
		}

		entitySave(request.aryUser, NOT val(arguments.rc.user_id));
		ormFlush();

		setNextEvent("user.index");

	}
	function remove(event,rc,prc) {
		request.aryUser = entityLoadByPK("User", val(arguments.rc.user_id));

		//entityDelete(request.aryUser);
		//ORMExecuteQuery("DELETE FROM users WHERE user_id = #val(arguments.rc.user_id)#", true);

		//ormFlush();

		createObject("component", "userUtilities").removeUser(arguments.rc.user_id);

		setNextEvent("user.index");
	}
}
