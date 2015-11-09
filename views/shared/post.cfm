<!--- <cfdump var="#request.aryPost.getCreatedByUser()#"><cfabort> --->

<cfoutput>
    <!-- Page Header -->
    <!-- Set your background image for this header on the line below. -->
    <header class="intro-header" style="background-image: url('img/post-bg.jpg')">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="post-heading">
                        <h1>#request.aryPost.getPost_headline_tx()#</h1>
                        <h2 class="subheading">#request.aryPost.getPost_preview_tx()#</h2>
                        <span class="meta">
							<cfif isDate(request.aryPost.getPost_update_datetime_dt())>
								Updated by
								<a href="##">#request.aryPost.getUpdatedByUser().getUser_full_name_tx()#</a>
								on #dateFormat(request.aryPost.getPost_update_datetime_dt(), "dddd mmmm d, yyyy")#
								at #timeFormat(request.aryPost.getPost_update_datetime_dt(), "hh:mm TT")#
								<br />Originally
							</cfif>
							Posted by
							<a href="##">#request.aryPost.getCreatedByUser().getUser_full_name_tx()#</a>
							on #dateFormat(request.aryPost.getPost_create_datetime_dt(), "dddd mmmm d, yyyy")#
							at #timeFormat(request.aryPost.getPost_create_datetime_dt(), "hh:mm TT")#
							<br />
							<a href="javascript: window.history.back(); ">Back</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Post Content -->
    <article>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
					#request.aryPost.getPost_body_tx()#
					<br />
					<a href="javascript: window.history.back(); ">Back</a>
                </div>
            </div>
        </div>
    </article>


	<!--- <div class="panel panel-default" style="margin-top: 15px; ">
		<div class="panel-heading">
			<div style="clear: both; ">
				<div style="float: left; ">
					<h3 class="panel-title">
						#request.aryPost.getPost_headline_tx()#
					</h3>
					<div class="created_updated_by">
						Created
						#dateTimeFormat(request.aryPost.getPost_create_datetime_dt(), "mm/dd/yyyy at hh:mm TT")#
						by #request.aryPost.getCreatedByUser().getUser_full_name_tx()#.
						<cfif isDate(request.aryPost.getPost_update_datetime_dt())>
							last updated
							#dateTimeFormat(request.aryPost.getPost_update_datetime_dt(), "mm/dd/yyyy at hh:mm TT")#
							by #request.aryPost.getUpdatedByUser().getUser_full_name_tx()#.
						</cfif>
					</div>
				</div>
				<div style="float: right; ">
					<button type="button" class="btn btn-success btn-xs" onClick="window.history.back(); ">
						<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
					</button>
				</div>
				<div style="clear: both; "></div>
			</div>
		</div>
		<div class="panel-body">
			<div>
				#request.aryPost.getPost_body_tx()#
			</div>
		</div>
	</div> --->
</cfoutput>