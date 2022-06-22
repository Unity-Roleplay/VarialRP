








fx_version "cerulean"
games { "gta5" }

description "Sanyo Boilerplate"

version "0.1.0"

server_script "@np-lib/server/sv_sql.js"
server_script "@np-lib/server/sv_rpc.js"
server_script "@np-lib/server/sv_rpc.lua"
server_script "@np-lib/server/sv_npx.js"
server_script "@np-lib/server/sv_asyncExports.js"

client_script "@np-lib/client/cl_ui.js"
client_script "@np-lib/client/cl_rpc.js"
client_script "@np-lib/client/cl_rpc.lua"

server_scripts {
    "server/*.js",
	"server/*.lua",
}

client_scripts {
    "client/*.js",
	"client/*.lua",
}