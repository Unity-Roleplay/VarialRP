





client_script "UYG.lua"
fx_version 'bodacious'
game 'gta5'

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

server_script '@np-lib/server/sv_rpc.lua'
shared_script "shared/sh_jobmanager.lua"

server_script "server/sv_jobmanager.lua"
client_script "client/cl_jobmanager.lua"