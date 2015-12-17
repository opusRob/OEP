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
	function invalid_user(event,rc,prc){
		event.setView("login/invalid_user");
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
