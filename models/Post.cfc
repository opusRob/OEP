/**
* A cool Post entity
*/
component persistent="true" table="posts" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="post_id" fieldtype="id" column="post_id" generator="increment" notNull=true;

	// Properties
	//property name="post_post_type_id" ormtype="int" notNull=true;	property name="post_headline_tx" ormtype="string" length=255 notNull=true;
	property name="post_preview_tx" ormtype="string" length=500;
	property name="post_body_tx" ormtype="string" length=4000;	//property name="post_create_user_id" ormtype="int" notNull=true;	//property name="post_update_user_id" ormtype="int";	property name="post_create_datetime_dt" ormtype="timestamp" notNull=true;	property name="post_update_datetime_dt" ormtype="timestamp";

	// Relationships
	property name="Tags" fieldType="many-to-many" fkColumn="posts_tags_xref_post_id" cfc="Tag" linkTable="posts_tags_xref" inverseJoinColumn="posts_tags_xref_tag_id";
	property name="Comments" fieldType="one-to-many" fkColumn="post_id" cfc="Comment";
	property name="PostType" fieldType="many-to-one" fkColumn="post_post_type_id" cfc="PostType";
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="post_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="post_update_user_id" cfc="User";

	// Validation
	this.constraints = {
		// Example: age = { required=true, min="18", type="int" }
	};

	// Custom functions:
	function getPostUpdateCreateDateTime() {
		return isDate(this.getPost_update_datetime_dt()) ? this.getPost_update_datetime_dt() : this.getPost_create_datetime_dt();
	}

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

