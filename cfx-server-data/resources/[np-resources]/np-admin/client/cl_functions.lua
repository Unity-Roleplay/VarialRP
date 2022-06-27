-- [ Code ] --

-- [ Functions ] --
local devmodeToggle = false
local debugmodeToggle = false


function ToggleDevMode(Bool)
    TriggerEvent('np-admin:currentDevmode', Bool)
    devmodeToggle = Bool
end

function IsPlayerAdmin() 

    return true
end

function DebugLog(Message)
    if Config.MenuDebug then
        print('[DEBUG]: ', Message)
    end
end

function DeletePlayerBlips()
    if AllPlayerBlips ~= nil then
        for k, v in pairs(AllPlayerBlips) do
            RemoveBlip(v) 
        end
        AllPlayerBlips = {}
    end
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
	
	if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function DrawText3D(Coords, Text)
    local OnScreen, _X, _Y = World3dToScreen2d(Coords.x, Coords.y, Coords.z)
    SetTextScale(0.3, 0.3)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(Text)
    DrawText(_X, _Y)
end

function roundDecimals(num, decimals)
	local mult = math.pow(10, decimals or 0)
	return math.floor(num * mult + 0.5) / 100
end

function UpdateMenu()
    local Players = GetPlayers()
    SendNUIMessage({
        Action = 'Update',
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end

function SetKvp(Name, Data, Type)
    SetResourceKvp(Name, Data)
    RefreshMenu(Type)
end

function RefreshMenu(Type)
    if Type == 'Favorites' then
        -- Favorites
        if GetResourceKvpString("np-adminmenu-favorites") == nil or GetResourceKvpString("np-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("np-adminmenu-favorites"))
        end
    elseif Type == 'Targets' then
        if GetResourceKvpString("np-adminmenu-pinned_targets") == nil or GetResourceKvpString("np-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("np-adminmenu-pinned_targets"))
        end
    elseif Type == 'Settings'then
        if GetResourceKvpString("np-adminmenu-settings") == nil or GetResourceKvpString("np-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("np-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("np-adminmenu-settings"))
        end
    elseif Type == 'All' then
        if GetResourceKvpString("np-adminmenu-favorites") == nil or GetResourceKvpString("np-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("np-adminmenu-favorites"))
        end
        if GetResourceKvpString("np-adminmenu-pinned_targets") == nil or GetResourceKvpString("np-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("np-adminmenu-pinned_targets"))
        end
        if GetResourceKvpString("np-adminmenu-settings") == nil or GetResourceKvpString("np-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("np-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("np-adminmenu-settings"))
        end
    end
    UpdateMenu()
end

-- Inventory Items
Citizen.CreateThread(function()
    GetInventoryItems()
end)

function GetInventoryItems()
    local items = exports["np-inventory"]:getFullItemList()
    for k, v in pairs(items) do
        table.insert(Inventory, {
            Text = k
        });
    end
    return Inventory
end

-- Get

function GetPlayersInArea(Coords, Radius)
	local Prom = promise:new()
	RPC.execute('np-admin/server/get-active-players-in-radius', function(Players)
		Prom:resolve(Players)
	end, Coords, Radius)
	return Citizen.Await(Prom)
end

function GetPlayers()

    local Players = RPC.execute("np-admin/server/get-players")

        return (Players)
end

function GetPlayersss()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetJobs()
    local JobList = {
        [1] = 'state',
        [2] = 'sheriff', 
        [3] = 'police',
        [4] = 'ems',
        [5] = 'addmore'
    }

    return JobList
end

function GetAddonVehicles()
    local AddonVehicles = {
        [1] = 'npolvic',
        [2] = 'npolexp', 
        [3] = 'npolchar',
        [4] = 'npolmm',
        [5] = 'lp700'
    }
    return AddonVehicles
end

AvailableGangs = {}
function GetGangs()
    local data = exports["np-gangsnew"]:GetAvailableGangs()
    for k,v in pairs(data) do
        local toinset = {
            Text = v
        }
        table.insert(AvailableGangs,toinset)
    end
    return AvailableGangs
end

-- Generate

function GenerateFavorites()
    local Retval = {}
    for _, Menu in pairs(Config.AdminMenus) do
        for k, v in pairs(Menu.Items) do
            Retval[v.Id] = false
        end
    end
    return Retval
end

function GeneratePinnedPlayers()
    local Retval = {}
    local Players = GetPlayers()
    for k, v in pairs(Players) do
        Retval[v.License] = false
    end
    return Retval
end

function GenerateAdminSettings()
    local Retval = {}
    -- Default Size
    Retval['DefaultSize'] = "Small"
    -- Tooltips
    Retval['Tooltips'] = true
    -- Bind Open
    Retval['BindOpen'] = true

    return Retval
end

-- Troll

-- Drunk
local DRUNK_ANIM_SET = "move_m@drunk@verydrunk"

local DRUNK_DRIVING_EFFECTS = {
    1, -- brake
    7, --turn left + accelerate
    8, -- turn right + accelerate
    23, -- accelerate
    4, -- turn left 90 + braking
    5, -- turn right 90 + braking
}

local function getRandomDrunkCarTask()
    math.randomseed(GetGameTimer())

    return DRUNK_DRIVING_EFFECTS[math.random(#DRUNK_DRIVING_EFFECTS)]
end

-- NOTE: We might want to check if a player already has an effect
function drunkThread()
    local playerPed = PlayerPedId()
    local isDrunk = true

    RequestAnimSet(DRUNK_ANIM_SET)
    while not HasAnimSetLoaded(DRUNK_ANIM_SET) do
        Wait(5)
    end

    SetPedMovementClipset(playerPed, DRUNK_ANIM_SET)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    SetPedIsDrunk(playerPed, true)
    SetTransitionTimecycleModifier("spectator5", 10.00)

    CreateThread(function()
        while isDrunk do
            local vehPedIsIn = GetVehiclePedIsIn(playerPed)
            local isPedInVehicleAndDriving = (vehPedIsIn ~= 0) and (GetPedInVehicleSeat(vehPedIsIn, -1) == playerPed)

            if isPedInVehicleAndDriving then
                local randomTask = getRandomDrunkCarTask()
                TaskVehicleTempAction(playerPed, vehPedIsIn, randomTask, 500)
            end

            Wait(5000)
        end
    end)

    Wait(30 * 1000)
    isDrunk = false
    SetTransitionTimecycleModifier("default", 10.00)
    StopGameplayCamShaking(true)
    ResetPedMovementClipset(playerPed)
    RemoveAnimSet(DRUNK_ANIM_SET)
end

-- Wild attack

local attackAnimalHashes = {
    GetHashKey("a_c_chimp"),
    GetHashKey("a_c_rottweiler"),
    GetHashKey("a_c_coyote")
}
local animalGroupHash = GetHashKey("Animal")
local playerGroupHash = GetHashKey("PLAYER")

function startWildAttack()
    -- Consts
    local playerPed = PlayerPedId()
    local animalHash = attackAnimalHashes[math.random(#attackAnimalHashes)]
    local coordsBehindPlayer = GetOffsetFromEntityInWorldCoords(playerPed, 100, -15.0, 0)
    local playerHeading = GetEntityHeading(playerPed)
    local belowGround, groundZ, vec3OnFloor = GetGroundZAndNormalFor_3dCoord(coordsBehindPlayer.x, coordsBehindPlayer.y, coordsBehindPlayer.z)

    -- Requesting model
    RequestModel(animalHash)
    while not HasModelLoaded(animalHash) do
        Wait(5)
    end
    SetModelAsNoLongerNeeded(animalHash)

    -- Creating Animal & setting player as enemy
    local animalPed = CreatePed(1, animalHash, coordsBehindPlayer.x, coordsBehindPlayer.y, groundZ, playerHeading, true, false)
    SetPedFleeAttributes(animalPed, 0, 0)
    SetPedRelationshipGroupHash(animalPed, animalGroupHash)
    TaskSetBlockingOfNonTemporaryEvents(animalPed, true)
    TaskCombatHatedTargetsAroundPed(animalPed, 30.0, 0)
    ClearPedTasks(animalPed)
    TaskPutPedDirectlyIntoMelee(animalPed, playerPed, 0.0, -1.0, 0.0, 0)
    SetRelationshipBetweenGroups(5, animalGroupHash, playerGroupHash)
    SetRelationshipBetweenGroups(5, playerGroupHash, animalGroupHash)
end


AddEventHandler("np-admin:noClipToggle", function(pIsEnabled)
    noClipEnabled = pIsEnabled
    inputRotEnabled = pIsEnabled
  
    if noClipEnabled and inputRotEnabled then
      toggleNoclip()
      checkInputRotation()
    end
  end)

RegisterNetEvent('np-admin:OpenMenuBind', function()
    if not devmodeToggle then return end
    TriggerEvent('np-admin-AttemptOpen',true)
end)

RegisterNetEvent('np-admin:NoClipBind', function()
    if not devmodeToggle then return end
    local bool = not isInNoclip
    RunNclp(nil,bool)
    TriggerEvent("np-admin:noClipToggle",bool)
end)

RegisterNetEvent('np-admin:Teleport', function()
  if not devmodeToggle then return end
  teleportMarker(nil)
end)

RegisterNetEvent("np-admin:ReviveInDistance")
AddEventHandler("np-admin:ReviveInDistance", function()
    local playerList = {}
    local players = GetPlayersss()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)


    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
        local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
        if(distance < 50) then
            playerList[index] = GetPlayerServerId(value)
        end
    end

    if playerList ~= {} and playerList ~= nil then
        TriggerServerEvent("admin:reviveAreaFromClient",playerList)

        for k,v in pairs(playerList) do
            TriggerServerEvent("reviveGranted", v)
            TriggerEvent("Hospital:HealInjuries",true) 
            TriggerServerEvent("ems:healplayer", v)
            TriggerEvent("heal")
        end
    end
    
end)

local LastVehicle = nil
RegisterNetEvent("np-adminmenu:runSpawnCommand")
AddEventHandler("np-adminmenu:runSpawnCommand", function(model, livery)
    Citizen.CreateThread(function()

        local hash = GetHashKey(model)

        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

        local localped = PlayerPedId()
        local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 5.0, 0.0)

        local heading = GetEntityHeading(localped)
        local vehicle = CreateVehicle(hash, coords, heading, true, false)

        SetVehicleModKit(vehicle, 0)
        SetVehicleMod(vehicle, 11, 3, false)
        SetVehicleMod(vehicle, 12, 2, false)
        SetVehicleMod(vehicle, 13, 2, false)
        SetVehicleMod(vehicle, 15, 3, false)
        SetVehicleMod(vehicle, 16, 4, false)


        if model == "npolvic" then
          SetVehicleMod(vehicle, 42, 4, true)
          SetVehicleMod(vehicle, 44, 2, true)
          SetVehicleMod(vehicle, 45, 0, true)

          ToggleVehicleMod(vehicle,  18, true) -- turbo
          SetVehicleExtra(vehicle, 1, toggle)
          SetVehicleExtra(vehicle, 2, toggle)
          SetVehicleExtra(vehicle, 3, toggle)
          SetVehicleExtra(vehicle, 4, toggle)
          SetVehicleExtra(vehicle, 5, toggle)       
          SetVehicleExtra(vehicle, 6, toggle)
          SetVehicleExtra(vehicle, 7, toggle)
          SetVehicleExtra(vehicle, 8, toggle)


        end

        if model == "npolchar" then
          SetVehicleMod(vehicle, 42, 4, true)
          SetVehicleMod(vehicle, 44, 2, true)
          SetVehicleMod(vehicle, 45, 0, true)

          ToggleVehicleMod(vehicle,  18, true) -- turbo
          SetVehicleExtra(vehicle, 1, toggle)
          SetVehicleExtra(vehicle, 2, toggle)
          SetVehicleExtra(vehicle, 3, toggle)
          SetVehicleExtra(vehicle, 4, toggle)
          SetVehicleExtra(vehicle, 5, toggle)       
          SetVehicleExtra(vehicle, 6, toggle)
          SetVehicleExtra(vehicle, 7, toggle)
          SetVehicleExtra(vehicle, 8, toggle)
        end

        if model == "npolexp" then
          SetVehicleMod(vehicle, 42, 4, true)
          SetVehicleMod(vehicle, 44, 2, true)
          SetVehicleMod(vehicle, 45, 0, true)

          ToggleVehicleMod(vehicle,  18, true) -- turbo
          SetVehicleExtra(vehicle, 1, toggle)
          SetVehicleExtra(vehicle, 2, toggle)
          SetVehicleExtra(vehicle, 3, toggle)
          SetVehicleExtra(vehicle, 4, toggle)
          SetVehicleExtra(vehicle, 5, toggle)       
          SetVehicleExtra(vehicle, 6, toggle)
          SetVehicleExtra(vehicle, 7, toggle)
          SetVehicleExtra(vehicle, 8, toggle)
        end



        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        TriggerServerEvent('garages:addJobPlate', plate)
        SetModelAsNoLongerNeeded(hash)
        TaskWarpPedIntoVehicle(localped, vehicle, -1)
        
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)

        if livery ~= nil then
            SetVehicleLivery(vehicle, tonumber(livery))
        end
        LastVehicle = vehicle
    end)
end)

RegisterNetEvent("np-admin:dv")
AddEventHandler("np-admin:dv", function()
  local ped = GetPlayerPed( -1 )

  if ( DoesEntityExist(ped) and not IsEntityDead(ped)) then 
      local pos = GetEntityCoords(ped)

      if ( IsPedSittingInAnyVehicle(ped)) then 
          local vehicle = GetVehiclePedIsIn(ped, false)

          if ( GetPedInVehicleSeat(vehicle, -1) == ped) then 
              DeleteGivenVehicle(vehicle, numRetries)
          else 
             TriggerEvent('DoLongHudText', 'You must be in the driver\'s seat!', 2)
          end 
      else
          local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
          local vehicle = GetVehicleInDirection(ped, pos, inFrontOfPlayer)

          if (DoesEntityExist(vehicle)) then 
              DeleteGivenVehicle(vehicle, numRetries)
          else 
            TriggerEvent('DoLongHudText', 'You must be in or near a vehicle to delete it.', 2)
          end 
      end 
  end 
end )




function DeleteGivenVehicle(veh, timeoutMax)
  local timeout = 0 

  SetEntityAsMissionEntity(veh, true, true)
  DeleteVehicle(veh)

  if (DoesEntityExist(veh)) then
    TriggerEvent('DoLongHudText', 'Try again.', 2)

      while (DoesEntityExist(veh) and timeout < timeoutMax) do 
          DeleteVehicle(veh)
          -- The vehicle has been banished from the face of the Earth!
          if (not DoesEntityExist(veh)) then 
            TriggerEvent('DoLongHudText', 'Vehicle Deleted', 1)
          end 
          timeout = timeout + 1 
          Citizen.Wait(500)
          if (DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
            TriggerEvent('DoLongHudText', 'Try Again.', 2)
          end 
      end 
  else 
    TriggerEvent('DoLongHudText', 'Successfully Deleted Vehicle.', 1)
  end 
end 

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
  local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
  
  if ( IsEntityAVehicle( vehicle ) ) then 
      return vehicle
  end 
end