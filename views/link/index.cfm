<br />
<cfoutput>
	<!--- <div class="paginator_div">
		#renderPaginator(
			total_records = request.intLinkCount
			, page = url.page
		)#
	</div> --->
</cfoutput>
<table class="table table-striped table-hover table_background">
	<tr>
		<th>Link Image Icon</th>
		<th>Link Name</th>
		<th class="hidden-xs">Link URL</th>
		<th class="visible-md visible-lg">Active</th>
		<th class="visible-md visible-lg">Last Updated</th>
		<th class="visible-lg">Created</th>
		<th style="text-align: right; ">
			<cfoutput>
				<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink('link.add')#'; ">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				</button>
			</cfoutput>
		</th>
	</tr>
	<cfoutput>
		<form method="post" name="links_form" id="links_form" action="#event.buildLink('link.remove')#">
			<input type="hidden" name="link_id" id="link_id" value="" maxlength="50"/>
			<cfset variables.intRowCount = 0/>
			<cfloop array="#request.aryLinks#" index="variables.objLink">
				<cfset variables.intRowCount++/>
				<tr>
					<td>
						<cfif len(trim(variables.objLink.getLink_url_tx()))>
							<a href="#variables.objLink.getLink_url_tx()#" target="_blank">
						</cfif>
						<cfif
							len(trim(variables.objLink.getLink_image_file_name_tx()))
							AND fileExists(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()))
							AND isImageFile(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()))
						>
							<img
								src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & variables.objLink.getLink_image_file_name_tx()#"
								alt="#variables.objLink.getLink_name_tx()# Link Icon Image"
								style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
							/>
						<cfelse>
							<img
								src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation#_no_link_image_available.png"
								alt="#variables.objLink.getLink_name_tx()# Link Icon Image Placeholder"
								style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
							/>
						</cfif>
						<cfif len(trim(variables.objLink.getLink_url_tx()))>
							</a>
						</cfif>
					</td>
					<td>
						#len(trim(variables.objLink.getLink_name_tx())) ? variables.objLink.getLink_name_tx() : "&nbsp;"#
					</td>
					<td class="hidden-xs">
						<cfif len(trim(variables.objLink.getLink_url_tx()))>
							<a href="#variables.objLink.getLink_url_tx()#" target="_blank">
								#variables.objLink.getLink_url_tx()#
							</a>
						<cfelse>
							&nbsp;
						</cfif>
					</td>
					<td class="visible-md visible-lg">#yesNoFormat(variables.objLink.getLink_active_bt())#</td>
					<td class="visible-md visible-lg">#isDate(variables.objLink.getLink_update_datetime_dt()) ? dateTimeFormat(variables.objLink.getLink_update_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<td class="visible-lg">#isDate(variables.objLink.getLink_create_datetime_dt()) ? dateTimeFormat(variables.objLink.getLink_create_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<td style="text-align: right; ">
						<button type="button" class="btn btn-warning btn-xs" onClick="location.href='#event.buildLink('link.edit.#variables.objLink.getLink_id()#')#'; ">
							<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
						</button>
						<button type="button" class="btn btn-danger btn-xs" onClick="linkRemove(#variables.objLink.getLink_id()#)">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						</button>
					</td>
				</tr>
			</cfloop>
		</form>
	</cfoutput>
</table>


