fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_scripts {
    '@np-remotecalls/client/cl_main.lua',
	'client/cl_*.lua',
}

server_scripts {
	'@np-remotecalls/server/sv_main.lua',
    'server/sv_*.lua',
}

ui_page 'html/bank.html'

files {
    'html/bank.html',
    'html/style.css',
    'html/load.css',
    'html/ui.js',
    'html/img/*.png',
	'html/pricedown.ttf',
    'html/bank-icon.png',
}