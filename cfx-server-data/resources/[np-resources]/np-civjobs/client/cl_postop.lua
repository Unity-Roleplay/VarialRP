local postop = {x = -424.33847045898, y = -2789.8154296875, z = 6.5157470703125}
local spawntruck = { x = -412.28570556641, y = -2793.2570800781, z = 5.892333984375, h = 317.48031616211}
local getpaid = { x = -424.16702270508, y = -2789.9868164062, z = 6.5157470703125 }
local cash = 0
local possibility = 0

local dropoffpoints = {
    [1] = {name = "El Rancho Factory",x = 956.65057373047, y = -2176.6418457031 , z = 31.150146484375},
    [2] = {name = "The Secure Unit",x = 919.31866455078, y = -1268.6900634766 , z = 25.539184570312},
    [3] = {name = "Popular Street",x = 845.05053710938, y = -902.65057373047 , z = 25.23583984375},
    [4] = {name = "Hawick Avenue",x = 401.92086791992, y = -339.27032470703 , z = 46.97216796875},
    [5] = {name = "Spanish Ave",x = 358.69451904297, y = -74.597801208496 , z = 67.0908203125},
    [6] = {name = "Pearls - Pier",x = -1793.7890625, y = -1199.0373535156 , z = 13.0029296875},
    [7] = {name = "Great Ocean Highway",x = -2947.5561523438, y = 57.019779205322 , z = 11.604370117188},
    [8] = {name = "Picture Perfect Drive",x = -802.82635498047, y = -802.82635498047 , z = 87.86669921875},
}

local isInJobPost = false
local coordinates = 0
local plateab = "POPJOBS"
local isToDropLocation = false
local isToPostOP = false
local multiplicador_De_dinero = 0.05
local job_payment = 0

local px = 0
local py = 0
local pz = 0

-------------------------------
-------------BLIPS-------------
-------------------------------

function Iracasa(dropoffpoints,coordinates)
    blip_casa = AddBlipForCoord(dropoffpoints[coordinates].x,dropoffpoints[coordinates].y, dropoffpoints[coordinates].z)
    SetBlipSprite(blip_casa, 1)
    SetNewWaypoint(dropoffpoints[coordinates].x,dropoffpoints[coordinates].y)
end

RegisterCommand('fuckoff', function()
    TriggerEvent('test?')
end)

RegisterNetEvent('dreams-civjobs:passed')
AddEventHandler('dreams-civjobs:passed', function()
    isInJobPost = true
    isToDropLocation = true
    coordinates = math.random(8)
    px = dropoffpoints[coordinates].x
    py = dropoffpoints[coordinates].y
    pz = dropoffpoints[coordinates].z
    distance = round(GetDistanceBetweenCoords(postop.x, postop.y, postop.z, px,py,pz))
    paga = math.ceil(distance * multiplicador_De_dinero)
    Iracasa(dropoffpoints,coordinates)
    print(coordinates)
    TriggerEvent("phone:addnotification", "EMAIL ", "Delivery Available: Check You GPS And Come Back For Your Paycheck")
end)

RegisterNetEvent('dreams-civjobs:start-post-op')
AddEventHandler('dreams-civjobs:start-post-op', function()
    if isInJobPost == false then
        local finished = exports['np-taskbar']:taskBar(7500, 'Awaiting Vehicle')
        if (finished == 100) then
            TriggerEvent('dreams-civjobs:spawn-truck')
        end
    end
end)

RegisterNetEvent('dreams-civjobs:post-op:paycheck')
AddEventHandler('dreams-civjobs:post-op:paycheck', function()
    if isToPostOP == true then
        if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("BOXVILLE2"))  then
            if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("BOXVILLE2")) then
                TriggerServerEvent('dreams-civjobs:post-op-payment')
                exports['np-ui']:hideInteraction()
                isToDropLocation = false
                isToPostOP = false
                isInJobPost = false
                job_payment = 0
                px = 0
                py = 0
                pz = 0
                local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )
            else
                TriggerEvent('DoLongHudText', 'You were not payed. Please return the Truck', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'Use the Truck provided', 2) 
        end
    else
        TriggerEvent('DoLongHudText', 'You dont get paid for fuck all round here chief get to work !', 2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isToDropLocation == true then
            destinol = dropoffpoints[coordinates].name
            if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
                exports['np-ui']:showInteraction('[E] Drop Off Package')
                if IsControlJustPressed(1,38) then
                    TriggerEvent('DoLongHudText', 'Good job return to HQ', 1)
                    exports['np-ui']:hideInteraction()
                    possibility = math.random(1, 100)
                    isToDropLocation = false
                    isToPostOP = true
                    RemoveBlip(blip_casa)
                    SetNewWaypoint(postop.x,postop.y)
                end
            else
                exports['np-ui']:hideInteraction()

            end
        end
            if IsEntityDead(GetPlayerPed(-1)) then
                isInJobPost = false
                coordinates = 0
                isToDropLocation = false
                isToPostOP = false
                job_payment = 0
                px = 0
                py = 0
                pz = 0
                RemoveBlip(blip_casa)
            end
        end
    end)  

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function IsInVehicle()
    local ply = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ply) then
        return true
    else
        return false
    end
end

--// Ped

function setPostOPped()
    modelHash = GetHashKey("ig_floyd")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    created_ped = CreatePed(0, modelHash , -417.9560546875, -2792.6110839844, 5.993408203125  -1, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityHeading(created_ped, 226.77166748047)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    setPostOPped()
end)

--// Collect Paycheck

DreamsPaycheckPolyzone = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("dreams_postop_collect_paycheck", vector3(-417.9560546875, -2792.6110839844, 5.993408203125), 2, 2, {
        name="dreams_postop_collect_paycheck",
        heading=315,
        --debugPoly=true,
        minZ=4.0,
        maxZ=8.0
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "dreams_postop_collect_paycheck" then
        DreamsPaycheckPolyzone = true     
        DreamsPostOPCollectPaycheck()
		exports['np-ui']:showInteraction("[E] Collect Paycheck")
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "dreams_postop_collect_paycheck" then
        DreamsPaycheckPolyzone = false
        exports['np-ui']:hideInteraction()
    end
end)

function DreamsPostOPCollectPaycheck()
	Citizen.CreateThread(function()
        while DreamsPaycheckPolyzone do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				TriggerEvent('dreams-civjobs:post-op:paycheck')
			end
		end
	end)
end

--// Spawn vehicle

RegisterNetEvent("dreams-civjobs:spawn-truck")
AddEventHandler("dreams-civjobs:spawn-truck", function()
	Citizen.CreateThread(function()
        local hash = GetHashKey("BOXVILLE2")

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findclosestspawnpostop(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, -412.28570556641, -2793.2570800781, 5.892333984375, 317.48031616211, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        TriggerEvent('dreams-civjobs:passed')
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
    end)
end)

function findclosestspawnpostop(pCurrentPosition)
	local coords = vector3(-412.28570556641, -2793.2570800781, 5.892333984375)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end