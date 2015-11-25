// "Signing out of Google..."
// alert_signout_

/*-- Init the window object var that will hold the Google Sign-Out popup: --*/
var objGoogleSignoutWindow;

$(document).ready(
	function() {
		doSignOut();
	}
);

function checkPopupState(intMilliseconds) {
	/*-- Set a timeout: --*/
	setTimeout(
		function() {
			/*-- Since we can't actually check the status of the popup doc after it's initialized due to it being in another domain, 
				we use a try/catch.  If we're able to still get the popup doc's readyState, it's still initializing.  If trying to get
				the popup doc's readyState throws an error, that means it's loaded. --*/
			try {
				/*-- Attempt to check popup doc's readyState: --*/
				objGoogleSignoutWindow.document.readyState;
				// console.log(new Date());
				
				/*-- If the check of the popup doc's readyState didn't cause an error (which means it's still loading), continue: --*/
				
				/*-- If we've been checking/waiting for the popup to load for 30 seconds or less: --*/
				if (intMilliseconds <= 30000) {
					/*-- Call this very function again, having incremented the timer to check again in another quarter of a second: --*/ 
					checkPopupState(intMilliseconds + 250);
				/*-- If we've been checking/waiting for the popup to load for more than seconds: --*/
				} else {
					/*-- Indicate to the user that there was a proplem signing out of Google: --*/
					$("div#alert_signout_google")
						.removeClass("alert-info")
						.removeClass("alert-success")
						.addClass("alert-danger")
						.html("Could not sign out of Google.");
						
					/*-- Enable the "Return to Login Page" button: --*/
					$("input#btn_return_to_login").prop("disabled", false);
					
				}
			/*-- If an error was thrown while trying to check the popup doc's readyState, which means it's no longer initializing and
				and therefore is likely loaded: --*/
			} catch(e) {
				// console.log("asdf");
				/*-- Close the popup window: --*/
				objGoogleSignoutWindow.close();
				
				/*-- Indicate to the user that they have signed out of Google: --*/
				$("div#alert_signout_google")
					.removeClass("alert-info")
					.removeClass("alert-danger")
					.addClass("alert-success")
					.html("You have successfully signed out of Google.");
					
				/*-- Enable the "Return to Login Page" button: --*/
				$("input#btn_return_to_login").prop("disabled", false);
					
				/*-- Assign focus back to the popup window: --*/
				objGoogleSignoutWindow.focus();
			}
		}
		, intMilliseconds
	);
}

function doSignOut() {
	/*-- Temporarily disable the "Return to Login Page" button: --*/
	$("button#btn_return_to_login").prop("disabled", true);	
	
	/*-- Open a popup window to the Google sign-out URL: --*/
	objGoogleSignoutWindow = window.open(
		"https://mail.google.com/mail/u/0/?logout&hl=en"
		, "google_signout_window"
		, "width=600,height=600,top=100,left=100,menubar=no,resizable=yes,scrollbars=yes,status=yes,titlebar=yes,toolbar=no"
	);
	/*-- Focus back on the parent page: --*/
	objGoogleSignoutWindow.parent.focus();
	
	/*-- Indicate to the user that we are attempting to sign out of Google: --*/
	$("div#alert_signout_google")
		.addClass("alert")
		.removeClass("alert-success")
		.removeClass("alert-danger")
		.addClass("alert-info")
		.html("Signing out of Google...");
				
	// console.log(objGoogleSignoutWindow.document.readyState);
	
	/*-- Set the first check of the popup doc's readyState: --*/
	checkPopupState(250);
}

