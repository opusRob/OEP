<cfoutput>
	<cfloop list="6:1:2,4:3:5" index="variables.r">
		<cfif isDefined("variables.bolHR") AND variables.bolHR>
			<div class="row_spacer"></div>
		<cfelse>
			<div class="row_spacer"></div>
			<cfset variables.bolHR = true/>
		</cfif>
		<div class="row">
			<cfloop from="#listGetAt(variables.r, 2, ':')#" to="#listLast(variables.r, ':')#" index="variables.i">
				<div class="col-sm-#listFirst(variables.r, ':')#">
					<div class="panel panel-default">
						<div class="panel-heading" style="height: 45px; ">
							<h3 class="panel-title" style="float: left; ">
								<a href="##">Container #variables.i#</a>
							</h3>
						</div>

						<table class="table page_section table-hover">
							<cfloop from="1" to ="5" index="variables.j">
								<tr>
									<td>
										#dateFormat(now(), "mm/dd/yyyy")#
										<br/>
										#timeFormat(now(), "HH:mm TT")#
									</td>
									<td>
										<a href="javascript: void(0); " class="panel_link">
											<strong>Data Record #variables.j#</strong>
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
						<a href="##">Links</a>
					</h3>
				</div>
				<div class="panel-body">
					<cfloop from="1" to="10" index="variables.i">
						<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2" style="margin-bottom: 15px; ">
							<a href="##" style="float: left; margin: 0px 10px 5px 0px; ">
								<img src="..." alt="Link Icon Image" style="width: 64px; height: 64px; float: left; border: solid 1px ##cccccc; "/>
							<!--- </a>
							<a href="##" style="float: left; "> --->
							<span style="float: left; ">Link Title Text</span>
							</a>
						</div>
					</cfloop>
				</div>
			</div>
		</div>
	</div>

</cfoutput>