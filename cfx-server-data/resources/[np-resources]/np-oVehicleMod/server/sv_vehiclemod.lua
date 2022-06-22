local plateChanges = {}

local function findPlate(plate)
    for k,v in pairs(plateChanges) do
        if plate == v then
            return k
        end
    end
    return nil
end

RegisterServerEvent("vehicleMod:changePlate")
AddEventHandler("vehicleMod:changePlate", function(newPlate, isFake, oldPlate)
    if isFake then
        plateChanges[newPlate] = oldPlate
    else
        local tempPlate = findPlate(newPlate)
        if tempPlate ~= nil then
            plateChanges[tempPlate] = nil
        end
    end
end)

RegisterServerEvent("vehicleMod:getHarness")
AddEventHandler("vehicleMod:getHarness", function(plate)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end 
    exports.ghmattimysql:execute("SELECT harness FROM characters_cars WHERE license_plate = @plate", {['plate'] = plate}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            TriggerClientEvent("vehicleMod:setHarness", src, result[1].harness, false)
        else
            TriggerClientEvent("vehicleMod:setHarness", src, false, false)
        end
    end)
end)

RegisterServerEvent("vehicleMod:applyHarness")
AddEventHandler("vehicleMod:applyHarness", function(plate, durability)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end

    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = durability
    }, function(result)
        if result ~= nil and result.changedRows ~= 0 then
            TriggerClientEvent("vehicleMod:setHarness", src, durability, true)
        else
            TriggerClientEvent("vehicleMod:setHarness", src, false, true)
        end
    end)
end)

RegisterServerEvent("vehicleMod:updateHarness")
AddEventHandler("vehicleMod:getHarness", function(plate, durability)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end
    
    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = durability
    }, function()
    end)
end)

RegisterServerEvent("vehicleMod:breakHarness")
AddEventHandler("vehicleMod:breakHarness", function(plate)
    local src = source
    
    if plateChanges[plate] ~= nil then
        plate = plateChanges[plate]
    end
    
    exports.ghmattimysql:execute("UPDATE characters_cars SET harness = @durability WHERE license_plate = @plate",
    {
        ['plate'] = plate,
        ['durability'] = 0
    }, function()
    end)
end)

RegisterServerEvent("carhud:ejection:server")
AddEventHandler("carhud:ejection:server", function(player, value)
    TriggerClientEvent("carhud:ejection:server", player, value)
end)

RegisterServerEvent("NetworkNos")
AddEventHandler("NetworkNos", function(player)
    TriggerClientEvent("NetworkNos",player)
end)

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

    exports.ghmattimysql:execute("SELECT * FROM characters_cars WHERE cid = ? AND license_plate = ?",{pChar, plate}, function(data)
        if data[1] then
            exports.ghmattimysql:execute("UPDATE characters_cars SET `cid` = @cid, `owner` = @owner WHERE license_plate = @license_plate", {
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

RegisterCommand("seat", function(source, args, rawCommand)
    if not args[2] or not tonumber(args[2]) then return end
    TriggerEvent('vehicle:swapSeat', tonumber(args[2]))
  end, false)