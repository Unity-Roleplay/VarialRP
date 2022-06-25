
fx_version 'cerulean'
game 'gta5'

ui_page {
	'html/ui.html',	
}

client_scripts {
	'@np-lib/client/cl_ui.lua',
    '@np-lib/client/cl_interface.lua',
	"client/cl_*.lua",
}

server_scripts {
	"server/sv_*.lua",
}

files {
	'html/*.png',
	'html/*.svg',
	'html/*.html',
	'html/ui.html',
	"html/img/*.svg",
	'html/css/main.css',
	'html/css/pricedown_bl-webfont.ttf',
	'html/css/pricedown_bl-webfont.woff',
	'html/css/pricedown_bl-webfont.woff2',
	'html/css/gta-ui.ttf',
	'html/js/app.js',
	'html/css/pdown.ttf',
	'html/css/*.css',
	'html/css/*.ttf',
	'html/css/*.woff',
	'html/css/*.woff2',
}

exports {
	'BuffIntel',
	'BuffStress',
	'BuffLuck',
	'BuffHunger',
    'BuffThirst',
	'BuffAlert',
	'NearGasFn'
}