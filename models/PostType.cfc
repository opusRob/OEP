/**
* A cool PostType entity
*/
component persistent="true" table="post_types" extends="cborm.models.ActiveEntity"{

	// Primary Key
	property name="post_type_id" fieldtype="id" column="post_type_id" generator="native" setter="false" notNull=true;

	// Properties
	property name="post_type_name_tx" ormtype="string" length=45 notNull=true;

	// Relationships

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
