<cfoutput>

	<div class="row_spacer"></div>

	<div class="row">
		<cfloop list="News,Blog" index="variables.strPostType">
			<div class="col-sm-6">
				<h3 style="text-align: center; ">
					<a href="#event.buildLink('#lCase(variables.strPostType)#.index')#">#variables.strPostType#</a>
				</h3>
				<cfinclude template="posts.cfm"/>
			</div>
		</cfloop>
	</div>

	<!--- <div class="row_spacer"></div> --->
</cfoutput>

<hr/>
<div class="row">
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a href="https://twitter.com/opusgroupllc" target="_blank">Twitter</a>
		</h3>
		<cfinclude template="twitter.cfm"/>
	</div>
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a href="https://www.linkedin.com/company/opus-group-llc" target="_blank">LinkedIn</a>
		</h3>
		<cfinclude template="linkedin.cfm"/>
	</div>
	<div class="col-sm-4">
		<h3 style="text-align: center; ">
			<a id="google_calendar_link" href="##" target="_blank">Upcoming Events</a>
		</h3>
		<cfinclude template="google_calendar.cfm"/>
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