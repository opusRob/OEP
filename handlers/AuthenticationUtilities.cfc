<cfcomponent extends="user">

	<cffunction name="header" returnType="void">
		<cfargument name="stcAttributes" type="struct" required="true"/>
		<cfheader attributeCollection="#arguments.stcAttributes#"/>
	</cffunction>

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

	<cffunction name="login" returnType="void">
		<cfargument name="stcLoginAttributes" type="struct" required="true"/>
		<cfargument name="stcLoginUserAttributes" type="struct" default="#structNew()#"/>

		<cflogin attributeCollection="#arguments.stcLoginAttributes#">
			<cfif NOT structIsEmpty(arguments.stcLoginUserAttributes)>
				<cfloginuser attributeCollection="#arguments.stcLoginUserAttributes#"/>
			</cfif>
		</cflogin>

	</cffunction>

	<cffunction name="logout" returnType="void">
		<cfargument name="stcAttributes" type="struct" default="#structNew()#"/>

		<cflogout attributeCollection="#arguments.stcAttributes#"/>

	</cffunction>

	<cffunction name="getPagesAndRoles" returnType="query">
		<cfargument name="strHandler" type="string" default=""/>
		<cfargument name="strAction" type="string" default=""/>
		<cfargument name="strRequiresStandardUser" type="string" default=""/>
		<cfargument name="strRequiresAdministrator" type="string" default=""/>

		<!--- NOTE: This data will be moved to a database table eventually, or perhaps stored in an external JSON file. --->
		<cfset local.qryData = queryNew(
			"handler_tx,action_tx,requires_standard_user_bt,requires_administrator_bt"
			, "varchar,varchar,boolean,boolean"
		)/>
		<cfsavecontent variable="local.lstData">
			<!--- handler,action,standard_user_required,is_admin_user_required --->
			<cfoutput>
				main,index,false,false
				main,encountered_error,false,false
				login,index,false,false
				login,authenticate,false,false
				login,sign_out,false,false
				login,no_access,true,false
				login,no_such_resource,true,false
				home,index,true,false
				user,index,true,false
				user,add,true,true
				user,edit,true,true
				user,save,true,true
				user,remove,true,true
				news,index,true,false
				news,item,true,false
				news,add,true,true
				news,edit,true,true
				news,save,true,true
				news,remove,true,true
				blog,index,true,false
				blog,item,true,false
				blog,add,true,true
				blog,edit,true,true
				blog,save,true,true
				blog,remove,true,true
				site_feedback_and_suggestions,index,true,false
				site_feedback_and_suggestions,item,true,false
				site_feedback_and_suggestions,add,true,false
				site_feedback_and_suggestions,edit,true,false
				site_feedback_and_suggestions,save,true,false
				site_feedback_and_suggestions,remove,true,true
				link,index,true,false
				link,item,true,false
				link,add,true,true
				link,edit,true,true
				link,save,true,true
				link,remove,true,true
			</cfoutput>
		</cfsavecontent>
		<cfset local.lstData = trim(local.lstData)/>
		<cfloop list="#local.lstData#" delimiters="#chr(10)##chr(13)#" index="local.lstRow">
			<cfset local.lstRow = trim(local.lstRow)/>
			<cfset queryAddRow(local.qryData)/>
			<cfset querySetCell(local.qryData, "handler_tx", listGetAt(local.lstRow, 1))/>
			<cfset querySetCell(local.qryData, "action_tx", listGetAt(local.lstRow, 2))/>
			<cfset querySetCell(local.qryData, "requires_standard_user_bt", listGetAt(local.lstRow, 3))/>
			<cfset querySetCell(local.qryData, "requires_administrator_bt", listGetAt(local.lstRow, 4))/>
		</cfloop>

		<cfquery name="local.qryData" dbtype="query">
			SELECT *
			FROM local.qryData
			WHERE 1 = 1
				<cfif len(trim(arguments.strHandler))>
					AND handler_tx = <cfqueryparam value="#trim(arguments.strHandler)#" cfsqltype="cf_sql_varchar"/>
				</cfif>
				<cfif len(trim(arguments.strAction))>
					AND action_tx = <cfqueryparam value="#trim(arguments.strAction)#" cfsqltype="cf_sql_varchar"/>
				</cfif>
				<cfif len(trim(arguments.strRequiresStandardUser))>
					AND requires_standard_user_bt = <cfqueryparam value="#trim(arguments.strRequiresStandardUser)#" cfsqltype="cf_sql_bit"/>
				</cfif>
				<cfif len(trim(arguments.strRequiresAdministrator))>
					AND requires_administrator_bt = <cfqueryparam value="#trim(arguments.strRequiresAdministrator)#" cfsqltype="cf_sql_bit"/>
				</cfif>
		</cfquery>

		<cfreturn local.qryData/>
	</cffunction>

</cfcomponent>