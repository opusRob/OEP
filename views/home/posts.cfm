<cfoutput>
	<div class="<!--- col-lg-8 ---> <!--- col-lg-offset-0  ---><!--- col-md-10 ---> <!--- col-md-offset-0 --->">
		<cfset variables.intRowCount = 0/>
		<cfif NOT arrayLen(request['ary' & variables.strPostType])>
			<span style="font-size: 18px; ">No #variables.strPostType# entries found.</span>
		<cfelse>
			<cfloop array="#request['ary' & variables.strPostType]#" index="variables.objPost">
				<cfset variables.intRowCount++/>
				<div class="post-preview">
					<a href="#event.buildLink(linkTo = lCase(variables.strPostType) & '.item.#variables.objPost.getPost_id()#', ssl = true)#">
						<h2 class="post-title">
							#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
						</h2>
						<div>
							<cfif
								len(trim(variables.objPost.getPost_small_image_file_name_tx()))
								AND fileExists(expandPath(application.stcApplicationCustomSettings["strUploaded#variables.strPostType#ImagesFolderLocation"] & variables.objPost.getPost_small_image_file_name_tx()))
								AND isImageFile(expandPath(application.stcApplicationCustomSettings["strUploaded#variables.strPostType#ImagesFolderLocation"] & variables.objPost.getPost_small_image_file_name_tx()))
							>
								<img
									class="visible-lg-inline visible-md-inline"
									src="#application.stcApplicationCustomSettings['strUploaded#variables.strPostType#ImagesFolderLocation'] & variables.objPost.getPost_small_image_file_name_tx()#"
									alt="#variables.objPost.getPost_headline_tx()# Image"
									style="width: 75px; height: 75px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
								/>
								<img
									class="visible-sm-inline <!--- visible-xs-inline --->"
									src="#application.stcApplicationCustomSettings['strUploaded#variables.strPostType#ImagesFolderLocation'] & variables.objPost.getPost_small_image_file_name_tx()#"
									alt="#variables.objPost.getPost_headline_tx()# Image"
									style="width: 50px; height: 50px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
								/>
							</cfif>
							<h3 class="post-subtitle" style="font-weight: 300; ">
								<!--- #len(trim(variables.objPost.getPost_preview_tx())) ? variables.objPost.getPost_preview_tx() : "&nbsp;"# --->
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
					</p>
				</div>
				<cfif variables.intRowCount LT arrayLen(request['ary' & variables.strPostType])>
					<hr/>
				</cfif>
			</cfloop>
		</cfif>
	</div>
</cfoutput>