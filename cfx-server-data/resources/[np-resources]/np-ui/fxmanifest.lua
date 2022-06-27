fx_version 'cerulean'
games {'gta5'}

ui_page "html/index.html"

files({
	"html/*",
	"html/img/*",
	"html/css/*",
	"html/font/*",
	"html/js/*"
})

client_script "@np-lib/client/cl_ui.lua"


client_scripts {
	"client/*.lua",
	"@np-lib/client/cl_polyhooks.lua",
	"@np-lib/client/cl_ui.lua",
	'@np-lib/client/cl_rpc.lua',
	'client/model/*.lua'
	
}
server_scripts {
	"server/*",
	"@np-lib/server/sv_asyncExports.lua",
	'@np-lib/server/sv_rpc.lua',
	'@np-lib/server/sv_sql.lua',
}
