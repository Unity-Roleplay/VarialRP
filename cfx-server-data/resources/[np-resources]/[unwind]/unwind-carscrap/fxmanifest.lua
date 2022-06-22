fx_version "cerulean"

games {"gta5"}



server_scripts {
	'@np-lib/server/sv_rpc.lua',
	"server/*.lua",
}

client_scripts {
	'@np-lib/client/cl_rpc.lua',
	"client/*.lua",
}
