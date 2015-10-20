/**
* A cool Tag entity
*/
component persistent="true" table="tags" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="tag_id" fieldtype="id" column="tag_id" generator="native" setter="false" notNull=true;

	// Properties
	property name="tag_name_tx" ormtype="string" length=45 notNull=true;

	// Relationships
	property name="Posts" fieldType="many-to-many" fkColumn="posts_tags_xref_tag_id" cfc="Post" linkTable="posts_tags_xref" inverseJoinColumn="posts_tags_xref_post_id";
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="tag_create_user_id" cfc="User";
	property name="UpdatedByUser" fieldType="many-to-one" fkColumn="tag_update_user_id" cfc="User";

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
