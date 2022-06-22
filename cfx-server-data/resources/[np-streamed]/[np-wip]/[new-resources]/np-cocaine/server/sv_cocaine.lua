RPC.register('heists:cocaine_paynow', function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if user:getCash() >= 100000 then
        user:removeMoney(100000)
    return true
    else
        return false
    end
end)

RPC.register('heists:cocaine_start_vehicle', function()
    local src = source
    TriggerClientEvent('np-heists:doVehicle', src, "dinghy",2004.4, 4007.85, 29.22)
    return 
end)

RPC.register('heists:cocaine_dump_vehicle', function(x,y,z)
    local src = source
    TriggerClientEvent('np-heists:doVehicle', src, "sultan",x,y,z)
end)

RegisterServerEvent("fx:spell:target")
AddEventHandler("fx:spell:target", function(x,y,z,pTimesent)
    TriggerClientEvent("fx:do:Effect", -1, x,y,z ,pTimesent)
end)
