








fx_version 'cerulean'

games { 'gta5' }

client_script "@np-sync/client/lib.lua"
client_script "@np-lib/client/cl_ui.lua"

client_scripts {
  '@np-lib/client/cl_rpc.lua',
  'client/cl_*.lua'
}

server_script "@np-lib/server/sv_npx.js"
server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_rpc.js',
  '@np-lib/server/sv_sql.lua',
  '@np-lib/server/sv_sql.js',
  "@np-lib/server/sv_asyncExports.lua",
  'config.lua',
  'server/sv_*.lua',
}

ui_page "./UI/index.html"

files{
    "./UI/index.html",
    "./UI/main.css",
    "./UI/main.js",
}