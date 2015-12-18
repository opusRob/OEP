/**
* A cool Link entity
*/
component persistent="true" table="links" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="link_id" fieldtype="id" column="link_id" generator="increment" notNull=true;

	// Properties
	property name="link_name_tx" ormtype="string" length=100;
	property name="link_https_bt" ormtype="boolean" notNull=true default=false;	property name="link_url_tx" ormtype="string" length=500;	property name="link_image_file_name_tx" ormtype="string" length=500 default="";	property name="link_active_bt" ormtype="boolean" notNull=true default=true;	property name="link_order_int" ormtype="int";	//property name="link_create_user_id" ormtype="int" notNull=true;	//property name="link_update_user_id" ormtype="int";	property name="link_create_datetime_dt" ormtype="timestamp" notNull=true;	property name="link_update_datetime_dt" ormtype="timestamp";

	// Calculated
	property name="link_update_create_datetime_dt" type="timestamp" formula="SELECT COALESCE(link_update_datetime_dt, link_create_datetime_dt)";

	// Relationships
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="link_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="link_update_user_id" cfc="User";

	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="int" }
	};

	// Custom functions:
	function getImageSrcAttr() {
		return application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & this.getLink_image_file_name_tx()
	}
	function getLink_url_full_tx() {
		return (this.getLink_https_bt() ? "https://" : "http://") & this.getLink_url_tx();
	}

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

