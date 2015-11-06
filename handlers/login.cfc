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

	function sign_out (event, rc, prc) {
		structDelete(session, "stcUserProperties");
		session.bolUserIsLoggedIn = false;
		session.bolUserIsAdmin = false;
		setNextEvent("login.index");
	}

	function authenticate(event, rc, prc) {
		local.stcHTTPCall = createObject("component", "authenticationUtilities").makeHTTPCall(
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
		);

		local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
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

				setNextEvent("home.index");

			} else {
				this.sign_out();
			}

		}

	}

}
