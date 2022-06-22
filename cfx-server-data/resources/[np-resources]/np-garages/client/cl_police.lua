local nearBuy = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("police_buy", vector3(442.92, -973.83, 25.7), 3, 3, {
        name="police_buy",
        heading=310,
        --debugPoly=true,
        minZ=22.5,
        maxZ=26.5
    }) 
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "police_buy" then
		local job = exports["isPed"]:isPed("myJob")
		if job == 'police' then
            nearBuy = true
            AtPoliceBuy()
            exports["np-ui"]:showInteraction("[E] Buy Vehicle")
        end
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "police_buy" then
        nearBuy = false
    end
    exports["np-ui"]:hideInteraction()
end)

function AtPoliceBuy()
	Citizen.CreateThread(function()
        while nearBuy do
            Citizen.Wait(5)
            local plate = GetVehicleNumberPlateText(vehicle)
            local job = exports["isPed"]:isPed("myJob")
            if job == 'police' then
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('np-garages:openBuyMenu')
                end
            end
        end
    end)
end

RegisterNetEvent('np-garages:openBuyMenu')
AddEventHandler('np-garages:openBuyMenu', function()
    TriggerEvent('np-context:sendMenu', {
		{
			id = 1,
			header = "Crown Vic",
			txt = "Purchase for $5000",
			params = {
				event = "np-garages:PurchasedGDEvoke"
			}
		},
        {
			id = 2,
			header = "Ranger Blazer",
			txt = "Purchase for $10000",
			params = {
				event = "np-garages:PurchasedGDEvokeW"
			}
		},
        {
			id = 3,
			header = "Explorer",
			txt = "Purchase for $15000",
			params = {
				event = "np-garages:PurchasedGDterritory"
			}
		},
        {
			id = 4,
			header = "Bike Interceptor",
			txt = "Purchase for $15000",
			params = {
				event = "np-garages:PurchasedGDsonata"
			}
		},
        {
			id = 5,
			header = "Mustang Interceptor",
			txt = "Purchase for $65000",
			params = {
				event = "np-garages:PurchasedGDgts"
			}
		},
        {
			id = 6,
			header = "Corvette Interceptor",
			txt = "Purchase for $75000",
			params = {
				event = "np-garages:PurchasedGDdog"
			}
		},
        {
			id = 7,
			header = "Challenger",
			txt = "Purchase for $85000",
			params = {
				event = "np-garages:PurchasedGDranger"
			}
		},
        {
			id = 8,
			header = "Charger",
			txt = "Purchase for $30000",
			params = {
				event = "np-garages:PurchasedGDlandy"
			}
		},
        
	})
end)

RegisterNetEvent('np-garages:PurchasedGDEvoke')
AddEventHandler('np-garages:PurchasedGDEvoke', function()
    if exports["isPed"]:isPed("mycash") >= 5000 then
        --TriggerServerEvent('banking:removeMoney', 5000)
        TriggerServerEvent('yorktax:vic')
        TriggerEvent('np-garages:PurchasedVeh', 'Crown Vic', 'npolvic', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDEvokeW')
AddEventHandler('np-garages:PurchasedGDEvokeW', function()
    if exports["isPed"]:isPed("mycash") >= 10000 then
        --TriggerServerEvent('banking:removeMoney', 10000)
        TriggerServerEvent('yorktax:blazer')
        TriggerEvent('np-garages:PurchasedVeh', 'Ranger QuadBike', 'npolblazer', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDterritory')
AddEventHandler('np-garages:PurchasedGDterritory', function()
    if exports["isPed"]:isPed("mycash") >= 15000 then
        --TriggerServerEvent('banking:removeMoney', 15000)
        TriggerServerEvent('yorktax:exp')
        TriggerEvent('np-garages:PurchasedVeh', 'Ford Explorer', 'npolexp', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDsonata')
AddEventHandler('np-garages:PurchasedGDsonata', function()
    if exports["isPed"]:isPed("mycash") >= 15000 then
        --TriggerServerEvent('banking:removeMoney', 15000)
        TriggerServerEvent('yorktax:mm')
        TriggerEvent('np-garages:PurchasedVeh', 'Police Bike', 'npolmm', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDdog')
AddEventHandler('np-garages:PurchasedGDdog', function()
    if exports["isPed"]:isPed("mycash") >= 80000 then
        --TriggerServerEvent('banking:removeMoney', 80000)
        TriggerServerEvent('yorktax:vette')
        TriggerEvent('np-garages:PurchasedVeh', 'HeatUnit Corvette', 'npolvette', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money or you are not Heat Unit", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDranger')
AddEventHandler('np-garages:PurchasedGDranger', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        --TriggerServerEvent('banking:removeMoney', 60000)
        TriggerServerEvent('yorktax:chal')
        TriggerEvent('np-garages:PurchasedVeh', 'HeatUnit Challenger', 'npolchal', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDgts')
AddEventHandler('np-garages:PurchasedGDgts', function()
    if exports["isPed"]:isPed("mycash") >= 75000 then
        --TriggerServerEvent('banking:removeMoney', 75000)
        TriggerServerEvent('yorktax:stang')
        TriggerEvent('np-garages:PurchasedVeh', 'HeatUnit Mustang', 'npolstang', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDlandy')
AddEventHandler('np-garages:PurchasedGDlandy', function()
    if exports["isPed"]:isPed("mycash") >= 30000 then
        --TriggerServerEvent('banking:removeMoney', 30000)
        TriggerServerEvent('yorktax:char')
        TriggerEvent('np-garages:PurchasedVeh', 'Police Charger', 'npolchar', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedGDbzcom')
AddEventHandler('np-garages:PurchasedGDbzcom', function()
    if exports["isPed"]:isPed("mycash") >= 40000 then
        TriggerServerEvent('banking:removeMoney', 40000)
        TriggerEvent('np-garages:PurchasedVeh', 'GD Holden BZ Commodore', 'NSWZBS', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWPe63')
AddEventHandler('np-garages:PurchasedHWPe63', function()
    if exports["isPed"]:isPed("mycash") >= 40000 then
        TriggerServerEvent('banking:removeMoney', 40000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Mercedes-benz E63', 'fatale63', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWPgts')
AddEventHandler('np-garages:PurchasedHWPgts', function()
    if exports["isPed"]:isPed("mycash") >= 45000 then
        TriggerServerEvent('banking:removeMoney', 45000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Holden GTS', 'HWPGTS', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWP530d')
AddEventHandler('np-garages:PurchasedHWP530d', function()
    if exports["isPed"]:isPed("mycash") >= 45000 then
        TriggerServerEvent('banking:removeMoney', 45000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP BMW 530D', 'hwy21', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWPbike')
AddEventHandler('np-garages:PurchasedHWPbike', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Yamaha 1300', 'hwpbike', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWvfss')
AddEventHandler('np-garages:PurchasedHWvfss', function()
    if exports["isPed"]:isPed("mycash") >= 55000 then
        TriggerServerEvent('banking:removeMoney', 55000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Holden VF SS', 'hwpvf2', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWP300c')
AddEventHandler('np-garages:PurchasedHWP300c', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Chrysler 300c', 'hwpsrtcore', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedHWPhellcat')
AddEventHandler('np-garages:PurchasedHWPhellcat', function()
    if exports["isPed"]:isPed("mycash") >= 65000 then
        TriggerServerEvent('banking:removeMoney', 65000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Dodge Charger', 'hellcatRB', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedPORSlandcruiser')
AddEventHandler('np-garages:PurchasedPORSlandcruiser', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'PORS Toyota Landcruiser', 'PORSLandy', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedPORSriot')
AddEventHandler('np-garages:PurchasedPORSriot', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'PORS Armored Truck', 'riot', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedUCstinger')
AddEventHandler('np-garages:PurchasedUCstinger', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP Kia Stinger', 'h1stinger', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedUC530d')
AddEventHandler('np-garages:PurchasedUC530d', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('np-garages:PurchasedVeh', 'HWP BMW 530D', 'UM21', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedUCzb')
AddEventHandler('np-garages:PurchasedUCzb', function()
    if exports["isPed"]:isPed("mycash") >= 60000 then
        TriggerServerEvent('banking:removeMoney', 60000)
        TriggerEvent('np-garages:PurchasedVeh', 'UC Holden ZB Commodore', 'NSWZBSUM', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedUClandcruiser')
AddEventHandler('np-garages:PurchasedUClandcruiser', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'UC Toyota Landcruiser', 'UCLandcruiser', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('np-garages:PurchasedUCprado')
AddEventHandler('np-garages:PurchasedUCprado', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('banking:removeMoney', 50000)
        TriggerEvent('np-garages:PurchasedVeh', 'UC Toyota Prado', 'NSWPrado', '0')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

    

RegisterNetEvent('np-garages:PurchasedVeh')
AddEventHandler('np-garages:PurchasedVeh', function(name, veh, price)
    local ped = PlayerPedId()
    local name = name    
    local vehicle = veh
    local price = price        
    local model = veh
    local colors = table.pack(GetVehicleColours(veh))
    local extra_colors = table.pack(GetVehicleExtraColours(veh))

    local mods = {}

    for i = 0,24 do
        mods[i] = GetVehicleMod(veh,i)
    end

    FreezeEntityPosition(ped,false)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    personalvehicle = CreateVehicle(model,435.80545043945, -975.96203613281, 25.699991226196,88.239898681641,true,false)
    SetEntityHeading(personalvehicle, 88.239898681641)
    SetModelAsNoLongerNeeded(model)

    for i,mod in pairs(mods) do
        SetVehicleModKit(personalvehicle,0)
        SetVehicleMod(personalvehicle,i,mod)
    end

    SetVehicleOnGroundProperly(personalvehicle)

    local plate = GetVehicleNumberPlateText(personalvehicle)
    SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
    local id = NetworkGetNetworkIdFromEntity(personalvehicle)
    SetNetworkIdCanMigrate(id, true)
    Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
    SetVehicleColours(personalvehicle,colors[1],colors[2])
    SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
    TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
    SetEntityVisible(ped,true)            
    local primarycolor = colors[1]
    local secondarycolor = colors[2]    
    local pearlescentcolor = extra_colors[1]
    local wheelcolor = extra_colors[2]
    --local VehicleProps = exports['np-base']:FetchVehProps(personalvehicle)
    local model = GetEntityModel(personalvehicle)
    local vehname = GetDisplayNameFromVehicleModel(model)
    TriggerEvent("keys:addNew",personalvehicle, plate)
    TriggerServerEvent('np-garages:FinalizedPur', plate, name, vehicle, price)
    Citizen.Wait(100)
    exports['np-textui']:hideInteraction()
end)

RegisterNetEvent('PDSpawnVeh33')
AddEventHandler('PDSpawnVeh33', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Police Garage",
            txt = ""
        },
        {
            id = 2,
            header = "PolAir",
			txt = "Eye in the sky",
			params = {
                event = "spawn:veh:pd33",
				args = {
					vehicle = "maverick2"
				}
            }
        },
	
    })
end)

RegisterNetEvent('spawn:veh:pd33')
AddEventHandler('spawn:veh:pd33', function(type)
	SpawnVehPD33(type.vehicle)	
end)

function SpawnVehPD33(name)
	Citizen.CreateThread(function()

        local hash = GetHashKey(name)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findClosestSpawnPointPD33(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 449.27819824219, -981.24462890625, 43.691368103027, 353.6337890625, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        applyMaxUpgrades(vehicle)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
		TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end

function applyMaxUpgrades(veh)
	SetVehicleModKit(veh, 0)
    SetVehicleMod(veh, 11, 3, false)
    SetVehicleMod(veh, 12, 2, false)
    SetVehicleMod(veh, 13, 2, false)
    SetVehicleMod(veh, 15, 3, false)
    SetVehicleMod(veh, 16, 4, false)
end

function findClosestSpawnPointPD33(pCurrentPosition)
	local coords = vector3(449.27819824219, -981.24462890625, 43.691368103027)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end