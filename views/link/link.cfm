
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
	<form method="post" name="link_form" id="link_form" action="#event.buildLink(linkTo = 'link.save', ssl = true)#" enctype="multipart/form-data">
		<input type="hidden" class="form-control" name="link_id" id="link_id" value="#request.aryLink.getLink_id()#"/>
		<input type="hidden" class="form-control" name="link_order_int" id="link_order_int" value="#val(request.aryLink.getLink_order_int())#"/>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_name_tx" class="col-md-4 control-label">Link Name:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_name_tx" id="link_name_tx" maxlength="100" value="#request.aryLink.getLink_name_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label for="link_url_tx" class="col-md-4 control-label">Link URL:</label>
				<div class="col-md-8">
					<input type="text" class="form-control" name="link_url_tx" id="link_url_tx" maxlength="500" value="#request.aryLink.getLink_url_tx()#"/>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="form-group">
				<label class="col-md-2 control-label">Link Icon Image:</label>
				<div class="col-md-10">
					<cfif
						len(trim(request.aryLink.getLink_image_file_name_tx()))
						AND fileExists(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & request.aryLink.getLink_image_file_name_tx()))
						AND isImageFile(expandPath(application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & request.aryLink.getLink_image_file_name_tx()))
					>
						<img
							src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation & request.aryLink.getLink_image_file_name_tx()#"
							alt="#request.aryLink.getLink_name_tx()# Link Icon Image"
							style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
						/>
					<cfelse>
						<img
							src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation#_no_link_image_available.png"
							alt="#request.aryLink.getLink_name_tx()# Link Icon Image Placeholder"
							style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "
						/>
					</cfif>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="link_image_upload_tx" class="col-md-2 control-label">Upload Link Icon Image:</label>
				<div class="col-md-10">
					<input type="file" class="" name="link_image_upload_tx" id="link_image_upload_tx"/>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="checkbox">
				<div class="col-md-12">
					<label for="link_delete_image_bt" class="control-label">
						<input type="checkbox" name="link_delete_image_bt" id="link_delete_image_bt" value="1"/>
						Delete Link Image
					</label>
				</div>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="checkbox">
				<div class="col-md-12">
					<label for="link_active_bt" class="control-label">
						<input type="checkbox" name="link_active_bt" id="link_active_bt" value="1" #val(request.aryLink.getLink_active_bt()) ? 'checked' : ''#/>
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