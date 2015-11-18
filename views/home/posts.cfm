<cfoutput>
	<div class="<!--- col-lg-8 ---> <!--- col-lg-offset-0  ---><!--- col-md-10 ---> <!--- col-md-offset-0 --->">
		<cfset variables.intRowCount = 0/>
		<cfloop array="#request['ary' & variables.strPostType]#" index="variables.objPost">
			<cfset variables.intRowCount++/>
			<div class="post-preview">
				<a href="#event.buildLink('news.item.#variables.objPost.getPost_id()#')#">
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
</cfoutput>