local sesduzey = 1
local ping
local dogalgaz, db, wind, ampul, dollar, yuzme, gym = false, 0, 0, 0, 0, 0, 0
local health2, armor2, oxy2, hunger2, thirst2 = false, false, false, false, false
local developer, debug = false, false
local pursuitmode = 0
local lastDamageTrigger = 0
local nuke, gps, gpu = 0, 0, 0

local isLoggedIn = false
local HudActive = false
local harness = 0
local oxygenLevel = 25
local oxyOn = false
local hasChanged = false
local inVehicle = false
local inveh = false
local engineOn = false
local weaponFireRate = 0
local showWeaponFireRate = false
local showOutLine = false

LocalPlayer.state:set('stressLevel', 0, true)
LocalPlayer.state:set('thirstLevel', 100, true)
LocalPlayer.state:set('hungerLevel', 100, true)

RegisterNetEvent("np-hud:EnableHud", function(status)
    isLoggedIn = status
    if status == true then
        HudActive = false
    end
end)

RegisterNetEvent("np-hud:changeRange", function(pRange)
    voice = pRange or 2
end)

RegisterNetEvent('np-admin:currentDevmode', function(status)
    developer = status
end)

RegisterNetEvent('np-admin:currentDebug', function(status)
    debug = status
end)

RegisterNetEvent('np-weapons:client:setWeaponFireRate', function (pAmount)
    weaponFireRate = pAmount
end)

RegisterNetEvent("np-hud:harness_values", function(cinturon)
	harness = cinturon
end)

function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end

function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp2()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
end

function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)

    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
end

RegisterNetEvent("UseOxygenTank",function()
	oxygenLevel = 100.0
	TriggerEvent('menu:hasOxygenTank', true)
end)

RegisterNetEvent("RemoveOxyTank",function()
	if oxygenLevel > 25.0 then
		oxygenLevel = 25.0
        removeAttachedProp()
        removeAttachedProp2()
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local plyPed = PlayerPedId()

    if IsPedSwimmingUnderWater(plyPed) then
      if oxygenLevel > 0 then
        SetPedDiesInWater(plyPed, false)
        if not hasChanged then
          SetAudioSubmixEffectParamInt(0, 0, `enabled`, 1)
          hasChanged = true
        end
        if oxygenLevel > 25.0 then
          oxygenLevel = oxygenLevel - 0.003125
        else
          oxygenLevel = oxygenLevel - (swimSpeedIncreased and 0.33 or 0.5)
        end
      else
        SetPedDiesInWater(plyPed, true)
      end
    end

    if (not IsPedSwimmingUnderWater(plyPed)) and hasChanged then
      SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
      hasChanged = false
    end

    if not IsPedSwimmingUnderWater( plyPed ) and oxygenLevel < 25.0 then
      if GetGameTimer() - lastDamageTrigger > 3000 then
        oxygenLevel = oxygenLevel + 1
        if oxygenLevel > 25.0 then
          oxygenLevel = 25.0
        end
      else
        if oxygenLevel <= 0 then

          if exports['ragdoll']:GetDeathStatus() then
            lastDamageTrigger = -7000
            oxygenLevel = 25.0
          else
            SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 20)
          end
        end
      end
    end

    if oxygenLevel > 25.0 and (not oxyOn) and (useBlackOxy) then
      oxyOn = true
      attachProp("p_s_scuba_tank_s_black", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s_black", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif oxygenLevel > 25.0 and not oxyOn then
      oxyOn = true
      attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
      attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
    elseif oxyOn and oxygenLevel <= 25.0 then
      oxyOn = false
      removeAttachedProp()
      removeAttachedProp2()
      useBlackOxy = false
    end
    if not oxyOn then
      if IsPedSwimming(plyPed) then
        ResetPlayerStamina(plyPed)
      end
      Wait(200)
    else
      if (IsPedRunning(plyPed) or IsPedSprinting(plyPed)) and not IsPedSwimming(plyPed) then
        DisableControlAction(0, 21, true)
      end
    end
  end
end)

Citizen.CreateThread(function ()
    local isTalkingToggle = false
    local isTalkingOnRadio = false

	while true do

        local isTalking = NetworkIsPlayerTalking(PlayerId())
        local pRadioActive = exports['np-voice']:pRadioActive()

        if (isTalking and not isTalkingToggle) then
            isTalkingToggle = true
            SendNUIMessage({
                action = "update", 
                talking = isTalking and not pRadioActive,
                radioPush = pRadioActive,
            })
        elseif (not isTalking and isTalkingToggle) then
            isTalkingToggle = false
            SendNUIMessage({
                action = "update", 
                talking = isTalking and not pRadioActive,
                radioPush = pRadioActive,
            })
        end
		Citizen.Wait(100)
	end
end)


Citizen.CreateThread(function()
    voice = 2
    while true do 
        Citizen.Wait(500)

        if isLoggedIn then
        
            local playerPed = PlayerPedId()
            speed = GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 3.6
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
            local pRadio = exports['np-voice']:pRadioActive()

            armed = false

            armorLevel = GetPedArmour(playerPed)
            healthLevel = GetEntityHealth(playerPed) - 100

            if LocalPlayer.state.stressLevel < 0 then 
                LocalPlayer.state:set('stressLevel', 0, true)
            end

            if LocalPlayer.state.hungerLevel < 0 then
                LocalPlayer.state:set('hungerLevel', 0, true)
            end

            if LocalPlayer.state.thirstLevel < 0 then
                LocalPlayer.state:set('thirstLevel', 0, true)
            end

            if LocalPlayer.state.stressLevel > 100 then LocalPlayer.state:set('stressLevel', 100, true) end
            if LocalPlayer.state.hungerLevel > 100 then LocalPlayer.state:set('hungerLevel', 100, true) end
            if LocalPlayer.state.thirstLevel > 100 then LocalPlayer.state:set('thirstLevel', 100, true) end
            if healthLevel < 1 then healthLevel = 100 end
            if armorLevel > 100 then armorLevel = 100 end
            
            TriggerServerEvent("hud-getping:sv") 

            if IsPauseMenuActive() then
                if HudActive then
                    HudActive = false
                    SendNUIMessage({ action = 'show', show = false, }) 
                end
            elseif not IsPauseMenuActive() and isLoggedIn then
                if not HudActive then
                    HudActive = true
                    SendNUIMessage({action = 'show', show = true, }) 
                end
            end

            SendNUIMessage({
                action = "update",
                health = healthLevel,
                armor = armorLevel,
                hunger = LocalPlayer.state.hungerLevel,
                thirst = LocalPlayer.state.thirstLevel,
                stress = LocalPlayer.state.stressLevel,
                oxy = oxygenLevel,
                dogalgaz = dogalgaz,
                db = db,
                wind = wind,
                ping = ping,
                ampul = ampul, --lightbulp
                dollar = dollar,
                yuzme = yuzme, -- swim buff
                gym = gym,
                harness = harness,
                cruise = pursuitmode,
                nuke = nuke,
                gps = gps,
                gpu = gpu,
            --   nos = exports["np-nitro"]:HowmuchNitro(),
                nos = 0 ,
                dev = developer,
                debug = debug,
                armed = weaponFireRate,
                health2 = health2,
                armor2 = armor2,
                hunger2 = hunger2,
                thirst2 = thirst2,
                oxy2 = oxy2,
                voice = voice,
                radio = pRadio
            })
        else
            SendNUIMessage({ action = 'show', show = false, })
        end
    end
end)

-- functs

function OpenMenu() SetNuiFocus(true, true) SendNUIMessage({action = "open"})end

RegisterNUICallback('close', function(data, cb) SetNuiFocus(false, false) end)

RegisterNetEvent("hud-getping:cl") AddEventHandler("hud-getping:cl", function(ping1) ping = tonumber(ping1) end)

function dobuffthing(name, value)
    if name == "db" then
        db = tonumber(value)
    elseif name == "wind" then
        wind = tonumber(value)
    elseif name == "lightbulp" then
        ampul = tonumber(value)
    elseif name == "dollar" then
        dollar = tonumber(value)
    elseif name == "swimming" then
        yuzme = tonumber(value)
    elseif name == "gym" then
        gym = tonumber(value)
    elseif name == "dev" then 
        dev = not dev
    elseif name == "debug" then 
        debug = not debug
    elseif name == "health" then
        health2 = value
    elseif name == "armor" then
        armor2 = value
    elseif name == "hunger" then
        hunger2 = value
    elseif name == "thirst" then
        thirst2 = value
    elseif name == "oxy" then
        oxy2 = value
    elseif name == 'nuke' then
        nuke = value
    elseif name == 'pursuitmode' then -- Pursuit
        pursuitmode = value
    end
end

--- CARHUD ---

local area = ""
local street = ""
local dist = 0
local sleep = 50
local osurcam = 50
local carhudfps = 500

RegisterNUICallback("compass", function(data)
    sleep = data.fps 
    osurcam = data.fps
    print(sleep)
end)

RegisterNUICallback("carhud", function(data)
    carhudfps = data.fps 
    TriggerEvent("alahiyedik", data.fps)
end)

Citizen.CreateThread(function()
    while true do
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        local eon = IsVehicleEngineOn(veh)
        if eon and not engineOn then
            roundedRadar()
            engineOn = true

            local hour = GetClockHours()
            if hour < 10 then 
                hour = "0" .. hour
            end
            local minute = GetClockMinutes()
            if minute < 10 then 
                minute = "0" .. minute
            end
            local time = hour .. ":" .. minute

            if IsWaypointActive() then
                dist = (#(GetEntityCoords(PlayerPedId()) - GetBlipCoords(GetFirstBlipInfoId(8))) / 1000) * 0.715 -- quick conversion maff
            else
                dist = 0
            end

            if not IsPauseMenuActive() then 
                SendNUIMessage({
                    action = "carhud",
                    show = true,
                    direction = math.floor(calcHeading(-GetEntityHeading(player) % 360)),
                    area = area,
                    street = street,
                    mil = dist,
                    time = time
                })
            end
        elseif not eon and engineOn then
            engineOn = false
            Citizen.Wait(32)
            DisplayRadar(0)
        elseif IsPedOnFoot(PlayerPedId()) then
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({action = "carhud", show = false})
            SendNUIMessage({action = "carhud", bar5 = false})
        end

        Citizen.Wait(250)
    end
end)

local imageWidth = 100 -- leave this variable, related to pixel size of the directions
local containerWidth = 100 -- width of the image container

-- local width =  (imageWidth / containerWidth) * 100; -- used to convert image width if changed
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

---- OVALMAP -----

local minimapEnabled = true
local inVehicle = false
local forceShowMinimap = false
local useDefaultMinimap = false
local appliedTextureChange = false
local sa = false

RegisterNUICallback("minimap", function(data)
    if data.action == "close" then
        minimapEnabled = false
        SendNUIMessage({action = "carhud", bar5 = false})
        roundedRadar()
    elseif data.action == "open" then
        minimapEnabled = true
        DisplayRadar(1)
        SendNUIMessage({action = "carhud", bar5 = true})
        roundedRadar()
    elseif data.action == "default" then
        useDefaultMinimap = true
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)

        TriggerEvent("carhud:getmap", "default")
    elseif data.action == "ovalmap" then
        useDefaultMinimap = false
        roundedRadar()

        Wait(500)
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
        TriggerEvent("carhud:getmap", "ovalmap")
    elseif data.action == "outline-close" then
        DisplayRadar(1)
        showOutLine = false
        SendNUIMessage({action = "carhud", bar5 = false})
    elseif data.action == "outline-open" then
        DisplayRadar(1)
        showOutLine = true
        SendNUIMessage({action = "carhud", bar5 = true})   
    end
end)

function roundedRadar()
    if wasMinimapEnabled == false then
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false) 
        return
    end
    Citizen.CreateThread(function()
        if not appliedTextureChange and not useDefaultMinimap then
          RequestStreamedTextureDict("circlemap", false)
          while not HasStreamedTextureDictLoaded("circlemap") do
              Citizen.Wait(0)
          end
          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasklg")
          AddReplaceTexture("platform:/textures/graphics", "radarmasklg", "circlemap", "radarmasklg")
          appliedTextureChange = true
        elseif appliedTextureChange and useDefaultMinimap then
          appliedTextureChange = false
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasksm")
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasklg")
        end

        SetBlipAlpha(GetNorthRadarBlip(), 0.0)

        local screenX, screenY = GetScreenResolution()
        local modifier = screenY / screenX

        local baseXOffset = 0.0046875
        local baseYOffset = 0.74

        local baseSize    = 0.20 -- 20% of screen

        local baseXWidth  = 0.1313 -- baseSize * modifier -- %
        local baseYHeight = baseSize -- %

        local baseXNumber = screenX * baseSize  -- 256
        local baseYNumber = screenY * baseSize  -- 144

        local radiusX     = baseXNumber / 2     -- 128
        local radiusY     = baseYNumber / 2     -- 72

        local innerSquareSideSizeX = math.sqrt(radiusX * radiusX * 2) -- 181.0193
        local innerSquareSideSizeY = math.sqrt(radiusY * radiusY * 2) -- 101.8233

        local innerSizeX = ((innerSquareSideSizeX / screenX) - 0.01) * modifier
        local innerSizeY = innerSquareSideSizeY / screenY

        local innerOffsetX = (baseXWidth - innerSizeX) / 2
        local innerOffsetY = (baseYHeight - innerSizeY) / 2

        local innerMaskOffsetPercentX = (innerSquareSideSizeX / baseXNumber) * modifier

        local function setPos(type, posX, posY, sizeX, sizeY)
            SetMinimapComponentPosition(type, "I", "I", posX, posY, sizeX, sizeY)
        end
        if not useDefaultMinimap then
            setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
            setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
            setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)

            if showOutLine then
                SendNUIMessage({action = "carhud", bar5 = true})
            else
                SendNUIMessage({action = "carhud", bar5 = false})
            end
        else
            local function setPosLB(type, posX, posY, sizeX, sizeY)
                SetMinimapComponentPosition(type, "L", "B", posX, posY, sizeX, sizeY)
            end
            local offsetX = -0.018
            local offsetY = 0.025
  
            local defaultX = -0.0045
            local defaultY = 0.002
  
            local maskDiffX = 0.020 - defaultX
            local maskDiffY = 0.032 - defaultY
            local blurDiffX = -0.03 - defaultX
            local blurDiffY = 0.022 - defaultY
  
            local defaultMaskDiffX = 0.0245
            local defaultMaskDiffY = 0.03
  
            local defaultBlurDiffX = 0.0255
            local defaultBlurDiffY = 0.02
  
            setPosLB("minimap",       -0.0045,  -0.0245,  0.150, 0.18888)
            setPosLB("minimap_mask",  0.020,    0.022,  0.111, 0.159)
            setPosLB("minimap_blur",  -0.03,    0.002,  0.266, 0.237)

            if not showOutLine then
                SendNUIMessage({action = "carhud", bar5 = false})
            else
                SendNUIMessage({action = "carhud", bar5 = true})
            end
        end
        if not useDefaultMinimap then
          SetMinimapClipType(1)
        else
          SetMinimapClipType(0)
        end
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
    end)
end

RegisterNetEvent('np-hud:ChangeThirst', function(amount)
    if isLoggedIn == true then

        LocalPlayer.state:set('thirstLevel', LocalPlayer.state.thirstLevel + amount, true)

		if LocalPlayer.state.thirstLevel < 0 then
            LocalPlayer.state:set('thirstLevel', 0, true)
		end

		if LocalPlayer.state.thirstLevel > 100 then
            LocalPlayer.state:set('thirstLevel', 100, true)
		end
	end
end)

RegisterNetEvent('np-hud:ChangeHunger', function(amount)
	if isLoggedIn == true then

        LocalPlayer.state:set('hungerLevel', LocalPlayer.state.hungerLevel + amount, true)

		if LocalPlayer.state.hungerLevel < 0 then
            LocalPlayer.state:set('hungerLevel', 0, true)
		end

		if LocalPlayer.state.hungerLevel > 100 then
            LocalPlayer.state:set('hungerLevel', 100, true)
		end
	end
end)

RegisterNetEvent("np-hud:updateStress", function(status, amount)
    if status == true then
        LocalPlayer.state:set('hungerLevel', LocalPlayer.state.stressLevel + amount, true)
        TriggerEvent("DoShortHudText",'Stress Gained',6)
    elseif status == false then
        LocalPlayer.state:set('hungerLevel', LocalPlayer.state.stressLevel - amount, true)
        TriggerEvent("DoShortHudText",'Stress Relieved',6)
    end
end)

RegisterNetEvent('np-admin:maxstats', function()
    LocalPlayer.state:set('stressLevel', 0, true)
    LocalPlayer.state:set('thirstLevel', 100, true)
    LocalPlayer.state:set('hungerLevel', 100, true)
    TriggerEvent("heal", PlayerPedId())
    TriggerEvent("Hospital:HealInjuries", PlayerPedId(),true) 
    TriggerServerEvent("np-death:reviveSV", source)
    TriggerServerEvent("reviveGranted", source)
    TriggerServerEvent("ems:healplayer", source)
    SetPlayerMaxArmour(PlayerPedId(), 100)
    SetPedArmour(PlayerPedId(), 100)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn then
            
            if LocalPlayer.state.hungerLevel > 0 then
                LocalPlayer.state:set('hungerLevel', LocalPlayer.state.hungerLevel - math.random(3), true)
            end

            if LocalPlayer.state.thirstLevel > 0 then
                LocalPlayer.state:set('thirstLevel', LocalPlayer.state.thirstLevel - 3, true)
            end	

            if LocalPlayer.state.thirstLevel < 20 or LocalPlayer.state.hungerLevel < 20 then
                local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
                SetEntityHealth(PlayerPedId(), newhealth)
            end
            TriggerEvent('np-hud:SaveValues')

            Citizen.Wait(300000)
        end
	end
end)

RegisterNUICallback("time", function(data)
    exports['np-carhud']:SetTimeEnabled(data.time)
end)

RegisterNUICallback("SaveSettings", function(data)
    local pInfo = exports["np-base"]:getModule("LocalPlayer")
    local cid = exports['isPed']:isPed('cid')

    SetResourceKvpInt(cid..'-healthValue', tonumber(data.healthValue))
    SetResourceKvpInt(cid..'-armorValue', tonumber(data.armorValue))
    SetResourceKvpInt(cid..'-hungerValue', tonumber(data.hungerValue))
    SetResourceKvpInt(cid..'-thirstValue', tonumber(data.thirstValue))

    SetResourceKvpInt(cid..'-healthToggled', data.healthToggled)
    SetResourceKvpInt(cid..'-armorToggled', data.armorToggled)
    SetResourceKvpInt(cid..'-hungerToggled', data.hungerToggled)
    SetResourceKvpInt(cid..'-thirstToggled', data.thirstToggled)

    SetResourceKvpInt(cid..'-speedFPSValue', tonumber(data.speedFPSValue))
    SetResourceKvpInt(cid..'-compassFPSValue', tonumber(data.compassFPSValue))

    SetResourceKvpInt(cid..'-defaultMapToggled', data.defaultMapToggled)
    SetResourceKvpInt(cid..'-outlineToggled', data.outlineToggled)
    SetResourceKvpInt(cid..'-timeToggled', data.timeToggled)

    exports['np-carhud']:SetCompassFPS(tonumber(data.compassFPSValue))
    exports['np-carhud']:SetSpeedFPS(tonumber(data.speedFPSValue))

    TriggerEvent('DoShortHudText', 'Setting Saved!', 1)
end)

RegisterNetEvent("np-hud:SaveValues", function()
    local pInfo = exports["np-base"]:getModule("LocalPlayer")
    local cid = exports['isPed']:isPed('cid')
    SetResourceKvpInt(cid..'-armour', GetPedArmour(PlayerPedId()))
    SetResourceKvpInt(cid..'-stress', LocalPlayer.state.stressLevel)
    SetResourceKvpInt(cid..'-thirst', LocalPlayer.state.thirstLevel)
    SetResourceKvpInt(cid..'-hunger', LocalPlayer.state.hungerLevel)
    SetResourceKvpInt(cid..'-health', GetEntityHealth(PlayerPedId()))
end)

RegisterNetEvent("np-hud:SetValues", function()
    local pInfo = exports["np-base"]:getModule("LocalPlayer")
    local cid = exports['isPed']:isPed('cid')

    local SetAmour = GetResourceKvpInt(cid..'-armour')
    local SetStress = GetResourceKvpInt(cid..'-stress')
    local SetThirst = GetResourceKvpInt(cid..'-thirst')
    local SetHunger = GetResourceKvpInt(cid..'-hunger')
    local SetHealth = GetResourceKvpInt(cid..'-health')

    local SetHealthValue = GetResourceKvpInt(cid..'-healthValue')
    local SetArmorValue = GetResourceKvpInt(cid..'-armorValue')
    local SetHungerValue = GetResourceKvpInt(cid..'-hungerValue')
    local SetThirstValue = GetResourceKvpInt(cid..'-thirstValue')

    local SetHealthToggled = GetResourceKvpInt(cid..'-healthToggled')
    local SetArmorToggled = GetResourceKvpInt(cid..'-armorToggled')
    local SetHungerToggled = GetResourceKvpInt(cid..'-hungerToggled')
    local SetThirstToggled = GetResourceKvpInt(cid..'-thirstToggled')

    local SetSpeedFPSValue = GetResourceKvpInt(cid..'-speedFPSValue')
    local SetCompassFPSValue = GetResourceKvpInt(cid..'-compassFPSValue')

    local SetDefaultMapToggled = GetResourceKvpInt(cid..'-defaultMapToggled')
    local SetOutlineToggled = GetResourceKvpInt(cid..'-outlineToggled')
    local SetTimeToggled = GetResourceKvpInt(cid..'-timeToggled')


    SendNUIMessage({ 
        action = 'SetSettings',

        SetHealthValue = SetHealthValue,
        SetArmorValue = SetArmorValue,
        SetHungerValue = SetHungerValue,  
        SetThirstValue = SetThirstValue,

        SetHealthToggled = SetHealthToggled,
        SetArmorToggled = SetArmorToggled,
        SetHungerToggled = SetHungerToggled,
        SetThirstToggled = SetThirstToggled,

        SetSpeedFPSValue = SetSpeedFPSValue,
        SetCompassFPSValue = SetCompassFPSValue,

        SetDefaultMapToggled = SetDefaultMapToggled,
        SetOutlineToggled = SetOutlineToggled,
        SetTimeToggled = SetTimeToggled,
    })


    exports['np-carhud']:SetCompassFPS(SetCompassFPSValue)
    exports['np-carhud']:SetSpeedFPS(SetSpeedFPSValue)

    if SetDefaultMapToggled == 1 then 
        useDefaultMinimap = true
        appliedTextureChange = false
        roundedRadar()
        Wait(500)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
    elseif SetDefaultMapToggled == 0 then 
        useDefaultMinimap = false
        Wait(500)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
    end

    if SetTimeToggled == 1 then
        exports['np-carhud']:SetTimeEnabled(true)
    elseif SetTimeToggled == 0 then
        exports['np-carhud']:SetTimeEnabled(false)
    end

    if SetOutlineToggled == 1 then 
        showOutLine = true
    elseif SetOutlineToggled == 0 then 
        showOutLine = false
    end

    if SetHunger == nil then 
        LocalPlayer.state:set('hungerLevel', 100, true)
        SetResourceKvpInt(cid..'-hunger', 100)
    else
        LocalPlayer.state:set('hungerLevel', SetHunger, true)
    end

    if SetThirst == nil then 
        LocalPlayer.state:set('thirstLevel', 100, true)
        SetResourceKvpInt(cid..'-thirst', 100)
    else
        LocalPlayer.state:set('thirstLevel', SetThirst, true)
    end

    if SetStress == nil then 
        LocalPlayer.state:set('stressLevel', 0, true)
        SetResourceKvpInt(cid..'-stress', 100)
    else
        LocalPlayer.state:set('stressLevel', SetStress, true)
    end

    Wait(1000)

    if SetHealth ~= nil then
        if SetHealth < 10.0 then
            SetEntityHealth(PlayerPedId(), 10.0)
        else
            SetEntityHealth(PlayerPedId(), SetHealth)
        end
    else
        SetEntityHealth(PlayerPedId(),100.0)
    end

    if SetAmour == nil then 
        SetPlayerMaxArmour(PlayerPedId(), 100)
        SetPedArmour(PlayerPedId(), 100)
        SetResourceKvpInt(cid..'-armour', 100)
    else
        SetPlayerMaxArmour(PlayerPedId(), 100)
        SetPedArmour(PlayerPedId(), SetAmour)
    end
end)

RegisterCommand('ui-r', function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'closeMenu'})
    TriggerEvent('np-hud:EnableHud', false)
    TriggerEvent('closeInventoryGui')
    TriggerEvent('np-banking:ResetUI')
    TriggerEvent('np-radio:ResetUI')
    TriggerEvent('np-menu:ResetUI')
    TriggerEvent('np-interact:ResetUI')
    TriggerEvent('np-mdt:ResetUI')
    TriggerEvent('phone:reset')
    TriggerEvent('clothing:close')
    exports['np-ui']:showInteraction("Restarting UI .")
    Wait(1000)
    exports['np-ui']:showInteraction("Restarting UI ..")
    Wait(1000)
    exports['np-ui']:showInteraction("Restarting UI ...")
    Wait(1000)
    exports['np-ui']:showInteraction("UI Successfully Restarted")
    Wait(1000)
    exports['np-ui']:hideInteraction()
    TriggerEvent('np-hud:EnableHud', true)
end)

exports("setFuel", function(veh, amt)
	DecorSetInt(veh, "GetVehicleCurrentFuel", amt)
end)