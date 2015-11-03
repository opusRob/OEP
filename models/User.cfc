/**
* A cool User entity
*/
component persistent="true" table="users" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="user_id" fieldtype="id" column="user_id" generator="increment" notNull=true;

	// Properties
	property name="user_first_name_tx" ormtype="string" length=45;	property name="user_middle_name_tx" ormtype="string" length=45;	property name="user_last_name_tx" ormtype="string" length=45;	property name="user_google_username_tx" ormtype="string" length=100;
	property name="user_is_admin_bt" ormtype="boolean" default=false;
	property name="user_active_bt" ormtype="boolean" default=true;	//property name="user_create_user_id" ormtype="int" notNull=true;	//property name="user_update_user_id" ormtype="int";	property name="user_create_datetime_dt" ormtype="timestamp" notNull=true;	property name="user_update_datetime_dt" ormtype="timestamp";
	// Relationships
	property name="UsersCreated" fieldType="one-to-many" fkColumn="user_id" cfc="User";
	property name="UsersUpdated" fieldType="one-to-many" fkColumn="user_id" cfc="User";
	property name="PostsCreated" fieldType="one-to-many" fkColumn="user_id" cfc="Post";
	property name="PostsUpdated" fieldType="one-to-many" fkColumn="user_id" cfc="Post";
	property name="LinksCreated" fieldType="one-to-many" fkColumn="user_id" cfc="Link";
	property name="LinksUpdated" fieldType="one-to-many" fkColumn="user_id" cfc="Link";
	property name="CommentsCreated" fieldType="one-to-many" fkColumn="user_id" cfc="Comment";
	property name="CommentsUpdated" fieldType="one-to-many" fkColumn="user_id" cfc="Comment";
	property name="TagsCreated" fieldType="one-to-many" fkColumn="user_id" cfc="Tag";
	property name="TagsUpdated" fieldType="one-to-many" fkColumn="user_id" cfc="Tag";
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="user_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="user_update_user_id" cfc="User";

	// Custom getters:
	function getUser_full_name_tx() {
		local.strFirstName = trim(this.getUser_first_name_tx());
		local.strMiddleName = trim(this.getUser_middle_name_tx());
		local.strLastName = trim(this.getUser_last_name_tx());

		local.strFullName = local.strFirstName;

		if (len(local.strFullName) AND len(local.strMiddleName & local.strLastName))
			local.strFullName &= chr(32);

		local.strFullName &= local.strMiddleName;

		if (len(local.strFullName) AND len(local.strLastName))
			local.strFullName &= local.strLastName;

		return local.strFullName;

	}


	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="int" }
	};

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

