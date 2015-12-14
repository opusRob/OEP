<cfoutput>

	<!--- <cfdump var="#request.cb_requestContext.getCurrentHandler()#"/><cfabort> --->


	<form name="post_form" id="post_form" action="#event.buildLink(linkTo = 'site_feedback_and_suggestions.remove', ssl = true)#" method="post">
		<input type="hidden" name="post_id" id="post_id" value="0"/>
	</form>

	<div class="row">
		<div class="" style="padding-left: 20px; ">
			<cfif NOT arrayLen(request.aryPosts)>
				<span style="font-size: 18px; ">No feedback or suggestions found.</span>
			<cfelse>
				<cfset variables.intRowCount = 0/>
				<cfloop array="#request.aryPosts#" index="variables.objPost">
					<cfset variables.intRowCount++/>
					<div class="post-preview">
						<a href="#event.buildLink(linkTo = 'site_feedback_and_suggestions.item.#variables.objPost.getPost_id()#', ssl = true)#">
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
									<!--- <cfif variables.objPost.getPost_my_vote_tx() IS "Up">
										<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
									<cfelseif variables.objPost.getPost_my_vote_tx() IS "Down">
										<span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span>
									<cfelse>
										<span class="glyphicon glyphicon-hand-right" aria-hidden="true"></span>
									</cfif> --->
								<!--- 	<div class="btn-group" role="group" aria-label="">
										<button type="button" class="btn btn-primary btn-xs" onClick="location.href='#event.buildLink(linkTo = 'site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#', ssl = true)#'; ">
											<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>
											<span class="badge">#val(variables.objPost.getPost_upvotes_ct())#</span>
										</button>
										<button type="button" class="btn btn-info btn-xs" onClick="location.href='#event.buildLink(linkTo = 'site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#', ssl = true)#'; ">
											<span class="glyphicon glyphicon-thumbs-down" aria-hidden="true"></span>
											<span class="badge">#val(variables.objPost.getPost_downvotes_ct())#</span>
										</button>
									</div> --->
									<div class="btn-group" role="group" aria-label="">
										<button type="button" class="btn btn-warning btn-xs" style="margin-left: 25px; " title="Edit Feedback/Suggestion" onClick="location.href='#event.buildLink(linkTo = 'site_feedback_and_suggestions.edit.#variables.objPost.getPost_id()#', ssl = true)#'; ">
											<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
										</button>
										<button type="button" class="btn btn-danger btn-xs" title="Delete Feedback/Suggestion" onClick="postRemove(#variables.objPost.getPost_id()#)">
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
			</cfif>
		</div>
	</div>
</cfoutput>