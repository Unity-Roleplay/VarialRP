
-- This manages recoil and crouch / prone
local stresslevel = 0
function RecoilFactor(stress,stance)
    if stance == nil then
        stance = 0
    end
    if stance == 3 then
        stance = 1
    end
    sendFactor = ((math.ceil(stress) / 1000)) - stance


    TriggerEvent("recoil:updateposition",sendFactor)

end


local prone = true
local movFwd = true

local ctrlStage = 0
local camon = false
local shitcam = 0


imdead = 0
RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
    if imdead == 0 then 
        imdead = 1
    else
        beingDragged = false
        dragging = false
        imdead = 0
    end
end)

function crouchMovement()
    RequestAnimSet("move_ped_crouched")
    while not HasAnimSetLoaded("move_ped_crouched") do
        Citizen.Wait(0)
    end

    SetPedMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)    
    SetPedWeaponMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)
    SetPedStrafeClipset(PlayerPedId(), "move_ped_crouched_strafing",1.0)

end



Controlkey = {["movementCrouch"] = {73,"X"},["movementCrawl"] = {20,"Z"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["movementCrouch"] = table["movementCrouch"]
    Controlkey["movementCrawl"] = table["movementCrawl"]
end)


RegisterNetEvent("fuckthis")
AddEventHandler("fuckthis",function()

    while firstPersonActive do
        Citizen.Wait(1)
        local crouchpos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.127,-0.29,0.801)
        if (not DoesCamExist(shitcam)) then
            shitcam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamCoord(shitcam, crouchpos)
            SetCamRot(shitcam, 0.0, 0.0, GetEntityHeading(PlayerPedId()))
            SetCamActive(shitcam,  true)
            RenderScriptCams(true,  false,  0,  true,  true)
            SetCamCoord(shitcam, crouchpos)
            SetCamFov(shitcam, 60.0)
        end

        SetCamCoord(shitcam, crouchpos)
        SetCamRot(shitcam, GetGameplayCamRelativePitch(), 0.0, GetEntityHeading(PlayerPedId()) + GetGameplayCamRelativeHeading())
         if IsControlJustReleased(0, INPUT_AIM) then
            firstPersonActive = false
         end
    end

    if (DoesCamExist(shitcam)) then
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(shitcam, false)
    end

end)
local fixprone = false
RegisterNetEvent("fixprone")
AddEventHandler("fixprone",function()
    if ctrlStage == 2 then
        fixprone = true
    end
end)


function doCrouchIn()

--  RequestAnimDict("swimming@swim")
--  while not HasAnimDictLoaded("swimming@swim") do
--      Citizen.Wait(0)
--  end

--  TaskPlayAnim(PlayerPedId(), "swimming@swim", "recover_down_to_idle", 0.8, 0.8, 1.0, 49, 0, 0, 0, 0)

--  Citizen.Wait(420)
    crouchMovement()
end

myWep = 0
local runningMovement = false
RegisterNetEvent("proneMovement")
AddEventHandler("proneMovement",function()
    if runningMovement then
        return
    end
    runningMovement = true

    if ((IsControlPressed(1,32)) and not movFwd) or (fixprone and (IsControlPressed(1,32))) then -- W
        fixprone = false
        movFwd = true
        SetPedMoveAnimsBlendOut(PlayerPedId())
        local pronepos = GetEntityCoords(PlayerPedId())
        TaskPlayAnimAdvanced(PlayerPedId(), "move_crawl", "onfront_fwd", pronepos["x"],pronepos["y"],pronepos["z"]+0.1, 0.0, 0.0, GetEntityHeading(PlayerPedId()), 100.0, 0.4, 1.0, 7, 2.0, 1, 1) 
        Citizen.Wait(500)
    elseif ( not (IsControlPressed(1,32)) and movFwd) or (fixprone and not (IsControlPressed(1,32))) then -- W
        fixprone = false
        curWep = GetSelectedPedWeapon(PlayerPedId())
        myWep =  GetSelectedPedWeapon(PlayerPedId())
        local pronepos = GetEntityCoords(PlayerPedId())
        TaskPlayAnimAdvanced(PlayerPedId(), "move_crawl", "onfront_fwd", pronepos["x"],pronepos["y"],pronepos["z"]+0.1, 0.0, 0.0, GetEntityHeading(PlayerPedId()), 100.0, 0.4, 1.0, 6, 2.0, 1, 1)
        Citizen.Wait(500)
        movFwd = false
    end     
    runningMovement = false

end)


local foreskin = false
local timelimit = 0
local isHolding = false
local isFlying = false
-- 0 = default, 1 = crouch, 2 = prone
incrouch = true

Citizen.CreateThread(function()

    local Triggered1 = false
    local Triggered2 = false
    
    while true do

        if ctrlStage == 3 then

            if IsControlJustPressed(2,23) then -- F
                firstPersonActive = false
                ctrlStage = 0
                TriggerEvent("AnimSet:Set")
                jumpDisabled = false
                SetPedStealthMovement(PlayerPedId(),0,0)
                RecoilFactor(stresslevel,0)             
            else
                if not Triggered3 then
                    ClearPedTasks(PlayerPedId())
                    Triggered1 = false  
                    Triggered2 = false
                    Triggered3 = true
                    crouchMovement()

                else
                    if IsControlJustReleased(1,Controlkey["movementCrouch"][1]) then -- X
                        SetPedStealthMovement(PlayerPedId(),true,"")
                        firstPersonActive = false
                        ctrlStage = 0

                        TriggerEvent("AnimSet:Set")

                        Citizen.Wait(100)  
                        ClearPedTasks(PlayerPedId())

                        jumpDisabled = false
                        
                        RecoilFactor(stresslevel,0)
                        Citizen.Wait(500)
                        SetPedStealthMovement(PlayerPedId(),false,"")
                        Triggered3 = false

                    else
                        if GetEntitySpeed(PlayerPedId()) > 1.0 and not incrouch then
                            incrouch = true
                            SetPedWeaponMovementClipset(PlayerPedId(), "move_ped_crouched",1.0)
                            SetPedStrafeClipset(PlayerPedId(), "move_ped_crouched_strafing",1.0)
                        elseif incrouch and GetEntitySpeed(PlayerPedId()) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
        
                            incrouch = false
                            ResetPedWeaponMovementClipset(PlayerPedId())
                            ResetPedStrafeClipset(PlayerPedId())
                        end     
                    end         
                end
            end
        end




        if timelimit > 0 then
            timelimit = timelimit - 1
        end



        if IsControlJustPressed(0, 142) or IsDisabledControlJustPressed(0, 142) then
            if ctrlStage == 2 then
                ctrlStage = 3
            end
        end

        if IsControlJustReleased(1,Controlkey["movementCrouch"][1]) and not isFlying and not isHolding and not ( IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) ) and not (handCuffed or handCuffedWalking or imdead == 1) then

            ctrlStage = 3
            if GetPedStealthMovement(PlayerPedId()) then
                SetPedStealthMovement(PlayerPedId(),0,0)
            end             
            RecoilFactor(stresslevel,ctrlStage)
            firstPersonActive = false
        end

        if IsPedJacking(PlayerPedId()) or IsPedInMeleeCombat(PlayerPedId()) or IsControlJustReleased(1,22) or IsPedRagdoll(PlayerPedId()) or handCuffed or handCuffedWalking or imdead == 1 or ( IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) ) then

            if ctrlStage ~= 0 then
                ClearPedTasks(PlayerPedId())
                firstPersonActive = false
                ctrlStage = 0
                TriggerEvent("AnimSet:Set")
                jumpDisabled = false
                SetPedStealthMovement(PlayerPedId(),0,0)
                RecoilFactor(stresslevel,0)
                Triggered1 = false  
                Triggered2 = false
                Triggered3 = false
            end

        end

        --TaskPlayAnim(PlayerPedId(), "move_crawl", "onfront_fwd", GetEntityCoords(PlayerPedId()), 1.0, 1.0, 999, 16, 1.0, 2, 2, 2);
    --  TASK_PLAY_ANIM_ADVANCED(Ped ped, char* animDict, char* animName, float posX, float posY, float posZ, float rotX, float rotY, float rotZ, float speed, float speedMultiplier, int duration, Any flag, float animTime, Any p14, Any p15);
        --TaskPlayAnimAdvanced(ped, animDict, animName, posX, posY, posZ, rotX, rotY, rotZ, speed, speedMultiplier, duration, flag, animTime, p14, p15)
        --TaskPlayAnimAdvanced(PlayerPedId(), "move_crawl", "onfront_fwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, -1, 47, 1.0, 0, 0) 

        --TaskPlayAnimAdvanced(PlayerPedId(), "move_crawl", "onfront_fwd", GetEntityCoords(PlayerPedId()), 0.0, 0.0, GetEntityHeading(PlayerPedId()), 1.0, 1.0, -1, 1, 1.0, 0, 0)  

        --TaskPlayAnim(ped, animDictionary, animationName, speed, speedMultiplier, duration, flag, playbackRate, lockX, lockY, lockZ)
        Citizen.Wait(1)

        if IsPedSittingInAnyVehicle( GetPlayerPed( -1 ) ) then
            Citizen.Wait(1000)
        end

    end
--  DeleteEntity(proneball)
end)
handCuffed = false
handCuffedWalking = false


RegisterNetEvent('police:currentHandCuffedState')
AddEventHandler('police:currentHandCuffedState', function(handCuffedSent,WalkingSent)
    handCuffed = handCuffedSent
    handCuffedWalking = WalkingSent
end)

RegisterNetEvent('news:HoldingState')
AddEventHandler('news:HoldingState', function(state)
    isHolding = state
end)

RegisterNetEvent("admin:isFlying")
AddEventHandler("admin:isFlying", function(state)
    isFlying = state
end)


Citizen.CreateThread( function()
    while true do
        playerPed = PlayerPedId() 
        if IsPedArmed(playerPed, 6) then
            if IsPedDoingDriveby(playerPed) then
                if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
                    SetPlayerCanDoDriveBy(PlayerId(),false)
                    SetFollowPedCamViewMode(4)
                    SetFollowVehicleCamViewMode(4)
                    Wait(50)
                    SetPlayerCanDoDriveBy(PlayerId(),true)
                end
            else
                DisableControlAction(0,36,true)
                if GetPedStealthMovement(playerPed) == 1 then
                    SetPedStealthMovement(playerPed,0)
                end
            end
        end
        Wait(1)
    end
end)


local recoils = {
	-- pistols
	[416676503] = 0.04,

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

local INPUT_AIM = 0
local INPUT_AIM = 0
local UseFPS = false
local justpressed = 0

-- this prevents certain camera modes
local disable = 0
Citizen.CreateThread( function()

  while true do    
    
    Citizen.Wait(0)


        if IsControlPressed(0, INPUT_AIM) then
          justpressed = justpressed + 1
        end

        if IsControlJustReleased(0, INPUT_AIM) then

            if justpressed < 15 then
                UseFPS = true
            end
            justpressed = 0
        end

        if GetFollowPedCamViewMode() == 1 or GetFollowVehicleCamViewMode() == 1 then
            Citizen.Wait(1)
            SetFollowPedCamViewMode(0)
            SetFollowVehicleCamViewMode(0)
        end


        if UseFPS then
            if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
                Citizen.Wait(0)
                
                SetFollowPedCamViewMode(4)
                SetFollowVehicleCamViewMode(4)
            else
                Citizen.Wait(0)
                
                SetFollowPedCamViewMode(0)
                SetFollowVehicleCamViewMode(0)
            end
            UseFPS = false
        end


        if IsPedArmed(ped,1) or not IsPedArmed(ped,7) then
            if IsControlJustPressed(0,24) or IsControlJustPressed(0,141) or IsControlJustPressed(0,142) or IsControlJustPressed(0,140)  then
               disable = 50
            end
        end

        if disable > 0 then
            disable = disable - 1
            DisableControlAction(0,24)
            DisableControlAction(0,140)
            DisableControlAction(0,141)
            DisableControlAction(0,142)
        end
  end

end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
    end
end)

