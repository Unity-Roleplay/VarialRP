








fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  '@np-lib/client/cl_rpc.lua',
  "@np-lib/client/cl_ui.lua",
  "@np-lib/client/cl_rpc.js",
  'config.lua',
  'client/cl_*.lua',
  --'@unwind-rpc/client/cl_main.lua',
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_asyncExports.js',
  "@np-lib/server/sv_npx.js",
  "@np-lib/server/sv_rpc.js",
  'config.lua',
  'server/sv_*.lua',
  --'@unwind-rpc/server/sv_main.lua',
}

ui_page 'ui/index.html'

files {
  'ui/*',
  'ui/images/*',
  'ui/css/*',
  'ui/webfonts/*'
}