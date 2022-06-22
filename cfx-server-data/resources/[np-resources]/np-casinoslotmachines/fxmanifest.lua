





fx_version "cerulean"
games {"gta5"}

name "np-casinoslotmachines"
description "have fun playing slot machines."
author "hbmsupra"

--client_script "@np-sync/client/lib.lua"
client_script "@np-lib/client/cl_ui.lua"
client_script "@np-lib/client/cl_polyhooks.lua"
client_script "@np-lib/client/cl_rpc.lua"
client_script "@PolyZone/client.lua"
shared_script "@np-lib/shared/sh_util.lua"
server_script "@np-lib/server/sv_rpc.lua"
server_script "@np-lib/server/sv_sql.lua"
--server_script "@np-lib/server/sv_asyncExports.lua"

shared_script "_configs/cfg_general.lua"

client_scripts {
    "core/client/cl_*.lua",
}

server_scripts {"core/server/sv_ply.lua"}
