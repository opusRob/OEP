/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
*/
component{
	// Application properties
	this.name = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.loginStorage = "Session";
	this.setClientCookies = true;

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE 	 = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY 		 = "";
	// JAVA INTEGRATION: JUST DROP JARS IN THE LIB FOLDER
	// You can add more paths or change the reload flag as well.
	this.javaSettings = { loadPaths = [ "lib" ], reloadOnChange = false };

	/*-- ORM extensions for ColdBox: --*/
	this.mappings[ "/cborm" ] = COLDBOX_APP_ROOT_PATH & "modules/cborm";

	/*-- Enable ORM: --*/
	this.ormEnabled = true;
	/*-- ORM datasource: --*/
	this.dataSource = "OEP";
	/*-- ORM config settings: --*/
	this.ormSettings = {
		/*-- Location of your entities (default is your convention "model" folder): --*/
		cfcLocation = "models"
		/*-- Choose if you want ORM to create the db for you or not: --*/
		, dbCreate = (
			isDefined("url.dbinit") AND listFindNoCase("update,dropCreate,none", url.dbinit) ? url.dbinit : "none"
		)
		/*-- Log SQL or not: --*/
		, logSQL = true
		/*-- Don't flush at end of requests, let Active Entity manage it for you: --*/
		, flushAtRequestEnd = false
		/*-- Don't manage session, let Active Entity manage it for you: --*/
		, autoManageSession = true
		/*-- Active ORM events: --*/
		, eventHandling = true
		/*-- Use the Coldbox Wirebox handler for events: --*/
		//, eventHandler = "coldbox.system.orm.hibernate.WBEventHandler"
		, eventHandler = "cborm.models.EventHandler"
		/*-- Additional: --*/
		//, useDBForMapping = false
		//, dialect = "PostgreSQL"
		//, catalog = ""
		//, schema = "public"
	};

	// application start
	public boolean function onApplicationStart(){
		application.cbBootstrap = new coldbox.system.Bootstrap( COLDBOX_CONFIG_FILE, COLDBOX_APP_ROOT_PATH, COLDBOX_APP_KEY, COLDBOX_APP_MAPPING );
		application.cbBootstrap.loadColdbox();

		if (fileExists(expandPath(COLDBOX_APP_ROOT_PATH & "applicationCustomSettings.json"))) {
			application.stcApplicationCustomSettings = deserializeJSON(fileRead(expandPath(COLDBOX_APP_ROOT_PATH & "applicationCustomSettings.json")));
			structAppend(
				application.stcApplicationCustomSettings
				, deserializeJSON(fileRead(expandPath(application.stcApplicationCustomSettings.strInitialAppDataFolderLocation & "additionalApplicationCustomSettings.json")))
			);
		} else {
			application.stcApplicationCustomSettings = structNew();
		}
		return true;
	}

	// request start
	public boolean function onRequestStart(String targetPage){
		// Process ColdBox Request
		createObject("component", "handlers.AuthenticationUtilities").header(
			stcAttributes = {
				name = "Expires"
				, value = GetHttpTimeString(Now())
			}
		);
		createObject("component", "handlers.AuthenticationUtilities").header(
			stcAttributes = {
				name = "pragma"
				, value = "no-cache"
			}
		);
		createObject("component", "handlers.AuthenticationUtilities").header(
			stcAttributes = {
				name = "cache-control"
				, value = "no-cache, no-store, must-revalidate"
			}
		);

		param name="session.bolUserIsLoggedIn" default = false;
		param name="session.bolUserIsAdmin" default = false;

		application.cbBootstrap.onRequestStart( arguments.targetPage );


		/*-- BEGIN UPDATE OR DROP AND CREATE DATABASE OBJECTS: --*/
		/*-- NOTE: If you are not deploying database changes, THIS CODE SHOULD BE COMMENTED OUT!!!! --*/
		/* if (structKeyExists(url, "dbinit")) {
			writeOutput("<h2>Prepare to ormReload()...</h2>");
			ormReload();
			writeOutput("<h2>...ormReload() done.</h2>");
			if (url.dbinit IS "dropCreate" AND structKeyExists(application.stcApplicationCustomSettings, "strInitialAppDataFolderLocation")) {
				writeOutput("<h2>Prepare to create initial data...</h1>");
				createObject("component", "config.CreateInitialData").createInitialData(
					application.stcApplicationCustomSettings.strInitialAppDataFolderLocation
				);
				writeOutput("<h2>...initial data created.</h2>");
			}
		} */
		/*-- / END UPDATE OR DROP AND CREATE DATABASE OBJECTS. --*/

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ){
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection=arguments );
	}

	public boolean function onMissingTemplate( template ){
		return application.cbBootstrap.onMissingTemplate( argumentCollection=arguments );
	}

}