
<cfsavecontent variable="request.strImageContent">
	<cfoutput>
		<cfif
			len(trim(request.aryPost.getPost_large_image_file_name_tx()))
			AND fileExists(expandPath(request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()))
			AND isImageFile(expandPath(request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()))
		>
			<img
				class="visible-lg-inline"
				src="#request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()#"
				alt="#request.aryPost.getPost_headline_tx()# Image"
				style="width: 300px; height: 300px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
			/>
			<img
				class="visible-md-inline"
				src="#request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()#"
				alt="#request.aryPost.getPost_headline_tx()# Image"
				style="width: 250px; height: 250px; border: solid 1px ##cccccc; margin: 0px 15px 15px 0px; float: left; "
			/>
			<img
				class="visible-sm-inline"
				src="#request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()#"
				alt="#request.aryPost.getPost_headline_tx()# Image"
				style="width: 200px; height: 200px; border: solid 1px ##cccccc; margin: 0px 10px 10px 0px; float: left; "
			/>
			<img
				class="visible-xs-inline"
				src="#request.strUploadedImagesFolderLocation & request.aryPost.getPost_large_image_file_name_tx()#"
				alt="#request.aryPost.getPost_headline_tx()# Image"
				style="width: 100px; height: 100px; border: solid 1px ##cccccc; margin: 0px 10px 10px 0px; float: left; "
			/>
		</cfif>
	</cfoutput>
</cfsavecontent>
<cfset request.strImageContent = trim(request.strImageContent)/>

<cfoutput>
	<div class="item_header" style="padding-top: 15px; ">
		<h1 style="float: left; margin: 0px; ">#request.aryPost.getPost_headline_tx()#</h1>
		<button type="button" class="btn btn-info btn-xs" style="float: right; " onClick="window.history.back(); ">
			<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
		</button>
		<div class="meta" style="clear: left; margin-top: 50px; ">
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
		</div>
	</div>
	<hr/>

    <!-- Post Content -->
    <article>
        <div class="container">
            <div class="row">
                <div class="<!--- col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 --->">
					#replaceNoCase(request.aryPost.getPost_body_tx(), "[[[IMAGE]]]", request.strImageContent, "all")#
					<br />
					<button type="button" class="btn btn-info btn-xs" onClick="window.history.back(); ">
						<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
					</button>
                </div>
            </div>
        </div>
    </article>

</cfoutput>