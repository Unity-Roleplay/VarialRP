








fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  'shared/config.lua',
  'client/cl_*.lua',
  '@np-errorlog/client/cl_errorlog.lua',
  '@np-sync/client/lib.lua',
  '@np-lib/client/cl_rpc.lua',
  '@np-lib/client/cl_ui.lua',
  '@np-lib/client/cl_animTask.lua',
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_sql.lua',
  '@np-lib/server/sv_sql.js',
  '@np-lib/server/sv_asyncExports.js',
  '@np-lib/server/sv_asyncExports.lua',
  'shared/config.lua',
  'server/sv_*.lua',
}
