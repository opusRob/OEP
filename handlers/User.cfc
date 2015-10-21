/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		event.setView("user/index");
	}

}
