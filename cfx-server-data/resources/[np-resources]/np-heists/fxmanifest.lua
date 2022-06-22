








fx_version 'bodacious'
games { 'rdr3', 'gta5' }


client_scripts {
  '@np-errorlog/client/cl_errorlog.lua',
  '@np-sync/client/lib.lua',
  '@np-lib/client/cl_rpc.lua',
  '@np-lib/client/cl_ui.lua',
  '@np-lib/client/cl_animTask.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  '@sanyo-lasers/client/client.lua',
  '@sanyo-grapple/client.lua',
  'client/cl_*.lua',
}

shared_script {
  '@np-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  'config.lua',
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_sql.lua',
  '@np-lib/server/sv_sql.js',
  '@np-lib/server/sv_asyncExports.js',
  '@np-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
}
