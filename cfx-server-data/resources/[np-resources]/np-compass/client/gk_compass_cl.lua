local compass_bool = true
local full_oof = true
local showwatchcompass = false

RegisterNetEvent('unwind:enablewatchcompass')
AddEventHandler('unwind:enablewatchcompass', function()
	showwatchcompass = not showwatchcompass
end)


Citizen.CreateThread( function()
	local heading, lastHeading = 0, 1
	SendNUIMessage({ action = "display", compass = compass })
	while Config.ShowCompass do
		Citizen.Wait(0)
		local camRot = GetGameplayCamRot(0)
		heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))
		if heading == '360' then heading = '0' end

		if heading ~= lastHeading then
			if IsPedInAnyVehicle(PlayerPedId()) and full_oof == true and not IsPauseMenuActive() then
				SendNUIMessage({ action = "display", value = heading })
			else
				SendNUIMessage({ action = "hide", value = heading })
			end
		end
		lastHeading = heading
	end
end)



Citizen.CreateThread( function()
	local heading, lastHeading = 0, 1
	SendNUIMessage({ action = "display", compass = compass })
	while Config.ShowCompass do
		Citizen.Wait(0)
		local camRot = GetGameplayCamRot(0)
		heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))
		if heading == '360' then heading = '0' end
		if showwatchcompass then
			if showwatchcompass and full_oof == true and not IsPauseMenuActive() then
				SendNUIMessage({ action = "display", value = heading })
			else
				SendNUIMessage({ action = "hide", value = heading })
			end
		end

		lastHeading = heading
	end
end)






RegisterNetEvent('change:full_oof')
AddEventHandler('change:full_oof', function(bool)
	full_oof = bool
end)

DecorRegister("GetVehicleCurrentFuel", 3)

function round( n )
    return math.floor( n + 0.5 )
end


function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end
function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

pShowLocation = false


Citizen.CreateThread(function()
    voice = 2
    while true do
        Wait(500)
		local player = PlayerPedId()
		local veh = GetVehiclePedIsIn(player, false)
		SetPedSuffersCriticalHits(PlayerPedId(),false)
		local x, y, z = table.unpack(GetEntityCoords(player, true))
		local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
		currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
		intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
		zone = tostring(GetNameOfZone(x, y, z))
		local area = GetLabelText(zone)
		if not zone then
			zone = "UNKNOWN"
		end
		if intersectStreetName ~= nil and intersectStreetName ~= "" and currentStreetName ~= nil and currentStreetName ~= "" then
			playerStreetsLocation = currentStreetName .. " | [" .. intersectStreetName .. "]"
		elseif currentStreetName ~= nil and currentStreetName ~= "" then
			playerStreetsLocation = currentStreetName
		end
		street = playerStreetsLocation
		if IsPedInAnyVehicle(PlayerPedId(), true) and not IsPauseMenuActive() and IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) then 
			local Mph = math.ceil(GetEntitySpeed(veh) * 2.236936)
			local vehhash = GetEntityModel(veh)
			local maxspeed = GetVehicleModelMaxSpeed(vehhash) * 2.236936
			SendNUIMessage({showCarUi = true})
			SendNUIMessage({street = area, street2 = street, engine = engine})
			--DisplayRadar(true)
		else
			--DisplayRadar(false)
			SendNUIMessage({ShowLocation = pShowLocation, street = area, street2 = street})
			SendNUIMessage({showCarUi = false})
		end     
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local player = PlayerPedId()

        if IsVehicleEngineOn(GetVehiclePedIsIn(player, false)) or pShowLocation or sleeping then
            SendNUIMessage({
                direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
            })
        else
            Citizen.Wait(1500)
        end
    end
end)

-- Map stuff below
local x = -0.025
local y = -0.015
local w = 0.16
local h = 0.25


RegisterCommand("togglehud", function()  
	SendNUIMessage({action = "toggle_hud"})
end, false)


local function toggleCompass()
    sendAppEvent("hud.compass", {
        showCompass = showCompassFromWatch or (compassEnabled and showCompassFromCar),
        showRoadNames = compassRoadNamesEnabled and inVehicle,
    })
end

--

AddEventHandler("np-compass:watch", function()
    showCompassFromWatch = not showCompassFromWatch
    if showCompassFromWatch then
        generateCompass()
    end
    toggleCompass()
end)

function generateCompass()
    if compassRunning then return end
    compassRunning = true
    Citizen.CreateThread(function()
        local function shouldShowCompass()
            return showCompassFromWatch or (compassEnabled and showCompassFromCar)
        end
        local function shouldShowSpeed()
            return inVehicle and minimapEnabled
        end
        while shouldShowCompass() or shouldShowSpeed() do
            local cWait = shouldShowCompass() and compassWaitTime or 1000
            local sWait = shouldShowSpeed() and speedometerWaitTime or 1000
            Citizen.Wait(math.min(cWait, sWait))
            local s = GetGameTimer()
            local heading = math.floor(-GetFinalRenderedCamRot(0).z % 360)

            sendAppEvent("hud.compass", {
                alt = altitude,
                area = area,
                heading = heading,
                speed = speed,
                street = street,
            })

        end
        compassRunning = false
    end)
end



local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local containerWidth = 100 -- width of the image container
local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width

function calcHeading(direction)
    if (direction < 90) then
        return lerp(north, east, direction / 90)
    elseif (direction < 180) then
        return lerp(east, south2, rangePercent(90, 180, direction))
    elseif (direction < 270) then
        return lerp(south, west, rangePercent(180, 270, direction))
    elseif (direction <= 360) then
        return lerp(west, north, rangePercent(270, 360, direction))
    end
end

function rangePercent(min, max, amt)
    return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
    return (1 - amt) * min + amt * max
end

function IsCar(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

function Fwv(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

--[[RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"],currentValues["armor"])
end)]]

--local crouched = false
--exports["drp-keymapping"]:registerKeyMapping("Crouch", "Player", "Toggle Crouch", "+Crouch", "-Crouch", "LCONTROL", true)
--[[RegisterCommand("+Crouch", function()
    local ped = PlayerPedId()

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        DisableControlAction(0, 36, true) -- INPUT_DUCK  

        if (not IsPauseMenuActive()) then 
            RequestAnimSet("move_ped_crouched")

            while (not HasAnimSetLoaded("move_ped_crouched")) do 
                Citizen.Wait(100)
            end 

            if crouched then 
                TriggerEvent("AnimSet:Set")
                crouched = false 
            else
                SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
                crouched = true 
            end 
        end 
    end 
end, false)]]


--[[local lastDamageTrigger = 0

RegisterNetEvent("fire:damageUser")
AddEventHandler("fire:damageUser", function(Reqeuester)
	if not DoesPlayerExist(Reqeuester) then return end

	local attacker = GetPlayerFromServerId(Reqeuester)
	local Attackerped = GetPlayerPed(attacker)

	if IsPedShooting(Attackerped) then
		local name = GetSelectedPedWeapon(Attackerped)
        if name == `WEAPON_FIREEXTINGUISHER` and not exports["isPed"]:isPed("dead") then
        	lastDamageTrigger = GetGameTimer()
        	currentValues["oxy"] = currentValues["oxy"] - 15
        end
	end
end)]]



--[[local lastping = 0
local blipgps = {}
RegisterNetEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,srcid,stage)

	local job = exports["isPed"]:isPed("myjob")
	if job == "police" or job == "ems" or job == "auto_exotics" or job == "tuner_shop" or job == "harmony_autos" or job == "hayes_autos" then
		if blipgps.srcid then
			RemoveBlip(blipgps.srcid)
		end
		blipgps.srcid = AddBlipForCoord(x,y,z) 
	    SetBlipColour(blipgps.srcid,1)
		SetBlipSprite(blipgps.srcid, 459)
		SetBlipColour(blipgps.srcid, 8)
		SetBlipScale(blipgps.srcid, 1.5)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Help Call")
		EndTextCommandSetBlipName(blipgps.srcid)
		Citizen.Wait(55000)
		RemoveBlip(blipgps.srcid)
	end
end)

RegisterNetEvent('GPSTrack:Create')
AddEventHandler('GPSTrack:Create', function()

	if lastping == 0 then
		lastping = 1
		x,y,z = GPSTrack(1)
		TriggerServerEvent("GPSTrack:Accepted",x,y,z,1)
		Citizen.Wait(60000)
		x,y,z = GPSTrack(2)
		TriggerServerEvent("GPSTrack:Accepted",x,y,z,2)
		Citizen.Wait(60000)
		x,y,z = GPSTrack(3)
		TriggerServerEvent("GPSTrack:Accepted",x,y,z,3)
		Citizen.Wait(120000)
		lastping = 0
	end

end)


function GPSTrack(stage)
	local multi = 50
	if stage == 1 then
		multi = 110
	elseif stage == 2 then
		multi = 55
	else
		multi = 5
	end
	local luck = math.random(2)
	local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, math.random(multi) + 0.0, 0.0))
	if luck == 1 then
		x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), math.random(multi) + 0.0, 0.0, 0.0))
	end
	return x,y,z
end
]]

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



