fx_version 'bodacious'
game 'gta5'

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_script "@np-errorlog/client/cl_errorlog.lua"

files {
	'html/css/balloon.min.css',
	'html/css/mui.css',
	'html/css/all.min.css',
	'html/ui.html',
	'html/css/materialize.min.css',
	'html/css/*.css',
	'html/js/*.js',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/images/*.svg',
	
	'html/wallpapers/*.png',
	'html/wallpapers/*.jpg',
	'html/wallpapers/*.svg',

	'html/images/cursor.png',
	'html/images/background.png',	
	'html/images/phone-shell.png',
	'html/images/phone-background.jpg',
	'html/images/gurgle.png',
	'html/images/pager2.png',
	'html/webfonts/fa-brands-400.eot',
	'html/webfonts/fa-brands-400.svg',
	'html/webfonts/fa-brands-400.ttf',
	'html/webfonts/fa-brands-400.woff',
	'html/webfonts/fa-brands-400.woff2',
	'html/webfonts/fa-regular-400.eot',
	'html/webfonts/fa-regular-400.svg',
	'html/webfonts/fa-regular-400.ttf',
	'html/webfonts/fa-regular-400.woff',
	'html/webfonts/fa-regular-400.woff2',
	'html/webfonts/fa-solid-900.eot',
	'html/webfonts/fa-solid-900.svg',
	'html/webfonts/fa-solid-900.ttf',
	'html/webfonts/fa-solid-900.woff',
	'html/webfonts/fa-solid-900.woff2',
}

ui_page 'html/ui.html'

shared_scripts {
	"@np-lib/shared/sh_util.lua",
}

client_scripts {
	"@np-lib/client/cl_ui.lua",
	'@np-lib/client/cl_rpc.lua',
	'client/assistance.lua',
	'client/stocks.lua',
	'client/main.lua',
	'client/license.lua',
	'client/notification.lua',
	'cl/cl_*.lua',
	'module/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	'@np-lib/server/sv_rpc.lua',
	'@np-lib/server/sv_sqlother.lua',
	"server/main.lua",
	"server/sv_*.lua",
	--"server/license.lua",
}

export "pOpen"
export "phasPhone"
export "pNotify"