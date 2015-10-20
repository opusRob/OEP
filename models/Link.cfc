/**
* A cool Link entity
*/
component persistent="true" table="links" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="link_id" fieldtype="id" column="link_id" generator="native" setter="false" notNull=true;

	// Properties
	property name="link_name_tx" ormtype="string" length=100;

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
