local koil = vehicleBaseRepairCost

RegisterServerEvent('mechanic:attemptPurchase')
AddEventHandler('mechanic:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= koil then
            user:removeMoney(koil)
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('mechanic:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('mechanic:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('mechanic:updateRepairCost')
AddEventHandler('mechanic:updateRepairCost', function(cost)
    koil = cost
end)
