// function handleAuthClick(event) {
	// gapi.auth.authorize(
		// {
			// client_id: clientId 
			// , scope: scopes
			// , immediate: false 
			// , cookie_policy: 'single_host_origin'
		// }
		// , handleAuthResult
	// );
	// return false;
// }

$(document).ready(
	function() {
		gapi.signin2.render(
			"google_signin"
			, {
				"scope": "email"
				, "width": 250
				, "height": 50
				, "longtitle": true
				, "theme": "dark"
				, "onsuccess": onSignIn
				, "onfailure": onFailure
			}
		);
	}
);

function onSignIn(googleUser) {
	$("#id_token").val(googleUser.getAuthResponse().id_token);
	$("#access_token").val(googleUser.getAuthResponse().access_token);
	$("#user_google_username_tx").val(googleUser.getBasicProfile().getEmail().split("@")[0]);
	
	//$("#btn_login").prop("disabled", false);
	
	$("#auth_form").submit();
	$("#btn_login").prop("disabled", true);
	
	
	
	
	
	// var profile = googleUser.getBasicProfile();
	// console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	// console.log('Name: ' + profile.getName());
	// console.log('Image URL: ' + profile.getImageUrl());
	// console.log('Email: ' + profile.getEmail());
}

function onFailure() {
	//console.log("Google sign-in failure.");
	$("#btn_login").prop("disabled", true);
}

function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	//auth2.signOut();
	auth2.signOut().then(
		function () {
			console.log('User signed out.');
			location.reload(); 
		}
	);
}
