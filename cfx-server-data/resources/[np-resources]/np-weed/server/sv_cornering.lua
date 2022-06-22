RPC.register("np-weed:startCorner", function(pSource, pCoords)
    print("Coords", pCoords)
    return true, "Corner Active"
end)

RPC.register("np-weed:cornerPed", function(pSource, pCoords, pPed, pVehicle)
    TriggerClientEvent("np-weed:cornerPed", pSource, pPed, pCoords, pVehicle)
    return true
end)

RPC.register("np-weed:cornerSyncHandoff", function(pSource, pCoords, pPed)
    TriggerClientEvent("np-weed:cornerSyncHandoff", pSource, pPed)
    return true
end)

RPC.register("np-weed:cornerSale", function(pSource, pCoords, pNetId, CurrentCornerZone, baggieInfo)
    print("cornerSale", json.encode(pCoords), pNetId, CurrentCornerZone, json.encode(baggieInfo))
    local user = exports["np-base"]:getModule("Player"):GetUser(pSource)

    TriggerClientEvent("inventory:removeItem", -1, "weedbaggie", 1)

    exports["np-log"]:AddLog("Weed", 
        source, "Corner Sale", { type = "weedbaggie", amount = tostring(1)})
    return true
end)

RPC.register("np-weed:prepareBaggies", function(pSource, pInfo)
    TriggerClientEvent("inventory:removeItem", -1, "emptybaggies", CornerConfig.BaggiesPerBrick)
    exports["np-log"]:AddLog("Weed", 
        source, "Corner Sale", { type = "emptybaggies", amount = tostring(1)})
    return true
end)

RPC.register("np-weed:stopCorner", function(pSource)
    return false
end)