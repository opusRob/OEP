<cfoutput>
	<!--- <div class="<!--- panel panel-default --->">
		<div class="<!--- panel-heading --->" style="height: 45px; ">
			<h3 class="<!--- panel-title --->" style="margin: 0px; padding: 0px; <!--- float: left;  --->">
				<a href="#event.buildLink('links.index')#">Links</a>
			</h3>
		</div> --->
		<div class="<!--- panel-body --->" style="text-align: center; ">
			<cfloop array="#request.aryLinks#" index="variables.objLink">
				<div class="<!--- col-xs-6 col-sm-4 col-md-3 col-lg-2 --->" style="display: inline-block; margin: 0px auto 35px auto; width: 150px; ">
					<a href="#variables.objLink.getLink_URL_tx()#" target="_blank" style="display: inline-block; <!--- float: left;  ---><!--- margin: 0px 10px 5px 0px; ---> ">
						<cfif
							len(trim(variables.objLink.getLink_image_file_name_tx()))
							AND fileExists(expandPath(variables.objLink.getImageSrcAttr()))
							AND isImageFile(expandPath(variables.objLink.getImageSrcAttr()))
						>
							<img
								src="#variables.objLink.getImageSrcAttr()#"
								alt="#variables.objLink.getLink_name_tx()# Link Icon Image"
								style="width: 64px; height: 64px; <!--- float: left;  --->border: solid 1px ##cccccc; <!--- margin-right: 5px;  --->"
								align="middle"
							/>
						<cfelse>
							<img
								src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation#_no_link_image_available.png"
								alt="#variables.objLink.getLink_name_tx()# Link Icon Image Placeholder"
								style="width: 64px; height: 64px; <!--- float: left;  --->border: solid 1px ##cccccc; margin-right: 5px; "
							/>
						</cfif>
						<div style="<!--- float: left;  --->max-width: <!--- 64px --->190px; white-space: nowrap; ">#variables.objLink.getLink_name_tx()#</div>
					</a>
				</div>
			</cfloop>
		</div>
	<!--- </div> --->
</cfoutput>