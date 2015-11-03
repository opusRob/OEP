﻿<cfoutput>#html.doctype()#<html lang="en"><head>	<meta charset="utf-8">	<title>Opus Group, LLC Employee Portal</title>	<meta name="description" content="ColdBox Application Template">    <meta name="author" content="Ortus Solutions, Corp">    <meta name="google-signin-client_id" content="449742839884-i34v6l8na4rg1qhim6glsg4q3c5sta22.apps.googleusercontent.com">    <meta name="google-signin-cookie_policy" content="single_host_origin">    <!--- <meta name="google-signin-callback" content="signinCallback"> --->	<!---Base URL --->	<base href="#getSetting("HTMLBaseURL")#" />	<!---css --->	<link href="includes/css/bootstrap.min.css" rel="stylesheet"/>	<link href="includes/css/sticky-footer.css" rel="stylesheet"/>	<link href="includes/css/custom.css" rel="stylesheet"/>	<!---js --->    <script src="includes/js/jquery.js"></script>	<script src="includes/js/bootstrap.min.js"></script>	<script src="includes/ckeditor/ckeditor.js"></script>	<script src="https://apis.google.com/js/platform.js"></script>	<script src="includes/js/user_authentication.js"></script>	<!--- Page-specific JS and CSS files: --->	<cfif request.cb_requestContext.getCurrentHandler() IS "user">		<link href="/includes/css/user.css" rel="stylesheet" type="text/css"/>		<cfif request.cb_requestContext.getCurrentAction() IS "index">			<script src="/includes/js/users.js"></script>		</cfif>	<cfelseif listFindNoCase("news,blog", request.cb_requestContext.getCurrentHandler())>		<cfif request.cb_requestContext.getCurrentAction() IS "index">			<link href="/includes/css/posts.css" rel="stylesheet" type="text/css"/>			<script src="/includes/js/posts.js"></script>		<cfelseif listFindNoCase("add,edit", request.cb_requestContext.getCurrentAction())>			<link href="/includes/css/post.css" rel="stylesheet" type="text/css"/>			<script src="/includes/js/post.js"></script>		<cfelseif listFindNoCase("item", request.cb_requestContext.getCurrentAction())>			<link href="/includes/css/post.css" rel="stylesheet" type="text/css"/>		</cfif>	</cfif></head><body data-spy="scroll">	<!---Top NavBar --->	<cfinclude template="header.cfm"/>	<cfinclude template="navbar.cfm"/>	<!---Container And Views --->	<div class="container">#renderView()#</div>	<cfinclude template="footer.cfm"/></body></html></cfoutput>