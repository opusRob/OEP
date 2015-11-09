<!--- <cfdump var="#request.aryPost.getCreatedByUser()#"><cfabort> --->

<cfoutput>
	<div class="panel panel-default" style="margin-top: 15px; ">
		<div class="panel-heading">
			<div style="clear: both; ">
				<div style="float: left; ">
					<h3 class="panel-title">
						#request.aryPost.getPost_headline_tx()#
					</h3>
					<div class="created_updated_by">
						Created
						#dateTimeFormat(request.aryPost.getPost_create_datetime_dt(), "mm/dd/yyyy at hh:mm TT")#
						by #request.aryPost.getCreatedByUser().getUser_full_name_tx()#.
						<cfif isDate(request.aryPost.getPost_update_datetime_dt())>
							last updated
							#dateTimeFormat(request.aryPost.getPost_update_datetime_dt(), "mm/dd/yyyy at hh:mm TT")#
							by #request.aryPost.getUpdatedByUser().getUser_full_name_tx()#.
						</cfif>
					</div>
				</div>
				<div style="float: right; ">
					<button type="button" class="btn btn-success btn-xs" onClick="window.history.back(); ">
						<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
					</button>
				</div>
				<div style="clear: both; "></div>
			</div>
		</div>
		<div class="panel-body">
			<div>
				#request.aryPost.getPost_body_tx()#
			</div>
		</div>
	</div>
</cfoutput>