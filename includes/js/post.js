$(document).ready(
	function() {
		var objEditor = CKEDITOR.replace("post_body_tx");
		
		objEditor.addCommand(
			"insertImageVariable"
			, {
				// create named command	  
				exec: function() {
					CKEDITOR.instances['post_body_tx'].insertText("[[[IMAGE]]]");
				}
			}
		);
		objEditor.ui.addButton(
			'btnInsertImageVariable'
			, {
				// add new button and bind our command
				label: "Insert uploaded image placeholder variable ('[[[IMAGE]]]')"
				, command: 'insertImageVariable'
				, toolbar: 'insert'
				, icon: '/includes/images/CKEditor/insert_picture.jpg'
			}
		);
		
	}
);
