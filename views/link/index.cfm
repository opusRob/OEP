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
		<th>Last Name</th>
		<th>First Name</th>
		<th class="visible-lg">Middle Name</th>
		<th class="hidden-xs">Linkname</th>
		<th class="hidden-xs">Is Admin</th>
		<th class="hidden-xs">Active</th>
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
						<!--- <a href="#event.buildLink('link.link.#variables.objLink.getLink_id()#')#"> --->
							#len(trim(variables.objLink.getLink_name_tx())) ? variables.objLink.getLink_name_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td>
						<!--- <a href="#event.buildLink('link.link.#variables.objLink.getLink_id()#')#"> --->
							#len(trim(variables.objLink.getLink_url_tx())) ? variables.objLink.getLink_url_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="visible-lg">
						<!--- <a href="#event.buildLink('link.link.#variables.objLink.getLink_id()#')#"> --->
							#len(trim(variables.objLink.getLink_image_file_name_tx())) ? variables.objLink.getLink_image_file_name_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="hidden-xs">
						<!--- <a href="#event.buildLink('link.link.#variables.objLink.getLink_id()#')#"> --->
							#len(trim(variables.objLink.getLink_google_linkname_tx())) ? variables.objLink.getLink_google_linkname_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="hidden-xs">#yesNoFormat(variables.objLink.getLink_is_admin_bt())#</td>
					<td class="hidden-xs">#yesNoFormat(variables.objLink.getLink_active_bt())#</td>
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


