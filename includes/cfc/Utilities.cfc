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
}