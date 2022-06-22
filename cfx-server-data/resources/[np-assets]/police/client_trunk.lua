intrunk = false
local frontTrunk = {

}

local disabledTrunk = {
    [1] = "penetrator",
    [2] = "vacca",
    [3] = "monroe",
    [4] = "turismor",
    [5] = "osiris",
    [6] = "comet",
    [7] = "ardent",
    [8] = "jester",
    [9] = "nero",
    [10] = "nero2",
    [11] = "vagner",
    [12] = "infernus",
    [13] = "zentorno",
    [14] = "comet2",
    [15] = "comet3",
    [16] = "comet4",
    [17] = "lp700r",
    [18] = "r8ppi",
    [19] = "911turbos",
    [20] = "rx7rb",
    [21] = "fnfrx7",
    [22] = "delsoleg",
    [23] = "s15rb",
    [24] = "gtr",
    [25] = "fnf4r34",
    [26] = "ap2",
    [27] = "bullet",
}

local trunkOffsets = {
  [`taxi`] = { y = 0.0, z = -0.5 },
  [`buccaneer`] = { y = 0.5, z = 0.0 },
  [`peyote`] = { y = 0.35, z = -0.15 },
  [`regina`] = { y = 0.2, z = -0.35 },
  [`pigalle`] = { y = 0.2, z = -0.15 },
  [`glendale`] = { y = 0.0, z = -0.35 },
}

local cam = 0
function CamTrunk()
    if(not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
        SetCamRot(cam, 0.0, 0.0, 0.0)
        SetCamActive(cam,  true)
        RenderScriptCams(true,  false,  0,  true,  true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
    end
  --  local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0,-2.5,1.0))
    AttachCamToEntity(cam, PlayerPedId(), 0.0,-2.5,1.0, true)
 --   SetCamCoord(cam, x, y, z)
    SetCamRot(cam, -30.0, 0.0, GetEntityHeading(PlayerPedId()) )
end

function CamDisable()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

function disabledCarCheck(veh)
    for i=1,#disabledTrunk do
        if GetEntityModel(veh) == GetHashKey(disabledTrunk[i]) then
            return true
        end
    end
    return false
end

function frontTrunkCheck(veh)
    for i=1,#frontTrunk do
        if GetEntityModel(veh) == GetHashKey(frontTrunk[i]) then
            return true
        end
    end
    return false
end

local TrunkedPlate = 0
local trunkveh = 0
function PutInTrunk(veh)
    local disabledCar = disabledCarCheck(veh)
    if disabledCar then
        return
    end
    if not DoesVehicleHaveDoor(veh, 6) and DoesVehicleHaveDoor(veh, 5) and IsThisModelACar(GetEntityModel(veh)) then
    	SetVehicleDoorOpen(veh, 5, 1, 1)
        local Player = PlayerPedId()

        local d1, d2 = GetModelDimensions(GetEntityModel(veh))

        local trunkZ = d2["z"]
        if trunkZ > 1.4 then
          trunkZ =  1.4 - (d2.z -  1.4)
        end

        TrunkedPlate = GetVehicleNumberPlateText(veh)
        intrunk = true
        TriggerEvent("ped:intrunk",intrunk)
        local testdic = "mp_common_miss"
        local testanim = "dead_ped_idle"
        RequestAnimDict(testdic)
        while not HasAnimDictLoaded(testdic) do
            Citizen.Wait(0)
        end

        SetBlockingOfNonTemporaryEvents(Player, true)
        SetPedSeeingRange(Player, 0.0)
        SetPedHearingRange(Player, 0.0)
        SetPedFleeAttributes(Player, 0, false)
        SetPedKeepTask(Player, true)
        DetachEntity(Player)
        ClearPedTasks(Player)
        TaskPlayAnim(Player, testdic, testanim, 8.0, 8.0, -1, 2, 999.0, 0, 0, 0)
        local vehicleName = GetEntityModel(veh)
        local vehicleTrunkOffset = trunkOffsets[vehicleName] or { y = 0.0, z = 0.0 }

        AttachEntityToEntity(Player, veh, 0, -0.1, (d1["y"] + 0.85) + vehicleTrunkOffset.y, ( trunkZ - 0.87) + vehicleTrunkOffset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
        trunkveh = veh

        while intrunk do

            HandCuffed = exports["isPed"]:isPed("HandCuffed")
            CamTrunk()
            if HandCuffed then
                Citizen.Wait(1)
            else

                Citizen.Wait(1)
                local DropPosition = GetOffsetFromEntityInWorldCoords(veh, 0.0,d1["y"]-0.2,0.0)

                --DrawText3DTest(DropPosition["x"],DropPosition["y"],DropPosition["z"],"[G] Open/Close | [F] Climb Out")

                if IsControlJustReleased(0,47) then

                    if GetVehicleDoorAngleRatio(veh, 5) > 0.0 then
                        SetVehicleDoorShut(veh, 5, 1, 0)
                    else
                        SetVehicleDoorOpen(veh, 5, 1, 0)
                    end

                end
                if IsControlJustReleased(0,23) then
                    TriggerEvent("ped:intrunk",false)
                end
            end

            intrunk = exports["isPed"]:isPed("intrunk")
			if GetVehicleEngineHealth(veh) < 100.0 or not DoesEntityExist(veh) then
		        TriggerEvent("ped:intrunk",false)
		        SetVehicleDoorOpen(trunkveh, 5, 1, 1)
		        trunkveh = 0
		        TrunkedPlate = 0
			end

			if not IsEntityPlayingAnim(Player, testdic, testanim, 3) then
				TaskPlayAnim(Player, testdic, testanim, 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end

        end
        DoScreenFadeOut(10)
        Citizen.Wait(1000)
        CamDisable()

        DetachEntity(Player)

        if DoesEntityExist(veh) then
        	local DropPosition = GetOffsetFromEntityInWorldCoords(veh, 0.0,d1["y"]-0.5,0.0)
	        SetEntityCoords(Player,DropPosition["x"],DropPosition["y"],DropPosition["z"])
	    end
        DoScreenFadeIn(2000)
    end
end
RegisterNetEvent('vehicle:getInTrunk')
AddEventHandler('vehicle:getInTrunk', function(pArgs, pEntity)

    local lockStatus = GetVehicleDoorLockStatus(pEntity)
    local hasTrunk = DoesVehicleHaveDoor(pEntity, 5)

    if lockStatus ~= 1 and lockStatus ~= 0 then
        TriggerEvent("DoLongHudText","The vehicle is locked!",2)
        return
    elseif not hasTrunk then
        TriggerEvent("DoLongHudText","Vehicle does not have a trunk!",2)
        return
    elseif GetVehicleDoorAngleRatio(pEntity, 5) == 0.0 then
        TriggerEvent("DoLongHudText","The trunk is closed!",2)
        return
    end

  PutInTrunk(pEntity)
end)

RegisterNetEvent('ped:forceTrunk')
AddEventHandler('ped:forceTrunk', function()
	t, distance = GetClosestPlayer()
	if (distance ~= -1 and distance < 7) then
		playerped = PlayerPedId()
        coordA = GetEntityCoords(playerped, 1)
        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 10.0, 0.0)
        v = getVehicleInDirection(coordA, coordB, true)
        if DoesEntityExist(v) then

            local Player = PlayerPedId()
            local d1,d2 = GetModelDimensions(GetEntityModel(v))
            local back = GetOffsetFromEntityInWorldCoords(v, 0.0,d1["y"]-0.5,0.0)
            if #(back - GetEntityCoords(Player))> 1.0 then
                TriggerEvent("DoLongHudText","You must be near the trunk to do this!",2)
                return
            end
            local Driver = GetPedInVehicleSeat(v, -1)
            if DoesEntityExist(Driver) and not IsPedAPlayer(Driver) then
                TriggerEvent("DoLongHudText","The vehicle is locked!",2)
                return
            end
            local lockStatus = GetVehicleDoorLockStatus(v)
            if lockStatus ~= 1 and lockStatus ~= 0 then
                TriggerEvent("DoLongHudText","The vehicle is locked!",2)
                return
            end
            if GetVehicleDoorAngleRatio(v, 5) == 0.0 then
                TriggerEvent("DoLongHudText","The trunk is closed?!",2)
                return
            end


			--SetEntityAsMissionEntity(v,false,true)
			local netid = NetworkGetNetworkIdFromEntity(v)
			TriggerServerEvent("ped:forceTrunkAsk", GetPlayerServerId(t), netid)
		else
			TriggerEvent("DoLongHudText", "Face the vehicle from the trunk!",2)
		end
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!",2)
	end
end)

RegisterNetEvent('ped:forcedEnteringVeh')
AddEventHandler('ped:forcedEnteringVeh', function(sender)
	local vehicleHandle = NetworkGetEntityFromNetworkId(sender)
    if vehicleHandle ~= nil then
      	PutInTrunk(vehicleHandle)
    end
end)

RegisterNetEvent('ped:releaseTrunkCheck')
AddEventHandler('ped:releaseTrunkCheck', function()

    playerped = PlayerPedId()


    local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)

    local curplate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))

    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB, true)
    if not isInVeh and GetVehicleDoorAngleRatio(targetVehicle, 5) > 0.0 then

        curplate = GetVehicleNumberPlateText(targetVehicle, false)
    else
        TriggerEvent("DoLongHudText","No vehicle found or trunk is closed",2)
        return
    end

    if curplate then
        TriggerServerEvent("ped:trunkAccepted",curplate)
    end

end)

RegisterNetEvent('ped:releaseTrunkCheckSelf')
AddEventHandler('ped:releaseTrunkCheckSelf', function()
	local HandCuffed = exports["isPed"]:isPed("HandCuffed")
	local dead = exports["isPed"]:isPed("dead")
	local intrunk = exports["isPed"]:isPed("intrunk")
    if not HandCuffed and not dead and intrunk then
	    TriggerServerEvent("ped:trunkAccepted",TrunkedPlate)
	end
end)

RegisterNetEvent('ped:releaseTrunk')
AddEventHandler('ped:releaseTrunk', function(licensePlate)
    if licensePlate == TrunkedPlate then
        TriggerEvent("ped:intrunk",false)
        SetVehicleDoorOpen(trunkveh, 5, 1, 1)
        trunkveh = 0
        TrunkedPlate = 0
    end
end)