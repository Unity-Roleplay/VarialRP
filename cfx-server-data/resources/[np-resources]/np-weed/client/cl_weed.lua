AddEventHandler("np-inventory:itemUsed", function(item, passedItemInfo, inventoryName, slot)
    if item == "driedbud" then
        local parsedInfo = json.decode(passedItemInfo)
        local finished = exports["np-taskbar"]:taskBar(5000, _L('weed-pack-bud', 'Packing'), false, true, false, false, nil, 5.0, PlayerPedId())
        if finished == 100 then
            TriggerEvent("inventory:removeItemByMetaKV", item, 1, "id", parsedInfo.id)
            local budData = {
                strain = parsedInfo.strain,
                quality = parsedInfo.quality,
                _hideKeys = {"quality"}
            }
            TriggerEvent("player:receiveItem", "smallbud", WeedConfig.BudPerDried, false, budData)
        end
    end

    if item == "weedpackage" then
        TriggerEvent("np-weed:prepareBaggies", {}, PlayerPedId())
        -- local parsedInfo = json.decode(passedItemInfo)
        -- local budData = {
        --     strain = getStrainNameFromQuality(parsedInfo.quality),
        --     quality = parsedInfo.quality,
        --     _hideKeys = {"quality"}
        -- }
        -- TriggerEvent("player:receiveItem", "smallbud", 10, false, budData)
        -- TriggerEvent("inventory:removeItemByMetaKV", item, 1, "quality", parsedInfo.quality)
    end
end)
