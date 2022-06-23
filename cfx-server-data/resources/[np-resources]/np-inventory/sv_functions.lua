RegisterServerEvent("server-item-quality-update")
AddEventHandler("server-item-quality-update", function(player, data)
    if data.quality < 1 then
        exports.ghmattimysql:execute("UPDATE user_inventory2 SET `quality` = @quality WHERE name = @name AND slot = @slot AND item_id = @item_id", {
            ['quality'] = "0", 
            ['name'] = 'ply-' ..player, 
            ['slot'] = data.slot,
            ['item_id'] = data.itemid
        })
    end
end)

RegisterServerEvent("server-item-update-metadata")
AddEventHandler("server-item-update-metadata", function(inventoryName, slot, itemid, information)
    print("server-item-update-metadata", inventoryName, slot, itemid, information)
    exports.ghmattimysql:execute("UPDATE user_inventory2 SET `information` = @information WHERE name = @name AND slot = @slot AND item_id = @item_id", {
        ['information'] = information, 
        ['name'] = inventoryName, 
        ['slot'] = slot,
        ['item_id'] = itemid
    })
end)

RegisterNetEvent("inv:itemUsed")
AddEventHandler("inv:itemUsed", function(pItemId, slot, inventory)
    local src = source
    local remove = false

    if pItemId == nil then
        return
    end

    if not hasEnoughOfItem(src, pItemId, 1, false) then
        return TriggerClientEvent("DoLongHudText", src, "You dont appear to have this item on you?", 2)
    end

    --Note: Fake item for demo purposes
    if pItemId == 'bankbox' then
        if hasEnoughOfItem(src, 'bankboxkey', 1, true) then
            removeItem(src, 'bankboxkey', 1)
            TriggerEvent('np:loot:system:draw', src, pItemId)
            remove = true
        end
    end

    if remove then
        removeItem(src, pItemId, 1)
    end
end)

function GetDecayDate(pItemId)
    
end

function getQuantity(pServerId, pItemId)
    local user, amount = exports["np-base"]:getModule("Player"):GetUser(pServerId), 0

    if user then
        local invId = ('ply-%s'):format(user.character.id)
        local query = 'SELECT count(item_id) as amount FROM user_inventory2 WHERE name = @inventory AND item_id = @item'
        local p = promise:new()

        local decayDate

        if checkQuality then
            decayDate = exports['np-inventory']:GetDecayDate(pItemId)

            if decayDate then
                query = query .. ' AND @decayDate < creationDate'
            end
        end

        exports.ghmattimysql:scalar(query, { ['inventory'] = invId, ['item'] = pItemId, ['decayDate'] = decayDate}, function(data)
            p:resolve(data and data or 0)
        end)

        amount = Citizen.Await(p)
    end

    return amount
end

exports('getQuantity', getQuantity)

function removeItem(pServerId, pItemId, pAmount, pShouldNotify)
    local user = exports["np-base"]:getModule("Player"):GetUser(pServerId)

    if user then
        local notify = pShouldNotify == nil and true or pShouldNotify

        if pItemId == nil or pItemId == 0 or pAmount == nil or pAmount <= 0 then
            return false
        end

        TriggerEvent('server-remove-item', user.character.id, pItemId, pAmount)

        if notify then
            TriggerClientEvent('hud-display-item', pServerId, pItemId, "Removed", pAmount)
        end

        return true
    end

    return false
end

exports('removeItem', removeItem)

function hasEnoughOfItem(pServerId, pItemId, pAmount, pShouldReturnText)
    local notify = pShouldReturnText == nil and true or pShouldReturnText

    if pItemId == nil or pItemId == 0 or pAmount == 0 then
        if notify then
            TriggerClientEvent("DoLongHudText", pServerId, "I dont seem to have " .. pItemId .. " in my pockets.", 2)
        end
        return false
    end

    if getQuantity(pServerId, pItemId) >= pAmount then
        return true
    end

    if (notify) then
        TriggerClientEvent("DoLongHudText", pServerId, "I dont have enough of that item...", 2)
    end

    return false 
end


exports('hasEnoughOfItem', hasEnoughOfItem)


