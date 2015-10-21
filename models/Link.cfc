/**
* A cool Link entity
*/
component persistent="true" table="links" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="link_id" fieldtype="id" column="link_id" generator="increment" notNull=true;

	// Properties
	property name="link_name_tx" ormtype="string" length=100;	property name="link_url_tx" ormtype="string" length=500;	property name="link_image_path_tx" ormtype="string" length=500;	property name="link_active_bt" ormtype="boolean" notNull=true;	property name="link_order_int" ormtype="int";	//property name="link_create_user_id" ormtype="int" notNull=true;	//property name="link_update_user_id" ormtype="int";	property name="link_create_datetime_dt" ormtype="timestamp" notNull=true;	property name="link_update_date_dt" ormtype="timestamp";

	// Relationships
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="link_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="link_update_user_id" cfc="User";

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

