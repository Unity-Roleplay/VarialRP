local fishes = { "fishingbass", "fishingcod", "fishingmackerel", "fishingbluefish", "fishingflounder" }
local bMarketFishes = { "fishingwhale", "fishingdolphin", "fishingshark" }
local nightTime = false
local pricePerFish = 100

local function sellFish()
    local totalFish = 0
    local totalBMarketFish = 0

    function processFish(fish, bMarket)
        local qty = exports["np-inventory"]:getQuantity(fish, true)

        if not bMarket then
            totalFish = totalFish + qty
        else
            totalBMarketFish = totalBMarketFish + qty
        end
        
        if qty > 0 and (not bMarket or (bMarket and nightTime)) then
            TriggerEvent("inventory:removeItem", fish, qty)
        end
    end

    for _, fish in pairs(fishes) do
        processFish(fish, false)
    end
    for _, fish in pairs(bMarketFishes) do
        processFish(fish, true)
    end

    if totalFish == 0 and totalBMarketFish == 0 then
        TriggerEvent("DoLongHudText", "Nothing to sell, dummy.", 2)
    end
    
    if totalFish > 0 then
        --RPC.execute("np-financials:giveJobPay", "fishing_sales", totalFish * pricePerFish)
        RPC.execute("givePlayerJobPay", "fishing_sales", totalFish * pricePerFish)
        TriggerEvent("DoLongHudText", "Added to bank!")
    end

    if totalBMarketFish > 0 then
        if nightTime then
            --local payoutFactor = exports["np-config"]:GetModuleConfig("main").payoutFactor
            TriggerEvent("player:receiveItem", "band", math.floor(9 * totalBMarketFish))
        else
            TriggerEvent("DoLongHudText", "Come back later if you want to sell those extra 'fish'", 1)
        end
    end
end

AddEventHandler("np-npcs:ped:sellFish", function()
    sellFish()
end)

RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(pHour, pMinutes)
    if pHour > 19 or pHour < 5 then
        nightTime = true
    else
        nightTime = false
    end
end)
