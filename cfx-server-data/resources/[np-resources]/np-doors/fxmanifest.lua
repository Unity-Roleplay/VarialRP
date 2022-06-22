





fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
  '@np-lib/client/cl_rpc.lua',
  '@np-lib/client/cl_ui.lua',
  '@np-lib/client/cl_polyhooks.lua',
	'client/cl_*.lua'
}

shared_scripts {
  '@np-lib/shared/sh_util.lua',
	"shared/*.lua"
}

server_scripts {
  '@np-lib/server/sv_rpc.lua',
  '@np-lib/server/sv_sql.lua',
	'server/*.lua'
}