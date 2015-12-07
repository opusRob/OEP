/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		param url.page default = 1;

		request.aryLinks = entityLoad("Link", {}, "link_update_create_datetime_dt DESC");

		event.setView("link/index");
	}
	function add(event,rc,prc) {
		request.aryLink = entityNew("Link");
		event.setView("link/link");
	}
	function edit(event,rc,prc) {
		request.aryLink = entityLoad("Link", val(listLast(request.cb_requestContext.getCurrentRoutedURL(), "/")), true);
		event.setView("link/link");
	}
	function save(event,rc,prc) {
		if (val(arguments.rc.link_id))
			request.aryLink = entityLoadByPK("Link", val(arguments.rc.link_id));
		else
			request.aryLink = entityNew("Link");

		local.strFileName = createObject("component", "includes.cfc.Utilities").processServerImage(
			strImageFileName = request.aryLink.getLink_image_file_name_tx()
			, bolDeleteImage = structKeyExists(arguments.rc, "link_delete_image_bt") AND arguments.rc.link_delete_image_bt
			, strImageUploadFieldName = "link_image_upload_tx"
			, link_image_upload_tx = arguments.rc.link_image_upload_tx
			, strImageType = "link"
			, strUploadedImagesFolderLocation = application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation
			, stcImageProperties = {
				intWidth = 64
				, intHeight = 64
			}
		);

		request.aryLink.setLink_name_tx(arguments.rc.link_name_tx);
		request.aryLink.setLink_url_tx(arguments.rc.link_url_tx);
		request.aryLink.setLink_image_file_name_tx(local.strFileName);
		request.aryLink.setLink_order_int(arguments.rc.link_order_int);
		request.aryLink.setLink_active_bt(structKeyExists(arguments.rc, "link_active_bt") ? arguments.rc.link_active_bt : false);

		if (val(arguments.rc.link_id)) {
			request.aryLink.setUpdatedByUser(entityLoadByPK("Link", session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_id));
			request.aryLink.setLink_update_datetime_dt(now());
		} else {
			request.aryLink.setCreatedByUser(entityLoadByPK("Link", session.stcUserProperties.stcOpusEmployeePortalUserProperties.user_id));
			request.aryLink.setLink_create_datetime_dt(now());
		}

		entitySave(request.aryLink, NOT val(arguments.rc.link_id));
		ormFlush();

		setNextEvent("link.index");

	}
	function remove(event,rc,prc) {
		request.aryLink = entityLoadByPK("Link", val(arguments.rc.link_id));
		local.strFullFilePath = expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & request.aryLink.getLink_image_file_name_tx());

		if (fileExists(local.strFullFilePath))
			fileDelete(local.strFullFilePath);

		entityDelete(request.aryLink);
		ormFlush();

		setNextEvent("link.index");
	}
}
