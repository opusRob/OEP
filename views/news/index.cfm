<cfoutput>

	<form name="post_form" id="post_form" action="#event.buildLink(linkTo = 'news.remove', ssl = true)#" method="post">
		<input type="hidden" name="post_id" id="post_id" value="0"/>
	</form>

	<div class="row">
		<div class="<!--- col-lg-8 ---> <!--- col-lg-offset-1 ---> <!--- col-md-10  ---><!--- col-md-offset-1 --->" style="padding-left: 20px; ">
			<cfif NOT arrayLen(request.aryPosts)>
				<span style="font-size: 18px; ">No news entries found.</span>
			<cfelse>
				<cfset variables.intRowCount = 0/>
				<cfloop array="#request.aryPosts#" index="variables.objPost">
					<cfset variables.intRowCount++/>
					<div class="post-preview">
						<a href="#event.buildLink(linkTo = 'news.item.#variables.objPost.getPost_id()#', ssl = true)#">
							<h2 class="post-title">
								#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
							</h2>
							<div>
								<cfif
									len(trim(variables.objPost.getPost_small_image_file_name_tx()))
									AND fileExists(expandPath(application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & variables.objPost.getPost_small_image_file_name_tx()))
									AND isImageFile(expandPath(application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & variables.objPost.getPost_small_image_file_name_tx()))
								>
									<img
										class="visible-lg-inline visible-md-inline"
										src="#application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & variables.objPost.getPost_small_image_file_name_tx()#"
										alt="#variables.objPost.getPost_headline_tx()# Image"
										style="width: 150px; height: 150px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
									/>
									<img
										class="visible-sm-inline <!--- visible-xs-inline --->"
										src="#application.stcApplicationCustomSettings.strUploadedNewsImagesFolderLocation & variables.objPost.getPost_small_image_file_name_tx()#"
										alt="#variables.objPost.getPost_headline_tx()# Image"
										style="width: 75px; height: 75px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
									/>
								</cfif>
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
									<button type="button" class="btn btn-warning btn-xs" onClick="location.href='#event.buildLink(linkTo = 'news.edit.#variables.objPost.getPost_id()#', ssl = true)#'; ">
										<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
									</button>
									<button type="button" class="btn btn-danger btn-xs" onClick="postRemove(#variables.objPost.getPost_id()#)">
										<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
									</button>
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