local degHealth = {
	["breaks"] = 0,-- has neg effect
	["axle"] = 0,	-- has neg effect
	["radiator"] = 0, -- has neg effect 
	["clutch"] = 0,	-- has neg effect
	["transmission"] = 0, -- has neg effect
	["electronics"] = 0, -- has neg effect
	["fuel_injector"] = 0, -- has neg effect
	["fuel_tank"] = 0 -- has neg effect
}

RegisterNetEvent("mech:tools")
AddEventHandler("mech:tools", function(material, amount)
    local shop = exports["isPed"]:isPed("myJob")
    if exports["np-inventory"]:hasEnoughOfItem(material, amount,false) then
        TriggerServerEvent("mech:add:materials", material, amount, shop)
    else
        TriggerEvent('DoLongHudText', 'You don\'t have the materials', 2)
    end
end)


RegisterNetEvent("mech:tools:cl")
AddEventHandler("mech:tools:cl", function(materials, amount, deg, plate)
    local shop = exports["isPed"]:isPed("myJob") -- ??
    TriggerServerEvent("mech:remove:materials", materials, amount, deg, plate, shop)
end)

RegisterNetEvent("mech:tools:cl2")
AddEventHandler("mech:tools:cl2", function(input, input2)
    local isEmployed = exports["np-business"]:IsEmployedAt("tuner_shop")
    if isEmployed then
        local degname = string.lower(input)
        local amount = tonumber(input2)
        local itemname = ""
        local current = 100

        if not amount then
            TriggerEvent('DoLongHudText', 'Error: You need to do re enter a amount!', 2)
            return
        end

        if degname == "body" then
            TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu!', 2)
        end

        if degname == "engine" then
            TriggerEvent('DoLongHudText', 'This part is not degrading please repair it through the menu!', 2)
        end

        if degname == "brakes" then
            itemname = "rubber"
            degname = "breaks"
            current = degHealth["breaks"]
        end

        if  degname == "axle" then
            degname = "axle"
            itemname = "scrapmetal"
            current = degHealth["axle"]
        end

        if degname == "radiator" then
            degname = "radiator"
            itemname = "scrapmetal"
            current = degHealth["radiator"]
        end

        if degname == "clutch" then
            degname = "clutch"
            itemname = "scrapmetal"
            current = degHealth["clutch"]
        end

        if degname == "electronics" then
            degname = "electronics"
            itemname = "plastic"
            current = degHealth["electronics"]
        end

        if degname == "fuel" then
            itemname = "steel"
            degname = "fuel_tank"
            current = degHealth["fuel_tank"]
        end

        if degname == "transmission"then
            itemname = "aluminium"
            current = degHealth["transmission"]
        end

        if degname == "injector" then
            itemname = "copper"
            degname = "fuel_injector"
            current = degHealth["fuel_injector"]
        end

        if amount <= 10 then
            RequestAnimDict("mp_car_bomb")
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(PlayerPedId(),"mp_car_bomb","car_bomb_mechanic",8.0, -8, -1, 49, 0, 0, 0, 0)
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports["np-taskbar"]:taskBar(35000,"Repairing")
            local coordA = GetEntityCoords(PlayerPedId(), 1)
            local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 5.0, 0.0)
            local targetVehicle = getVehicleInDirection(coordA, coordB)
            local plate = GetVehicleNumberPlateText(targetVehicle)
            if finished == 100 then
                FreezeEntityPosition(PlayerPedId(), false)
                if targetVehicle ~= 0 then
                    if itemname ~= "" then
                        TriggerServerEvent('scrap:towTake', degname, itemname, plate, amount, amount)
                    else
                        TriggerEvent('DoLongHudText', 'Vehicle Part does not exist!', 2)
                    end
                else
                    TriggerEvent('DoLongHudText', 'No Vehicle!', 2)
                end
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end
        else
            TriggerEvent('DoLongHudText', 'You cant repair anything higher then 10!', 2)
        end
       
    end
end)

exports("getVehicleInDirection", function(coordA, coordB)
    return getVehicleInDirection(coordA, coordB)
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('towgarage:repairamount')
AddEventHandler('towgarage:repairamount', function(data)
	local playerped = PlayerPedId()
	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)
	local plate = GetVehicleNumberPlateText(targetVehicle)
    local isEmployed = exports["np-business"]:IsEmployedAt("tuner_shop")
	local part = data.part
	if #(vector3(841.25274658203,-974.61096191406,26.482788085938) - GetEntityCoords(PlayerPedId())) < 35 then
		if isEmployed then
			local keyboard = exports["np-applications"]:KeyboardInput({
				header = "Repair: ".. part,
				rows = {
				{
					id = 0, 
					txt = "Amount"
				}
			}
		})
		
		if keyboard ~= nil then
			if keyboard[1].input == nil then return end
				TriggerEvent('mech:tools:cl2', part, keyboard[1].input)
			end
		end
	elseif #(vector3(1179.3099365234, 2635.9252929688, 184.25196838379) - GetEntityCoords(PlayerPedId())) < 160 then
		if job >= 1 then
			local keyboard = exports["np-applications"]:KeyboardInput({
				header = "Repair: ".. part,
				rows = {
				{
					id = 0, 
					txt = "Amount"
				}
			}
		})
		
		if keyboard ~= nil then
			if keyboard[1].input == nil then return end
				TriggerEvent('mech:tools:cl2', part, keyboard[1].input)
			end
		end
	end
end)

RegisterNetEvent('np-towjob:StoreMaterialsMain')
AddEventHandler('np-towjob:StoreMaterialsMain', function()
	if #(vector3(841.25274658203,-974.61096191406,26.482788085938) - GetEntityCoords(PlayerPedId())) < 35 or #(vector3(1179.3099365234, 2635.9252929688, 184.25196838379) - GetEntityCoords(PlayerPedId())) < 160 then
        local isEmployed = exports["np-business"]:IsEmployedAt("tuner_shop")
        if isEmployed then
			local keyboard = exports["np-applications"]:KeyboardInput({
				header = "Store Materials",
				rows = {
				{
					id = 0, 
					txt = "Material Name"
				},
                {
					id = 1, 
					txt = "Amount"
				}
			}
		})
        if keyboard ~= nil then
			if keyboard[1].input == nil then return end
				TriggerEvent('mech:tools', keyboard[1].input, keyboard[2].input)
			end
		end
	end
end)

RegisterNetEvent("mech:check:internal:storage")
AddEventHandler("mech:check:internal:storage", function()
    local isEmployed = exports["np-business"]:IsEmployedAt("tuner_shop")
    if isEmployed then
        TriggerServerEvent("mech:check:materials", 'tuner_shop')
    else
        TriggerEvent('DoLongHudText', 'You are not a ak customs worker!', 2)
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

exports("NearVehicle", function(pType)
    if pType == "Distance" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return true
        else
            return false
        end
    elseif pType == "plate" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    elseif pType == "Fuel" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return  GetVehicleFuelLevel(vehicle)
        else
            return false
        end
    end
end)



RegisterCommand("transfer", function(source, args)
    TriggerEvent("transfer:attempt")
end)

RegisterNetEvent("transfer:attempt")
AddEventHandler("transfer:attempt", function()
    local coords = GetEntityCoords(PlayerPedId())
    if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
        if DoesEntityExist(vehicle) then
            t, distance = GetClosestPlayer()
	        if(distance ~= -1 and distance < 2) then
                local plate = GetVehicleNumberPlateText(vehicle)
                TriggerServerEvent("transfer:attempt:send", plate, GetPlayerServerId(t))
            else
                TriggerEvent("DoLongHudText", "You are not near anyone to transfer the vehicle too", 2)
            end
        end
    end
end)

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end