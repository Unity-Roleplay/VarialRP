RegisterServerEvent("np:flags:set")
AddEventHandler("np:flags:set", function(callID, netID, flagType, flags)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(netID)
    local eType = GetEntityType(entity)
    TriggerClientEvent("np:flags:set", -1, netID, eType, flagType, flags)
end)
