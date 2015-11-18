component{

	function preProcess(event, struct interceptData, buffer) {
		//dump(var = arguments, label = "login.cfc preProcess arguments");
		//this.fileTrace(strText = "redsox");
		//if (event.getCurrentHandler() & "." & event.getCurrentAction() NEQ "news.index")
//			setNextEvent("news.index");

		this.securityCheck(event.getCurrentHandler(), event.getCurrentAction());

	}

	function verifyGoogleIDToken(strIDToken) {
		local.stcHTTPCall = createObject("component", "handlers.authenticationUtilities").makeHTTPCall(
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
						//, user_update_user_id = local.aryUser[1].getUser_update_user_id()
					}
				}

				//local.bolUserIsLoggedIn = true;
				//local.bolUserIsAdmin = session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_is_admin_bt;

				return local.stcUserProperties;
				//setNextEvent("home.index");

			} else {
				this.sign_out();
				return structNew();
			}

		}
	}

	function sign_out () {
		createObject("component", "handlers.authenticationUtilities").logout();
		structClear(session);
		//structDelete(session, "stcUserProperties");
		//session.bolUserIsLoggedIn = false;
//		session.bolUserIsAdmin = false;
		/*if (len(trim(arguments.nextEvent)))
			setNextEvent(arguments.nextEvent);
		else
			setNextEvent("login.index");*/
	}

	function securityCheck(required string strHandler, required string strAction) {
		//dump(arguments);
		this.fileTrace(strText = "------------------------------------------------------------------------------------------------------------");
		this.fileTrace(strText = "securityCheck: strHandler=#arguments.strHandler#; strAction=#arguments.strAction#");
		this.fileTrace(strText = "securityCheck a");

		local.strHandlerAction = arguments.strHandler & "." & arguments.strAction;
		this.fileTrace(strText = "securityCheck: local.strHandlerAction=#local.strHandlerAction#");
		local.objAuthenticationUtilities = createObject("component", "handlers.authenticationUtilities");
		local.qryPagesAndRoles = local.objAuthenticationUtilities.getPagesAndRoles(
			strHandler = arguments.strHandler
			, strAction = arguments.strAction
		);
		/*dump(var = local.qryPagesAndRoles, label = "local.qryPagesAndRoles");
		abort;*/

		this.fileTrace(strText = "securityCheck b");
		local.strRolesRequired = "";
		if (local.qryPagesAndRoles.recordCount) {
			if (local.qryPagesAndRoles.requires_standard_user_bt)
				local.strRolesRequired = listAppend(local.strRolesRequired, "standard_user");
			if (local.qryPagesAndRoles.requires_administrator_bt)
				local.strRolesRequired = listAppend(local.strRolesRequired, "administrator");
		}

		this.fileTrace(strText = "securityCheck c");
		if (local.qryPagesAndRoles.recordCount) {
			this.fileTrace(strText = "securityCheck d");
			switch(local.strHandlerAction) {
				case "login.index":
					this.fileTrace(strText = "securityCheck e");
					if (isUserLoggedIn()) {
						this.fileTrace(strText = "securityCheck f");
						setNextEvent("home.index");
					} else {
						this.fileTrace(strText = "securityCheck g");
						//continue to login.index
					}
					break;

				case "login.authenticate":
					this.fileTrace(strText = "securityCheck h");
					//Google auth checks out?
					local.stcHTTPCall = this.verifyGoogleIDToken(form.id_token);
					local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
					if (NOT structKeyExists(local.stcAuthenticationInfo, "error_description")) {
						this.fileTrace(strText = "securityCheck i");
						//db check
						local.aryUser = entityLoad(
							"User"
							, {
								user_google_username_tx = form.user_google_username_tx
								, user_active_bt = true
							}
						);
						if (arrayLen(local.aryUser) GT 1)
							throw("More than one user was found.");
						this.fileTrace(strText = "securityCheck j");

						if (arrayLen(local.aryUser)) {
							this.fileTrace(strText = "securityCheck k");
							//log in
							local.objAuthenticationUtilities.login(
								stcLoginAttributes = {}
								, stcLoginUserAttributes = {
									name = form.user_google_username_tx
									, password = form.id_token
									, roles = "standard_user" & (local.aryUser[1].getUser_is_admin_bt() ? ",administrator" : "")
								}
							);
							//build session
							session.stcUserProperties = this.buildUserPropertiesStructure(
								strIDToken = form.id_token
								, strAccessToken = form.access_token
								, stcAuthenticationInfo = local.stcAuthenticationInfo
							);
							this.fileTrace(strText = "securityCheck l");
							setNextEvent("home.index");
						} else {
							this.fileTrace(strText = "securityCheck m");
							setNextEvent("login.index");
						}
					} else {
						this.fileTrace(strText = "securityCheck n");
						setNextEvent("login.index");
					}
					break;

				case "login.no_access,login.no_such_resource":
					this.fileTrace(strText = "securityCheck o");
					if (isUserLoggedIn()) {
						this.fileTrace(strText = "securityCheck p");
						//continue to login.no_access / login.no_such_resource
					} else {
						this.fileTrace(strText = "securityCheck q");
						setNextEvent("login.index");
					}
					break;

				case "login.sign_out":
					this.fileTrace(strText = "securityCheck r");
					if (isUserLoggedIn()) {
						this.fileTrace(strText = "securityCheck s");
						this.sign_out();
						setNextEvent("login.index");
					} else {
						this.fileTrace(strText = "securityCheck t");
						setNextEvent("login.index");
					}
					break;

				default:
					this.fileTrace(strText = "securityCheck u");
					if (isUserLoggedIn()) {
						this.fileTrace(strText = "securityCheck v");
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
							this.fileTrace(strText = "securityCheck w");
							//Google auth checks out?
							local.stcHTTPCall = this.verifyGoogleIDToken(session.stcUserProperties.stcGoogleUserProperties.id_token);
							local.stcAuthenticationInfo = deserializeJSON(local.stcHTTPCall.fileContent);
							if (NOT structKeyExists(local.stcAuthenticationInfo, "error_description")) {
								this.fileTrace(strText = "securityCheck x");
								//continue to requested page.
							} else {
								this.fileTrace(strText = "securityCheck y");
								this.sign_out();
								setNextEvent("login.index");
							}
						} else {
							this.fileTrace(strText = "securityCheck z");
							setNextEvent("login.no_access");
						}
					} else {
						this.fileTrace(strText = "securityCheck aa");
						setNextEvent("login.index");
					}
					break;
			}
		} else {
			this.fileTrace(strText = "securityCheck ab");
			setNextEvent("login.no_such_resource");
		}
	}

	function fileTrace(strText) {
		trace(text = arguments.strText);
		/*local.objFile = fileOpen("C:\OEP_Debug.txt", "append");
		fileWriteLine(local.objFile, dateTimeFormat(now(), "mm/dd/yyyy TT:mm:ss") & ": " & arguments.strText);
		fileClose(local.objFile);*/
	}

}
