<cfoutput>

	<div class="row_spacer"></div>

	<div class="row">
		<cfloop list="News,Blog" index="variables.strPostType">
			<div class="col-sm-6">
				<h3 style="text-align: center; ">
					<a href="#event.buildLink('#lCase(variables.strPostType)#.index')#" class="header_link">#variables.strPostType#</a>
				</h3>
				<cfinclude template="posts.cfm"/>
				<div class="see_more_button_link_div">
					<a href="#event.buildLink('#lCase(variables.strPostType)#.index')#" class="see_more_button_link btn-sm btn-info" role="button">
						More #variables.strPostType# Entries
					</a>
				</div>
			</div>
		</cfloop>
	</div>

	<!--- <div class="row_spacer"></div> --->
</cfoutput>

<hr/>
<div class="row">
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a href="https://twitter.com/opusgroupllc" class="header_link" target="_blank">Twitter</a>
		</h3>
		<cfinclude template="twitter.cfm"/>
		<div class="see_more_button_link_div">
			<a href="https://twitter.com/opusgroupllc" class="see_more_button_link btn-sm btn-info" role="button">
				Opus Twitter Page
			</a>
		</div>
	</div>
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a href="https://www.linkedin.com/company/opus-group-llc" class="header_link" target="_blank">LinkedIn</a>
		</h3>
		<cfinclude template="linkedin.cfm"/>
		<div class="see_more_button_link_div">
			<a href="https://www.linkedin.com/company/opus-group-llc" class="see_more_button_link btn-sm btn-info" role="button">
				Opus LinkedIn Page
			</a>
		</div>
	</div>
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a id="google_calendar_link" href="##" class="header_link" target="_blank">Upcoming Events</a>
		</h3>
		<cfinclude template="google_calendar.cfm"/>
		<div class="see_more_button_link_div">
			<a id="google_calendar_link" href="##" class="see_more_button_link btn-sm btn-info" role="button">
				Opus Google Calendar
			</a>
		</div>
	</div>
</div>

<cfoutput>
	<!--- <div class="row_spacer"></div> --->

	<hr/>
	<div class="row">
		<div class="col-sm-12" style="<!--- text-align: center;  --->">
			<h3 class="<!--- panel-title --->" style="text-align: center; <!--- margin: 0px; padding: 0px;  ---><!--- float: left;  --->">
				<a href="#event.buildLink('links.index')#">Links</a>
			</h3>
			<cfinclude template="links.cfm"/>
		</div>
	</div>

</cfoutput>