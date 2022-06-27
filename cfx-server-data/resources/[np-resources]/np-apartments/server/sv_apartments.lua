local currentRoomLocks = {
    [1] = {},
    [2] = {},
    [3] = {}
}

CURRENT_APARTMENTS = {}

RegisterServerEvent("apartment:serverLockdown")
AddEventHandler("apartment:serverLockdown",function(roomType, roomNumber)
end)

RegisterServerEvent("apartment:serverLockdownCID")
AddEventHandler("apartment:serverLockdownCID", function(roomCid, roomNumber)
end)

RegisterServerEvent("apartments:ToggleLocks")
AddEventHandler("apartments:ToggleLocks",function(roomType, roomNumber)
    currentRoomLocks[roomType][roomNumber] = not currentRoomLocks[roomType][roomNumber]
    TriggerClientEvent("apartments:apartmentLocks", -1, currentRoomLocks)
end)

RegisterServerEvent("apartment:serverApartmentSpawn")
AddEventHandler("apartment:serverApartmentSpawn",function(roomType, isNew, instance, isSpawn)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.ghmattimysql:execute("SELECT * FROM character_motel WHERE cid = @cid", {
        ["cid"] = char.id
    }, function(result)
        if #result > 0 then
            if isSpawn then
                TriggerClientEvent("apartments:enterMotel", src, result[1].id, roomType, isSpawn)
            end
            if isNew then
                TriggerClientEvent("apartments:enterMotel", src, result[1].id, roomType, isSpawn)
            end
            TriggerClientEvent("apartments:apartmentSpawn", src, {roomType = roomType}, result[1].id)
        end
        currentRoomLocks[roomType][result[1].id] = false
        TriggerClientEvent("apartments:apartmentLocks", -1, currentRoomLocks)
    end)
end)

RPC.register("GetMotelInformation", function(pSource, currentRoomType, currentRoomNumber)
    local returnData = Await(SQL.execute("SELECT * FROM character_motel WHERE id = @number AND building_type = @type", {
        ["number"] = currentRoomNumber,
        ["type"] = currentRoomType
    }))

    return returnData
end)

RPC.register("IsValidRoom", function(pSource, roomType, roomNumber)
    local returnData = Await(SQL.execute("SELECT * FROM character_motel WHERE id = @number AND building_type = @type", {
        ["number"] = roomNumber,
        ["type"] = roomType
    }))

    local retval = false

    if returnData[1] then
        retval = true
    end

    return retval
end)

RPC.register("getApartmentInformation", function(pSource)
    return Apart.info
end)

RPC.register("apartment:allCurrentApartmentsOfRoomType", function(pSource, pRoomType)
    for k,v in pairs(currentRoomLocks[pRoomType]) do
        if (CURRENT_APARTMENTS[k]) then return CURRENT_APARTMENTS end
        table.insert(CURRENT_APARTMENTS, k)
    end

    return CURRENT_APARTMENTS
end)

RPC.register("upgradeApartment", function(pSource, apartmentTargetType, roomType, roomNumber)
    local returnData = Await(SQL.execute("SELECT * FROM character_motel WHERE id = @number AND building_type = @type", {
        ["number"] = roomNumber,
        ["type"] = roomType
    }))

    SQL.execute("UPDATE character_motel SET building_type = @type WHERE id = @number", {
        ["number"] = roomNumber,
        ["type"] = apartmentTargetType
    })

    return true
end)

RPC.register("apartment:forclose", function(pSource, roomType, roomNumber)

end)

RPC.register("apartment:getOwner", function(pSource, roomType, roomNumber)
    local returnData = Await(SQL.execute("SELECT * FROM character_motel WHERE id = @number AND building_type = @type", {
        ["number"] = roomNumber,
        ["type"] = roomType
    }))

    return returnData[1].cid
end)
   

RegisterServerEvent("apartment:upgradeApartment2")
AddEventHandler("apartment:upgradeApartment2",function(price)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if user:getCash() >= price then
        user:removeMoney(price)
        exports.ghmattimysql:execute("UPDATE character_motel SET building_type=@building_type WHERE cid=@cid",{
            ["cid"] = char.id,
            ["building_type"] = 2
        })
    else
        TriggerClientEvent('DoLongHudText', source, "You can't afford that", 2)
    end
end)

RegisterServerEvent("apartment:upgradeApartment3")
AddEventHandler("apartment:upgradeApartment3",function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if user:getCash() >= price then
        user:removeMoney(price)
        exports.ghmattimysql:execute("UPDATE character_motel SET building_type=@building_type WHERE cid=@cid",{
            ["cid"] = char.id,
            ["building_type"] = 3
        })
    else
        TriggerClientEvent('DoLongHudText', source, "You can't afford that", 2)
    end
end)

