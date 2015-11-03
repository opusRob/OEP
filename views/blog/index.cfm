<br />
<cfoutput>
	<!--- <div class="paginator_div">
		#renderPaginator(
			total_records = request.intUserCount
			, page = url.page
		)#
	</div> --->
</cfoutput>
<table class="table table-striped table-hover table_background">
	<tr>
		<th>Headline</th>
		<th class="visible-lg">Preview</th>
		<th class="visible-md visible-lg">Last Updated</th>
		<th class="visible-lg">Created</th>
		<th style="text-align: right; ">
			<cfoutput>
				<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink('blog.add')#'; ">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
				</button>
			</cfoutput>
		</th>
	</tr>
	<cfoutput>
		<form method="post" name="post_form" id="post_form" action="#event.buildLink('blog.remove')#">
			<input type="hidden" name="post_id" id="post_id" value="" maxlength="50"/>
			<cfset variables.intRowCount = 0/>
			<cfloop array="#request.aryPosts#" index="variables.objPost">
				<cfset variables.intRowCount++/>
				<tr>
					<td>
						<a href="#event.buildLink('blog.item.#variables.objPost.getPost_id()#')#">
							#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
						</a>
					</td>
					<td class="visible-lg">
						<a href="#event.buildLink('blog.item.#variables.objPost.getPost_id()#')#">
							#len(trim(variables.objPost.getPost_preview_tx())) ? variables.objPost.getPost_preview_tx() : "&nbsp;"#
						</a>
					</td>
					<td class="visible-md visible-lg">#isDate(variables.objPost.getPost_update_datetime_dt()) ? dateTimeFormat(variables.objPost.getPost_update_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<td class="visible-lg">#isDate(variables.objPost.getPost_create_datetime_dt()) ? dateTimeFormat(variables.objPost.getPost_create_datetime_dt(), "mm/dd/yyyy hh:mm:ss TT") : "&nbsp;"#</td>
					<td style="text-align: right; ">
						<button type="button" class="btn btn-warning btn-xs" onClick="location.href='#event.buildLink('blog.edit.#variables.objPost.getPost_id()#')#'; ">
							<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
						</button>
						<button type="button" class="btn btn-danger btn-xs" onClick="postRemove(#variables.objPost.getPost_id()#)">
							<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
						</button>
					</td>
				</tr>
			</cfloop>
		</form>
	</cfoutput>
</table>


