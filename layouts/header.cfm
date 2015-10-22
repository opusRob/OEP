<header class="header">
	<cfif listFindNoCase("home,login", request.cb_requestContext.getCurrentHandler())>
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<img alt="Opus Group LLC logo" width="500" src="../includes/images/opus_logo.PNG" class="visible-lg-inline"/>
				<img alt="Opus Group LLC logo" width="400" src="../includes/images/opus_logo.PNG" class="visible-md-inline"/>
				<img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-sm-inline"/>
				<img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="visible-xs-inline"/>

				<cfif request.cb_requestContext.getCurrentHandler() IS "home">
					<h1 style="font-size: 40px; ">Welcome to the Opus Employee Portal!</h1>
					<p style="font-size: 14px; ">Your source for company news, messages from management, social media, resources and more.</p>

				<cfelseif request.cb_requestContext.getCurrentHandler() IS "login">

			</div>
		</div>
		<div class="jumbotron" style="background: #ffffff; color: #021139; margin-top: 0px; ">
			<div class="container" style="text-align: center; ">
					<h2 style="font-size: 40px; ">Log In</h2>
					<p style="font-size: 14px; ">Use your Opus Group Google credentials to log in.</p>
					<!--- <div class="g-signin2" data-onsuccess="onSignIn" align="center"></div> --->
					<div id="google_signin" align="center"></div>
				</cfif>

			</div>
		</div>
	<cfelse>
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<h2 class="visible-lg-inline visible-md-inline visible-sm-inline" style="display: inline; float: left; margin: 0px; ">Users</h2>
				<h2 class="visible-xs-inline" style="display: inline; float: left; margin: 0px; font-size: large; ">Users</h2>
				<img alt="Opus Group LLC logo" width="300" src="../includes/images/opus_logo.PNG" class="visible-lg-inline visible-md-inline visible-sm-inline" style="float: right; "/>
				<!--- <img alt="Opus Group LLC logo" width="200" src="../includes/images/opus_logo.PNG" class="" style="float: right; "/> --->
				<img alt="Opus Group LLC logo" width="150" src="../includes/images/opus_logo.PNG" class="visible-xs-inline" style="float: right; "/>
			</div>
		</div>
	</cfif>
</header>
