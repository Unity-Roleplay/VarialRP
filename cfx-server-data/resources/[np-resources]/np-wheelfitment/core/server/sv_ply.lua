RPC.register("np-wheelfitment_sv:saveWheelfitment",function(pSource,plate,vehiclewheelMods)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	if not user then return end
	local char = user:getCurrentCharacter()
	if not char then return end
	local owner = user:getVar("hexid")
	if not owner then return end
	local vehicleMods = json.encode(vehiclewheelMods.param)
	exports.ghmattimysql:execute("UPDATE characters_cars SET wheelfitment=@wheels WHERE license_plate = @plate",
	{['wheels'] = vehicleMods, ['plate'] = plate.param})
end)

RPC.register("np-wheelfitment_sv:getfuckingdata",function(pSource,plyveh,plate)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	if not user then return end
	local char = user:getCurrentCharacter()
	if not char then return end
	local owner = user:getVar("hexid")
	if not owner then return end
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND license_plate = @plate ', { ['@cid'] = char.id, ['plate'] = plate.param}, function(result)
		if (result and result[1]) then
            TriggerClientEvent("np-wheelfitment_cl:applySavedWheelFitment", src, result[1].wheelfitment, plyveh.param)
        end
    end)
end)

-- RegisterNetEvent("np-wheelfitment_sv:getfuckingdata2",function(pSource,plyveh,plate)
	-- local src = source
	-- local user = exports["np-base"]:getModule("Player"):GetUser(src)
	-- if not user then return end
	-- local char = user:getCurrentCharacter()
	-- if not char then return end
	-- local owner = user:getVar("hexid")
	-- if not owner then return end
	-- exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND license_plate = @plate ', { ['@cid'] = char.id, ['plate'] = plate.param}, function(result)
		-- if (result and result[1]) then
            -- TriggerClientEvent("np-wheelfitment_cl:applySavedWheelFitment", src, result[1].wheelfitment, plyveh.param)
        -- end
    -- end)
-- end)