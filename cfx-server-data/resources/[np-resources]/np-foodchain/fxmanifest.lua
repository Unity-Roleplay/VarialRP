








fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
  "np-lib",
  "PolyZone",
  "np-ui"
} ]]--

client_script "@np-sync/client/lib.lua"
client_script "@np-lib/client/cl_ui.lua"
client_script "@np-lib/client/cl_polyhooks.lua"
client_script "@np-locales/client/lib.lua"

client_scripts {
  '@np-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
  '@sanyo-lasers/client/client.lua',
}

shared_script {
  '@np-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_sql.lua',
  '@np-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
}
