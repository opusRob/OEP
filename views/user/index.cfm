<br />
<cfoutput>
	<!--- <div class="paginator_div">
		#renderPaginator(
			total_records = request.intUserCount
			, page = url.page
		)#
	</div> --->
</cfoutput>
<table class="table table-striped table-hover table_background">
	<tr>
		<th>Last Name</th>
		<th>First Name</th>
		<th class="visible-lg">Middle Name</th>
		<th class="hidden-xs">Username</th>
		<th class="hidden-xs">Is Admin</th>
		<th class="hidden-xs">Active</th>
		<th class="visible-md visible-lg">Last Updated</th>
		<th class="visible-lg">Created</th>
		<cfif isUserInRole("administrator")>
			<th style="text-align: right; ">
				<cfoutput>
					<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink('user.add')#'; ">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</button>
				</cfoutput>
			</th>
		</cfif>
	</tr>
	<cfoutput>
		<form method="post" name="users_form" id="users_form" action="#event.buildLink('user.remove')#">
			<input type="hidden" name="user_id" id="user_id" value="" maxlength="50"/>
			<cfset variables.intRowCount = 0/>
			<cfloop array="#request.aryUsers#" index="variables.objUser">
				<cfset variables.intRowCount++/>
				<tr>
					<td>
						<!--- <a href="#event.buildLink('user.user.#variables.objUser.getUser_id()#')#"> --->
							#len(trim(variables.objUser.getUser_last_name_tx())) ? variables.objUser.getUser_last_name_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td>
						<!--- <a href="#event.buildLink('user.user.#variables.objUser.getUser_id()#')#"> --->
							#len(trim(variables.objUser.getUser_first_name_tx())) ? variables.objUser.getUser_first_name_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="visible-lg">
						<!--- <a href="#event.buildLink('user.user.#variables.objUser.getUser_id()#')#"> --->
							#len(trim(variables.objUser.getUser_middle_name_tx())) ? variables.objUser.getUser_middle_name_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="hidden-xs">
						<!--- <a href="#event.buildLink('user.user.#variables.objUser.getUser_id()#')#"> --->
							#len(trim(variables.objUser.getUser_google_username_tx())) ? variables.objUser.getUser_google_username_tx() : "&nbsp;"#
						<!--- </a> --->
					</td>
					<td class="hidden-xs">#yesNoFormat(variables.objUser.getUser_is_admin_bt())#</td>
					<td class="hidden-xs">#yesNoFormat(variables.objUser.getUser_active_bt())#</td>
					<td class="visible-md visible-lg">#isDate(variables.objUser.getUser_update_datetime_dt()) ? dateTimeFormat(variables.objUser.getUser_update_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<td class="visible-lg">#isDate(variables.objUser.getUser_create_datetime_dt()) ? dateTimeFormat(variables.objUser.getUser_create_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<cfif isUserInRole("administrator")>
						<td style="text-align: right; white-space: nowrap; ">
							<button type="button" class="btn btn-warning btn-xs" onClick="location.href='#event.buildLink('user.edit.#variables.objUser.getUser_id()#')#'; ">
								<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
							</button>
							<button type="button" class="btn btn-danger btn-xs" onClick="userRemove(#variables.objUser.getUser_id()#)">
								<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
							</button>
						</td>
					</cfif>
				</tr>
			</cfloop>
		</form>
	</cfoutput>
</table>


