





fx_version 'cerulean'
games { 'gta5' }

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script "@np-errorlog/client/cl_errorlog.lua"


client_script {
  "client.lua",
}
server_scripts {
  'server.lua'
}

export "GetClosestNPC"
export "IsPedNearCoords"
export "isPed"
export "GroupRank"
export "GlobalObject"
export "retreiveBusinesses"