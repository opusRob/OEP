
<!--- <cfdump var="#request#"> --->

<!--- <cfloop list="#structKeyList(request.cb_requestContext)#" index="variables.i">
	<cfoutput>
		<cfif left(variables.i, 3) IS "get">
			<cftry>
				request.cb_requestContext.#variables.i#() = <cfdump var="#evaluate('request.cb_requestContext.#variables.i#()')#">
				<cfcatch>
					ERROR: Message: #cfcatch.message# Detail: #cfcatch.detail#
				</cfcatch>
				<cffinally>
					<br/>
				</cffinally>
			</cftry>
		</cfif>
	</cfoutput>
</cfloop> --->

<!--- <cfdump var="#request.aryUser#"> --->

<cfoutput>
	<div class="page_content_spacer"></div>
	<form method="post" name="user_form" id="user_form" action="#event.buildLink(linkTo = 'user.save', ssl = true)#">
		<input type="hidden" class="form-control" name="user_id" id="user_id" value="#request.aryUser.getUser_id()#"/>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="user_last_name_tx" class="col-md-4 control-label">Last Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="user_last_name_tx" id="user_last_name_tx" maxlength="45" value="#request.aryUser.getUser_last_name_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="user_first_name_tx" class="col-md-4 control-label">First Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="user_first_name_tx" id="user_first_name_tx" maxlength="45" value="#request.aryUser.getUser_first_name_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="user_middle_name_tx" class="col-md-4 control-label">Middle Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="user_middle_name_tx" id="user_middle_name_tx" maxlength="45" value="#request.aryUser.getUser_middle_name_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="user_google_username_tx" class="col-md-4 control-label">Google Username:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="user_google_username_tx" id="user_google_username_tx" maxlength="45" value="#request.aryUser.getUser_google_username_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="checkbox">
				<div class="col-md-8">
					<label for="user_is_admin_bt" class="control-label">
						<input type="checkbox" name="user_is_admin_bt" id="user_is_admin_bt" value="1" #request.aryUser.getUser_is_admin_bt() ? 'checked' : ''#/>
						Is Admin User
					</label>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="checkbox">
				<div class="col-md-8">
					<label for="user_active_bt" class="control-label">
						<input type="checkbox" name="user_active_bt" id="user_active_bt" value="1" #request.aryUser.getUser_active_bt() ? 'checked' : ''#/>
						Is Active
					</label>
				</div>
			</div>
		</div>
		<div class="col-sm-6" style="">
			<div class="form-group">
				<div class="">
					<input type="submit" class="form-control btn btn-primary" name="btn_submit" id="btn_submit" value="Save"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group" style="">
				<div class="">
					<input type="button" class="form-control btn btn-default" name="btn_cancel" id="btn_cancel" value="Cancel" onClick="window.history.back(); "/>
				</div>
			</div>
		</div>
	</form>
</cfoutput>