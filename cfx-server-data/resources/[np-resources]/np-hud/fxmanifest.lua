fx_version 'cerulean'
game 'gta5'


client_script {
    'config.lua',
	'client/*.lua'
}

server_script {
    'server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.css',
    'html/*.js',
    'html/img/*.png',
}

exports {
    'sendfpscarhud',
    'dobuffthing'
}