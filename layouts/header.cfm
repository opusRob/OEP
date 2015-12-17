
<header class="header">
	<cfif listFindNoCase("home,login", request.cb_requestContext.getCurrentHandler())>
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<img alt="Opus Group LLC logo" width="500" src="../includes/images/opus_logo.PNG" class="visible-lg-inline"/>
				<img alt="Opus Group LLC logo" width="400" src="../includes/images/opus_logo.PNG" class="visible-md-inline"/>
				<img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-sm-inline"/>
				<img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="visible-xs-inline"/>

				<cfif request.cb_requestContext.getCurrentHandler() IS "home">
					<h1 class="visible-lg-block" style="font-size: xx-large; ">Welcome to the Opus Employee Portal!</h1>
					<h1 class="visible-md-block" style="font-size: x-large; ">Welcome to the Opus Employee Portal!</h1>
					<h1 class="visible-sm-block" style="font-size: large; ">Welcome to the Opus Employee Portal!</h1>
					<h1 class="visible-xs-block" style="font-size: medium; ">Welcome to the Opus Employee Portal!</h1>
					<p class="visible-lg-block visible-md-block" style="font-size: 14px; ">Your source for company news, messages from management, social media, resources and more.</p>

				<cfelseif request.cb_requestContext.getCurrentHandler() IS "login">

			</div>
		</div>
		<div class="jumbotron" style="background: #ffffff; color: #021139; margin-top: 0px; ">
			<div class="container" style="text-align: center; ">
					<cfif request.cb_requestContext.getCurrentAction() IS "sign_out">
						<div id="alert_signout_app" class="alert alert-success" role="alert">You have successfully signed out of the application.</div>
						<div id="alert_signout_google" class="" role="alert"></div>
						<cfoutput>
							<input type="button" name="btn_return_to_login" id="btn_return_to_login" value="Return to Login Page" class="btn btn-lg btn-primary" onClick="location.href='#event.buildLink(linkTo = linkTo = 'login.index', ssl = true, ssl = true)#'; "/>
						</cfoutput>
					<cfelseif request.cb_requestContext.getCurrentAction() IS "invalid_user">
						<div class="alert alert-danger" role="alert">Your user account doesn't exist or is invalid.</div>
						<cfoutput>
							<input type="button" name="btn_sign_out" id="btn_sign_out" value="Sign Out of Google Session" class="btn btn-lg btn-primary" onClick="location.href='#event.buildLink(linkTo = linkTo = 'login.sign_out', ssl = true, ssl = true)#'; "/>
						</cfoutput>
					<cfelse>
						<h2 style="font-size: 40px; ">Log In</h2>
						<p style="font-size: 14px; ">Authenticate using your Opus Group Google credentials.</p>
						<!--- <div class="g-signin2" data-onsuccess="onSignIn" align="center"></div> --->
						<div id="google_signin" align="center"></div>
						<cfoutput>
							<form name="auth_form" id="auth_form" method="post" action="#event.buildLink(linkTo = linkTo = 'login.authenticate', ssl = true, ssl = true)#">
								<input type="hidden" name="id_token" id="id_token" value=""/>
								<input type="hidden" name="access_token" id="access_token" value=""/>
								<input type="hidden" name="user_google_username_tx" id="user_google_username_tx" value=""/>
								<!--- <input type="submit" name="btn_login" id="btn_login" value="Log Into Application" class="btn btn-lg btn-info" disabled style="width: 250px; margin: 20px 0px 5px 0px; "/> --->
							</form>
						</cfoutput>
					</cfif>
				</cfif>

			</div>
		</div>
	<cfelseif request.cb_requestContext.getCurrentHandler() IS "user">
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h1
					class="visible-lg-inline visible-md-inline visible-sm-inline"
					style="display: inline; float: left; margin: 0px; font-size: 40px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Users: --->Add User
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Users: --->Edit User
					<cfelse>
						Users
					</cfif>
				</h1>
				<h1
					class="visible-xs-inline"
					style="display: inline; float: left; margin: 0px; font-size: 25px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Users: --->Add User
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Users: --->Edit User
					<cfelse>
						Users
					</cfif>
				</h1>
				<cfif isUserInRole("administrator") AND request.cb_requestContext.getCurrentAction() IS "index">
					<cfoutput>
						<button type="button" class="btn btn-success btn-xs" style="float: right; " onClick="location.href='#event.buildLink(linkTo = linkTo = 'user.add', ssl = true, ssl = true)#'; ">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</cfoutput>
				</cfif>
				<!--- <img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/> --->
			</div>
		</div>
	<cfelseif request.cb_requestContext.getCurrentHandler() IS "news">
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h1
					class="visible-lg-inline visible-md-inline visible-sm-inline"
					style="display: inline; float: left; margin: 0px; font-size: 40px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- News: --->Add News
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- News: --->Edit News
					<cfelse>
						News
					</cfif>
				</h1>
				<h1
					class="visible-xs-inline"
					style="display: inline; float: left; margin: 0px; font-size: 25px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- News: --->Add News
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- News: --->Edit News
					<cfelse>
						News
					</cfif>
				</h1>
				<cfif isUserInRole("administrator") AND request.cb_requestContext.getCurrentAction() IS "index">
					<cfoutput>
						<button type="button" class="btn btn-success btn-xs" style="float: right; " onClick="location.href='#event.buildLink(linkTo = 'news.add', ssl = true)#'; ">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</cfoutput>
				</cfif>
				<!--- <img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/> --->
			</div>
		</div>
	<cfelseif request.cb_requestContext.getCurrentHandler() IS "blog">
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h1
					class="visible-lg-inline visible-md-inline visible-sm-inline"
					style="display: inline; float: left; margin: 0px; font-size: 40px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Blog: --->Add Blog
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Blog: --->Edit Blog
					<cfelse>
						Blog
					</cfif>
				</h1>
				<h1
					class="visible-xs-inline"
					style="display: inline; float: left; margin: 0px; font-size: 25px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Blog: --->Add Blog
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Blog: --->Edit Blog
					<cfelse>
						Blog
					</cfif>
				</h1>
				<cfif isUserInRole("administrator") AND request.cb_requestContext.getCurrentAction() IS "index">
					<cfoutput>
						<button type="button" class="btn btn-success btn-xs" style="float: right; " onClick="location.href='#event.buildLink(linkTo = 'blog.add', ssl = true)#'; ">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</cfoutput>
				</cfif>
				<!--- <img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/> --->
			</div>
		</div>
	<cfelseif request.cb_requestContext.getCurrentHandler() IS "site_feedback_and_suggestions">
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h1
					class="visible-lg-inline visible-md-inline visible-sm-inline"
					style="display: inline; float: left; margin: 0px; font-size: 40px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Site Feedback and Suggestions: --->Add Site Feedback or Suggestion
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Site Feedback and Suggestions: --->Edit Site Feedback and Suggestion
					<cfelse>
						Site Feedback and Suggestions
					</cfif>
				</h1>
				<h1
					class="visible-xs-inline"
					style="display: inline; float: left; margin: 0px; font-size: 25px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Site Feedback and Suggestions: --->Add Site Feedback and Suggestion
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Site Feedback and Suggestions: --->Edit Site Feedback and Suggestion
					<cfelse>
						Site Feedback and Suggestions
					</cfif>
				</h1>
				<cfif isUserInRole("administrator") AND request.cb_requestContext.getCurrentAction() IS "index">
					<cfoutput>
						<button type="button" class="btn btn-success btn-xs" style="float: right; " onClick="location.href='#event.buildLink(linkTo = 'site_feedback_and_suggestions.add', ssl = true)#'; ">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</cfoutput>
				</cfif>
				<!--- <img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/> --->
			</div>
		</div>
	<cfelseif request.cb_requestContext.getCurrentHandler() IS "link">
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h1
					class="visible-lg-inline visible-md-inline visible-sm-inline"
					style="display: inline; float: left; margin: 0px; font-size: 40px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Link: --->Add Link
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Link: --->Edit Link
					<cfelse>
						Links
					</cfif>
				</h1>
				<h1
					class="visible-xs-inline"
					style="display: inline; float: left; margin: 0px; font-size: 25px; "
				>
					<cfif request.cb_requestContext.getCurrentAction() IS "add">
						<!--- Link: --->Add Link
					<cfelseif request.cb_requestContext.getCurrentAction() IS "edit">
						<!--- Link: --->Edit Link
					<cfelse>
						Links
					</cfif>
				</h1>
				<cfif isUserInRole("administrator") AND request.cb_requestContext.getCurrentAction() IS "index">
					<cfoutput>
						<button type="button" class="btn btn-success btn-xs" style="float: right; " onClick="location.href='#event.buildLink(linkTo = 'link.add', ssl = true)#'; ">
							<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
						</button>
					</cfoutput>
				</cfif>
				<!--- <img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/> --->
			</div>
		</div>
	</cfif>
</header>
