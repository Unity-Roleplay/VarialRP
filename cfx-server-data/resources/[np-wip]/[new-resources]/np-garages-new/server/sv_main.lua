fakeplates = {}

pSharedGarageNames = {
	"Police Department",
	"Pillbox",
	'Marina' -- boat lol for ma yacht : D | aleks 👍
}

RPC.register("np-garages:select", function(pGarage, job, pType)
    local pSrc = source
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	local isShared = isSharedGarage(pGarage)
	if isShared and not pType then
		TriggerClientEvent('np-context:sendMenu', pSrc, {
			{
				id = 1,
				header = "Personal Garage",
				txt = "List of Personal Vehicles",
				params = {
					event = "np-garages:select:option",
					args = {
						type = "personal"
					}
				}
			},
			{
				id = 2,
				header = "Shared Garage",
				txt = "List of Shared Vehicles",
				params = {
					event = "np-garages:select:option",
					args = {
						type = "shared"
					}
				}
			},
		})

	elseif isShared and pType == "shared" then
		exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE job = @job AND current_garage = @garage', { ['@job'] = job, ['@garage'] = pGarage}, function(vehicles)
			if vehicles[1] ~= nil then
				for i = 1, #vehicles do
					if vehicles[i].vehicle_state ~= "Out" then
						TriggerClientEvent('np-context:sendMenu', pSrc, {
							{
								id = vehicles[i].id,
								header = vehicles[i].name,
								txt = "Plate: "..vehicles[i].license_plate,
								params = {
									event = "np-garages:attempt:spawn",
									args = {
										id = vehicles[i].id,
										engine = vehicles[i].engine_damage,
										current_garage = vehicles[i].current_garage,
										body = vehicles[i].body_damage,
										model = vehicles[i].model,
										fuel = vehicles[i].fuel, 
										customized = vehicles[i].data,
										plate = vehicles[i].license_plate,
										shared = true,
										job = job,
									}
								}
							},
						})
					end
				end
			else
				TriggerClientEvent("DoLongHudText", pSrc, "You have no vehicles here!", 2)
				return
			end
		end)

	else 
		exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND current_garage = @garage', { ['@cid'] = char.id, ['@garage'] = pGarage}, function(vehicles)
			if vehicles[1] ~= nil then
				for i = 1, #vehicles do
					if vehicles[i].vehicle_state ~= "Out" then
						TriggerClientEvent('np-context:sendMenu', pSrc, {
							{
								id = vehicles[i].id,
								header = vehicles[i].name,
								txt = "Plate: "..vehicles[i].license_plate,
								params = {
									event = "np-garages:attempt:spawn",
									args = {
										id = vehicles[i].id,
										engine = vehicles[i].engine_damage,
										current_garage = vehicles[i].current_garage,
										body = vehicles[i].body_damage,
										model = vehicles[i].model,
										fuel = vehicles[i].fuel, 
										customized = vehicles[i].data,
										plate = vehicles[i].license_plate,
										held = vehicles[i].seizuredata,
									}
								}
							},
						})
					end
				end
			else
				TriggerClientEvent("DoLongHudText", pSrc, "You have no vehicles here!", 2)
				return
			end
		end)
	end
end)


RPC.register("np-garages:selectShared", function(pGarage)
    local pSrc = source
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE current_garage = @garage', { ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('np-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].model,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "np-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate,
									held = vehicles[i].seizuredata,
								}
							}
						},
					})
				end
            end
        else
            TriggerClientEvent("DoLongHudText", pSrc, "You have no vehicles here!", 2)
            return
        end
	end)
end)



RPC.register("np-garages:attempt:sv", function(data)
    local pSrc = source
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()


    local enginePercent = data.engine / 10
	local bodyPercent = data.body / 10
	TriggerClientEvent('np-context:sendMenu', pSrc, {
		{
			id = 1,
			header = "< Go Back",
			txt = "Return to your list of all your vehicles.",
			params = {
				event = "np-garages:open"
			}
		},
		{
			id = 2,
			header = "Take Out Vehicle",
			txt = "Spawn the vehicle!",
			params = {
				event = "np-garages:takeout",
				args = {
					pVeh = data.id,
					shared = data.shared,
					job = data.job
				}
			}
			
		},
		{
			id = 3,
			header = "Vehicle Status",
			txt = "Garage: "..data.current_garage.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
	})
end)


RPC.register("np-garages:managePlates", function(newPlate, oldPlate, param)
	if param == "add" then
		if fakeplates[newPlate] == nil then
			fakeplates[newPlate] = {
				isOn = true,
				oldPlate = oldPlate,
				plate = newPlate

			}
		end
	elseif param == "remove" then
		fakeplates[newPlate] = nil
		json.encode(fakeplates)
	elseif param == "get" then
		return fakeplates
	end

	
	return fakeplates
end)

RPC.register("np-garages:fake:plate:data", function(pType, plate_number)
	if pType == "real_plate" then
		if fakeplates[plate_number] ~= nil then
			return fakeplates[plate_number].oldPlate
		end
	elseif pType == "active" then
		if fakeplates[plate_number] ~= nil then
			return true
		else
			return false
		end
	end
end)

RPC.register("np-garages:spawned:get", function(pID, shared, job)
    local pSrc = source
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	local args =  {}
	if shared then
		exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE job = @job AND id = @id', { ['@job'] = job, ['@id'] = pID}, function(vehicles)
			args = {
				model = vehicles[1].model,
				fuel = vehicles[1].fuel, 
				customized = vehicles[1].data,
				plate = vehicles[1].license_plate,
				engine = vehicles[1].engine_damage,
				body = vehicles[1].body_damage,
			}
	
			if vehicles[1].current_garage == "Impound Lot" then
				if vehicles[1].vehicle_state == 'Normal Impound' then
					if user:getCash() >= 500 then
						user:removeMoney(500)
						exports["np-banking"]:UpdateSociety(500, "judge", "add")
						TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
					else
						TriggerClientEvent("DoLongHudText", pSrc, "You need $500", 2)
						TriggerClientEvent("impound:return", pSrc)
						return
					end
				elseif vehicles[1].vehicle_state == 'Police Impound' then
					if user:getCash() >= 5000 then
						user:removeMoney(5000)
						exports["np-banking"]:UpdateSociety(5000, "judge", "add")
						TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
					else
						TriggerClientEvent("DoLongHudText", pSrc, "You need $5000", 2)
						TriggerClientEvent("impound:return", pSrc)
						return
					end
				end
			else
				TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
			end
		end)
	else
		exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND id = @id', { ['@cid'] = char.id, ['@id'] = pID}, function(vehicles)
			args = {
				model = vehicles[1].model,
				fuel = vehicles[1].fuel, 
				customized = vehicles[1].data,
				plate = vehicles[1].license_plate,
				engine = vehicles[1].engine_damage,
				body = vehicles[1].body_damage
			}

			if vehicles[1].current_garage == "Impound Lot" then
				if vehicles[1].vehicle_state == 'Normal Impound' then
					if user:getCash() >= 500 then
						user:removeMoney(500)
						TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
					else
						TriggerClientEvent("DoLongHudText", pSrc, "You need $500", 2)
						TriggerClientEvent("impound:return", pSrc)
						return
					end
				elseif vehicles[1].vehicle_state == 'Police Impound' then
					if user:getCash() >= 5000 then
						user:removeMoney(5000)
						TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
					else
						TriggerClientEvent("DoLongHudText", pSrc, "You need $5000", 2)
						TriggerClientEvent("impound:return", pSrc)
						return
					end
				end
			else
				
				TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
			end
		end)
	end
end)

RPC.register("np-garages:spawned:getShared", function(pID)
    local pSrc = source
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE id = @id', { ['@cid'] = char.id, ['@id'] = pID}, function(vehicles)
		args = {
			model = vehicles[1].model,
			fuel = vehicles[1].fuel, 
			customized = vehicles[1].data,
			plate = vehicles[1].license_plate,
			engine = vehicles[1].engine_damage,
			body = vehicles[1].body_damage,
		}
			TriggerClientEvent("np-garages:attempt:spawn", pSrc, args, true)
	end)
end)

RPC.register("np-garages:states", function(pState, plate, garage, fuel, bodydamage, enginedamage)
    local pSrc = source
	local shared = false
	if exports['np-vehicledegrade']:isSharedVehicle(plate) then
		exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE license_plate = ?', {plate}, function(pIsValid)
			if pIsValid[1] then
				local isShared = isSharedGarage(garage)
				if isShared then
					pExist = true
					shared =  true
					exports.ghmattimysql:execute("UPDATE shared_vehicles SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, engine_damage = @engine_damage, body_damage = @body_damage WHERE license_plate = @plate", {
						['garage'] = garage, 
						['state'] = pState, 
						['plate'] = plate,  
						['fuel'] = fuel, 
						['body_damage'] = bodydamage,
						['engine_damage'] = enginedamage
					})
				else
					pExist = false
					shared =  true
					TriggerClientEvent("DoLongHudText", pSrc, "You can only store shared vehicles in the department garages", 2)
				end
			else
				pExist = false
			end
		end)
	else
		exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = ?', {plate}, function(pIsValid)
			if pIsValid[1] then
				pExist = true
				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, coords = @coords, engine_damage = @engine_damage, body_damage = @body_damage WHERE license_plate = @plate", {
					['garage'] = garage, 
					['state'] = pState, 
					['plate'] = plate,  
					['fuel'] = fuel, 
					['body_damage'] = bodydamage,
					['engine_damage'] = enginedamage,
					['coords'] = nil
				})
			else
				pExist = false
			end
		end)
	end

	Citizen.Wait(100)
	return pExist, shared
end)


RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods,plate)
	vehicleMods = json.encode(vehicleMods)
	if exports['np-vehicledegrade']:isSharedVehicle(plate) then
		exports.ghmattimysql:execute("UPDATE shared_vehicles SET data=@mods WHERE license_plate = @plate",{['mods'] = vehicleMods, ['plate'] = plate})
	else
		exports.ghmattimysql:execute("UPDATE characters_cars SET data=@mods WHERE license_plate = @plate",{['mods'] = vehicleMods, ['plate'] = plate})
	end
end)

RegisterServerEvent('np-imp:ImpoundCar')
AddEventHandler('np-imp:ImpoundCar', function(plate)
	if exports['np-vehicledegrade']:isSharedVehicle(plate) then
		exports.ghmattimysql:execute("UPDATE shared_vehicles SET vehicle_state = @state, current_garage = @garage WHERE license_plate = @plate", {['garage'] = 'Impound Lot', ['state'] = 'Normal Impound', ['plate'] = plate})
	else
		exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, coords = @coords WHERE license_plate = @plate", {['garage'] = 'Impound Lot', ['state'] = 'Normal Impound', ['coords'] = nil, ['plate'] = plate})
	end
end)

RegisterNetEvent("garages:loaded:in", function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id

    exports.ghmattimysql:execute('SELECT `name`, `license_plate`, `current_garage`, `vehicle_state`, `engine_damage`, `body_damage`, `payments_left`, `finance_time`, `financed` FROM characters_cars WHERE cid = @cid', { ['@cid'] = owner}, function(vehicles)
		TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)

function ResetGaragesServer()
	exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE current_garage = ?', {"Impound Lot"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state,coords = @coords WHERE license_plate = @plate", {['state'] = 'Stored', ['coords'] = nil, ['plate'] = v.license_plate})
			end
		end
	end)

	exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE vehicle_state = ?', {"Out"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.ghmattimysql:execute("UPDATE shared_vehicles SET vehicle_state = @state  WHERE license_plate = @plate", {['state'] = 'Stored', ['plate'] = v.license_plate})
			end
		end
	end)

end

Citizen.CreateThread(function()
    ResetGaragesServer();
end)

RPC.register("np-garages:impound:request", function(pImpoundReqType, pPlate)
	if exports['np-vehicledegrade']:isSharedVehicle(pPlate) then
		exports.ghmattimysql:execute('SELECT * FROM shared_vehicles WHERE license_plate = ?', {pPlate}, function(pData)
			if pData[1] then
				if pImpoundReqType ~= "scuff" then
					exports.ghmattimysql:execute("UPDATE shared_vehicles SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
						['current_garage'] = 'Impound Lot', 
						['vehicle_state'] = pImpoundReqType,
						['plate'] = pPlate
					})
				else
					exports.ghmattimysql:execute("UPDATE shared_vehicles SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
						['current_garage'] = 'Police Department', 
						['vehicle_state'] = "Stored",
						['plate'] = pPlate
					})
				end
			end
		end)
	else
		exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = ?', {pPlate}, function(pData)
			if pData[1] then
				if pImpoundReqType ~= "scuff" and pData[1].vin == 0 then
					exports.ghmattimysql:execute("UPDATE characters_cars SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
						['current_garage'] = 'Impound Lot', 
						['vehicle_state'] = pImpoundReqType,
						['plate'] = pPlate
					})
				elseif pData[1].vin == 1 then
					exports.ghmattimysql:execute("DELETE FROM characters_cars WHERE license_plate = @license_plate", {['@license_plate'] = pPlate}, function()

					end)
				else
					exports.ghmattimysql:execute("UPDATE characters_cars SET current_garage = @current_garage, vehicle_state = @vehicle_state WHERE license_plate = @plate", {
						['current_garage'] = 'T', 
						['vehicle_state'] = "Stored",
						['plate'] = pPlate
					})
				end
			end
		end)
	end
end)


RPC.register("np-garages:attempt:buy", function(price)
	local s = source
    local user = exports["np-base"]:getModule("Player"):GetUser(s)

    if user:getBalance() >= price then
        user:removeBank(price)
		return true, "Congraduations on the new vehicle, enjoy!"
	else
		return false, "You dont have enough money to complete this transaction!"
	end
end)


RPC.register("np-garages:purchase:car", function(car, plate, shared, job, price)
	local s = source
    local user = exports["np-base"]:getModule("Player"):GetUser(s)
	local char = user:getCurrentCharacter()
	local player = user:getVar("hexid")
	if job == "police" or job == "state" or job == "sheriff" or job == "ems" then
		if shared then
			exports.ghmattimysql:execute("INSERT INTO shared_vehicles (job, model, current_garage, name, license_plate) VALUES (@job, @model, @current_garage, @name, @license_plate)", {
				['@job'] = job,
				['@model'] = car,
				['@current_garage'] = pefgarage(job),
				['@name'] = car,
				['@license_plate'] = plate
			})
		else
			exports.ghmattimysql:execute('INSERT INTO characters_cars (id, cid, license_plate, name, model, purchase_price, vehicle_state, current_garage) VALUES (@id, @cid, @license_plate, @name, @model, @buy_price, @vehicle_state, @current_garage)',{
				['@id'] = player,
				['@cid'] = char.id,
				['@license_plate'] = plate,
				['@name'] = car,
				['@model'] = car,
				['@buy_price'] = price,
				['@current_garage'] = pefgarage(job),
				['@vehicle_state'] = "Out"
			})
		end
	end
end)

function pefgarage(job)
	if job == "police" or job == "state" or job == "sheriff" or job == "ems" then
		return "Police Department"
	else
		return "Pillbox"
	end
end


function isSharedGarage(pass_gar)
	for i=1,  #pSharedGarageNames do
		if pSharedGarageNames[i] == pass_gar then
			return true
		end
	end

	return false
end




-- Make Vehicle Purchase menu  (ems)