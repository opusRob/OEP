
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

<!--- <cfdump var="#request.aryPost#"> --->

<cfoutput>
	<form method="post" name="post_form" id="post_form" action="#event.buildLink(linkTo = request.cb_requestContext.getCurrentHandler() & '.save', ssl = true)#" enctype="multipart/form-data">
		<input type="hidden" class="form-control" name="post_id" id="post_id" value="#request.aryPost.getPost_id()#"/>
		<input type="hidden" class="form-control" name="post_post_type_id" id="post_post_type_id" value="#request.aryPostType.getPost_type_id()#"/>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="post_headline_tx" class="control-label">Headline:</label>
				<input type="text" class="form-control" name="post_headline_tx" id="post_headline_tx" maxlength="255" value="#request.aryPost.getPost_headline_tx()#"/>
			</div>
		</div>
		<cfif listFindNoCase("news,blog", request.cb_requestContext.getCurrentHandler())>
			<div class="col-sm-12" style="padding-bottom: 10px; ">
				<div class="form-group">
					<label class="col-md-2 control-label" style="padding-left: 0px; ">Image:</label>
					<div class="col-md-10">
						<cfif
							len(trim(request.aryPost.getPost_small_image_file_name_tx()))
							AND fileExists(expandPath(request.strUploadedImagesFolderLocation & request.aryPost.getPost_small_image_file_name_tx()))
							AND isImageFile(expandPath(request.strUploadedImagesFolderLocation & request.aryPost.getPost_small_image_file_name_tx()))
						>
							<img
								src="#request.strUploadedImagesFolderLocation & request.aryPost.getPost_small_image_file_name_tx()#"
								alt="#request.aryPost.getPost_headline_tx()# Image"
								style="width: 150px; height: 150px; float: left; border: solid 1px ##cccccc; "
							/>
						<cfelse>
							<img
								src="#request.strUploadedImagesFolderLocation#_no_post_image_available.png"
								alt="#request.aryPost.getPost_headline_tx()# Image Placeholder"
								style="width: 150px; height: 150px; float: left; border: solid 1px ##cccccc; "
							/>
						</cfif>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="form-group">
					<label for="post_image_upload_tx" class="col-md-2 control-label" style="padding-left: 0px; ">Upload Image:</label>
					<div class="col-md-10">
						<input type="file" class="" name="post_image_upload_tx" id="post_image_upload_tx"/>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="checkbox">
					<div class="col-md-12" style="padding-left: 0px; ">
						<label for="post_delete_image_bt" class="control-label">
							<input type="checkbox" name="post_delete_image_bt" id="post_delete_image_bt" value="1"/>
							Delete Image
						</label>
					</div>
				</div>
			</div>
		</cfif>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="post_body_tx" class="control-label">
					Body
					<span
						style="font-weight: normal; font-style: italic; "
					>(currently <span id="post_body_char_length">#val(request.aryPost.getPost_body_tx())#</span> of 4000 allowed characters)</span>:
				</label>
				<textarea class="form-control" name="post_body_tx" id="post_body_tx" maxlength="4000" style="height: 200px; ">#request.aryPost.getPost_body_tx()#</textarea>
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