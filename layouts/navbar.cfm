<nav class="navbar navbar-inverse navbar-fixed-bottom">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Opus Group, LLC</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  <cfoutput>
	      <ul class="nav navbar-nav">
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'home' ? 'active' : ''#"><a href="#event.buildLink('home.index')#">Home</a></li>
	      </ul>
	      <ul class="nav navbar-nav navbar-right">
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'news' ? 'active' : ''#"><a href="#event.buildLink('news.index')#">News</a></li>
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'blog' ? 'active' : ''#"><a href="#event.buildLink('blog.index')#">Blog</a></li>
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'link' ? 'active' : ''#"><a href="#event.buildLink('link.index')#">Links</a></li>
	        <li class="#request.cb_requestContext.getCurrentHandler() EQ 'user' ? 'active' : ''#"><a href="#event.buildLink('user.index')#">Users</a></li>
			<cfif request.bolAdminMode>
	        	<li><a href="##">Users</a></li>
			</cfif>
	        <li class="dropdown">
	          <a href="##" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">eddard.stark@opusgroupllc.com <span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="javascript: signOut(); void(0); ">Sign Out</a></li>
	          </ul>
	        </li>
	      </ul>
	  </cfoutput>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>