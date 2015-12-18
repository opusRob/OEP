$(document).ready(
	function() {
		var objEditor = CKEDITOR.replace(
			"post_body_tx"
			, {
				removePlugins: "image,flash,iframe,scayt,form,checkbox,radio,textfield,textarea,select,button,hiddenfield"
			}
		);
		
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
		
		var bolUndoTriggered = false;
		objEditor.on(
			"change"
			, function() {
				if (global["bolEditorAutoUndo"]) {
					if (objEditor.getData().length > 4000 && !bolUndoTriggered) {
						bolUndoTriggered = true;
						objEditor.execCommand("undo");
					} else {
						bolUndoTriggered = false;
					}
				}
				$("#post_body_char_length").html(objEditor.getData().length);
			}
		);
		objEditor.on(
			"mode"
			, function() {
				if (this.mode == "source") {
					var editable = objEditor.editable();
					editable.attachListener(
						editable
						, "input"
						, function() {
							if (global["bolEditorAutoUndo"]) {
								if (objEditor.getData().length > 4000 && !bolUndoTriggered) {
									bolUndoTriggered = true;
									objEditor.execCommand("undo");
								} else {
									bolUndoTriggered = false;
								}
							}
							$("#post_body_char_length").html(objEditor.getData().length);
				        }
					);
				}
			}
		);
		
		
	}
);


//CKEDITOR.instances.editor1.getData().length