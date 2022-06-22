








fx_version "cerulean"

games { "gta5" }

description "Sanyo Fiber"

version "0.1.0"

ui_page 'nui/index.html'

files {
    'nui/**/*',
}

server_scripts {
    "@np-lib/server/sv_npx.js",
    "@np-lib/server/sv_rpc.js",
    "@np-lib/server/sv_sql.js",
    "@np-lib/shared/sh_cacheable.js",
    "@np-lib/server/sv_asyncExports.js",
    "server/*.js",
}

client_scripts {
    "@np-lib/client/cl_rpc.js",
    "client/*.js",
}
