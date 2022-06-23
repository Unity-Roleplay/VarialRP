RegisterServerEvent("np-baycity:getGetDoorStateSV")
AddEventHandler("np-baycity:getGetDoorStateSV", function()
    TriggerClientEvent('np-baycity:getDoorCheckCL', -1, doorCheckbaycity)
end)

RegisterServerEvent("np-particleserverbaycity")
AddEventHandler("np-particleserverbaycity", function(method)
    TriggerClientEvent("np-ptfxparticlebaycity", -1, method)
end)

RegisterServerEvent("np-particleserverbaycity1")
AddEventHandler("np-particleserverbaycity1", function(method)
    TriggerClientEvent("np-ptfxparticlebaycity1", -1, method)
end)
