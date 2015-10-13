<header class="header">
	<cfif listFindNoCase("home,login", request.cb_requestContext.getCurrentHandler())>
		<div class="jumbotron" style="margin-bottom: 0px; ">
			<div class="container" style="text-align: center; ">
				<img alt="" width="550" src="../includes/images/opus_logo.PNG"/>

				<cfif request.cb_requestContext.getCurrentHandler() IS "home">
					<h1 style="font-size: 40px; ">Welcome to the Opus Employee Portal!</h1>
					<p style="font-size: 14px; ">Your source for company news, messages from management, social media, resources and more.</p>

				<cfelseif request.cb_requestContext.getCurrentHandler() IS "login">

			</div>
		</div>
		<div class="jumbotron" style="background: #eeeeee; color: #021139; margin-top: 0px; ">
			<div class="container" style="text-align: center; ">
					<h1 style="font-size: 40px; ">Log In</h1>
					<p style="font-size: 14px; ">Use your Opus Group Google credentials to log in.</p>
					<div class="g-signin2" data-onsuccess="onSignIn" align="center"></div>
				</cfif>

			</div>
		</div>
	</cfif>
</header>
