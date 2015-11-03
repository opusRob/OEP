<!--- All methods in this helper will be available in all handlers,views & layouts --->

<cffunction name="renderPaginator" returnType="string">
	<cfargument name="total_records" type="numeric" required="true"/>
	<cfargument name="page" type="numeric" default="1"/>
	<cfargument name="records_per_page" type="numeric" default="10"/>
	<cfargument name="number_of_page_buttons" type="numeric" default="5"/>

	<cfif arguments.number_of_page_buttons LT 1>
		<cfset arguments.number_of_page_buttons = 1/>
	</cfif>
	<cfset local.total_pages = ceiling(arguments.total_records / arguments.records_per_page)/>
	<cfset local.records_on_last_page = arguments.total_records - (
		(local.total_pages - 1) * arguments.records_per_page
	)/>
	<cfif arguments.page LT 1>
		<cfset arguments.page = 1/>
	<cfelseif arguments.page GT local.total_pages>
		<cfset arguments.page = local.total_pages/>
	</cfif>
	<cfset local.start_page = max(1, arguments.page)/>
	<cfset local.end_page = min(
		local.start_page + (arguments.number_of_page_buttons - 1)
		, local.total_pages
	)/>

	<cfsavecontent variable="local.strContent">
		<cfoutput>
			<nav>
				<ul class="pagination">
					<cfset local.strURL = addUpdateURLParams(
						strBaseURL = (cgi.https IS "on" ? "https" : "http")
							& "://"
							& cgi.server_name
							& cgi.script_name
							& cgi.path_info
						, strQueryString = cgi.query_string
						, aryParamsToAddUpdate = [
							{
								strParam = "page"
								, strValue = 1
							}
						]
					)/>
					<li>
						<a href="#local.strURL#" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span>
						</a>
					</li>
					<cfloop from="#local.start_page#" to="#local.end_page#" index="local.i">
						<cfset local.strURL = addUpdateURLParams(
							strBaseURL = (cgi.https IS "on" ? "https" : "http")
								& "://"
								& cgi.server_name
								& cgi.script_name
								& cgi.path_info
							, strQueryString = cgi.query_string
							, aryParamsToAddUpdate = [
								{
									strParam = "page"
									, strValue = local.i
								}
							]
						)/>
						<li><a href="#local.strURL#">#local.i#</a></li>
					</cfloop>
					<cfset local.strURL = addUpdateURLParams(
						strBaseURL = (cgi.https IS "on" ? "https" : "http")
							& "://"
							& cgi.server_name
							& cgi.script_name
							& cgi.path_info
						, strQueryString = cgi.query_string
						, aryParamsToAddUpdate = [
							{
								strParam = "page"
								, strValue = local.total_pages
							}
						]
					)/>
					<li>
						<a href="#local.strURL#" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
						</a>
					</li>
				</ul>
			</nav>
		</cfoutput>
	</cfsavecontent>

	<cfreturn local.strContent/>

</cffunction>

<cffunction name="addUpdateURLParams" returnType="string">
	<cfargument name="strBaseURL" type="string" required="true"/>
	<cfargument name="strQueryString" type="string" required="true"/>
	<cfargument name="aryParamsToAddUpdate" type="array" required="true"/>

	<cfset local.aryURLParams = arrayNew(1)/>
	<cfset local.strReturnURL = arguments.strBaseURL & "?"/>
	<cfloop list="#arguments.strQueryString#" index="local.i" delimiters="&">
		<cfset arrayAppend(
			local.aryURLParams
			, {
				strParam = listFirst(local.i, "=")
				, strValue = listDeleteAt(local.i, 1, "=")
			}
		)/>
		<cfloop array="#arguments.aryParamsToAddUpdate#" index="local.j">
			<cfif local.j.strParam EQ local.aryURLParams[arrayLen(local.aryURLParams)].strParam>
				<cfset local.aryURLParams[arrayLen(local.aryURLParams)].strValue = local.j.strValue/>
				<cfbreak/>
			</cfif>
		</cfloop>
	</cfloop>

	<cfloop array="#arguments.aryParamsToAddUpdate#" index="local.i">
		<cfset local.bolNewParam = true/>
		<cfloop array="#local.aryURLParams#" index="local.j">
			<cfif local.j.strParam EQ local.i.strParam>
				<cfset local.bolNewParam = false/>
				<cfbreak/>
			</cfif>
		</cfloop>
		<cfif local.bolNewParam>
			<cfset arrayAppend(
				local.aryURLParams
				, {
					strParam = local.i.strParam
					, strValue = local.i.strValue
				}
			)/>
		</cfif>
	</cfloop>


		<cfset local.strReturnURL
			&= "&" & local.aryURLParams[arrayLen(local.aryURLParams)].strParam
			& "=" & local.aryURLParams[arrayLen(local.aryURLParams)].strValue
		/>


	<cfreturn local.strReturnURL/>

</cffunction>