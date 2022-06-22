Citizen.CreateThread(function()
	ResetGarages()
	ResetPDGarages()
end)

function ResetGarages()

	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE vehicle_state = ?', {"Out"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state WHERE license_plate = @plate", {['state'] = 'In', ['plate'] = v.license_plate})
		end
	end)
end


function ResetPDGarages()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE vehicle_state = @state AND current_garage = @garage', {['@state'] = "Out",["garage"] = "Police Shared"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state WHERE license_plate = @plate", {['state'] = 'In', ['plate'] = v.license_plate})
		end
	end)
end


RegisterServerEvent("np-garages:resetpdgarage")
AddEventHandler("np-garages:resetpdgarage",function ()
    ResetPDGarages()
end)



RegisterServerEvent("np-garages:resetcartoimpound")
AddEventHandler("np-garages:resetcartoimpound",function (plate)
	exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage WHERE license_plate = @plate", {['state'] = 'In',['garage'] = 'Impound Lot', ['plate'] = plate})
end)

RPC.register("np-garages:select",function(pSource,garname)
	local src = source
	if garname.param == "Impound Lot" then
		exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE vehicle_state = @state', {['@state'] = "Out"}, function(vehicles)
			for k, v in ipairs(vehicles) do
				TriggerClientEvent("np-garages:resetcartoimpound", src, v.license_plate)
			end
		end)
	end

    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND current_garage = @garage ', { ['@cid'] = char.id, ["garage"] = garname.param }, function(result)
		if (result and result[1]) then
			for ind, value in pairs(result) do
				enginePercent = value.engine_damage / 10
				bodyPercent = value.body_damage / 10
				curGarage = value.current_garage
				TriggerClientEvent('np-context:sendMenu', src, {
					{
						id = value.id,
						header = value.name,
						txt = 'Plate: ' .. value.license_plate,
						params = {
							event = "np-garages:takeout",
							args = value.id
						}
					},
				})
			end
		else
			TriggerClientEvent('DoLongHudText', src, 'There is no parked vehicles in this garage.', 2)
		end
	end)
end)

RPC.register("np-garages:selectShared",function(pSource,garname)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE current_garage = @garage ', { ["garage"] = garname.param }, function(result)
		if (result[1]) then
			for ind, value in pairs(result) do
				enginePercent = value.engine_damage / 10
				bodyPercent = value.body_damage / 10
				curGarage = value.current_garage

				TriggerClientEvent('np-context:sendMenu', src, {
					{
						id = value.id,
						header = value.name,
						txt = 'Plate: ' .. value.license_plate,
						params = {
							event = "np-garages:takeout2",
							args = value.id
						}
					},
				})
			end
		else
			TriggerClientEvent('DoLongHudText', src, "There is no parked vehicles in this garage.", 2)
		end
	end)
end)

RPC.register("np-garages:attempt:sv",function(pSource,pdata)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND id = @id', { ['@cid'] = char.id, ['@id'] = pdata.param }, function(result)
		for ind, value in pairs(result) do
			TriggerClientEvent('np-context:sendMenu', src, {
				{
					id = "close",
					header = "< Go Back",
					txt = "",
					params = {
						event = "np-garages:open"
					}
				},
				{
					id = "take",
					header = "Take Out : " ..value.name ,
					txt = 'Spawn Selected Vehicle',
					params = {
						event = "np-garages:attempt:spawn",
						args = result
					}
				},
				{
					id = "status",
					header = "Vehicle Status",
					txt = 'Garage : ' ..value.current_garage.. ' | Body : ' .. bodyPercent .. '% | Engine : ' .. enginePercent..'% | Fuel : '..value.fuel..'%',
					params = {
						event = "np-garages:open"
					}
				},
				
			})
		end
	end)
end)

RPC.register("np-garages:attempt:sv2",function(pSource,pdata)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE id = @id', { ['@id'] = pdata.param }, function(result)
		for ind, value in pairs(result) do
			TriggerClientEvent('np-context:sendMenu', src, {
				{
					id = "close",
					header = "< Go Back",
					txt = "",
					params = {
						event = "np-garages:open2"
					}
				},
				{
					id = "take",
					header = "Take Out : " ..value.name ,
					txt = 'Spawn Selected Vehicle',
					params = {
						event = "np-garages:attempt:spawn2",
						args = result
					}
				},
				{
					id = "status",
					header = "Vehicle Status",
					txt = 'Garage : ' ..value.current_garage.. ' | Body : ' .. bodyPercent .. '% | Engine : ' .. enginePercent..'% | Fuel : '..value.fuel..'%',
					params = {
						event = "np-garages:open2"
					}
				},
				
			})
		end
	end)
end)

RPC.register("np-garages:spawned:get",function(pSource,valid)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()

	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND id = @id', { ['@cid'] = char.id, ['@id'] = valid.param }, function(result)
		if result[1].vehicle_state == "In" then
			TriggerClientEvent("np-garages:attempt:spawn", src, result, true)
		else
			TriggerClientEvent('DoLongHudText', src, 'Vehicle is not in the garage. Check in your phone maybe.', 2)
		end
    end)
end)

RPC.register("np-garages:spawned:getShared",function(pSource,valid)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()

	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE id = @id', { ['@id'] = valid.param }, function(result)
		if result[1].vehicle_state == "In" then
			TriggerClientEvent("np-garages:attempt:spawn2", src, result, true)
		else
			TriggerClientEvent('DoLongHudText', src, 'Vehicle is not in the garage. Check in your phone maybe.', 2)
		end
    end)
end)

RPC.register("np-garages:states",function(pSource,state,plate,curGarage,fuel)
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND license_plate = @plate', { ['@cid'] = char.id, ['@plate'] = plate.param }, function(result)
		exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel WHERE license_plate = @plate", {['garage'] = curGarage.param, ['state'] = state.param, ['fuel'] = fuel.param, ['plate'] = plate.param})
    end)
	return true
end)

RPC.register("np-garages:getonlyimpound",function(pSource)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND vehicle_state = @vehiclestate', { ['@cid'] = char.id, ['@vehiclestate'] = "Out"}, function(result)
		if (result and result[1]) and result[1].vehicle_state == "Out" then
			for ind, value in pairs(result) do
				enginePercent = value.engine_damage / 10
				bodyPercent = value.body_damage / 10
				curGarage = value.current_garage

				TriggerClientEvent('np-context:sendMenu', src, {
					{
						id = value.id,
						header = value.name,
						txt = 'Plate: ' .. value.license_plate,
						params = {
							event = "np-garages:takeout",
							args = value.id
						}
					},
				})
			end
		else
			TriggerClientEvent('DoLongHudText', src, 'You have no vehicle here', 2)
		end
	end)
end)

RegisterServerEvent('garages:CheckGarageForVeh')
AddEventHandler("garages:CheckGarageForVeh", function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id

    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid', { ['@cid'] = owner }, function(vehicles)
		local v = vehicles[1]
        TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)

RegisterServerEvent('garages:carisout')
AddEventHandler("garages:carisout", function()
    exports.ghmattimysql:execute('SELECT * FROM characters_cars', {}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, coords = @coords WHERE license_plate = @plate", {['state'] = 'In', ['coords'] = nil, ['plate'] = v.license_plate})
			end
		end
	end)
end)


RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods,plate)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	if not user then return end
	local char = user:getCurrentCharacter()
	if not char then return end
	local owner = user:getVar("hexid")
	if not owner then return end
	vehicleMods = json.encode(vehicleMods)
	exports.ghmattimysql:execute("UPDATE characters_cars SET data=@mods WHERE license_plate = @plate",
	{['mods'] = vehicleMods, ['plate'] = plate})
end)

RegisterServerEvent("yorktax:vic")
AddEventHandler("yorktax:vic",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(5000)
end)

RegisterServerEvent("yorktax:blazer")
AddEventHandler("yorktax:blazer",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(10000)
end)

RegisterServerEvent("yorktax:exp")
AddEventHandler("yorktax:exp",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(15000)
end)

RegisterServerEvent("yorktax:mm")
AddEventHandler("yorktax:mm",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(15000)
end)

RegisterServerEvent("yorktax:vette")
AddEventHandler("yorktax:vette",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(75000)
end)

RegisterServerEvent("yorktax:chal")
AddEventHandler("yorktax:chal",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(85000)
end)

RegisterServerEvent("yorktax:stang")
AddEventHandler("yorktax:stang",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(65000)
end)

RegisterServerEvent("yorktax:char")
AddEventHandler("yorktax:char",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(30000)
end)

RegisterServerEvent("yorktax:speedo")
AddEventHandler("yorktax:speedo",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(5000)
end)

RegisterServerEvent("yorktax:bamb")
AddEventHandler("yorktax:bamb",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(5000)
end)

RegisterServerEvent("yorktax:bexp")
AddEventHandler("yorktax:bexp",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(15000)
end)

RegisterServerEvent("yorktax:emspro")
AddEventHandler("yorktax:emspro",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(35000)
end)