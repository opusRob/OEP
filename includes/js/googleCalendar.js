
// var clientId = "449742839884-i34v6l8na4rg1qhim6glsg4q3c5sta22.apps.googleusercontent.com";
// var apiKey = "AIzaSyDqGBwJP1V1D_qA_8GK9iY2L2IpG9nClA4";
// var scopes = "https://www.googleapis.com/auth/calendar.readonly";

      // Your Client ID can be retrieved from your project in the Google
      // Developer Console, https://console.developers.google.com
      var CLIENT_ID = global.googleClientId;

      var SCOPES = ["https://www.googleapis.com/auth/calendar.readonly"];

      /**
       * Check if current user has authorized this application.
       */
      function checkAuth() {
        gapi.auth.authorize(
          {
            'client_id': CLIENT_ID,
            'scope': SCOPES.join(' '),
            'immediate': true
          }, handleAuthResult);
      }

      /**
       * Handle response from authorization server.
       *
       * @param {Object} authResult Authorization result.
       */
      function handleAuthResult(authResult) {
        if (authResult && !authResult.error) {
          loadCalendarApi();
        } else {
			$("#google_calendar_div ul").html("Could not load calendar.");
        }
      }

      /**
       * Initiate auth flow in response to user clicking authorize button.
       *
       * @param {Event} event Button click event.
       */
      function handleAuthClick(event) {
        gapi.auth.authorize(
          {client_id: CLIENT_ID, scope: SCOPES, immediate: false},
          handleAuthResult);
        return false;
      }

      /**
       * Load Google Calendar client library. List upcoming events
       * once client library is loaded.
       */
      function loadCalendarApi() {
        gapi.client.load('calendar', 'v3', listCalendars);
      }


		function listCalendars() {
	        var request = gapi.client.calendar.calendarList.list({});
	        
	        request.execute(
	        	function(resp) {
	        		//var items = resp.items;
	        		var calendar_id = new String();
	        		for (var i = 0; i < resp.items.length; i++) {
	        			if (resp.items[i].summary == global.googleCalendarName) {
	        				calendar_id = resp.items[i].id;
	        				break;
	        			}
	        		}
	        		if (calendar_id.length) {
	        			$("a#google_calendar_link").attr("href", "https://calendar.google.com/calendar/render?id=" + calendar_id);
	        			listUpcomingEvents(calendar_id);
	        		} else {
	        			$("#google_calendar_div ul").html("Could not load calendar.");
	        		}
	        		//alert(resp.items[0].toSource());
	        	}
	        );
		}

      /**
       * Print the summary and start datetime/date of the next ten events in
       * the authorized user's calendar. If no events are found an
       * appropriate message is printed.
       */
      function listUpcomingEvents(calendar_id) {
        var request = gapi.client.calendar.events.list({
          'calendarId': calendar_id,
          'timeMin': (new Date()).toISOString(),
          'showDeleted': false,
          'singleEvents': true,
          'maxResults': 5,
          // 'orderBy': 'startTime'
        });

        request.execute(function(resp) {
          var events = resp.items;
		
	      if (events.length > 0) {
            for (var i = 0; i < events.length; i++) {
            	
              var event = events[i];
              var objEventAttendeeInfo = getEventAttendeeInfo(event);
              var when = event.start.dateTime;
              if (!when) {
                when = event.start.date;
              }
              $("#google_calendar_div").append(
              	"<a href='" + event.htmlLink + "' target='_blank' class='' style=' '>"  //list-group-item
              	
              	+ "<h4 class=''>"  //list-group-item-heading
              	+ "<span style='float: left; '>"
              	+ event.summary
              	+ "</span>"
              	+ "<span style='float: right; font-size: 12px; font-weight: normal; '>"
              	+ objEventAttendeeInfo["strMyStatus"]
              	+ "</span>"
              	+ "</h4>"
              	
              	+ "<p class='' style='clear: left; '>"  //list-group-item-text
              	+ "<span style='float: left; '>"
              	+ formatGoogleDate(when)
              	+ "</span>"
              	// + "<span class='label label-default' style='float: right; font-style: normal; border-top-left-radius: 0px; border-bottom-left-radius: 0px; ' title='" + objEventAttendeeInfo["intNeedsAction"] + " people have not responded.'>"
              	// + "?:" + objEventAttendeeInfo["intNeedsAction"]
              	// + "</span>"
              	// + "<span class='label label-danger' style='float: right; font-style: normal; border-radius: 0px; ' title='" + objEventAttendeeInfo["intDeclined"] + " people have declined.'>"
              	// + "D:" + objEventAttendeeInfo["intDeclined"]
              	// + "</span>"
              	// + "<span class='label label-warning' style='float: right; font-style: normal; border-radius: 0px; ' title='" + objEventAttendeeInfo["intTentative"] + " people are tentative.'>"
              	// + "T:" + objEventAttendeeInfo["intTentative"]
              	// + "</span>"
              	// + "<span class='label label-success' style='float: right; font-style: normal; border-top-right-radius: 0px; border-bottom-right-radius: 0px; ' title='" + objEventAttendeeInfo["intAccepted"] + " people have accepted.'>"
              	// + "A:" + objEventAttendeeInfo["intAccepted"]
              	// + "</span>"
              	+ "</p>"
              	
              	+ "</a>"
              	+ (i < events.length - 1 ? "<hr style='clear: left; margin: 30px 0px 0px 0px; '/>" : "")
              );
            }
          } else {
            $("#google_calendar_div ul").html("No events found.");
          }

        });
      }

	function getEventAttendeeInfo(event) {
		var intInvitees = typeof event["attendees"] != "undefined" ? event["attendees"].length : 0;
		var objEventAttendeeInfo = {
			intInvitees: intInvitees
			, intNeedsAction: 0
			, intDeclined: 0
			, intTentative: 0
			, intAccepted: 0
			, strMyStatus: "You're not invited"
		};
		if (intInvitees) {
			for (var i = 0; i < intInvitees; i++) {
				var bolUser = event["attendees"][i]["email"].split("@")[0] == strGID;
				switch(event["attendees"][i].responseStatus) {
					case "needsAction":
						objEventAttendeeInfo["intNeedsAction"]++;
						if (bolUser)
							objEventAttendeeInfo["strMyStatus"] = "You haven't responded";
						break;
					case "declined":
						objEventAttendeeInfo["intDeclined"]++;
						if (bolUser)
							objEventAttendeeInfo["strMyStatus"] = "You declined";
						break;
					case "tentative":
						objEventAttendeeInfo["intTentative"]++;
						if (bolUser)
							objEventAttendeeInfo["strMyStatus"] = "You are tentative";
						break;
					case "accepted":
						objEventAttendeeInfo["intAccepted"]++;
						if (bolUser)
							objEventAttendeeInfo["strMyStatus"] = "You accepted";
						break;
				}
			}
		}
		
		return objEventAttendeeInfo;

	}

      /**
       * Append a pre element to the body containing the given message
       * as its text node.
       *
       * @param {string} message Text to be placed in pre element.
       */
      // function appendPre(message) {
        // var pre = document.getElementById('google_calendar_div');
        // var textContent = document.createTextNode(message + '\n');
        // pre.appendChild(textContent);
      // }
      


function formatGoogleDate(strDate) {
	var objDate = new Date(strDate);
	
	var aryWeekdays = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
	var aryMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
	
	var strWeekday = aryWeekdays[objDate.getDay()];
	var strMonth = aryMonths[objDate.getMonth()];
	var strDay = String(objDate.getDate());
	var strYear = String(objDate.getFullYear());
	var strHour = String(objDate.getHours() - (objDate.getHours() > 12 ? 12 : 0));
	var strMinute = (objDate.getMinutes() < 10 ? "0" : "") + String(objDate.getMinutes());
	var strTT = String(objDate.getHours() > 12 ? "PM" : "AM");
	
	return strWeekday + " " + strMonth + " " + strDay + ", " + strHour + ":" + strMinute + " " + strTT;
	
}
