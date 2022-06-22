local IsWeedProcessing = true
local IsWeedProcessingFinished = true

RPC.register("np-weed:currentlyProcessing", function(pSource)
    return IsWeedProcessing
end)    

RPC.register("np-weed:readyForPickup", function(pSource)
    return IsWeedProcessingFinished
end)    

RPC.register("np-weed:collectpackage", function(pSource)
    TriggerClientEvent("player:receiveItem", -1, "weedpackage", 1)
    return true
end)    

RPC.register("np-weed:deliverpackage", function(pSource)
    local user = exports["np-base"]:getModule("Player"):GetUser(pSource)
    amount = math.random(3000, 4000)
    user:addMoney(amount)
    TriggerClientEvent("inventory:removeItem", -1, "weedpackage", 1)
    
    exports["np-log"]:AddLog("Weed", 
        source, "Deliver Package", { type = "weedpackage", amount = tostring(amount) })
    return true
end)    

RPC.register("np-weed:processWeed", function(pSource)
    TriggerClientEvent("inventory:removeItem", -1, "smallbud", 10)
    TriggerClientEvent("DoLongHudText", -1, "Stay nearby a few minutes while I package this")
    Citizen.Wait(math.random(1000, 120000))
    
    exports["np-log"]:AddLog("Weed", 
        source, "Process Package", { type = "smallbud" })
    -- Need Trigger Phone xD
    -- Will Show Collect Package Interact
end)  

RPC.register("np-weed:buyDelivery", function(pSource)
    local user = exports["np-base"]:getModule("Player"):GetUser(pSource)

    if user:getCash() >= tonumber(WeedConfig.ListCost) then
        user:removeMoney(WeedConfig.ListCost)
        TriggerClientEvent("player:receiveItem", -1, "tacodeliverylist", 1)

        exports["np-log"]:AddLog("Weed", 
            source, "Buy Delivery", { type = "tacodeliverylist", amount = tostring(WeedConfig.ListCos) })
        return true
    else
        TriggerClientEvent("DoLongHudText", -1, "You have not enough money!", 2)
        return false    
    end    
end)    

-- Video Link = https://www.youtube.com/watch?v=t1v7h6og-7A&t=11103s 3:06:20 Start
-- Video 2 Link = https://www.youtube.com/watch?v=AZaxuHEhPl8 3:00 Start Delivery