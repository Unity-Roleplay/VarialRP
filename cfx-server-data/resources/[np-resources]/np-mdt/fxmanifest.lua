





fx_version 'cerulean'
game 'gta5'

lua54 'yes'

server_scripts {
    '@np-lib/server/sv_sqlother.lua',
    '@np-lib/server/sv_rpc.lua',
    'sv_main.lua'
}

client_scripts {
    'cl_main.lua',
    '@np-lib/client/cl_rpc.lua'
}

shared_script 'sh_conf.lua'

ui_page 'ui/dashboard.html'

files {
    'ui/img/*.png',
    'ui/img/*.jpg',
    'ui/dashboard.html',
    'ui/dmv.html',
    'ui/bolos.html',
    'ui/incidents.html',
    'ui/penalcode.html',
    'ui/reports.html',
    'ui/warrants.html',
    'ui/app.js',
    'ui/style.css',
}