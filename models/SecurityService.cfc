<cfcomponent accessors="false" output="false" persistent="false">

	<!--- Security Service --->
	<cfproperty name="securityService" inject="id:SecurityService"/>

	<cffunction name="configure" returnType="void">
		<cfscript>
			if( !propertyExists("enabled") ){
				setProperty("enabled", true );
			}
		</cfscript>
	</cffunction>

	<cffunction name="preProcess" returnType="void">
		<cfargument name="event"/>
		<cfargument name="struct"/>
		<cfargument name="interceptData"/>
		<cfargument name="buffer"/>

		<cfscript>
			// verify turned on
			if( !getProperty("enabled") ){ return; }

			// Verify Incoming Headers to see if we are authorizing already or we are already Authorized
			if( !securityService.isLoggedIn() OR len( event.getHTTPHeader("Authorization","") ) ){

				// Verify incoming authorization
				var credentials = event.getHTTPBasicCredentials();
				if( securityService.authorize(credentials.username, credentials.password) ){
					// we are secured woot woot!
					return;
				};

				// Not secure!
				event.setHTTPHeader(name="WWW-Authenticate",value="basic realm=""Please enter your username and password for our Cool App!""");

				// secured content data and skip event execution
				event.renderData(data="<h1>Unathorized Access<p>Content Requires Authentication</p>",statusCode="401",statusText="Unauthorized")
					.noExecution();
			}
		</cfscript>
	</cffunction>


	<---  User Validator for security --->
	<cffunction name="userValidator" access="public" returntype="boolean" output="false" hint="Verifies that the user is in any permission">
		<---************************************************************** --->
		<cfargument name="rule" 	required="true" type="struct"   hint="The rule to verify">
		<cfargument name="messagebox" type="any" required="true" hint="The ColdBox messagebox plugin. You can use to set a redirection message"/>
		<cfargument name="controller" type="any" required="true" hint="The coldbox controller" />
		<---************************************************************** --->
		<---  Local call to get the user object from the session --->
		<cfset local.oUser = getUserSession()>
		<---  The results boolean variable I will return --->
		<cfset local.results = false>
		<---  The permission I am checkin --->
		<cfset local.thisPermission = "">

		<---  Authorized Check, if true, then see if user is valid. This column is an additional column in my query --->
		<cfif arguments.rule['authorize_check'] and local.oUser.getisAuthorized()>
			<---  I first check if the user is authorized or not if set in the db rules --->
			<cfset local.results = true>
		</cfif>

		<---  Loop Over Permissions to see if my user is in any of them. --->
		<cfloop list="#arguments.rule['permissions']#" index="local.thisPermission">

			<---  My user object has a method called check permission that I call with a permission to validate --->
			<cfif local.oUser.checkPermission( local.thisPermission ) >
				<---  This permission existed, I only need one to match as per my business logic, so let's return and move on --->
				<cfset local.results = true>
				<cfbreak>
			</cfif>
		</cfloop>

		<---  Messagebox will be set with a custom message --->
		<cfif not local.results>
			<cfset arguments.messagebox.setMessage("warning","You are not authorized to view this page.")>
		</cfif>

		<---  I now return whether the user can view the incoming rule or not --->
		<cfreturn local.results>
	</cffunction>

</cfcomponent>