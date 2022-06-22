local hmm = vehicleBaseRepairCost

RegisterServerEvent('np-bennys:attemptPurchase')
AddEventHandler('np-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('np-bennys:purchaseSuccessful', src)

            exports["np-log"]:AddLog("Bennys", 
                src, 
                "Repair", 
                { amount = tostring(hmm) })
        else
            TriggerClientEvent('np-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('np-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])

            exports["np-log"]:AddLog("Bennys", 
                src, 
                "Performance", 
                { amount = tostring(vehicleCustomisationPrices[type].prices[upgradeLevel]) })
        else
            TriggerClientEvent('np-bennys:purchaseFailed', src)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('np-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].price)

            exports["np-log"]:AddLog("Bennys", 
                src, 
                "Other", 
                { type = tostring(type), amount = tostring(vehicleCustomisationPrices[type].price) })
        else
            TriggerClientEvent('np-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('np-bennys:updateRepairCost')
AddEventHandler('np-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('np-bennys:repairciv')
AddEventHandler('np-bennys:repairciv', function(amount)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", src)

        exports["np-log"]:AddLog("Bennys", 
            src, 
            "Repair Civ", 
            { amount = tostring(amount) })
    end
end)