





fx_version 'cerulean'
games {"gta5"}

description "actionbar"

client_scripts {
  "@np-errorlog/client/cl_errorlog.lua",
  '@np-lib/client/cl_rpc.lua',
  "client.lua",
}

shared_script {
  '@np-lib/shared/sh_util.lua'
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_sql.lua',
}