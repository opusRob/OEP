<cfoutput>

  <!---   <!-- Page Header -->
    <!-- Set your background image for this header on the line below. -->
    <header class="intro-header" style="background-image: url('img/home-bg.jpg')">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="site-heading">
                        <h1>News</h1>
                        <hr class="small">
                        <span class="subheading">
							Opus Group, LLC Internal News
							&nbsp;&nbsp;
							<cfif isUserInRole("administrator")>
								<button type="button" class="btn btn-success btn-xs" onClick="location.href='#event.buildLink('news.add')#'; ">
									<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
								</button>
							</cfif>
						</span>
                    </div>
                </div>
            </div>
        </div>
    </header> --->

	<form name="post_form" id="post_form" action="#event.buildLink('news.remove')#" method="post">
		<input type="hidden" name="post_id" id="post_id" value="0"/>
	</form>

	<div class="row">
		<div class="<!--- col-lg-8 ---> <!--- col-lg-offset-1 ---> <!--- col-md-10  ---><!--- col-md-offset-1 --->" style="padding-left: 20px; ">
			<cfset variables.intRowCount = 0/>
			<cfloop array="#request.aryPosts#" index="variables.objPost">
				<cfset variables.intRowCount++/>
				<div class="post-preview">
					<a href="#event.buildLink('news.item.#variables.objPost.getPost_id()#')#">
						<h2 class="post-title">
							#len(trim(variables.objPost.getPost_headline_tx())) ? variables.objPost.getPost_headline_tx() : "&nbsp;"#
						</h2>
						<h3 class="post-subtitle">
							<cfif len(trim(variables.objPost.getPost_body_tx()))>
								#left(
									request.cfcUtilities.stripHTML(
										variables.objPost.getPost_body_tx()
									)
									, 200
								)#
							<cfelse>
								&nbsp;
							</cfif>
						</h3>
					</a>
					<p class="post-meta">
						<cfif isDate(variables.objPost.getPost_update_datetime_dt())>
							Updated by
							<a href="##">#variables.objPost.getUpdatedByUser().getUser_full_name_tx()#</a>
							on #dateFormat(variables.objPost.getPost_update_datetime_dt(), "dddd mmmm d, yyyy")#
							at #timeFormat(variables.objPost.getPost_update_datetime_dt(), "h:mm TT")#
						<cfelse>
							Posted by
							<a href="##">#variables.objPost.getCreatedByUser().getUser_full_name_tx()#</a>
							on #dateFormat(variables.objPost.getPost_create_datetime_dt(), "dddd mmmm d, yyyy")#
							at #timeFormat(variables.objPost.getPost_create_datetime_dt(), "h:mm TT")#
						</cfif>
						<cfif isUserInRole("administrator")>
							<div style="">
								<button type="button" class="btn btn-warning btn-xs" onClick="location.href='#event.buildLink('news.edit.#variables.objPost.getPost_id()#')#'; ">
									<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
								</button>
								<button type="button" class="btn btn-danger btn-xs" onClick="postRemove(#variables.objPost.getPost_id()#)">
									<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
								</button>
							</div>
						</cfif>
					</p>
				</div>
				<cfif variables.intRowCount LT arrayLen(request.aryPosts)>
					<hr/>
				</cfif>
			</cfloop>
		</div>
	</div>
</cfoutput>