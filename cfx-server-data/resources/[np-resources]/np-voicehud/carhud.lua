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
local currentValues = {
	["voice"] = 2,
	["dev"] = false,
	["devdebug"] = false,
	["is_talking"] = false,
	["is_transmitting"] = false
}

function GetCauseOfDeath()

    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if distance < 3.0 and not IsPedAPlayer(ped) then
        	if hashDeathToText['' .. GetPedCauseOfDeath(ped) .. ''] ~= nil then
	        	TriggerEvent("DoLongHudText","It seems they sustained injuries from a " .. hashDeathToText['' .. GetPedCauseOfDeath(ped) .. ''])
	        else
	        	TriggerEvent("DoLongHudText","It seems they died from unknown causes")
	        end
         --   SetEntityAsNoLongerNeeded(ped)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped

end

function carryPed(ped)

	loadAnim('anim@narcotics@trash')
	TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1500, 49, 3.0, 0, 0, 0) 
	TaskTurnPedToFaceEntity(PlayerPedId(), ped, 1.0)

	

	SetBlockingOfNonTemporaryEvents(ped, true)		
	SetPedSeeingRange(ped, 0.0)		
	SetPedHearingRange(ped, 0.0)		
	SetPedFleeAttributes(ped, 0, false)		
	SetPedKeepTask(ped, true)	

	    loadAnim( "dead" ) 
	    TaskPlayAnim(ped, "dead", "dead_f", 8.0, 8.0, -1, 1, 0, 0, 0, 0)

	DetachEntity(ped)
	ClearPedTasks(ped)
	loadAnim( "amb@world_human_bum_slumped@male@laying_on_left_side@base" ) 
	TaskPlayAnim(ped, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
	attachCarryPed(ped)
	local holdingBody = true
	ClearPedTasksImmediately(PlayerPedId())
	while (holdingBody) do

		Citizen.Wait(1)


		if not IsEntityPlayingAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 3) then
			loadAnim( "missfinale_c2mcs_1" ) 
			TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)

		end

		
		if IsControlJustPressed(0, 38) or (`WEAPON_UNARMED` ~= GetSelectedPedWeapon(PlayerPedId()))  then
			holdingBody = false
			DetachEntity(ped)
		end


	end
	ClearPedTasks(PlayerPedId())	  
	DetachEntity(ped)
end

function attachCarryPed(ped)
	AttachEntityToEntity(ped, PlayerPedId(), 1, -0.68, -0.2, 0.94, 180.0, 180.0, 60.0, 1, 1, 0, 1, 0, 1)
	loadAnim( "missfinale_c2mcs_1" ) 
	TaskPlayAnim(PlayerPedId(), "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
end
RegisterNetEvent('police:carryAI')
AddEventHandler('police:carryAI', function()
	local ped = GetClosestPlayer()
	-- print('lol ', ped)
		-- print('entity exists')
		carryPed(ped)
end)

RegisterNetEvent('police:reviveAI')
AddEventHandler('police:reviveAI', function()
	revivePeds()
end)

RegisterNetEvent('police:COD')
AddEventHandler('police:COD', function()
	GetCauseOfDeath()
end)

function carryPedNow()

    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if distance < 2.0 and not IsPedAPlayer(ped) then
        	--ResurrectPed(ped)
            --ReviveInjuredPed(ped)
            ClearPedTasksImmediately(ped) 
        	carryPed(ped)
        	return
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped

end

function revivePeds()

    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if distance < 2.0 and not IsPedAPlayer(ped) then
        	if hashDeathToText['' .. GetPedCauseOfDeath(ped) .. ''] ~= nil then
	        	TriggerEvent("DoLongHudText","It seems they sustained injuries from a " .. hashDeathToText['' .. GetPedCauseOfDeath(ped) .. ''])
	        else
	        	TriggerEvent("DoLongHudText","It seems they died from unknown causes")
	        end
        	ResurrectPed(ped)
            ReviveInjuredPed(ped)
            ClearPedTasksImmediately(ped)
            local crds = GetEntityCoords(ped)
            SetEntityCoords(ped,crds["x"],crds["y"],crds["z"]+1.2)

            TaskWanderStandard(ped, 10.0, 10)
            Citizen.Wait(1000)
            SetEntityCoords(ped,crds["x"],crds["y"],crds["z"]+1.2)
         --   SetEntityAsNoLongerNeeded(ped)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped

end

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





function quickmafs(dir)
	local x = 0.0
	local y = 0.0
	local dir = dir
	if dir >= 0.0 and dir <= 90.0 then
		local factor = (dir/9.2) / 10
		x = -1.0 + factor
		y = 0.0 - factor
	end

	if dir > 90.0 and dir <= 180.0 then
		dirp = dir - 90.0
		local factor = (dirp/9.2) / 10
		x = 0.0 + factor
		y = -1.0 + factor
	end

	if dir > 180.0 and dir <= 270.0 then
		dirp = dir - 180.0
		local factor = (dirp/9.2) / 10
		x = 1.0 - factor
		y = 0.0 + factor
	end

	if dir > 270.0 and dir <= 360.0 then
		dirp = dir - 270.0
		local factor = (dirp/9.2) / 10	
		x = 0.0 - factor
		y = 1.0 - factor
	end
	return x,y
end

RegisterNetEvent("disableHUD")
AddEventHandler("disableHUD", function(passedinfo)
	HudStage = passedinfo

end)

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job, name)
	if job ~= "police" then isCop = false else isCop = true end
end)







sleeping = false
--missfbi5ig_0
--lyinginpain_loop_steve
--missprologueig_6
--lying_dead_player0
--missheist_agency3amcs_4b
--lying_idle_crew2
--mp_safehousebong@
--bong_bong

local beds = {
	2117668672,
	1631638868,
	-1787305376,
	666470117,
	-1182962909,
	-1519439119, -- operation
	-289946279, -- mri
	-1091386327,
}



RegisterNetEvent("client:bed")
AddEventHandler("client:bed",function()
--v_med_bed1=1631638868
--v_med_bed2=2117668672
  local ped = PlayerPedId()
  lastPlayerPos = GetEntityCoords(PlayerPedId())

  local objFound = nil
  local near = 999
  for i=1, #beds do

    local curobjFound = GetClosestObjectOfType(lastPlayerPos, 3.0, beds[i], 0, 0, 0)
    if curobjFound ~= 0 then
      local dist = #(GetEntityCoords(curobjFound) - GetEntityCoords(ped))

      if DoesEntityExist(curobjFound) then
        if dist ~= 0 and dist < near then
          near = dist
          objFound = curobjFound
        end
      end
    end
  end

  if DoesEntityExist(objFound) then
    -- TriggerEvent("DoLongHudText","Press [E] to leave the bed at any time.",1)
      loadAnimDict( "missfinale_c1@" )
      Citizen.Wait(500)

      sleeping = true
      showInteraction = true
      exports["np-ui"]:showInteraction("[E] Leave Bed")

    local bedOffset = vector3(-0.2, 0.1, 1.4)
    if GetEntityModel(objFound) == -289946279 or GetEntityModel(objFound) == -1519439119 then
      TaskPlayAnim( ped, "anim@gangops@morgue@table@", "body_search", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
      bedOffset = vector3(0, 0.05, 2)
    else
      TaskPlayAnim( ped, "missfinale_c1@", "lying_dead_player0", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    end

      while sleeping do
        AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z, 0.0, 0.0, 180.0, true, true, true, true, 1, true)
        -- camOn()
        if not showInteraction then
          exports["np-ui"]:hideInteraction()
        end
        Citizen.Wait(1000)
        -- SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(objFound, 0.0, 1.0, bedOffset.z + 0.8))
        -- SetCamRot(cam, -50.0, 0.0, GetEntityHeading(objFound) + 180)
    end

    exports["np-ui"]:hideInteraction()

    local counter = 0
      SetEntityHeading(GetEntityHeading(PlayerPedId()-90))
      TriggerEvent("animation:PlayAnimation","getup")
      local count=0
      while counter < 400 do
        counter = counter + 1

        if counter > 250 then
          count = count + 0.004
          AttachEntityToEntity(ped, objFound, 1, bedOffset.x+count, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
        else
          AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
        end
        Citizen.Wait(1)
      end


      camOff()
      DetachEntity(PlayerPedId(), 1, true)
      local bedcoords = GetEntityCoords(objFound) + vector3(0.0, 0.0, 1.0)
      SetEntityCoords(ped, bedcoords)



    end

end)

function camOn()
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		
		SetCamActive(cam,  true)

		RenderScriptCams(true,  false,  0,  true,  true)
		
	end	
end

function camOff()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
end

-- add stress TriggerEvent("client:newStress",true,10)
-- remove stress TriggerEvent("client:newStress",false,10)



HasNuiFocus, IsFocusThreadRunning = false, false

RegisterNetEvent('np:voice:focus:set')
AddEventHandler('np:voice:focus:set', function(hasFocus, hasKeyboard, hasMouse)
	HasNuiFocus = hasFocus

	if HasNuiFocus and not IsFocusThreadRunning then
		Citizen.CreateThread(function ()
            while HasNuiFocus do
                if hasKeyboard then
                    DisableAllControlActions(0)
                    EnableControlAction(0, 249, true)
                end

                if not hasKeyboard and hasMouse then
                    DisableControlAction(0, 1, true)
                    DisableControlAction(0, 2, true)
                elseif hasKeyboard and not hasMouse then
                    EnableControlAction(0, 1, true)
                    EnableControlAction(0, 2, true)
                end

                Citizen.Wait(0)
			end
        end)
    end
end)


Citizen.CreateThread(function ()
	while true do
		local isTalking = NetworkIsPlayerTalking(PlayerId())

		if isTalking and not currentValues["is_talking"] then
			SendNUIMessage({type = "talkingStatus", is_talking = true})
		elseif not isTalking and currentValues["is_talking"] then
			SendNUIMessage({type = "talkingStatus", is_talking = false})
		end

		currentValues["is_talking"] = isTalking

		Citizen.Wait(100)
	end
end)

AddEventHandler("hud:voice:transmitting", function (transmitting)
	SendNUIMessage({type = "transmittingStatus", is_transmitting = transmitting})
end)

function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end
function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end


RegisterNetEvent("np-hud:changeRange")
AddEventHandler("np-hud:changeRange", function(pRange)
	if pRange == 1 then 
		currentValues["voice"] = 3
	elseif pRange == 2 then
    currentValues["voice"] = 2
	else
		currentValues["voice"] = 1
	end
end)

-- this should just use nui instead of drawrect - it literally ass fucks usage.
Citizen.CreateThread(function()
	


	local counter = 0
	local get_ped = PlayerPedId() -- current ped
	local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
	local plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
	local veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
	local veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
	local veh_body_health = GetVehicleBodyHealth(get_ped_veh)
	local veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
	local thespeed = GetEntitySpeed(get_ped_veh) * 3.6
	currentValues["voice"] = 2
	while true do

		if sleeping then
			if IsControlJustReleased(0,38) then
				sleeping = false
				DetachEntity(PlayerPedId(), 1, true)
			end
		end

		Citizen.Wait(1)
		

		if counter == 0 then
			 -- current ped
			get_ped = PlayerPedId()
			SetPedSuffersCriticalHits(get_ped,false)
			get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
			plate_veh = GetVehicleNumberPlateText(get_ped_veh) -- Vehicle Plate
			veh_stop = IsVehicleStopped(get_ped_veh) -- Parked or not
			veh_engine_health = GetVehicleEngineHealth(get_ped_veh) -- Vehicle Engine Damage 
			veh_body_health = GetVehicleBodyHealth(get_ped_veh)
			veh_burnout = IsVehicleInBurnout(get_ped_veh) -- Vehicle Burnout
			thespeed = GetEntitySpeed(get_ped_veh) * 3.6
			

			for k,v in pairs(currentValues) do
				if lastValues[k] == nil or lastValues[k] ~= v then
					valueChanged = true
					lastValues[k] = v
				end
			end

			if valueChanged then
				SendNUIMessage({
					type = "updateStatusHud",
					varSetVoice = currentValues["voice"],
					varDev = currentValues["dev"],
					varDevDebug = currentValues["devdebug"],
					is_talking = currentValues["is_talking"],
					is_transmitting = currentValues["is_transmitting"]
				})
			end

			counter = 25

		end

		counter = counter - 1

        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)


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

