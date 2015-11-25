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
		event.setView("login/index");
	}
	function no_access(event,rc,prc){
		event.setView("login/no_access");
	}
	function no_such_resource(event,rc,prc){
		event.setView("login/no_such_resource");
	}
	function sign_out(event, rc, prc) {
		event.setView("login/sign_out")
	}

	function securityCheck(required string strHandler, required string strAction) {
		//dump(arguments);
		trace(text = "securityCheck a");
		local.strHandlerAction = arguments.strHandler & "." & arguments.strAction;
		local.objAuthenticationUtilities = createObject("component", "authenticationUtilities");
		local.qryPagesAndRoles = local.objAuthenticationUtilities.getPagesAndRoles(
			strHandler = arguments.strHandler
			, strAction = arguments.strAction
		);

		trace(text = "securityCheck b");
		local.strRolesRequired = "";
		if (local.qryPagesAndRoles.recordCount) {
			if (local.qryPagesAndRoles.requires_standard_user_bt)
				local.strRolesRequired = listAppend(local.strRolesRequired, "standard_user");
			if (local.qryPagesAndRoles.requires_administrator_bt)
				local.strRolesRequired = listAppend(local.strRolesRequired, "administrator");
		}

		trace(text = "securityCheck c");
		if (local.qryPagesAndRoles.recordCount) {
			trace(text = "securityCheck d");
			switch(local.strHandlerAction) {
				case "login.index":
					trace(text = "securityCheck e");
					if (isUserLoggedIn()) {
						trace(text = "securityCheck f");
						setNextEvent("home.index");
					} else {
						trace(text = "securityCheck g");
						//continue to login.index
					}
					break;

				case "login.authenticate":
					trace(text = "securityCheck h");
					//Google auth checks out?
					local.stcHTTPCall = this.verifyGoogleIDToken(cflogin.password);
					local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
					if (NOT structKeyExists(local.stcAuthenticationInfo, "error_description")) {
						trace(text = "securityCheck i");
						//db check
						local.aryUser = entityLoad(
							"User"
							, {
								user_google_username_tx = form.user_google_username_tx
								, user_active_bt = true
							}
							, true
						);
						trace(text = "securityCheck j");
						if (arrayLen(local.aryUser)) {
							trace(text = "securityCheck k");
							//build session
							session.stcUserProperties = this.buildUserPropertiesStructure(
								strIDToken = arguments.rc.id_token
								, strAccessToken = arguments.rc.access_token
								, stcAuthenticationInfo = local.stcAuthenticationInfo
							);
							trace(text = "securityCheck l");
							setNextEvent("home.index");
						} else {
							trace(text = "securityCheck m");
							setNextEvent("login.index");
						}
					} else {
						trace(text = "securityCheck n");
						setNextEvent("login.index");
					}
					break;

				case "login.no_access,login.no_such_resource":
					trace(text = "securityCheck o");
					if (isUserLoggedIn()) {
						trace(text = "securityCheck p");
						//continue to login.no_access / login.no_such_resource
					} else {
						trace(text = "securityCheck q");
						setNextEvent("login.index");
					}
					break;

				case "login.sign_out":
					trace(text = "securityCheck r");
					if (isUserLoggedIn()) {
						trace(text = "securityCheck s");
						this.sign_out();
						setNextEvent("login.index");
					} else {
						trace(text = "securityCheck t");
						setNextEvent("login.index");
					}
					break;

				default:
					trace(text = "securityCheck u");
					if (isUserLoggedIn()) {
						trace(text = "securityCheck v");
						//user's role has access to page?
						if (
							(
								NOT local.qryPagesAndRoles.requires_standard_user_bt
								OR (
									local.qryPagesAndRoles.requires_standard_user_bt
									AND isUserInRole("standard_user")
								)
							) AND (
								NOT local.qryPagesAndRoles.requires_administrator_bt
								OR (
									local.qryPagesAndRoles.requires_administrator_bt
									AND isUserInRole("administrator")
								)
							)
						) {
							trace(text = "securityCheck w");
							//Google auth checks out?
							local.stcHTTPCall = this.verifyGoogleIDToken(cflogin.password);
							local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
							if (NOT structKeyExists(local.stcAuthenticationInfo, "error_description")) {
								trace(text = "securityCheck x");
								//continue to requested page.
							} else {
								trace(text = "securityCheck y");
								this.sign_out();
								setNextEvent("login.index");
							}
						} else {
							trace(text = "securityCheck z");
							setNextEvent("login.no_access");
						}
					} else {
						trace(text = "securityCheck aa");
						setNextEvent("login.index");
					}
					break;
			}
		} else {
			trace(text = "securityCheck ab");
			setNextEvent("login.no_such_resource");
		}
	}

	function verifyGoogleIDToken(strIDToken) {
		local.stcHTTPCall = createObject("component", "authenticationUtilities").makeHTTPCall(
			stcAttributes = {
				url = "https://www.googleapis.com/oauth2/v3/tokeninfo"
				, method = "post"
			}, aryParams = [
				{
					type = "formField"
					, name = "id_token"
					, value = arguments.strIDToken
				}
			]
		);
		return local.stcHTTPCall;
	}

	function buildUserPropertiesStructure(required strIDToken, required strAccessToken, required stcAuthenticationInfo) {
			local.stcAuthenticationInfo = arguments.stcAuthenticationInfo;
			local.stcAuthenticationInfo.id_token = arguments.strIDToken;
			local.stcAuthenticationInfo.access_token = arguments.strAccessToken;
			local.stcAuthenticationInfo.google_username_tx = listFirst(local.stcAuthenticationInfo.email, "@");

			if (local.stcAuthenticationInfo.aud EQ application.stcApplicationCustomSettings.googleClientId) {
				local.aryUser = entityLoad(
					"User"
					, {
						user_google_username_tx = local.stcAuthenticationInfo.google_username_tx
						, user_active_bt = true
					}
				);

				if (arrayLen(local.aryUser)) {
					local.stcUserProperties = {
						stcGoogleUserProperties = local.stcAuthenticationInfo
						, stcOpusEmployeePortalUserProperties = {
							user_id = local.aryUser[1].getUser_id()
							, user_first_name_tx = local.aryUser[1].getUser_first_name_tx()
							, user_middle_name_tx = local.aryUser[1].getUser_middle_name_tx()
							, user_last_name_tx = local.aryUser[1].getUser_last_name_tx()
							, user_google_username_tx = local.aryUser[1].getUser_google_username_tx()
							, user_is_admin_bt = local.aryUser[1].getUser_is_admin_bt()
							, user_active_bt = local.aryUser[1].getUser_active_bt()
							, user_create_datetime_dt = local.aryUser[1].getUser_create_datetime_dt()
							, user_update_datetime_dt = local.aryUser[1].getUser_update_datetime_dt()
							//, user_create_user_id = local.aryUser[1].getUser_create_user_id()
	//						, user_update_user_id = local.aryUser[1].getUser_update_user_id()
						}
					}

					//local.bolUserIsLoggedIn = true;
//					local.bolUserIsAdmin = session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_is_admin_bt;

					return local.stcUserProperties;
					//setNextEvent("home.index");

				} else {
					this.sign_out();
					return structNew();
				}

			}
	}

	function authenticate(event, rc, prc) {

		//if (isUserLoggedIn())
			setNextEvent("home.index");
		//else
//			setNextEvent("login.index");


		/*local.stcHTTPCall = createObject("component", "authenticationUtilities").makeHTTPCall(
			stcAttributes = {
				url = "https://www.googleapis.com/oauth2/v3/tokeninfo"
				, method = "post"
			}, aryParams = [
				{
					type = "formField"
					, name = "id_token"
					, value = arguments.rc.id_token
				}
			]
		);*/
		/*local.stcHTTPCall = this.verifyGoogleIDToken(arguments.rc.id_token);
		local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
		//dump(var = local.stcAuthenticationInfo); abort;

		if (NOT structKeyExists(local.stcAuthenticationInfo, "error_description")) {
			session.stcUserProperties = this.buildUserPropertiesStructure(
				strIDToken = arguments.rc.id_token
				, strAccessToken = arguments.rc.access_token
				, stcAuthenticationInfo = local.stcAuthenticationInfo
			);*/
			/*local.stcAuthenticationInfo.id_token = arguments.rc.id_token;
			local.stcAuthenticationInfo.access_token = arguments.rc.access_token;
			local.stcAuthenticationInfo.google_username_tx = listFirst(local.stcAuthenticationInfo.email, "@");

			if (local.stcAuthenticationInfo.aud EQ application.stcApplicationCustomSettings.googleClientId) {
				local.aryUser = entityLoad(
					"User"
					, {
						user_google_username_tx = local.stcAuthenticationInfo.google_username_tx
						, user_active_bt = true
					}
				);

				if (arrayLen(local.aryUser)) {
					session.stcUserProperties = {
						stcGoogleUserProperties = local.stcAuthenticationInfo
						, stcOpusEmployeePortalUserProperties = {
							user_id = local.aryUser[1].getUser_id()
							, user_first_name_tx = local.aryUser[1].getUser_first_name_tx()
							, user_middle_name_tx = local.aryUser[1].getUser_middle_name_tx()
							, user_last_name_tx = local.aryUser[1].getUser_last_name_tx()
							, user_google_username_tx = local.aryUser[1].getUser_google_username_tx()
							, user_is_admin_bt = local.aryUser[1].getUser_is_admin_bt()
							, user_active_bt = local.aryUser[1].getUser_active_bt()
							, user_create_datetime_dt = local.aryUser[1].getUser_create_datetime_dt()
							, user_update_datetime_dt = local.aryUser[1].getUser_update_datetime_dt()
							//, user_create_user_id = local.aryUser[1].getUser_create_user_id()
	//						, user_update_user_id = local.aryUser[1].getUser_update_user_id()
						}
					}

					session.bolUserIsLoggedIn = true;
					session.bolUserIsAdmin = session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_is_admin_bt;

					return true;
					//setNextEvent("home.index");

				} else {
					this.sign_out();
					return false;
				}

			}*/
		/*} else {
			return false;
			//setNextEvent("login.index");
		}*/

	}

}
