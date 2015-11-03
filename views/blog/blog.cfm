
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
	<form method="post" name="post_form" id="post_form" action="#event.buildLink('blog.save')#">
		<input type="hidden" class="form-control" name="post_id" id="post_id" value="#request.aryPost.getPost_id()#"/>
		<input type="hidden" class="form-control" name="post_post_type_id" id="post_post_type_id" value="#request.aryPostType.getPost_type_id()#"/>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="post_headline_tx" class="control-label">Headline:</label>
				<input type="text" class="form-control" name="post_headline_tx" id="post_headline_tx" maxlength="255" value="#request.aryPost.getPost_headline_tx()#"/>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="post_preview_tx" class="control-label">Preview:</label>
				<textarea class="form-control" name="post_preview_tx" id="post_preview_tx" maxlength="500" style="height: 50px; ">#request.aryPost.getPost_preview_tx()#</textarea>
			</div>
		</div>
		<div class="col-sm-12">
			<div class="form-group">
				<label for="post_body_tx" class="control-label">Body:</label>
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