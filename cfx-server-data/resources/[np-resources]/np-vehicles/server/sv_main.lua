RegisterServerEvent("transfer:attempt:send")
AddEventHandler("transfer:attempt:send", function(plate, target)
    local pSrc = source
    local pUser = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local pChar = pUser:getCurrentCharacter().id
    local pSteam = GetPlayerIdentifiers(pSrc)[1]

    -- target shit
    local tUser = exports["np-base"]:getModule("Player"):GetUser(target)
    local tChar = tUser:getCurrentCharacter().id
    local tSteam = GetPlayerIdentifiers(target)[1]

    exports.oxmysql:execute("SELECT * FROM characters_cars WHERE cid = ? AND license_plate = ?",{pChar, plate}, function(data)
        if data[1] then
            exports.oxmysql:execute("UPDATE characters_cars SET `cid` = @cid, `cid` = @cid WHERE license_plate = @license_plate", {
                ['cid'] = tChar, 
                ['owner'] = tSteam,
                ['license_plate'] = plate
            })
            TriggerClientEvent("DoLongHudText", pSrc, "You have successfully transfered this vehicle!")
            TriggerClientEvent("DoLongHudText", target, "You have successfully received keys to your new ride!")
            TriggerClientEvent("keys:remove", pSrc, plate)
            TriggerClientEvent('keys:received', target, plate)
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You dont own this vehicle", 2)
        end

    end)
end)