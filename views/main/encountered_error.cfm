
<div class="alert alert-danger" role="alert" style="margin-top: 25px; ">
	The application has encountered an error.
</div>

<cfif application.stcApplicationCustomSettings.bolShowErrorInfo>
	<cfif structKeyExists(request, "exception")>
		<cfdump var="#request.exception#" label="request.exception"/>
	<cfelse>
		No exception information was available.
	</cfif>
</cfif>