local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local lastValues = {}
Fuel = 0
local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["hunger"] = 100,
	["thirst"] = 100,
	["oxy"] = 2,
	["stress"] = 100,
	["voice"] = 2,
	["devmode"] = false,
	["devdebug"] = false,
	["is_talking"] = false
}

local compassEnabled = true
local isLoggedIn = false
local compassRoadNamesEnabled = true
local compassWaitTime = 16
local speedometerWaitTime = 64
local showCompassFromWatch = false
local showCompassFromCar = false
local minimapEnabled = true
local wasMinimapEnabled = true
local useDefaultMinimap = false
local appliedTextureChange = false
local round = false
local inVehicle = false
local inveh = false
local engineOn = false
local isDead = false
local pStress = 0

RegisterNetEvent("np-hud:EnableHud")
AddEventHandler("np-hud:EnableHud", function(status)
    isLoggedIn = status
end)


DecorRegister("GetVehicleCurrentFuel", 3)

function fRound( n )
    return math.floor( n + 0.5 )
end


function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end
function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

function HasPedLoaded()
    if PlayerPedId() == PlayerPedId() then return true else return false end
end
CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 0)
end)

local lastDamageTrigger = 0
  
currentValues["oxy"] = 25

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
	if currentValues["oxy"] > 25.0 then
		currentValues["oxy"] = 25.0
        removeAttachedProp()
        removeAttachedProp2()
        print('[OXYGEN] Removed tank')
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
	currentValues["oxy"] = 100.0
	TriggerEvent('menu:hasOxygenTank', true)
end)

--- Disables wierd run after shooting
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then
            if IsPedUsingActionMode(ped) then
                SetPedUsingActionMode(ped, -1, -1, 1)
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

oxyOn = false

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if currentValues["oxy"] > 0 and IsPedSwimmingUnderWater(PlayerPedId()) then
			SetPedDiesInWater(PlayerPedId(), false)
			if currentValues["oxy"] > 25.0 then
				currentValues["oxy"] = currentValues["oxy"] - 0.0028125
			else
				currentValues["oxy"] = currentValues["oxy"] - 2.5
			end
		else
			if IsPedSwimmingUnderWater(PlayerPedId()) then
				currentValues["oxy"] = currentValues["oxy"] - 0.01
				SetPedDiesInWater(PlayerPedId(), true)
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 15)
			end
		end

		if not IsPedSwimmingUnderWater( PlayerPedId() ) and currentValues["oxy"] < 25.0 then
			if GetGameTimer() - lastDamageTrigger > 3000 then
				currentValues["oxy"] = currentValues["oxy"] + 6
				if currentValues["oxy"] > 25.0 then
					currentValues["oxy"] = 25.0
				end
			else
				if currentValues["oxy"] <= 0 then
                    local dead = exports['ragdoll']:GetDeathStatus()

					if dead then
						lastDamageTrigger = -7000
						currentValues["oxy"] = 25.0
					else
						SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 20)
					end
				end
			end
		end

		if currentValues["oxy"] > 25.0 and not oxyOn then
			oxyOn = true
			attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
			attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
		elseif oxyOn and currentValues["oxy"] <= 25.0 then
			oxyOn = false
			removeAttachedProp()
			removeAttachedProp2()
		end
		if not oxyOn then
			Wait(1000)
    end

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
            SendNUIMessage({
                action = "displayUI"
            })
            round = true
          setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
          setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
          -- setPos("minimap_mask",  baseXOffset + innerOffsetX, baseYOffset + innerOffsetY, innerSizeX, innerSizeY)
          -- The next one is FUCKING WEIRD.
          -- posX is based off top left 0.0 coords of minimap - 0.00 -> 1.00
          -- posY seems to be based off of the top of the minimap, with 0.75 representing 0% and 1.75 representing 100%
          -- sizeX is based off the size of the minimap - 0.00 -> 0.10
          -- sizeY seems to be height based on minimap size, ranging from -0.25 to 0.25
          setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)
          -- setPos("minimap_mask", 0.0, 0.75, 1.0, 1.0)
          -- setPos("minimap_mask",  baseXOffset, baseYOffset, baseXWidth, baseYHeight)
        else
            round = false
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

Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        --
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(15)
        --HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)

        local selectedWeapon = GetSelectedPedWeapon(PlayerPedId())
		if `WEAPON_UNARMED` ~= selectedWeapon and 741814745 ~= selectedWeapon then
			DisplayAmmoThisFrame(true)
		end

        HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
        DisableControlAction(0, 37, true)
        
        HideMinimapInteriorMapThisFrame()
        SetRadarZoom(1000)

        Citizen.Wait(0)
    end
end)

-- No idle cams
Citizen.CreateThread(function()
    while true do
      InvalidateIdleCam()
      N_0x9e4cfff989258472() -- Disable the vehicle idle camera
      Wait(10000) --The idle camera activates after 30 second so we don't need to call this per frame
    end 
end)

--minimap stuff

local speed = 0.0
local cruiseOn = false
local toggle = false
local developer = false
local estashowroom = false
local setHealOnOff = true
local setArmorOnOff = true
local setFoodOnOff = true
local setWateronOff = true
local setOxyOnOff = true
local setStressOnOff = true
local developer = false
local debug = false
local bleedingPercentage = 0
local level = 100
local voz = 66.66
local speedometeron = 0
local tiempo = 0
local pursuitmode = 0
local ecompass = false
local hcompass = 100
local shoot = 0
local chipmode = 0

local seatbelt = false
RegisterNetEvent("seatbelt")
AddEventHandler("seatbelt", function(belt)
    seatbelt = belt
end)

local harness = false
local harnessDur = 0.0
RegisterNetEvent("harness")
AddEventHandler("harness", function(belt, dur)    
    harness = belt
    harnessDur = dur             
end)

RegisterNetEvent('np-admin:currentDevmode')
AddEventHandler('np-admin:currentDevmode', function(test)
    developer = test
end)

RegisterNetEvent('np-admin:currentDebug')
AddEventHandler('np-admin:currentDebug', function(status)
    debug = status
end)


RegisterNUICallback('update:timer:speed', function(data)
    TriggerEvent("unwind-hud:changefps",data.fps_speed)
end)



RegisterNetEvent('speedmeter:info')
AddEventHandler('speedmeter:info', function(test)
    speedometeron = test
    print(speedometeron)
end)

RegisterNetEvent('hud:casino')
AddEventHandler('hud:casino', function(test)
    tiempo = test
end)

RegisterNetEvent("np-hud:changeRange")
AddEventHandler("np-hud:changeRange", function(pRange)
    voice = pRange or 2
end)

-- RegisterNetEvent("np-hud:changeRange")
--  AddEventHandler("np-hud:changeRange", function(pRange)
-- 	if pRange == 99 then
--     	currentValues["voice"] = 99
--     elseif pRange == 1 then 
--  		currentValues["voice"] = 3
--  	elseif pRange == 2 then
--     	currentValues["voice"] = 2
--  	else
--  		currentValues["voice"] = 1
--  	end
-- end)

AddEventHandler("hud:voice:transmitting", function (transmitting)
	SendNUIMessage({type = "transmittingStatus", is_transmitting = transmitting})
end)

RegisterNetEvent('estashowroom')
AddEventHandler('estashowroom', function(test)
    estashowroom = test
end)

RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"],currentValues["armor"])
end)

Citizen.CreateThread( function()
	while true do
		Wait(50)
		local ped = PlayerPedId()
		if IsPedShooting(ped) and not IsPedCurrentWeaponSilenced(ped) then
			Citizen.Wait(50)
			TriggerEvent("client:newStress",true,math.random(15,40))
			Citizen.Wait(800)
		elseif IsPedShooting(ped) and IsPedCurrentWeaponSilenced(ped) then 
			Citizen.Wait(50)
			TriggerEvent("client:newStress",true,math.random(15,40))
			Citizen.Wait(800)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
    	if currentValues["hunger"] > 0 then
    		currentValues["hunger"] = currentValues["hunger"] - math.random(1)
    	end
	    if currentValues["thirst"] > 0 then
    		currentValues["thirst"] = currentValues["thirst"] - 1
    	end	

		Citizen.Wait(120000)
    	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
		
		if currentValues["thirst"] < 20 or currentValues["hunger"] < 20 then
			local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
			SetEntityHealth(PlayerPedId(), newhealth)
			
		end
	end
end)
blackBars = true
CinematicCamBool = true
hudoff = true


RegisterNUICallback('hud_on', function(data)
    hudoff = data.hud_on
end)

RegisterNUICallback('compassinput', function(data)
    TriggerEvent("change:full_oof", data.compassinput)
end)

RegisterNUICallback('compassTime', function(data)
    TriggerEvent("change:compass", data.compassTime)
end)

RegisterNUICallback('compassStreet', function(data)
    TriggerEvent("change:street", data.compassStreet)
end)

RegisterNUICallback('minimap_clip', function(data)
    useDefaultMinimap = data.d_minimap
end)


local radioPush = false

local watchtoggeled = false
RegisterNetEvent("police:enablewatchcompass")
AddEventHandler("police:enablewatchcompass",function()

    -- unwind
    watchtoggeled = not watchtoggeled
    if watchtoggeled then
        print('off')
        
    else
        SendNUIMessage({
            action = "compass", 
        })
    end
end)

RegisterNetEvent("police:setClientMeta")
AddEventHandler("police:setClientMeta",function(meta)
	if meta == nil then return end
	if meta.thirst == nil then currentValues["thirst"] = 100 else currentValues["thirst"] = meta.thirst end
	if meta.hunger == nil then currentValues["hunger"] = 100 else currentValues["hunger"] = meta.hunger end
	if meta.health == nil then
		return
	end

	if meta.health < 10.0 then
		SetEntityHealth(PlayerPedId(),10.0)
	else
		SetEntityHealth(PlayerPedId(),meta.health)
	end

	
	SetPlayerMaxArmour(PlayerPedId(), 60 )
	SetPedArmour(PlayerPedId(),meta.armour)
end)

pRadioActive = false

RegisterNetEvent("np-voice:radioActive")
AddEventHandler("np-voice:radioActive",function(pBool)
    pRadioActive = pBool
end)

Citizen.CreateThread(function ()
	while true do
		local isTalking = NetworkIsPlayerTalking(PlayerId())
        if isTalking == 1 and pRadioActive == false then
            talking = "normal"
        elseif pRadioActive == true then 
            talking = "radio"
        elseif not isTalking then
            talking = "nottalking"
        end
        SendNUIMessage({
            action = "voiceupdate", 
            talking = talking,
            radioPush = pRadioActive,
        })
		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
    voice = 2
    while true do 
        Citizen.Wait(500)
        if isLoggedIn then
            local playerPed = PlayerPedId()
            speed = GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 2.4
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
            local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            local pRadio = exports['radio']:pChannel()

            local get_ped = PlayerPedId()
            currentValues["armor"] = GetPedArmour(get_ped)

            local death = exports['ragdoll']:GetDeathStatus()
            --currentValues["health"] = GetEntityHealth(get_ped) - 100
            currentValues["armor"] = GetPedArmour(get_ped)
            if stresslevel ~= nil then
                currentValues["stress"] = math.ceil(stresslevel / 100)
            else
                currentValues["stress"] = 0
            end
            if currentValues["stress"] > 100 then currentValues["stress"] = 100 end

            if currentValues["hunger"] < 0 then
                currentValues["hunger"] = 0
            end
            if currentValues["thirst"] < 0 then
                currentValues["thirst"] = 0
            end

            if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end

            if currentValues["health"] < 1 then currentValues["health"] = 100 end
            if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end
        
                
            if oxy < 0 then oxy = 0 end

            -- if IsPedInAnyVehicle(PlayerPedId(), true) and not IsPauseMenuActive() then 
            --     local Mph = math.ceil(GetEntitySpeed(playerVeh) * 3.6)
            --     local vehhash = GetEntityModel(playerVeh)
            --     local maxspeed = GetVehicleModelMaxSpeed(vehhash) * 3.6
            --     -- SendNUIMessage({action = "ShowCarHud", showCarUi = true})
            --     -- SendNUIMessage({action = "ShowCarHud", belt = seatbelt})                
            --     -- SendNUIMessage({action = "ShowCarHud", speed = Mph, maxspeed = maxspeed, engine = engine, fuel = math.ceil(Fuel)})                
            -- else                
            --     -- SendNUIMessage({action = "ShowCarHud", showCarUi = false})
            -- end
            SendNUIMessage({
                action = "hudtick",
                show = IsPauseMenuActive() or hudoff == false,
                health = GetEntityHealth(playerPed),
                armor = lerp(0, 100, rangePercent(0, 60, currentValues["armor"])),--GetPedArmour(playerPed),
                hunger = currentValues["hunger"],
                thirst = currentValues["thirst"],
                oxygen = currentValues["oxy"],
                mic = voice,
                stress = currentValues["stress"],
                radio = pRadio,
                dev = developer,
                dev2 = debug,
                speedometeron = speedometeron,               
                casino = tiempo,
                inVehicle = inveh,
                cinturon = harnessDur,
                nitron = hasbottle,--exports["np-nitro"]:onNitro(),
                pursuitmode = SelectedPursuitMode,
                hcompass = hcompass,
                ecompass = ecompass,
                hshootmode = hshootmode,
                shootmode = 0,
                chipmode = chipmode                
                
                             
                
            })
        else 
            -- SendNUIMessage({action = "ShowCarHud", showCarUi = false})
            SendNUIMessage({action = "hudtick", show = "none"})
        end
    end
end)




RegisterNetEvent('hud:dealertimerClock')
AddEventHandler('hud:dealertimerClock', function(timetable)
    casino = timetable
end)

RegisterNetEvent('noshud')
AddEventHandler('noshud', function(newlevel,noson,bottle)
	level = newlevel
	nitro = noson
	nitron = bottle
end)

RegisterNetEvent('np-hud:ChangeThirst')
AddEventHandler('np-hud:ChangeThirst', function(amount)
    if isLoggedIn == true then
		currentValues["thirst"] = currentValues["thirst"] + amount

		if currentValues["thirst"] < 0 then
			currentValues["thirst"] = 0
		end

		if currentValues["thirst"] > 100 then
			currentValues["thirst"] = 100
		end
	end
end)

RegisterNetEvent('np-hud:ChangeHunger')
AddEventHandler('np-hud:ChangeHunger', function(amount)
	if isLoggedIn == true then
		currentValues["hunger"] = currentValues["hunger"] + amount

		if currentValues["hunger"] < 0 then
			currentValues["hunger"] = 0
		end

		if currentValues["hunger"] > 100 then
			currentValues["hunger"] = 100
		end
	end
end)

function GetPed()
    return PlayerPedId()
end

local isPause = false
local uiHidden = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not useDefaultMinimap then
            if IsPauseMenuActive() or IsRadarHidden() then
                if not uiHidden then
                    SendNUIMessage({
                        action = "hideUI"
                    })
                    uiHidden = true
                end
            elseif uiHidden or IsPauseMenuActive() then
                Citizen.Wait(500)
                SendNUIMessage({
                    action = "displayUI"
                })
                uiHidden = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local veh = GetVehiclePedIsIn(GetPed(), false)
        local eon = IsVehicleEngineOn(veh)
        if eon and not engineOn then
            roundedRadar()
            engineOn = true
            inVehicle = true
            inveh = true
        elseif not eon and engineOn then
            inveh = false
            engineOn = false
            showCompassFromCar = false
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({
                action = "hideUI"
            })
        elseif IsPedOnFoot(GetPed()) then
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({
                action = "hideUI"
            })
        elseif wasMinimapEnabled ~= minimapEnabled then
            wasMinimapEnabled = minimapEnabled
            roundedRadar()
        end
    end
end)

RegisterNUICallback('ayar-minimap', function(data)
    minimapEnabled = data.minimap
end)

currentValues["hunger"] = 100
currentValues["thirst"] = 100

hunger = "Full"
thirst = "Sustained"

AddEventHandler('playerSpawned', function()
    Citizen.Wait(8000)
    SendNUIMessage({action = "DisplayPursuitMode", pursuitmode = 0})
end)

RegisterCommand('hud', function()
    TriggerEvent('np-hud:open-hud')
end)

RegisterNetEvent('np-hud:open-hud')
AddEventHandler('np-hud:open-hud', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'showMenu'})
end)

RegisterNUICallback('close-ayar-menu', function()
    SetNuiFocus(false, false)
end)

dstamina = 0

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
	stresslevel = newStress
end)

local stressDisabled = false
RegisterNetEvent("client:disableStress")
AddEventHandler("client:disableStress",function(stressNew)
	stressDisabled = stressNew
end)


RegisterNetEvent("client:newStress")
AddEventHandler("client:newStress",function(positive,alteredValue)
	if stressDisabled then
		return
	end
	if positive then
		TriggerEvent("DoShortHudText",'Stress Gained',6)
	else
		TriggerEvent("DoShortHudText",'Stress Relieved',6)
	end

	TriggerServerEvent("server:alterStress",positive,alteredValue,GetPlayerServerId())
end)


RegisterNetEvent("stress:timed")
AddEventHandler("stress:timed",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	TriggerEvent("DoShortHudText",'Stress is being relieved',6)
	SetPlayerMaxArmour(PlayerId(), 30 )
	while true do
		removedStress = removedStress + 100
		if removedStress >= alteredValue then
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerServerEvent("server:alterStress",false,removedStress)
end)


RegisterNetEvent("stress:timed2")
AddEventHandler("stress:timed2",function(alteredValue,scenario)
	local removedStress = 0
    Wait(100)
	while true do
		removedStress = removedStress + 100
		if removedStress >= alteredValue then
            TriggerEvent("animation:cancel")
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+1)
        TriggerServerEvent("server:alterStress",false,removedStress)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
end)


-- Citizen.CreateThread(function()

--     while true do

--         Citizen.Wait(500)
--         local player = PlayerPedId()

--         if (IsPedInAnyVehicle(player, false)) then

--             local veh = GetVehiclePedIsIn(player,false)

--             if GetPedInVehicleSeat(veh, -1) == player then

--                 if not DivingStatus then


--                     if updateLatestVehicle ~= veh then
--                         if not DecorExistOn(veh, "GetVehicleCurrentFuel") then
--                             Fuel = math.random(80,100)
--                         else
--                             Fuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--                         end
--                     else
--                         Fuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--                     end

--                     DivingStatus = true
--                     updateLatestVehicle = veh
--                     setLastUpdate = 0

--                     if not DecorExistOn(veh, "GetVehicleCurrentFuel") then 
--                         Fuel = math.random(80,100)
--                         DecorSetInt(veh, "GetVehicleCurrentFuel", fRound(Fuel))
--                     end

--                 else

--                     if Fuel > 105 then
--                         Fuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--                     end                     
--                     if Fuel == 101 then
--                         Fuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--                     end

--                 end

--                 if ( setLastUpdate > 300) then
--                     DecorSetInt(veh, "GetVehicleCurrentFuel", fRound(Fuel))
--                     lasteupdate = 0
--                 end

--                 setLastUpdate = setLastUpdate + 1

--                 if Fuel > 0 then
--                     if IsVehicleEngineOn(veh) then
--                         local fueltankhealth = GetVehiclePetrolTankHealth(veh)
--                         if fueltankhealth == 1000.0 then
--                             SetVehiclePetrolTankHealth(veh, 4000.0)
--                         end
--                         local fuelMath = GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6
--                         if fuelMath > 30 then
--                             fuelMath = fuelMath * 1.8
--                         else
--                             fuelMath = fuelMath / 2.0
--                         end
--                         fuelMath = fuelMath / 7500

--                         if fuelMath == 0 then
--                             fuelMath = 0.0001
--                         end
--                         if IsPedInAnyBoat(PlayerPedId()) then
--                             fuelMath = 0.0090
--                         end
--                         local missingTankHealth = (4000 - fueltankhealth) / 1000

--                         if missingTankHealth > 1 then
--                             missingTankHealth = missingTankHealth * (missingTankHealth * missingTankHealth * 12)
--                         end

--                         local factorFuel = (fuelMath + 1 / 5000) * (missingTankHealth+1)
--                         Fuel = Fuel - factorFuel
--                     end
--                 end

--                 if Fuel <= 4 and Fuel > 0 then
--                     if not IsThisModelABike(GetEntityModel(veh)) then
--                         local decayChance = math.random(20,100)
--                         if decayChance > 90 then
--                             SetVehicleEngineOn(veh,0,0,1)
--                             SetVehicleUndriveable(veh,true)
--                             Citizen.Wait(100)
--                             SetVehicleEngineOn(veh,1,0,1)
--                             SetVehicleUndriveable(veh,false)
--                         end
--                     end
--                 end

--                 if Fuel < 15 then
--                 end

--                 if Fuel < 1 then
--                     if Fuel ~= 0 then
--                         Fuel = 0
--                         DecorSetInt(veh, "GetVehicleCurrentFuel", fRound(Fuel))
--                     end

--                     if IsVehicleEngineOn(veh) or IsThisModelAHeli(GetEntityModel(veh)) then
--                         SetVehicleEngineOn(veh,0,0,1)
--                         SetVehicleUndriveable(veh,false)
--                     end
--                 end
--             end
--         else
--             if DivingStatus then
--                 DivingStatus = false
--                 DecorSetInt(updateLatestVehicle, "GetVehicleCurrentFuel", fRound(Fuel))
--             end
--             Citizen.Wait(1500)
--         end
--     end
-- end)
-- local showGasStations = false

-- local gasStations = {
--     {49.41872, 2778.793, 58.04395,600},
--     {263.8949, 2606.463, 44.98339,600},
--     {1039.958, 2671.134, 39.55091,900},
--     {1207.26, 2660.175, 37.89996,900},
--     {2539.685, 2594.192, 37.94488,1500},
--     {2679.858, 3263.946, 55.24057,1500},
--     {2005.055, 3773.887, 32.40393,1200},
--     {1687.156, 4929.392, 42.07809,900},
--     {1701.314, 6416.028, 32.76395,1200},
--     {179.8573, 6602.839, 31.86817,600},
--     {-94.46199, 6419.594, 31.48952,600},
--     {-2554.996, 2334.402, 33.07803,600},
--     {-1800.375, 803.6619, 138.6512,600},
--     {-1437.622, -276.7476, 46.20771,600},
--     {-2096.243, -320.2867, 13.16857,600},
--     {-724.6192, -935.1631, 19.21386,600},
--     {-526.0198, -1211.003, 18.18483,600},
--     {-70.21484, -1761.792, 29.53402,600},
--     {265.6484,-1261.309, 29.29294,600},
--     {819.6538,-1028.846, 26.40342,780},
--     {1208.951,-1402.567, 35.22419,900},
--     {1181.381,-330.8471, 69.31651,900},
--     {620.8434, 269.1009, 103.0895,780},
--     {2581.321, 362.0393, 108.4688,1500},
--     {1785.363, 3330.372, 41.38188,1200},
--     {-319.537, -1471.5116, 30.54118,600},
--     {-66.58, -2532.56, 6.14, 400}
-- }


-- RegisterNetEvent('CarPlayerHud:ToggleGas')
-- AddEventHandler('CarPlayerHud:ToggleGas', function()
--     showGasStations = not showGasStations
--    for _, item in pairs(gasStations) do
--         if not showGasStations then
--             if item.blip ~= nil then
--                 RemoveBlip(item.blip)
--             end
--         else
--             item.blip = AddBlipForCoord(item[1], item[2], item[3])
--             SetBlipSprite(item.blip, 361)
--             SetBlipScale(item.blip, 0.7)
--             SetBlipAsShortRange(item.blip, true)
--             BeginTextCommandSetBlipName("STRING")
--             AddTextComponentString("Gas")
--             EndTextCommandSetBlipName(item.blip)
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     showGasStations = true
--     TriggerEvent('CarPlayerHud:ToggleGas')
-- end)

-- RegisterNetEvent('np-gas:checkpump')
-- AddEventHandler('np-gas:checkpump', function()
--     local ped = PlayerPedId()
-- 	local vehicle = GetPlayersLastVehicle()
-- 	local vehicleCoords = GetEntityCoords(vehicle)
--     local veh = getVehicleClosestToMe()

--     TriggerEvent('customNotification', "Make sure you are facing the vehicle!") 
--     TaskTurnPedToFaceEntity(ped, vehicle, 1000)
--     Wait(1600)
--     if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then
--         vehicleCurrentFuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--         costs = (100 - vehicleCurrentFuel)
--         if costs < 0 then
--             costs = 0
--         end
--         if vehicleCurrentFuel >= 100 then
--             PlaySound(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
--             TriggerEvent('customNotification', "You are already full!") 
--         else
--             costs = math.ceil(costs)
--             TriggerServerEvent("carfill:checkmoney", costs)
--         end
--     end
-- end)

-- exports("setFuel", function(veh, amt)
-- 	DecorSetInt(veh, "GetVehicleCurrentFuel", amt)
-- end)

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

-- RegisterNetEvent("RefuelCarServerReturn")
-- AddEventHandler("RefuelCarServerReturn",function()
--     local timer = (100 - vehicleCurrentFuel) * 400
--     refillVehicle()
--     local finished = exports["np-taskbar"]:taskBar(timer,"Refueling")
--     local veh = getVehicleClosestToMe()

--     if finished == 100 then
--         DecorSetInt(veh, "GetVehicleCurrentFuel", 100)
--     else

--         local vehicleCurrentFuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--         local endFuel = (100 - vehicleCurrentFuel) 
--         endFuel = math.ceil(endFuel * (finished / 100) + vehicleCurrentFuel)
--         DecorSetInt(veh, "GetVehicleCurrentFuel", endFuel)

--     end
--     endanimation()
-- end)

-- function refillVehicle()
--     ClearPedSecondaryTask(PlayerPedId())
--     loadAnimDict( "weapon@w_sp_jerrycan" ) 
--     TaskPlayAnim( PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
-- end

function endanimation()
    shiftheld = false
    ctrlheld = false
    tabheld = false
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('np-admin:maxstats')
AddEventHandler('np-admin:maxstats', function()
    currentValues["thirst"] = 100
	currentValues["hunger"] = 100 
    TriggerEvent("heal", PlayerPedId())
    TriggerEvent("Hospital:HealInjuries", PlayerPedId(),true) 
    TriggerServerEvent("np-death:reviveSV", source)
    TriggerServerEvent("reviveGranted", source)
    TriggerServerEvent("ems:healplayer", source)
    SetPlayerMaxArmour(PlayerPedId(), 60)
    SetPedArmour(PlayerPedId(), 60)
end)


RegisterNetEvent("np-admin:currentDevmode")
AddEventHandler("np-admin:currentDevmode", function(devmode)
    isBlocked = devmode
end)

local stresslevel = 0
local isBlocked = false

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
    stresslevel = newStress
end)

RegisterNetEvent("client:blockShake")
AddEventHandler("client:blockShake",function(isBlockedInfo)
    isBlocked = isBlockedInfo
end)


RegisterNetEvent("np-admin:currentDevmode")
AddEventHandler("np-admin:currentDevmode", function(devmode)
    isBlocked = devmode
end)

-- Citizen.CreateThread(function()
--     while true do
-- 		local waitTime = 120000
-- 		if stresslevel > 7500 then
-- 			waitTime = 10000
-- 		elseif stresslevel > 4500 then
-- 			waitTime = 30000
-- 		elseif stresslevel > 2000 then
-- 			waitTime = 60000
-- 		end
-- 		if stresslevel > 1000 then
-- 			TriggerScreenblurFadeIn(1000.0)
-- 			Wait(1100)
-- 			TriggerScreenblurFadeOut(1000.0)
-- 		end
--         Citizen.Wait(waitTime)
--     end
-- end)
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
    TriggerServerEvent("server:alterStress")
	TriggerServerEvent("police:SetMeta")
end)

Citizen.CreateThread( function()

	local resetcounter = 0
	local jumpDisabled = false
  	
  	while true do 
    Citizen.Wait(100)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(PlayerPedId()) then
			
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)

			resetcounter = 0
		end

		if not jumpDisabled and IsPedJumping(PlayerPedId()) then

			jumpDisabled = true
			resetcounter = 10
			Citizen.Wait(1200)
		end

		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)

local recoils = {
	-- pistols
	[416676503] = 0.34,

	--smg
	[-957766203] = 0.22,

	-- rifles
	[970310034] = 0.14,
}

local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)
    myRecoilFactor = sendFactor / 5 + 0.0
end)


AddEventHandler('baseevents:leftVehicle', function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    SetVehicleEngineOn(pCurrentVehicle, false, true, false)
  end)

Citizen.CreateThread( function()
	while true do 

		local ply = PlayerPedId()

		if IsPedArmed(ply, 6) then Wait(0)
		else Wait(1500) end

		local _,wep = GetCurrentPedWeapon(ply)

	    if wep ~= `WEAPON_SNOWBALL` and IsPedShooting(ply) then
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(50,75+(math.ceil(MovementSpeed*1.5)))/100
	        local rifle = false


          	if group == 970310034 or group == 1159398588 then
          		rifle = true
          	end

          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end


	        if Vehicled then
	        	recoil = recoil + (recoil + cameraDistance)
	        else
	        	recoil = recoil * 1.0
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.35
		        if rifle then
					recoil = recoil * 0.15
				else
					recoil = recoil * 0.05
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.15
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 2.0
	        end


	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
		

	        local set = p+recoil

			SetGameplayCamRelativePitch(set,0.8)    
	       	
	    end
	end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        else
            Citizen.Wait(1500)
        end
    end
end)


function removeAttachedProp2()
    DeleteEntity(attachedProp2)
    attachedProp2 = 0
  end
  function removeAttachedProp()
    DeleteEntity(attachedProp)
    attachedProp = 0
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
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
      Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
  end

--   RegisterNetEvent("np-hud:jerry_can:refuel")
--   AddEventHandler("np-hud:jerry_can:refuel",function()
--       vehicleCurrentFuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--       if exports['np-inventory']:hasEnoughOfItem('883325847', 1) then
--         local timer = (100 - vehicleCurrentFuel) * 400
--         refillVehicle()
--         local finished = exports["np-taskbar"]:taskBar(timer,"Refueling")
--         local veh = getVehicleClosestToMe()
    
--         if finished == 100 then
--             if exports['np-inventory']:hasEnoughOfItem('883325847', 1) then
--                 DecorSetInt(veh, "GetVehicleCurrentFuel", 100)
--                 TriggerEvent('inventory:removeItem', '883325847', 1)
--             else
--                 TriggerEvent('DoLongHudText', 'Try again!', 2)
--             end
    
--             local vehicleCurrentFuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
--             local endFuel = (100 - vehicleCurrentFuel) 
--             endFuel = math.ceil(endFuel * (finished / 100) + vehicleCurrentFuel)
--             DecorSetInt(veh, "GetVehicleCurrentFuel", endFuel)
    
--         end
--         endanimation()
--     else
--         TriggerEvent('DoLongHudText', 'Unsure how you managed this?', 2)
--     end
--   end)


-----


--SetEntityCoords(PlayerPedId(),1957.7397460938,5172.4497070313,47.9102439880379)
-- that is a change  x

--1  Coords: 892.2587, -960.8538, 38.18458
--2 Coords: -1366.676, -316.9358, 38.28989
--3 Coords: 1957.7397460938,5172.4497070313,47.910243988037
--4 Coords: -341.86242675781,-2444.3217773438,6.000337600708

--FD05J2SX
local invehicle = false
local HudStage = 1

local lastValues = {}
-- local currentValues = {
-- 	["voice"] = 2,
-- 	["dev"] = false,
-- 	["devdebug"] = false,
-- 	["is_talking"] = false
-- }



hashDeathToText = {
['-102973651'] = "Hatchet",
['-1834847097'] = "Dagger",
['-102323637'] = "Glass Bottle",
['-2067956739'] = "Crowbar",
['-656458692'] = "Knuckle Dusters",
['-1786099057'] = "Baseball Bat",

['-102973651'] = "Hatchet",
['-1834847097'] = "Dagger",
['-102323637'] = "Glass Bottle",
['-2067956739'] = "Crowbar",
['-656458692'] = "Knuckle Dusters",
['-1786099057'] = "Baseball Bat",
['-1716189206'] = "Combat Knife",
['-2066285827'] = "Assault SMG",
['-270015777'] = "Bullpup Rifle",
['-1654528753'] = "Bullpup Shotgun",
['-494615257'] = "Auto Shotgun",
['-619010992'] = "Tec 9",
['-2009644972'] = "SNS Pistol",
['-1121678507'] = "Mini SMG",
['2725352035'] = "Unarmed",
['4194021054'] = "Animal",
['148160082'] = "Cougar",
['2578778090'] = "Knife",
['1737195953'] = "Nightstick",
['1317494643'] = "Hammer",
['2508868239'] = "Bat",
['1141786504'] = "Golfclub",
['2227010557'] = "Crowbar",
['453432689'] = "Pistol",
['1593441988'] = "Combat Pistol",
['584646201'] = "AP Pistol",
['2578377531'] = "Deagle",
['324215364'] = "Micro SMG",
['736523883'] = "SMG",
['4024951519'] = "Assault SMG",
['3220176749'] = "Assault Rifle",
['2210333304'] = "Carbine",
['2937143193'] = "Adv Rifle",
['2634544996'] = "MG",
['2144741730'] = "Combat MG",
['487013001'] = "Pump Action",
['2017895192'] = "Sawnoff",
['3800352039'] = "Assault Shotgun",
['2640438543'] = "Bullpup Shotgun",
['911657153'] = "Stun Gun",
['100416529'] = "Sniper",
['205991906'] = "Heavy Sniper",
['856002082'] = "Remote Sniper",
['2726580491'] = "GND Launcher",
['1305664598'] = "GND Launcher SMK",
['2982836145'] = "RPG",
['375527679'] = "Passenger Rocket",
['324506233'] = "Air Rocket",
['1752584910'] = "Stinger",
['1119849093'] = "Minigun",
['2481070269'] = "Grenade",
['741814745'] = "Stick Bomb",
['4256991824'] = "Smoke Grenade",
['2694266206'] = "Bz Gas",
['615608432'] = "Molotov",
['101631238'] = "Fire Ext",
['883325847'] = "Petrol Can",
['4256881901'] = "Digi Scanner",
['2294779575'] = "Briefcase",
['28811031'] = "Briefcase",
['600439132'] = "Ball",
['1233104067'] = "Flare",
['3204302209'] = "Veh Rocket",
['1223143800'] = "Barbed Wire",
['4284007675'] = "Drown",
['1936677264'] = "Drown Vehicle",
['2339582971'] = "Bleeding",
['2461879995'] = "Electric Fence",
['539292904'] = "Explosion",
['3452007600'] = "Fall",
['910830060'] = "Exhaustion",
['3425972830'] = "Water Cannon",
['133987706'] = "Rammed",
['2741846334'] = "Run Over",
['341774354'] = "Heli Crash",
['3750660587'] = "Fire",

----------------DLC Weapons----------------

------------------------------------
['3218215474'] = "SNS Pistol",
['4192643659'] = "Bottle",

------------------------------------
['1627465347'] = "Gusenberg",

------------------------------------
['3231910285'] = "Special Carbine",
['3523564046'] = "Heavy Pistol",

------------------------------------
['2132975508'] = "Bullpup",


------------------------------------
['2460120199'] = "Dagger",
['137902532'] = "Vintage Pistol",


------------------------------------
['2138347493'] = "Firework",
['2828843422'] = "Musket",


------------------------------------
['984333226'] = "Heavy Shotgun",
['3342088282'] = "Mark Rifle",


------------------------------------
['1672152130'] = "Homing Launcher",
['2874559379'] = "Proximity Mine",
['126349499'] = "Snowball",

------------------------------------
['1198879012'] = "Flaregun",
['3794977420'] = "Garbage Bag",
['3494679629'] = "Handcuffs",


------------------------------------
['171789620'] = "Combat PDW",


------------------------------------
['3696079510'] = "Mrk Pistol",
['3638508604'] = "Knuckle",


------------------------------------
['4191993645'] = "Hatchet",
['1834241177'] = "Railgun",


------------------------------------
['3713923289'] = "Machete",
['3675956304'] = "Mac Pistol",


------------------------------------
['738733437'] = "Air Defence",
['3756226112'] = "Switchblade",
['3249783761'] = "Revolver",


------------------------------------
['4019527611'] = "DB Shotgun",
['1649403952'] = "Cmp Rifle",


------------------------------------
['317205821'] = "Auto Shotgun",
['3441901897'] = "Battle Axe",
['125959754'] = "Cmp Launcher",
['3173288789'] = "SMG Mini",
['3125143736'] = "Pipebomb",
['2484171525'] = "Cue",
['419712736'] = "Wrench",
["-581044007"] = "Machete",
}


function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end




RegisterNetEvent("roll")
AddEventHandler("roll",function(times,weight)

	times = tonumber(times)
	weight = tonumber(weight)
	rollAnim()
	local strg = ""
	for i = 1, times do
		if i == 1 then
			strg = strg .. " " .. math.random(weight) .. "/" .. weight
		else
			strg = strg .. " | " .. math.random(weight) .. "/" .. weight
		end
		
	end
	TriggerServerEvent("actionclose", GetPlayerServerId(PlayerId()), "Dice rolled " .. strg, GetPlayerServerId(PlayerId()))
end)

function rollAnim()
    loadAnimDict( "anim@mp_player_intcelebrationmale@wank" ) 
    Citizen.Wait(500)
    TaskPlayAnim( PlayerPedId(), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(1500)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'dice', 0.1)
    ClearPedTasks(PlayerPedId())
    Citizen.Wait(500)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



local lastPlayerPos = GetEntityCoords(PlayerPedId())
Citizen.CreateThread(function() 
	while true do
		lastPlayerPos = GetEntityCoords(PlayerPedId())
		Wait(300)
	end
end)


--SetPedMoveRateOverride(PlayerPedId(), 0.00)




local recoils = {


	-- pistols
	[416676503] = 0.34,

	--smg
	[-957766203] = 0.22,

	-- rifles
	[970310034] = 0.14,

}


local myRecoilFactor = 0.0
RegisterNetEvent("recoil:updateposition")
AddEventHandler("recoil:updateposition", function(sendFactor)

    myRecoilFactor = sendFactor / 5 + 0.0

end)






RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name)
	if job ~= "police" then isCop = false else isCop = true end
end)







-- sleeping = false
-- --missfbi5ig_0
-- --lyinginpain_loop_steve
-- --missprologueig_6
-- --lying_dead_player0
-- --missheist_agency3amcs_4b
-- --lying_idle_crew2
-- --mp_safehousebong@
-- --bong_bong

-- local beds = {
-- 	2117668672,
-- 	1631638868,
-- 	-1787305376,
-- 	666470117,
-- 	-1182962909,
-- 	-1519439119, -- operation
-- 	-289946279, -- mri
-- 	-1091386327,
-- }



-- RegisterNetEvent("client:bed")
-- AddEventHandler("client:bed",function()
-- --v_med_bed1=1631638868
-- --v_med_bed2=2117668672
-- 	local ped = PlayerPedId()
-- 	lastPlayerPos = GetEntityCoords(PlayerPedId())

-- 	local objFound = nil
-- 	local near = 999
-- 	for i=1, #beds do
		
-- 		local curobjFound = GetClosestObjectOfType(lastPlayerPos, 3.0, beds[i], 0, 0, 0)
-- 		if curobjFound ~= 0 then
-- 			local dist = #(GetEntityCoords(curobjFound) - GetEntityCoords(ped))

-- 			if DoesEntityExist(curobjFound) then
-- 				if dist ~= 0 and dist < near then
-- 					near = dist 
-- 					objFound = curobjFound
-- 				end
-- 			end
-- 		end
-- 	end

-- 	if DoesEntityExist(objFound) then
-- 		TriggerEvent("DoLongHudText","Press [E] to leave the bed at any time.",1)
-- 	    loadAnimDict( "missfinale_c1@" ) 
-- 	    Citizen.Wait(500)

-- 	    sleeping = true

-- 		local bedOffset = vector3(-0.2, -0.2, 1.4)
-- 		if GetEntityModel(objFound) == -289946279 or GetEntityModel(objFound) == -1519439119 or  GetEntityModel(objFound) == 2117668672 or GetEntityModel(objFound) == 1631638868 then
-- 			TaskPlayAnim( ped, "anim@gangops@morgue@table@", "body_search", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
-- 			bedOffset = vector3(0, 0.05, 2)
-- 		else
-- 			TaskPlayAnim( ped, "missfinale_c1@", "lying_dead_player0", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
-- 		end

-- 	    while sleeping do
-- 	    	AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z, 0.0, 0.0, 180.0, true, true, true, true, 1, true)
-- 	    	camOn()
-- 	    	Citizen.Wait(1)
-- 	    	SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(objFound, 0.0, -0.8, bedOffset.z + 0.1))
-- 	    	SetCamRot(cam, -30.0, 0.0, GetEntityHeading(objFound))
-- 		end
		
-- 		local counter = 0	
-- 	    SetEntityHeading(GetEntityHeading(PlayerPedId()-90))
-- 	    TriggerEvent("animation:PlayAnimation","getup")
-- 	    local count=0
-- 	    while counter < 400 do
-- 	    	counter = counter + 1
	    	
-- 	    	if counter > 250 then
-- 	    		count = count + 0.004
-- 	    		AttachEntityToEntity(ped, objFound, 1, bedOffset.x+count, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
-- 	    	else
-- 	    		AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
-- 	    	end
-- 	    	Citizen.Wait(1)
-- 	    end

	    
-- 	    camOff()
-- 	    DetachEntity(PlayerPedId(), 1, true)

	    

--     end
    
-- end)

-- function camOn()
-- 	if(not DoesCamExist(cam)) then
-- 		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		
-- 		SetCamActive(cam,  true)

-- 		RenderScriptCams(true,  false,  0,  true,  true)
		
-- 	end	
-- end

-- function camOff()
-- 	RenderScriptCams(false, false, 0, 1, 0)
-- 	DestroyCam(cam, false)
-- end

-- add stress TriggerEvent("client:newStress",true,10)
-- remove stress TriggerEvent("client:newStress",false,10)



HasNuiFocus, IsFocusThreadRunning = false, false

-- RegisterNetEvent('np:voice:focus:set')
-- AddEventHandler('np:voice:focus:set', function(hasFocus, hasKeyboard, hasMouse)
-- 	HasNuiFocus = hasFocus

-- 	if HasNuiFocus and not IsFocusThreadRunning then
-- 		Citizen.CreateThread(function ()
--             while HasNuiFocus do
--                 if hasKeyboard then
--                     DisableAllControlActions(0)
--                     EnableControlAction(0, 249, true)
--                 end

--                 if not hasKeyboard and hasMouse then
--                     DisableControlAction(0, 1, true)
--                     DisableControlAction(0, 2, true)
--                 elseif hasKeyboard and not hasMouse then
--                     EnableControlAction(0, 1, true)
--                     EnableControlAction(0, 2, true)
--                 end

--                 Citizen.Wait(0)
-- 			end
--         end)
--     end
-- end)


-- Citizen.CreateThread(function ()
-- 	while true do
-- 		local isTalking = NetworkIsPlayerTalking(PlayerId())

-- 		if isTalking and not currentValues["is_talking"] then
-- 			SendNUIMessage({type = "talkingStatus", is_talking = true})
-- 		elseif not isTalking and currentValues["is_talking"] then
-- 			SendNUIMessage({type = "talkingStatus", is_talking = false})
-- 		end

-- 		currentValues["is_talking"] = isTalking

-- 		Citizen.Wait(100)
-- 	end
-- end)

-- AddEventHandler("hud:voice:transmitting", function (transmitting)
-- 	SendNUIMessage({type = "transmittingStatus", is_transmitting = transmitting})
-- end)

-- function lerp(min, max, amt)
-- 	return (1 - amt) * min + amt * max
-- end
-- function rangePercent(min, max, amt)
-- 	return (((amt - min) * 100) / (max - min)) / 100
-- end


-- RegisterNetEvent("np-hud:changeRange")
-- AddEventHandler("np-hud:changeRange", function(pRange)
-- 	if pRange == 1 then 
-- 		currentValues["voice"] = 3
-- 	elseif pRange == 2 then
--     currentValues["voice"] = 2
-- 	else
-- 		currentValues["voice"] = 1
-- 	end
-- end)

-- this should just use nui instead of drawrect - it literally ass fucks usage.
-- Citizen.CreateThread(function()
	


-- 	local counter = 0
-- 	local get_ped = PlayerPedId() -- current ped
-- 	local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
-- 	local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
-- 	local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
-- 	local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
-- 	local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
-- 	local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
-- 	local thespeed = GetEntitySpeed(get_ped_veh) * 3.6
-- 	while true do

-- 		if sleeping then
-- 			if IsControlJustReleased(0,38) then
-- 				sleeping = false
-- 				DetachEntity(PlayerPedId(), 1, true)
-- 			end
-- 		end

-- 		Citizen.Wait(1)
		

-- 		if counter == 0 then
-- 			 -- current ped
-- 			get_ped = PlayerPedId()
-- 			SetPedSuffersCriticalHits(get_ped,false)
-- 			get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
-- 			plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
-- 			veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
-- 			veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
-- 			veh_body_health = GetVehicleBodyHealth(get_ped_veh)
-- 			veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
-- 			thespeed = GetEntitySpeed(get_ped_veh) * 3.6
			

-- 			for k,v in pairs(currentValues) do
-- 				if lastValues[k] == nil or lastValues[k] ~= v then
-- 					valueChanged = true
-- 					lastValues[k] = v
-- 				end
-- 			end

-- 			if valueChanged then
-- 				SendNUIMessage({
-- 					type = "updateStatusHud",
-- 					varSetVoice = currentValues["voice"],
-- 					varDev = currentValues["dev"],
-- 					varDevDebug = currentValues["devdebug"],
-- 					is_talking = currentValues["is_talking"]
-- 				})
-- 			end

-- 			counter = 25

-- 		end

-- 		counter = counter - 1

--         BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
--         ScaleformMovieMethodAddParamInt(3)
--         EndScaleformMovieMethod()
--     end
-- end)


Citizen.CreateThread( function()

	
	while true do 

		 if IsPedArmed(PlayerPedId(), 6) then
		 	Citizen.Wait(1)
		 else
		 	Citizen.Wait(1500)
		 end  

	    if IsPedShooting(PlayerPedId()) then
	    	local ply = PlayerPedId()
	    	local GamePlayCam = GetFollowPedCamViewMode()
	    	local Vehicled = IsPedInAnyVehicle(ply, false)
	    	local MovementSpeed = math.ceil(GetEntitySpeed(ply))

	    	if MovementSpeed > 69 then
	    		MovementSpeed = 69
	    	end

	        local _,wep = GetCurrentPedWeapon(ply)

	        local group = GetWeapontypeGroup(wep)

	        local p = GetGameplayCamRelativePitch()

	        local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))

	        local recoil = math.random(130,140+(math.ceil(MovementSpeed*1.5)))/100
	        local rifle = false


          	if group == 970310034 or group == 1159398588 then
          		rifle = true
          	end


          	if cameraDistance < 5.3 then
          		cameraDistance = 1.5
          	else
          		if cameraDistance < 8.0 then
          			cameraDistance = 4.0
          		else
          			cameraDistance = 7.0
          		end
          	end


	        if Vehicled then
	        	recoil = recoil + (recoil * cameraDistance)
	        else
	        	recoil = recoil * 0.3
	        end

	        if GamePlayCam == 4 then

	        	recoil = recoil * 0.7
		        if rifle then
		        	recoil = recoil * 0.1
		        end

	        end

	        if rifle then
	        	recoil = recoil * 0.1
	        end

	        local rightleft = math.random(4)
	        local h = GetGameplayCamRelativeHeading()
	        local hf = math.random(10,40+MovementSpeed)/100

	        if Vehicled then
	        	hf = hf * 2.0
	        end

	        if rightleft == 1 then
	        	SetGameplayCamRelativeHeading(h+hf)
	        elseif rightleft == 2 then
	        	SetGameplayCamRelativeHeading(h-hf)
	        end 
        
	        local set = p+recoil

	       	SetGameplayCamRelativePitch(set,0.8)    	       	

	       	
	      -- 	print(GetGameplayCamRelativePitch())

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
    
    return closestPlayer
end


function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

