/**
* A cool Post entity
*/
component persistent="true" table="posts" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="post_id" fieldtype="id" column="post_id" generator="native" setter="false" notNull=true;

	// Properties
	//property name="post_post_type_id" ormtype="int" notNull=true;

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

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}
