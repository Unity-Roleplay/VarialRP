local robbedSafes = {}

RPC.register("checkIfRobbed", function(pSource, pNetworkId)
    return robbedSafes[pNetworkId]
end)

RPC.register("robbedNow", function(pSource, pNetworkId)
    if not pNetworkId or pNetworkId == 0 then return nil end
    local user = exports["np-base"]:getModule("Player"):GetUser(pSource)
    local random = math.random(250, 500)
    robbedSafes[pNetworkId] = true
    user:addMoney(random)
end)