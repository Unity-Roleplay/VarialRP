





fx_version "cerulean"
games {"gta5"}

server_script '@np-lib/server/sv_rpc.lua'
client_script '@np-lib/client/cl_rpc.lua'

client_scripts {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}