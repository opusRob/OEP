<cfoutput>

	<div class="row_spacer"></div>

	<div class="row">
		<cfloop list="News,Blog" index="variables.strPostType">
			<div class="col-sm-6">
				<div class="<!--- col-lg-8 ---> col-lg-offset-2 <!--- col-md-10 ---> col-md-offset-1">
					<cfset variables.intRowCount = 0/>
					<cfloop array="#request['ary' & variables.strPostType]#" index="variables.objPost">
						<cfset variables.intRowCount++/>
						<div class="post-preview">
							<a href="#event.buildLink('blog.item.#variables.objPost.getPost_id()#')#">
								<h2 class="post-title">
									#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
								</h2>
								<h3 class="post-subtitle">
									#len(trim(variables.objPost.getPost_preview_tx())) ? variables.objPost.getPost_preview_tx() : "&nbsp;"#
								</h3>
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
				</div>
			</div>
		</cfloop>

		<!--- <cfloop list="News,Blog" index="variables.strPostType">
			<div class="col-sm-6">
				<div class="panel panel-default">
					<div class="panel-heading" style="height: 45px; ">
						<h3 class="panel-title" style="float: left; ">
							<a href="#event.buildLink(lCase(variables.strPostType) & '.index')#">#variables.strPostType#</a>
						</h3>
					</div>

					<table class="table page_section table-hover">
						<cfloop array="#request['ary' & variables.strPostType]#" index="variables.obj#variables.strPostType#">
							<tr>
								<td style="width: 80px; ">
									<cfif isDate(variables["obj" & variables.strPostType].getPost_update_create_datetime_dt())>
										#dateFormat(variables["obj" & variables.strPostType].getPost_update_create_datetime_dt(), "mm/dd/yyyy")#
										<br/>
										#timeFormat(variables["obj" & variables.strPostType].getPost_update_create_datetime_dt(), "h:mm TT")#
									<cfelse>
										&nbsp;
									</cfif>
								</td>
								<td>
									<a href="#event.buildLink(variables.strPostType & '.item.' & variables["obj" & variables.strPostType].getPost_id())#" class="panel_link">
										<strong>#variables["obj" & variables.strPostType].getPost_headline_tx()#</strong>
										<div class="td_content">
											#variables["obj" & variables.strPostType].getPost_preview_tx()#
										</div>
									</a>
								</td>
							</tr>
						</cfloop>
					</table>
				</div>
			</div>
		</cfloop> --->
	</div>

	<div class="row_spacer"></div>
</cfoutput>


<cfoutput>
	<cfloop list="4:3:5" index="variables.r">
		<div class="row">
			<cfloop list="Twitter:Tweet,LinkedIn:Post,Opus Google Calendar:Event" index="variables.i">
				<div class="col-sm-4">
					<div class="panel panel-default">
						<div class="panel-heading" style="height: 45px; ">
							<h3 class="panel-title" style="float: left; ">
								<a href="##">#listFirst(variables.i, ":")#</a>
							</h3>
						</div>

						<table class="table page_section table-hover">
							<cfloop from="1" to ="5" index="variables.j">
								<tr>
									<td>
										#dateFormat(now(), "mm/dd/yyyy")#
										<br/>
										#timeFormat(now(), "h:mm TT")#
									</td>
									<td>
										<a href="javascript: void(0); " class="panel_link">
											<strong>#listLast(variables.i, ":")# #variables.j#</strong>
											<div class="td_content">
												Blah blah blah blah blah blah blah blah blah blah. Ooga booga!! Blah.
											</div>
										</a>
									</td>
								</tr>
							</cfloop>
						</table>
					</div>
				</div>
			</cfloop>
		</div>
	</cfloop>

	<div class="row_spacer"></div>

	<div class="row">
		<div class="col-sm-12">
			<div class="panel panel-default">
				<div class="panel-heading" style="height: 45px; ">
					<h3 class="panel-title" style="float: left; ">
						<a href="#event.buildLink('links.index')#">Links</a>
					</h3>
				</div>
				<div class="panel-body">
					<cfloop array="#request.aryLinks#" index="variables.objLink">
						<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2" style="margin-bottom: 15px; ">
							<a href="#variables.objLink.getLink_URL_tx()#" target="_blank" style="float: left; margin: 0px 10px 5px 0px; ">
								<cfif
									len(trim(variables.objLink.getLink_image_file_name_tx()))
									AND fileExists(expandPath(variables.objLink.getImageSrcAttr()))
									AND isImageFile(expandPath(variables.objLink.getImageSrcAttr()))
								>
									<img
										src="#variables.objLink.getImageSrcAttr()#"
										alt="#variables.objLink.getLink_name_tx()# Link Icon Image"
										style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; margin-right: 5px; "
										align="middle"
									/>
								<cfelse>
									<img
										src="#application.stcApplicationCustomSettings.strUploadedLinkImagesFolderLocation#_no_link_image_available.png"
										alt="#variables.objLink.getLink_name_tx()# Link Icon Image Placeholder"
										style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; margin-right: 5px; "
									/>
								</cfif>
								<span style="float: left; max-width: 64px; ">#variables.objLink.getLink_name_tx()#</span>
							</a>
						</div>
					</cfloop>
				</div>
			</div>
		</div>
	</div>

</cfoutput>