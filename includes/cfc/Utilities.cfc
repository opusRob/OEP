component {

	/*-- Removes HTML from the string.
	v2 - Mod by Steve Bryant to find trailing, half done HTML.
	v4 mod by James Moberg - empties out script/style blocks

	@param string 	 String to be modified. (Required)
	@return Returns a string.
	@author Raymond Camden (ray@camdenfamily.com)
	@version 4, October 4, 2010 --*/
	function stripHTML(str) {
		arguments.str = reReplaceNoCase(arguments.str, "<*style.*?>(.*?)</style>","","all");
		arguments.str = reReplaceNoCase(arguments.str, "<*script.*?>(.*?)</script>","","all");

		arguments.str = reReplaceNoCase(arguments.str, "<.*?>","","all");

		/*-- get partial html in front --*/
		arguments.str = reReplaceNoCase(arguments.str, "^.*?>","");

		/*-- get partial html at end --*/
		arguments.str = reReplaceNoCase(arguments.str, "<.*$","");

		return trim(arguments.str);

	}

	function processServerImage(
		required string strImageFileName
		, required boolean bolDeleteImage
		, required string strImageUploadFieldName
		, required string strImageType
		, required string strUploadedImagesFolderLocation
	) {
		/*-- Set initial file name. --*/
		local.strFileName = arguments.strImageFileName;
		/*-- Are wee deleting the image? --*/
		local.bolDeleteImageFile = structKeyExists(arguments, "bolDeleteImage") AND arguments.bolDeleteImage;

		/*-- If there is an upload form field in the arguments scope and it has a value: --*/
		if (structKeyExists(arguments, arguments.strImageUploadFieldName) AND len(trim(arguments[arguments.strImageUploadFieldName]))) {

			/*-- If the initial file name has a value AND a file of that name exists on the server (which means that
				the record exists already and has an image, but we're uploading a new one and need to delete/overwrite the old one): --*/
			if (
				len(local.strFileName)
				AND fileExists(
					expandPath(arguments.strUploadedImagesFolderLocation & local.strFileName)
				)
			) {
				/*-- Delete the image from the server: --*/
				fileDelete(expandPath(arguments.strUploadedImagesFolderLocation & local.strFileName));

				/*-- Blank out the file name in preparation for generating a new file name for the new file we're going to upload: --*/
				local.strFileName = "";
			}

			/*-- Generate the new file name comprised of the image type (link, blog, news, etc.), and a random string of alphanumeric chars: --*/
			local.strFileName = arguments.strImageType & "_image_" & uCase(reReplaceNoCase(createUUID(), "[^a-zA-Z0-9]", "", "all"));

			/*-- Upload the new file to the server (note that the "makeUnique" setting is used just in case of the highly unlikely scenario in which another
				image of the same name already existed): --*/
			local.stcFileUpload = fileUpload(
				destination = expandPath(arguments.strUploadedImagesFolderLocation)
				, fileField = arguments.strImageUploadFieldName
				, accept = "image/png,image/jpg,image/jpeg,image/gif"
				, nameConflict = "makeUnique"
			);

			/*-- Reset the file name to whatever name the file was written to the server as (generally this will be the same name we attempted to
				upload it as, but this is done just in case of the highly unlikely scenario in which another image of the same name already existed): --*/
			local.strFileName = local.stcFileUpload.serverFile;

			/*-- Get the full file path of the uploaded image including folder location and file name: --*/
			local.strFullFilePath = expandPath(arguments.strUploadedImagesFolderLocation & local.strFileName);

			/*-- If the file is an image file: --*/
			if (
				isImageFile(local.strFullFilePath)
				AND structKeyExists(arguments, "aryImageProperties")
				AND isArray(arguments.aryImageProperties)
				AND arrayLen(arguments.aryImageProperties)
				AND structKeyExists(arguments.aryImageProperties[1], "intWidth")
				AND structKeyExists(arguments.aryImageProperties[1], "intHeight")
			) {
				/*-- Resize the image on the hard drive: --*/
				local.objImage = imageNew(local.strFullFilePath);
				imageScaleToFit(local.objImage, arguments.aryImageProperties[1].intWidth, arguments.aryImageProperties[1].intHeight);
				imageWrite(local.objImage, local.strFullFilePath);
			/*-- Else if the file is NOT an image file: --*/
			} else {
				/*-- Since the file shouldn't be here if it's not an image, delete the image from the server,
					reset/blank out the file name, and set the image deletion flag: --*/
				fileDelete(local.strFullFilePath);
				local.strFileName = "";
				local.bolDeleteImageFile = true;
			}
		}

		/*-- If the image is/was to be deleted, and the file name has a length (which means we haven't already deleted it yet), and the file exists: --*/
		if (
			local.bolDeleteImageFile
			AND len(local.strFileName)
			AND fileExists(
				expandPath(arguments.strUploadedImagesFolderLocation & local.strFileName)
			)
		) {
			/*-- Delete the file from the server and reset/blank out the name: --*/
			fileDelete(expandPath(arguments.strUploadedImagesFolderLocation & local.strFileName));
			local.strFileName = "";
		}

		return local.strFileName;

	}
}