/**
* A cool Comment entity
*/
component persistent="true" table="comments" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="comment_id" fieldtype="id" column="comment_id" generator="native" setter="false" notNull=true;

	// Properties
	//property name="comment_post_id" ormtype="int" notNull=true;	property name="comment_body_tx" ormtype="string" length=1000;	//property name="comment_create_user_id" ormtype="int" notNull=true;	//property name="comment_update_user_id" ormtype="int";	property name="comment_create_datetime_dt" ormtype="date" notNull=true;	property name="comment_update_datetime_dt" ormtype="date";

	// Relationships
	property name="Post" fieldType="many-to-one" fkColumn="comment_post_id" cfc="Post";
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="comment_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="comment_update_user_id" cfc="User";

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

