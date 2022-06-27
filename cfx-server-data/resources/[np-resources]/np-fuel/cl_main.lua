local isNearGasStation = false
local isFueling = false
local hasNozle = false
local canReturnNozle = true
local canRefillVehicle = true
local canPayBill = false
local zoneData = nil
local GallonPrice = 6
local paid = false
attachedProp = 0

local FuelClasses = {
	[0] = 1.0, -- Compacts
	[1] = 1.0, -- Sedans
	[2] = 0.8, -- SUVs
	[3] = 1.2, -- Coupes
	[4] = 1.1, -- Muscle
	[5] = 1.3, -- Sports Classics
	[6] = 1.2, -- Sports
	[7] = 1.2, -- Super
	[8] = 0.8, -- Motorcycles
	[9] = 1.0, -- Off-road
	[10] = 0.8, -- Industrial
	[11] = 0.8, -- Utility
	[12] = 0.8, -- Vans
	[13] = 0.0, -- Cycles
	[14] = 1.0, -- Boats
	[15] = 1.0, -- Helicopters
	[16] = 1.0, -- Planes
	[17] = 1.2, -- Service
	[18] = 1.2, -- Emergency
	[19] = 1.2, -- Military
	[20] = 1.2, -- Commercial
	[21] = 1.0, -- Trains
}

local FuelUsage = {
	[1.0] = 0.4,
	[0.9] = 0.4,
	[0.8] = 0.3,
	[0.7] = 0.3,
	[0.6] = 0.2,
	[0.5] = 0.2,
	[0.4] = 0.1,
	[0.3] = 0.1,
	[0.2] = 0.1,
	[0.1] = 0.1,
	[0.0] = 0.0,
}

local GasStations = {
	vector3(49.4187, 2778.793, 58.043),
	vector3(263.894, 2606.463, 44.983),
	vector3(1039.958, 2671.134, 39.550),
	vector3(1207.260, 2660.175, 37.899),
	vector3(2539.685, 2594.192, 37.944),
	vector3(2679.858, 3263.946, 55.240),
	vector3(2005.055, 3773.887, 32.403),
	vector3(1687.156, 4929.392, 42.078),
	vector3(1701.314, 6416.028, 32.763),
	vector3(179.857, 6602.839, 31.868),
	vector3(-94.4619, 6419.594, 31.489),
	vector3(-2554.996, 2334.40, 33.078),
	vector3(-1800.375, 803.661, 138.651),
	vector3(-1437.622, -276.747, 46.207),
	vector3(-2096.243, -320.286, 13.168),
	vector3(-724.619, -935.1631, 19.213),
	vector3(-526.019, -1211.003, 18.184),
	vector3(-70.2148, -1761.792, 29.534),
	vector3(265.648, -1261.309, 29.292),
	vector3(819.653, -1028.846, 26.403),
	vector3(1208.951, -1402.567,35.224),
	vector3(1181.381, -330.847, 69.316),
	vector3(620.843, 269.100, 103.089),
	vector3(2581.321, 362.039, 108.468),
	vector3(176.631, -1562.025, 29.263),
	vector3(176.631, -1562.025, 29.263),
	vector3(-319.292, -1471.715, 30.549),
	vector3(1784.324, 3330.55, 41.253)
}

function getVehicleClosestToMe()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end

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
	
	if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

local function Round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function SetFuel(sentVeh, sentFuel)
	if not DoesEntityExist(sentVeh) then return end;
	if type(sentFuel) == 'number' and sentFuel >= 0 and sentFuel <= 100 then
		local fuel = sentFuel + 0.0
		Entity(sentVeh).state:set('fuel', fuel, true)
		SetVehicleFuelLevel(sentVeh, fuel)
	end
end

local function GetFuel(sentVeh)
	if not DoesEntityExist(sentVeh) then return end;
	return Entity(sentVeh).state.fuel or -1.0
end

local function doFuel(sentVeh)
	if DoesEntityExist(sentVeh) then
		local currFuel = GetFuel(sentVeh)
		if currFuel == -1.0 then
			TriggerServerEvent('np-fuel:initFuel', VehToNet(sentVeh))
		elseif IsVehicleEngineOn(sentVeh) then
			SetFuel(sentVeh, currFuel - FuelUsage[Round(GetVehicleCurrentRpm(sentVeh), 1)] * (FuelClasses[GetVehicleClass(sentVeh)] or 1.0) / 10) -- From LegacyFuel
		end
	end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

exports('SetFuel', SetFuel) -- exports['np-fuel']:SetFuel(veh, fuel)
exports('GetFuel', GetFuel)-- exports['np-fuel']:GetFuel(veh)

CreateThread(function()
	for i=1, #GasStations do
		local blip = AddBlipForCoord(GasStations[i])    
		SetBlipSprite(blip, 361)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Gas Station")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip, true)
	end
	GasStations = nil
	while true do
		Wait(1000)
		local plyPed = PlayerPedId()
		local plyVeh = GetVehiclePedIsIn(plyPed, false)
		if plyVeh ~= 0 then
			local plySeat = GetPedInVehicleSeat(plyVeh, -1) == plyPed
			if plySeat then
				doFuel(plyVeh)
			end
		end
	end
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name, data)
    if name == "gas_station" then
        isNearGasStation = true
		zoneData = data
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "gas_station" then
        isNearGasStation = false
		zoneData = nil
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		print(playerVeh)
		if playerVeh ~= 0 and hasNozle then
			NetworkExplodeVehicle(playerVeh, true, false, 0)
			hasNozle = false
		end
    end
end)

RegisterNetEvent('np-fuel:SelectFuel', function()
	local menuData = {
		{
            title = "Gas Pump",
            description = "Select the kind of fuel you want to use",
			icon = 'info-circle',
            key = "EVENTS.GAS",
        },
		{
            title = "Regular",
            description = "Octane: 87 | Price: $".. GallonPrice,
			icon = 'gas-pump',
            key = "EVENTS.REFUEL",
			action = 'np-fuel:FuelSelected'
        },
    }
    exports["np-ui"]:showContextMenu(menuData)
end)

RegisterUICallback("np-fuel:FuelSelected", function(data, cb)
	SetUIFocus(false, false)
	if not hasNozle then
		hasNozle = true
		canReturnNozle = false
		TriggerEvent("attachItemRadio","fuel_nozle")
		-- attachedProp = CreateObject(GetHashKey("prop_cs_fuel_nozle"), 0, 0, 0, true, true, true)
		-- AttachEntityToEntity(attachedProp, currentPed, GetPedBoneIndex(currentPed, 0xDEAD), 0.13, 0.04, -0.03, 80.0, 100.0, 190.0, true, true, false, true, 1, true)
	end
end)

RegisterNetEvent('np-fuel:ReturnNozel', function()
	if hasNozle then
		TriggerEvent("destroyPropRadio")
		hasNozle = false
		canReturnNozle = true
	end
end)

RegisterNetEvent('np-fuel:RefillVehicle', function()
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['np-fuel']:GetFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice

	local menuData = {
		{
			title = "Refuel Vehicle",
			description = "Fuel Amount: ".. math.ceil(exports['np-fuel']:GetFuel(veh)) .. " | Total Cost: $".. FuelCost .. ".0",
			icon = 'info-circle',
			key = "EVENTS.GAS",
		},
		{
			title = "Start Refueling",
			icon = 'gas-pump',
			key = "EVENTS.REFUEL",
			action = 'np-fuel:RefuelVehicle',
			disabled = not canPayBill
		},
		{
			title = "Send Bill",
			icon = 'credit-card',
			key = "EVENTS.CARD",
			action = 'np-fuel:pay_bank',
			disabled = canPayBill
		},
	}
	exports["np-ui"]:showContextMenu(menuData)
end)

RegisterUICallback('np-fuel:pay_bank', function(data, cb, pParams)
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['np-fuel']:GetFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice
	SetUIFocus(false, false)
	local input = exports["np-ui"]:showInput({
		{
			icon = "address-card",
			label = "Paypal ID",
			name = "ppaypal_id",
		},
	})
	
	if input["ppaypal_id"] then
		TriggerServerEvent("np-phone:send_gas_bill", input["ppaypal_id"], FuelCost)
		print(json.encode(input))
	end
end)

RegisterNetEvent('np-fuel:SendBillToBank', function(fCost)
	TriggerEvent('np-phone:client:gasOffer', 'Fuel Cost: $' .. fCost)
end)

RegisterNetEvent('np-fuel:OfferAccepted', function()
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['np-fuel']:GetFuel(veh))
	local endFuel = (100 - vehicleCurrentFuel)
	local FuelCost = endFuel * GallonPrice
	if not paid then
		paid = true
		TriggerServerEvent('np-fuel:PurchaseSuccessful', FuelCost)
	end
	canRefillVehicle = false
	canPayBill = true
end)

RegisterUICallback('np-fuel:RefuelVehicle', function(data, cb)
	local veh = getVehicleClosestToMe()
	local vehicleCurrentFuel = math.ceil(exports['np-fuel']:GetFuel(veh))
	local timer = (100 - vehicleCurrentFuel) * 400

	loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@","idle_a",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)

	SetUIFocus(false, false)
	-- exports['np-taskbar']:Progress({
	-- 	duration = timer,
	-- 	label = "Refueling",
	-- }, function(cancelled)
	local finished = exports['np-taskbar']:taskBar(timer, 'Refueling')
	if finished == 100 then
		paid = false
		exports['np-fuel']:SetFuel(veh, 100)
		canRefillVehicle = true
		canPayBill = false
		ClearPedTasks(PlayerPedId())
	else
		canRefillVehicle = true
		canPayBill = false
		ClearPedTasks(PlayerPedId())
	end
end)

exports("hasNozle", function()
	return hasNozle
end)

exports("NearGasFn", function()
	return isNearGasStation
end)

exports("gasZoneData", function()
	return zoneData
end)