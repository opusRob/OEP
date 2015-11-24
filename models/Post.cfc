/**
* A cool Post entity
*/
component persistent="true" table="posts" extends="cborm.models.ActiveEntity" {

	// Primary Key
	property name="post_id" fieldtype="id" column="post_id" generator="increment" notNull=true;

	// Properties
	//property name="post_post_type_id" ormtype="int" notNull=true;	property name="post_headline_tx" ormtype="string" length=255 notNull=true;
	property name="post_body_tx" ormtype="string" length=4000;
	property name="post_large_image_file_name_tx" ormtype="string" length=500 default="";
	property name="post_small_image_file_name_tx" ormtype="string" length=500 default="";	//property name="post_create_user_id" ormtype="int" notNull=true;	//property name="post_update_user_id" ormtype="int";	property name="post_create_datetime_dt" ormtype="timestamp" notNull=true;	property name="post_update_datetime_dt" ormtype="timestamp";

	// Calculated
	property name="post_update_create_datetime_dt" type="timestamp" formula="SELECT COALESCE(post_update_datetime_dt, post_create_datetime_dt)";
	property name="post_votes_ct" type="numeric" formula="SELECT COUNT(pv.post_vote_id) FROM post_votes pv WHERE pv.post_id = post_id";
	property name="post_upvotes_ct" type="numeric" formula="SELECT COUNT(pv.post_vote_id) FROM post_votes pv WHERE pv.post_id = post_id AND pv.post_vote_is_upvote_bt = 'true'";
	property name="post_downvotes_ct" type="numeric" formula="SELECT COUNT(pv.post_vote_id) FROM post_votes pv WHERE pv.post_id = post_id AND pv.post_vote_is_upvote_bt = 'false'";

	// Relationships
	property name="PostVotes" fieldType="one-to-many" fkColumn="post_id" cfc="Post_Vote";
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
	function getImageSrcAttr() {
		if (arguments.strImageType EQ "news") {
			if (arguments.strImageSize EQ "large") {
				return application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & this.getPost_large_image_file_name_tx();
			} else if (arguments.strImageSize EQ "small") {
				return application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & this.getPost_small_image_file_name_tx();
			}
		} else if (arguments.strImageType EQ "blog") {
			if (arguments.strImageSize EQ "large") {
				return application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation & this.getPost_large_image_file_name_tx();
			} else if (arguments.strImageSize EQ "small") {
				return application.stcApplicationCustomSettings.strUploadedBlogImagesFolderLocation & this.getPost_small_image_file_name_tx();
			}
		}
		return "";
	}

	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}
}

