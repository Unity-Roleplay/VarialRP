version '1.0.0'

fx_version 'cerulean'
game 'gta5'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'html/ui.html',
    'html/styles.css'
}

ui_page 'html/ui.html'

exports {
    'SetCompassFPS',
    'SetSpeedFPS',
    'SetTimeEnabled'
}