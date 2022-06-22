RPC.register("np-civjobs:sell-crab", function(pSource, pCrabType)
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local payout
    local crabType

    if pCrabType == "crab" then
        payout = math.random(40, 65)
        crabType = "Crab"
    elseif pCrabType == "crab2" then
        payout = math.random(55, 75)
        crabType = "Blue Crab"
    elseif pCrabType == "crab3" then
        payout = math.random(65, 90)
        crabType = "King Crab"
    else
        print(("[POSSIBLE EXPLOITER] %s tried to sell a crab with an invalid type"):format(user:getVar("hexid")))
        return
    end

    user:addMoney(payout)
    TriggerClientEvent('DoLongHudText', src, ("You've sold 1x %s and received $%s"):format(crabType, payout), 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Crab", 
        { type = "crab", amount = tostring(payout), typeCrab = crabType })

    timeout = os.time()
end)
