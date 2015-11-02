/**
 * CreateInitialData
 *
 * @author Rob Germain
 * @date 10/21/15
 **/
component accessors=false output=false persistent=false {
	public void function createUser(
		string user_first_name_tx=""
		, string user_middle_name_tx
		, string user_last_name_tx=""
		, string user_google_username_tx
		, boolean user_is_admin_bt
		, boolean user_active_bt
	) {

		/*-- Create the new user with initial values: --*/
		local.objUser = entityNew(
			"User"
			, {
				user_first_name_tx = arguments.user_first_name_tx
				, user_middle_name_tx = arguments.user_middle_name_tx
				, user_last_name_tx = arguments.user_last_name_tx
				, user_google_username_tx = arguments.user_google_username_tx
				, user_is_admin_bt = arguments.user_is_admin_bt
				, user_active_bt = arguments.user_active_bt
				, user_create_datetime_dt = now()
			}
		);

		/*-- Save the user in order to auto-generate the user_id: --*/
		entitySave(local.objUser, true);

		/*-- Set the new user's CreatedByUser property to itself (meaning, the user created themself (since this is an initial record in the app)): --*/
		local.objUser.setCreatedByUser(local.objUser);

		/*-- Update the user now that we've added the CreatedByUser property value: --*/
		entitySave(local.objUser, false);

		/*-- Apply what we've done to the database: --*/
		ormFlush();
	}
	public void function createPostType(string post_type_name_tx="", string post_type_code_tx, boolean post_type_active_bt) {

		/*-- Create the new post type with initial values: --*/
		local.objPostType = entityNew(
			"PostType"
			, {
				post_type_name_tx = arguments.post_type_name_tx
				, post_type_code_tx = arguments.post_type_code_tx
				, post_type_active_bt = arguments.post_type_active_bt
			}
		);

		/*-- Save the post type in order to auto-generate the post_type_id: --*/
		entitySave(local.objPostType, true);

		/*-- Apply what we've done to the database: --*/
		ormFlush();
	}

	public void function createInitialUsers(required string strFilePath) {
		local.aryInitialUsers = this.loadInitialDataFromFile(strFilePath);

		for (local.i = 1; local.i LTE arrayLen(local.aryInitialUsers); local.i++) {
			this.createUser(argumentCollection = local.aryInitialUsers[local.i]);
		}

	}

	public void function createInitialPostTypes(required string strFilePath) {
		local.aryInitialPostTypes = this.loadInitialDataFromFile(strFilePath);

		for (local.i = 1; local.i LTE arrayLen(local.aryInitialPostTypes); local.i++) {
			this.createPostType(argumentCollection = local.aryInitialPostTypes[local.i]);
		}

	}

	public void function createInitialData(required string strInitialAppDataFolderLocation) {
		this.createInitialUsers(expandPath(arguments.strInitialAppDataFolderLocation & "initialUserData.json"));
		this.createInitialPostTypes(expandPath(arguments.strInitialAppDataFolderLocation & "initialPostTypeData.json"));
	}

	public array function loadInitialDataFromFile(required string strFilePath) {
		return deserializeJSON(fileRead(arguments.strFilePath));
	}

}