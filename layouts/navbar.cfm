<nav class="navbar navbar-inverse navbar-fixed-top" style="background: #021139; color: #ffffff; ">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">
		<!--- Opus Group, LLC --->
		<img src="/includes/images/opus_logo_medium.png"/>
	  </a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  <cfoutput>
		<cfif isUserLoggedIn()>
	      <ul class="nav navbar-nav">
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'home' ? 'active' : ''#"><a href="#event.buildLink('home.index')#">Home</a></li>
	      </ul>
	    </cfif>
	      <ul class="nav navbar-nav navbar-right">
			<cfif isUserLoggedIn()>
		        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'news' ? 'active' : ''#"><a href="#event.buildLink('news.index')#">News</a></li>
		        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'blog' ? 'active' : ''#"><a href="#event.buildLink('blog.index')#">Blog</a></li>
		        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'link' ? 'active' : ''#"><a href="#event.buildLink('link.index')#">Links</a></li>
		        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'site_feedback_and_suggestions' ? 'active' : ''#"><a href="#event.buildLink('site_feedback_and_suggestions.index')#">Site Feedback and Suggestions</a></li>
				<cfif isUserInRole("administrator")>
		        	<li class="#request.cb_requestContext.getCurrentHandler() EQ 'user' ? 'active' : ''#"><a href="#event.buildLink('user.index')#">Users</a></li>
				</cfif>
		        <li class="dropdown">
		          <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">#session.stcUserProperties.stcGoogleUserProperties.email#<span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="#event.buildLink('login.sign_out')#">Sign Out</a></li>
		          </ul>
		        </li>
		    <cfelse>
		    	<li class="#request.cb_requestContext.getCurrentHandler() EQ 'login' ? 'active' : ''#"><a href="#event.buildLink('login.index')#">Log In</a></li>
		    </cfif>
	      </ul>
	  </cfoutput>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>