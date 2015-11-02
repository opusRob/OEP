<cfcomponent extends="user">
	<cffunction name="removeUser" returnType="boolean">
		<cfargument name="user_id" type="numeric" required="true"/>

		<cftry>
			<cfquery name="local.qryDelete">
				DELETE
				FROM users
				WHERE user_id = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_bigint"/>
			</cfquery>

			<cfreturn true>
			<cfcatch>
				<cfreturn false/>
			</cfcatch>

		</cftry>

	</cffunction>

</cfcomponent>