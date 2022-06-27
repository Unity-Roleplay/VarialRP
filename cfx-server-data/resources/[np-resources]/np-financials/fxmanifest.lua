fx_version "cerulean"
games { "gta5" }

ui_page "ui/index.html"

files {
	"ui/*.html",
	"ui/*.css",
	"ui/*.js",
}

shared_script {
    "@np-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "config.lua",
    "@np-lib/server/sv_rpc.lua",
    "@np-lib/server/sv_sql.lua",
    "server/*",
}

client_scripts {
    -- "@np-lib/client/cl_ui.lua",
    -- "@np-errorlog/client/cl_errorlog.lua",
    "@np-lib/client/cl_rpc.lua",
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/ComboZone.lua",
    "client/*",
}