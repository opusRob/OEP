<br />
<table class="table table-striped table-hover table_background">
	<tr>
		<th>Last Name</th>
		<th>First Name</th>
		<th class="visible-lg">Middle Name</th>
		<th class="hidden-xs">Username</th>
		<th class="hidden-xs">Is Admin</th>
		<th class="visible-md visible-lg">Last Updated</th>
		<th class="visible-lg">Created</th>
		<th>&nbsp;</th>
	</tr>
	<cfoutput>
		<cfset variables.intRowCount = 0/>
		<cfloop array="#request.aryUsers#" index="variables.objUser">
			<cfset variables.intRowCount++/>
			<tr>
				<td>#len(trim(variables.objUser.getUser_last_name_tx())) ? variables.objUser.getUser_last_name_tx() : "&nbsp;"#</td>
				<td>#len(trim(variables.objUser.getUser_first_name_tx())) ? variables.objUser.getUser_first_name_tx() : "&nbsp;"#</td>
				<td class="visible-lg">#len(trim(variables.objUser.getUser_middle_name_tx())) ? variables.objUser.getUser_middle_name_tx() : "&nbsp;"#</td>
				<td class="hidden-xs">#len(trim(variables.objUser.getUser_google_username_tx())) ? variables.objUser.getUser_google_username_tx() : "&nbsp;"#</td>
				<td class="hidden-xs">#yesNoFormat(variables.objUser.getUser_is_admin_bt())#</td>
				<td class="visible-md visible-lg">#isDate(variables.objUser.getUser_update_datetime_dt()) ? dateTimeFormat(variables.objUser.getUser_update_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
				<td class="visible-lg">#isDate(variables.objUser.getUser_create_datetime_dt()) ? dateTimeFormat(variables.objUser.getUser_create_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
				<td> X </td>
			</tr>
		</cfloop>
	</cfoutput>
</table>


