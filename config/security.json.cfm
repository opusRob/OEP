[
	{
		"whitelist": "login\\.(index|authenticate|sign_out),main\.*"
		, "securelist": "home\\.index,(user|news|blog|link)\\.(index|item)"
		, "match": "event"
		, "roles": "standard_user,administrator"
		, "permissions": ""
		, "redirect": "login.index"
		, "useSSL": true
	}, {
		"whitelist": "login\\.(index|authenticate|sign_out),main\.*"
		, "securelist": "(user|news|blog|link)\\.(add|edit|save|remove)"
		, "securelist": "*\.add,*\.edit,*\.save,*\.remove"
		, "match": "event"
		, "roles": "administrator"
		, "permissions": ""
		, "redirect": "login.index"
		, "useSSL": true
	}, {
		"whitelist": "login\\.(index|authenticate|sign_out),main\.*"
		, "securelist": "home\\.index,(user|news|blog|link)\\.(index|item)"
		, "match": "url"
		, "roles": "standard_user,administrator"
		, "permissions": ""
		, "redirect": "login.index"
		, "useSSL": true
	}, {
		"whitelist": "login\\.(index|authenticate|sign_out),main\.*"
		, "securelist": "(user|news|blog|link)\\.(add|edit)"
		, "securelist": "*\.add,*\.edit,*\.save,*\.remove"
		, "match": "url"
		, "roles": "administrator"
		, "permissions": ""
		, "redirect": "login.index"
		, "useSSL": true
	}
]

<!---
	login.index
	login.authenticate
	[ login.sign_out ]

	home.index

	user.index
	* user.add
	* user.edit
	* [ user.save ]
	* [ user.remove ]

	news.index
	news.item
	* news.add
	* news.edit
	* [ news.save ]
	* [ news.remove ]

	blog.index
	blog.item
	* blog.add
	* blog.edit
	* [ blog.save ]
	* [ blog.remove ]

	link.index
	link.item
	* link.add
	* link.edit
	* [ link.save ]
	* [ link.remove ]
 --->