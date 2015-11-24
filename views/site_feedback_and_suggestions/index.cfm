<cfoutput>

	<!--- <cfdump var="#request.cb_requestContext.getCurrentHandler()#"/><cfabort> --->


	<form name="post_form" id="post_form" action="#event.buildLink('site_feedback_and_suggestions.remove')#" method="post">
		<input type="hidden" name="post_id" id="post_id" value="0"/>
	</form>

	<div class="row">
		<div class="" style="padding-left: 20px; ">
			<cfset variables.intRowCount = 0/>
			<cfloop array="#request.aryPosts#" index="variables.objPost">
				<cfset variables.intRowCount++/>
				<div class="post-preview">
					<a href="#event.buildLink('site_feedback_and_suggestions.item.#variables.objPost.getPost_id()#')#">
						<h2 class="post-title">
							#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
						</h2>
						<div>
							<h3 class="post-subtitle" style="font-weight: 300; ">
								<cfif len(trim(variables.objPost.getPost_body_tx()))>
									#left(
										request.cfcUtilities.stripHTML(
											replaceNoCase(variables.objPost.getPost_body_tx(), "[[[IMAGE]]]", "", "all")
										)
										, 200
									)#
								<cfelse>
									&nbsp;
								</cfif>
							</h3>
						</div>
					</a>
					<p class="post-meta">
						<cfif isDate(variables.objPost.getPost_update_datetime_dt())>
							Updated by
							<a href="##">#variables.objPost.getUpdatedByUser().getUser_full_name_tx()#</a>
							on #dateFormat(variables.objPost.getPost_update_datetime_dt(), "dddd mmmm d, yyyy")#
							at #timeFormat(variables.objPost.getPost_update_datetime_dt(), "h:mm TT")#
						<cfelse>
							Posted by
							<a href="##">#variables.objPost.getCreatedByUser().getUser_full_name_tx()#</a>
							on #dateFormat(variables.objPost.getPost_create_datetime_dt(), "dddd mmmm d, yyyy")#
							at #timeFormat(variables.objPost.getPost_create_datetime_dt(), "h:mm TT")#
						</cfif>
						<cfif isUserInRole("administrator")>
							<div style="clear: left; ">
								<div class="btn-group" role="group" aria-label="">
									<button type="button" class="btn btn-primary btn-xs" onClick="location.href='#event.buildLink('site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#')#'; ">
										<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
										<span class="badge">#val(variables.objPost.getPost_upvotes_ct())#</span>
									</button>
									<button type="button" class="btn btn-info btn-xs" onClick="location.href='#event.buildLink('site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#')#'; ">
										<span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span>
										<span class="badge">#val(variables.objPost.getPost_downvotes_ct())#</span>
									</button>
								</div>
								<div class="btn-group" role="group" aria-label="">
									<button type="button" class="btn btn-warning btn-xs" style="margin-left: 25px; " onClick="location.href='#event.buildLink('site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#')#'; ">
										<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									</button>
									<button type="button" class="btn btn-danger btn-xs" onClick="postRemove(#variables.objPost.getPost_id()#)">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
									</button>
								</div>
							</div>
						</cfif>
					</p>
				</div>
				<cfif variables.intRowCount LT arrayLen(request.aryPosts)>
					<hr/>
				</cfif>
			</cfloop>
		</div>
	</div>
</cfoutput>