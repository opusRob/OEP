/**
* A ColdBox ORM Module Enabled Hibernate Event Handler that ties to the ColdBox proxy for ColdBox Operations.
*/
component extends="cborm.models.EventHandler"{
	function index(event,rc,prc){
		param url.page default = 1;

		request.aryLinks = entityLoad("Link");

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

		local.strFileName = request.aryLink[1].getLink_image_file_name_tx;
		local.bolDeleteImageFile = structKeyExists(arguments.rc, "link_delete_image_bt") AND arguments.rc.link_delete_image_bt;

		if (structKeyExists(arguments.rc, "link_image_upload_tx") AND len(trim(arguments.rc.link_image_upload_tx))) {
			local.strFileName = "link_image_" & uCase(reReplaceNoCase(createUUID(), "[^a-zA-Z]", "", "all"));
			local.stcFileUpload = fileUpload(
				expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & local.strFileName)
				, "link_image_upload_tx"
				, "image/png,image/jpg,image/jpeg,image/gif"
				, "makeUnique"
			);
			local.strFileName = local.stcFileUpload.serverFile;
			local.strFullFilePath = expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & local.strFileName);
			if (isImageFile(local.strFullFilePath) {
				local.objImage = imageNew(local.strFullFilePath);
				imageScaleToFit(local.objImage, 64, 64);
				imageWrite(local.objImage, local.strFullFilePath);
			} else {
				fileDelete(local.strFullFilePath);
				local.strFileName = "";
				local.bolDeleteImageFile = true;
			}
		}

		if (local.bolDeleteImageFile AND len(local.strFileName) AND fileExists(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & local.strFileName))) {
			fileDelete(local.strFullFilePath);
			local.strFileName = "";
		}

		request.aryLink.setLink_name_tx(arguments.rc.link_name_tx);
		request.aryLink.setLink_url_tx(arguments.rc.link_url_tx);
		request.aryLink.setLink_image_file_name_tx(local.bolDeleteImageFile ? "" : local.strFileName);
		request.aryLink.setLink_order_int(arguments.rc.link_order_int);
		request.aryLink.setLink_active_bt(structKeyExists(arguments.rc, "link_active_bt") ? arguments.rc.link_active_bt : false);

		if (val(arguments.rc.link_id)) {
			request.aryLink.setUpdatedByLink(entityLoadByPK("Link", 1));
			request.aryLink.setLink_update_datetime_dt(now());
		} else {
			request.aryLink.setCreatedByLink(entityLoadByPK("Link", 1));
			request.aryLink.setLink_create_datetime_dt(now());
		}

		entitySave(request.aryLink, NOT val(arguments.rc.link_id));
		ormFlush();

		setNextEvent("link.index");

	}
	function remove(event,rc,prc) {
		request.aryLink = entityLoadByPK("Link", val(arguments.rc.link_id));

		//entityDelete(request.aryLink);
		//ORMExecuteQuery("DELETE FROM links WHERE link_id = #val(arguments.rc.link_id)#", true);

		//ormFlush();

		createObject("component", "linkUtilities").removeLink(arguments.rc.link_id);

		setNextEvent("link.index");
	}
}
