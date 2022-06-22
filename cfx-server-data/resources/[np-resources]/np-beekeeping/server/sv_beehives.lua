RPC.register("np-beekeeping:installHive", function(pSource, pCoords, pHeading)
    local syncedTimeStamp = os.time()
    local installHive = Await(SQL.execute("INSERT INTO _beehives (coords, heading, timestamp) VALUES (?, ?, ?)", json.encode(pCoords), pHeading, syncedTimeStamp))

    if installHive.affectedRows then
        TriggerClientEvent("np-beekeeping:trigger_zone", -1, 2, {
            id = installHive.insertId,
            coords = pCoords,
            heading = pHeading,
            has_queen = false,
            last_harvest = 0,
            timestamp = syncedTimeStamp
        })

        exports["np-log"]:AddLog("Bee Keeping", 
            pSource, 
            "Installed Hive", 
            { id = installHive.insertId, coords = json.encode(pCoords), heading = tostring(pHeading) })
    end

    return true
end)

RPC.register("np-beekeeping:addQueen", function(pSource, pID)
    local addQueen = Await(SQL.execute("UPDATE _beehives SET has_queen = ? WHERE id = ?", true, pID))

    if addQueen.affectedRows > 0 then
        local dataQueen = Await(SQL.execute("SELECT * FROM _beehives WHERE id = ?", pID))
		
        local coords = json.decode(dataQueen[1].coords)
        dataQueen[1].coords = vector3(coords.x, coords.y, coords.z)
        TriggerClientEvent("np-beekeeping:trigger_zone", -1, 3, dataQueen[1])
    end

    return true
end)

RPC.register("np-beekeeping:removeHive", function(pSource, pData, pIsReady)
    SQL.execute("DELETE FROM _beehives WHERE id = ?", pData.id)

    TriggerClientEvent("np-beekeeping:trigger_zone", -1, 4, pData)
    return true
end)

RPC.register("np-beekeeping:harvestHive", function(pSource, pID)
    local chance = math.random()
    if HiveConfig.QueenChance > chance then
        TriggerClientEvent("player:receiveItem", pSource, "beequeen", 1)
    end

    TriggerClientEvent("player:receiveItem", pSource, "beeswax", 1)
    TriggerClientEvent("player:receiveItem", pSource, "honey", 3)
    
    local harvestHive = Await(SQL.execute("UPDATE _beehives SET last_harvest = ? WHERE id = ?", os.time(), pID))
    
    if harvestHive.affectedRows > 0 then
        local dataHive = Await(SQL.execute("SELECT * FROM _beehives WHERE id = ?", pID))

        local coords = json.decode(dataHive[1].coords)
        dataHive[1].coords = vector3(coords.x, coords.y, coords.z)
        if ((os.time() - dataHive[1].timestamp) / 60) >= HiveConfig.LifeTime then
            SQL.execute("DELETE FROM _beehives WHERE id = ?", pID)

            TriggerClientEvent("np-beekeeping:trigger_zone", -1, 4, dataHive[1])
        else
            TriggerClientEvent("np-beekeeping:trigger_zone", -1, 3, dataHive[1])
        end
        return true
    end
end)

RPC.register("np-beekeeping:getBeehives", function(pSource)
    print("fetching beehives")
    local getBeehives = Await(SQL.execute("SELECT * FROM _beehives"))
	
    for k, v in pairs(getBeehives) do
        print(json.encode(v))
        local coords = json.decode(v.coords)
        v.coords = vector3(coords.x, coords.y, coords.z)
    end

    TriggerClientEvent("np-beekeeping:trigger_zone", -1, 1, getBeehives)
    return true
end)