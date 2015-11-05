
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

<!--- <cfdump var="#request.aryLink#"> --->

<cfoutput>
	<form method="post" name="link_form" id="link_form" action="#event.buildLink('link.save')#" enctype="multipart/form-data">
		<input type="hidden" class="form-control" name="link_id" id="link_id" value="#request.aryLink.getLink_id()#"/>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_name_tx" class="col-md-4 control-label">Last Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_name_tx" id="link_name_tx" maxlength="45" value="#request.aryLink.getLink_name_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_url_tx" class="col-md-4 control-label">First Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_url_tx" id="link_url_tx" maxlength="45" value="#request.aryLink.getLink_url_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_image_upload_tx" class="col-md-4 control-label">Middle Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_image_upload_tx" id="link_image_upload_tx" maxlength="45" value="#request.aryLink.getLink_image_upload_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_google_linkname_tx" class="col-md-4 control-label">Google Linkname:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_google_linkname_tx" id="link_google_linkname_tx" maxlength="45" value="#request.aryLink.getLink_google_linkname_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="checkbox">
				<div class="col-md-8">
					<label for="link_is_admin_bt" class="control-label">
						<input type="checkbox" name="link_is_admin_bt" id="link_is_admin_bt" value="1" #request.aryLink.getLink_is_admin_bt() ? 'checked' : ''#/>
						Is Admin Link
					</label>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="checkbox">
				<div class="col-md-8">
					<label for="link_active_bt" class="control-label">
						<input type="checkbox" name="link_active_bt" id="link_active_bt" value="1" #request.aryLink.getLink_active_bt() ? 'checked' : ''#/>
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