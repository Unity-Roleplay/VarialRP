game 'gta5'
fx_version 'adamant'
lua54 'yes'

server_script 'sv_main.lua'

client_script {
    '@np-lib/client/cl_ui.lua',
    'cl_main.lua',
    'config.lua'
}
