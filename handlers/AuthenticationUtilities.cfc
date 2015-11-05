<cfcomponent extends="user">

	<cffunction name="makeHTTPCall" returnType="struct">
		<cfargument name="stcAttributes" type="struct" required="true"/>
		<cfargument name="aryParams" type="array" default="#arrayNew(1)#"/>

		<cfhttp attributeCollection="#arguments.stcAttributes#" result="local.stcHTTPResult">
			<cfloop array="#arguments.aryParams#" index="local.stcParam">
				<cfhttpparam attributeCollection="#local.stcParam#"/>
			</cfloop>
		</cfhttp>

		<cfreturn local.stcHTTPResult/>

	</cffunction>

</cfcomponent>