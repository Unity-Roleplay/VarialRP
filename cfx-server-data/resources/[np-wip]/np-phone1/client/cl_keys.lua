--[[

    Functions

]]

function loadKeys()
    local _ownedKeys = RPC.execute("getCurrentOwned")
    local _sharedKeys = RPC.execute("currentKeys")

    local ownedKeys = {}
    for k, v in pairs(_ownedKeys) do
        table.insert(ownedKeys, {
            house_id = v.house_id,
            house_name = v.house_name,
            house_price = v.house_price,
            last_payment = v.last_payment,
        })
    end

    local sharedKeys = {}
    for k, v in pairs(_sharedKeys) do
        table.insert(sharedKeys, {
            house_id = v.house_id,
            house_name = v.house_name,
            house_price = v.house_price,
            last_payment = v.last_payment
        })
    end

    SendNUIMessage({
        openSection = "keys",
        keys = {
            ownedKeys = ownedKeys,
            sharedKeys = sharedKeys
        }
    })
end

function GetClosestPlayer(coords, pDist)
    local closestPlyPed
    local closestPly
    local dist = -1

    for _, player in ipairs(GetActivePlayers()) do
        if player ~= PlayerId() then
            local ped = GetPlayerPed(player)
            local pedcoords = GetEntityCoords(ped)
            local newdist = #(coords - pedcoords)

            if (newdist <= pDist) then
                if (newdist < dist) or dist == -1 then
                    dist = newdist
                    closestPlyPed = ped
                    closestPly = player
                end
            end
        end
    end

    return closestPlyPed, closestPly, GetPlayerServerId(closestPly)
end

--[[

    NUI

]]

RegisterNUICallback("btnProperty2", function(data, cb)
    loadKeys()
    cb("ok")
end)

RegisterNUICallback('retrieveHouseKeys', function(data, cb)
    local pSharedKeys = RPC.execute("np-phone:getHouseKeys", data.house_id)

    SendNUIMessage({
        openSection = "manageKeys",
        sharedKeys = pSharedKeys
    })

    cb("ok")
end)

RegisterNUICallback('removeHouseKey', function(data, cb)
    local removed = RPC.execute("np-phone:removeKey", data.house_id, data.player_id)

    if removed then
        local pSharedKeys = RPC.execute("np-phone:getHouseKeys", data.house_id)

        SendNUIMessage({
            openSection = "manageKeys",
            sharedKeys = pSharedKeys
        })
    end

    cb("ok")
end)

RegisterNUICallback("btnMortgage", function(data, cb)
    local payed, message = RPC.execute("np-phone:payHouse", data.house_id)

    if payed then
        loadKeys()
    else
        phoneNotification("fas fa-exclamation-circle", "Error", message, 5000)
    end

    cb("ok")
end)

RegisterNUICallback("btnGiveKey", function(data, cb)
    local tped, tply, tplyId = GetClosestPlayer(GetEntityCoords(PlayerPedId()), 5.0)

    if tped ~= nil and tped > 0 then
        local gived, message = RPC.execute("np-phone:giveKey", data.house_id, tplyId)
        if gived then
            phoneNotification("fas fa-key", "Keys", message, 5000)
        else
            phoneNotification("fas fa-exclamation-circle", "Error", message, 5000)
        end
    else
        phoneNotification("fas fa-exclamation-circle", "Error", "No player near you (maybe get closer)!", 5000)
    end

    cb("ok")
end)

RegisterNUICallback("removeSharedKey", function(data, cb)
    local removed = RPC.execute("np-phone:removeSharedKey", data.house_id)

    if removed then
        loadKeys()
    end

    cb("ok")
end)







