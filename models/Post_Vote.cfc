/**
* A cool Comment entity
*/
component persistent="true" table="post_votes" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="post_vote_id" fieldtype="id" column="post_vote_id" generator="increment" notNull=true;

	// Properties
	property name="post_vote_is_upvote_bt" ormtype="boolean" notNull=true default=true;	property name="post_vote_create_datetime_dt" ormtype="timestamp" notNull=true;

	// Calculated

	// Relationships
	property name="Post" fieldType="many-to-one" fkColumn="post_vote_post_id" cfc="Post";
	property name="CreatedByUser" fieldType="many-to-one" fkColumn="post_vote_create_user_id" cfc="User";

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

