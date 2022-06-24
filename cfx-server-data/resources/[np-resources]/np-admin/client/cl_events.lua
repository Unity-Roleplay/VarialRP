local BlipsEnabled, NamesEnabled, GodmodeEnabled, AllPlayerBlips = false, false, false, {}

-- [ Code ] --

-- [ Events ] --

RegisterNetEvent("Admin:Godmode", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/toggle-godmode', Result['player'])
    end
end)

RegisterNetEvent('Admin:Toggle:Noclip', function()
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        SendNUIMessage({
            Action = "SetItemEnabled",
            Name = 'noclip',
            State = not noClipEnabled
        })
        if noClipEnabled then
            TriggerEvent('np-admin:runNoclipbtn', false)
        else
            TriggerEvent('np-admin:runNoclipbtn', true)
        end
    end
end)

RegisterNetEvent('Admin:Fix:Vehicle', function(Result)
    if IsPlayerAdmin() then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), true))
        else
            local Vehicle, Distance = GetClosestVehicle(GetEntityCoords(PlayerPedId()))
            SetVehicleFixed(Vehicle)
        end 
    end
end)

RegisterNetEvent('Admin:Delete:Vehicle', function(Result)
    if IsPlayerAdmin() then
        TriggerEvent("np-admin:dv")
    end
end)

RegisterNetEvent('Admin:Spawn:Vehicle', function(Result)
    if IsPlayerAdmin() then

        TriggerEvent('np-adminmenu:runSpawnCommand', Result['model'])
    end
end)

RegisterNetEvent('Admin:Bennys:Menu', function(Result)
    print(IsPedInAnyVehicle(PlayerPedId()))
    if IsPlayerAdmin() then
        if IsPedInAnyVehicle(PlayerPedId()) == 1 then
            SendNUIMessage({
                Action = 'Close',
            })
            TriggerEvent('enter:benny:DevBennys')
        end
    end
end)

RegisterNetEvent('Admin:SetDevSpawn', function(Result)
    if IsPlayerAdmin() then
        local loc = {}
        loc = {
        vars = {}
      }
       loc.vars.pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
       local heading = GetEntityHeading(PlayerPedId())
       local value = vector4(loc.vars.pos.x,loc.vars.pos.y,loc.vars.pos.z,heading)
       exports["storage"]:set(value,"devspawn")
       TriggerEvent('DoShortHudText', 'Dev spawn set at current location..')
    end
end)

RegisterNetEvent('Admin:Teleport:Marker', function(Result)
    if IsPlayerAdmin() then
        teleportMarker(nil)
    end
end)

RegisterNetEvent('Admin:Teleport:Coords', function(Result)
    if IsPlayerAdmin() then
        if Result['x-coord'] ~= '' and Result['y-coord'] ~= '' and Result['z-coord'] ~= '' then
            SendNUIMessage({
                Action = 'Close',
            })
            SetEntityCoords(PlayerPedId(), tonumber(Result['x-coord']), tonumber(Result['y-coord']), tonumber(Result['z-coord']))
        end
    end
end)

RegisterNetEvent('Admin:Teleport', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin/server/teleport-player', Result['player'], Result['type'])
    end
end)

RegisterNetEvent("Admin:Chat:Say", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/chat-say', Result['message'])
    end
end)

RegisterNetEvent('Admin:Open:Clothing', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin/server/give-clothing', Result['player'])
    end
end)

RegisterNetEvent('Admin:Open:BarberShop', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerEvent("raid_clothes:admin:open", true, false)
    end
end)

RegisterNetEvent('Admin:Revive', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/revive-target', Result['player'])
    end
end)

RegisterNetEvent('Admin:Remove:Stress', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/remove-stress', Result['player'])
    end
end)

RegisterNetEvent('Admin:Change:Model', function(Result)
    if IsPlayerAdmin() and Result['model'] ~= '' then
        local Model = GetHashKey(Result['model'])
        if IsModelValid(Model) then
            TriggerServerEvent('np-admin/server/set-model', Result['player'], Model)
        end
    end
end)

RegisterNetEvent('Admin:Reset:Model', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/reset-skin', Result['player'])
    end
end)


RegisterNetEvent('Admin:Food:Drink', function(Result)
    if IsPlayerAdmin() then
        TriggerEvent('np-admin:maxstats')
    end
end)

RegisterNetEvent('Admin:Request:Job', function(Result)
    if IsPlayerAdmin() then
        if Result['job'] ~= '' then
            TriggerServerEvent('np-admin/server/request-job', Result['player'], Result['job'])
        end
    end
end)

RegisterNetEvent("Admin:Drunk", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/drunk', Result['player'])
    end
end)

RegisterNetEvent("Admin:Animal:Attack", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/animal-attack', Result['player'])
    end
end)

RegisterNetEvent('Admin:Set:Fire', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/set-fire', Result['player'])
    end
end)

RegisterNetEvent('Admin:Fling:Player', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/fling-player', Result['player'])
    end
end)

RegisterNetEvent('Admin:GiveItem', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/give-item', Result['player'], Result['item'], Result['amount'])
    end
end)

RegisterNetEvent('Admin:Ban', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/ban-player', Result['player'], Result['expire'], Result['reason'])
    end
end)

RegisterNetEvent('Admin:Kick', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/kick-player', Result['player'], Result['reason'])
    end
end)

RegisterNetEvent("Admin:Copy:Coords", function(Result)
    if IsPlayerAdmin() then
        local CoordsType = Result['type']
        local CoordsLayout = nil

        local Coords = GetEntityCoords(PlayerPedId())
        local Heading = GetEntityHeading(PlayerPedId())
        local X = roundDecimals(Coords.x, 2)
        local Y = roundDecimals(Coords.y, 2)
        local Z = roundDecimals(Coords.z, 2)
        local H = roundDecimals(Heading, 2)
        if CoordsType == 'vector3(0.0, 0.0, 0.0)' then
            CoordsLayout = 'vector3('..X..', '..Y..', '..Z..')'
        elseif CoordsType == 'vector4(0.0, 0.0, 0.0, 0.0)' then
            CoordsLayout = 'vector4('..X..', '..Y..', '..Z..', '..H..')'
        elseif CoordsType == '0.0, 0.0, 0.0' then
            CoordsLayout = ''..X..', '..Y..', '..Z..''
        elseif CoordsType == '0.0, 0.0, 0.0, 0.0' then
            CoordsLayout = ''..X..', '..Y..', '..Z..', '..H..''
        elseif CoordsType == 'X = 0.0, Y = 0.0, Z = 0.0' then
            CoordsLayout = 'X = '..X..', Y = '..Y..', Z = '..Z..''
        elseif CoordsType == 'x = 0.0, y = 0.0, z = 0.0' then
            CoordsLayout = 'x = '..X..', y = '..Y..', z = '..Z..''
        elseif CoordsType == 'X = 0.0, Y = 0.0, Z = 0.0, H = 0.0' then
            CoordsLayout = 'X = '..X..', Y = '..Y..', Z = '..Z..', H = '..H
        elseif CoordsType == 'x = 0.0, y = 0.0, z = 0.0, h = 0.0' then
            CoordsLayout = 'x = '..X..', y = '..Y..', z = '..Z..', h = '..H
        elseif CoordsType == '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0' then
            CoordsLayout = '["X"] = '..X..', ["Y"] = '..Y..', ["Z"] = '..Z
        elseif CoordsType == '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0' then
            CoordsLayout = '["x"] = '..X..', ["y"] = '..Y..', ["z"] = '..Z
        elseif CoordsType == '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0, ["H"] = 0.0' then
            CoordsLayout = '["X"] = '..X..', ["Y"] = '..Y..', ["Z"] = '..Z..', ["H"] = '..H
        elseif CoordsType == '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0' then
            CoordsLayout = '["x"] = '..X..', ["y"] = '..Y..', ["z"] = '..Z..', ["h"] = '..H
        end
        SendNUIMessage({
			Action = 'copyCoords',
			Coords = CoordsLayout
		})
    end
end)

RegisterNetEvent("Admin:Fart:Player", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin/server/play-sound', Result['player'], Result['fart'])
    end
end)

RegisterNetEvent('Admin:Toggle:PlayerBlips', function()
    if not IsPlayerAdmin() then return end

    BlipsEnabled = not BlipsEnabled

    TriggerServerEvent('np-admin/server/toggle-blips')

    SendNUIMessage({
        Action = "SetItemEnabled",
        Name = 'playerblips',
        State = BlipsEnabled
    })

    if not BlipsEnabled then
        DeletePlayerBlips()
    end
end)

RegisterNetEvent('Admin:Toggle:PlayerNames', function()
    if not IsPlayerAdmin() then return end

    NamesEnabled = not NamesEnabled

    SendNUIMessage({
        Action = "SetItemEnabled",
        Name = 'playernames',
        State = NamesEnabled
    })

    if NamesEnabled then
        local Players = GetPlayersInArea(nil, 15.0)

        Citizen.CreateThread(function()
            while NamesEnabled do
                Citizen.Wait(2000)
                Players = GetPlayersInArea(nil, 15.0)
            end
        end)

        Citizen.CreateThread(function()
            while NamesEnabled do
                for k, v in pairs(Players) do
                    local Ped = GetPlayerPed(GetPlayerFromServerId(tonumber(v['ServerId'])))
                    local PedCoords = GetPedBoneCoords(Ped, 0x796e)
                    local PedHealth = GetEntityHealth(Ped) / GetEntityMaxHealth(Ped) * 100
                    local PedArmor = GetPedArmour(Ped)
                    
                    DrawText3D(vector3(PedCoords.x, PedCoords.y, PedCoords.z + 0.5), ('[%s] - %s ~n~Health: %s - Armor: %s'):format(v['ServerId'], v['Name'], math.floor(PedHealth), math.floor(PedArmor)))
                end
                
                Citizen.Wait(1)
            end
        end)
    end
end)

RegisterNetEvent('Admin:Toggle:Spectate', function(Result)
    if not IsPlayerAdmin() then return end

    if not isSpectateEnabled then
        TriggerServerEvent('np-admin/server/start-spectate', Result['player'])
    else
        toggleSpectate(storedTargetPed)
        preparePlayerForSpec(false)
        TriggerServerEvent('np-admin/server/stop-spectate')
    end
end)

RegisterNetEvent("Admin:OpenInv", function(Result)
    if exports["np-base"]:getModule("LocalPlayer"):getVar("rank") == ('dev' or 'owner' or 'mod') then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-adminmenu:CheckInventory', Result['player'])
        TriggerEvent('DoLongHudText', 'Searching ID ' ..Result['player'].. '\'s Inventory.', 1)
      else
        TriggerEvent('DoLongHudText', 'Insuficcient Permissions.', 2)
      end
    end)
-- [ Triggered Events ] --

RegisterNetEvent("np-admin/client/toggle-godmode", function()
    GodmodeEnabled = not GodmodeEnabled

    local Msg = GodmodeEnabled and 'enabled.' or 'disabled.'
    local MsgType = GodmodeEnabled and 'success' or 'error'
    TriggerEvent('DoShortHudText','Godmode '..Msg, MsgType)

    if GodmodeEnabled then
        while GodmodeEnabled do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

local DebugMode = false

RegisterNetEvent("np-admin/client/toggle-debug", function()
    SendNUIMessage({
        Action = "SetItemEnabled",
        Name = 'Debug',
        State = not DebugMode
    })
  if not DebugMode then
    DebugMode = true
    TriggerEvent('DoLongHudText', 'Dev Debug Enabled!', 1)
    debugmodeToggle = true
  else
    DebugMode = false
    TriggerEvent('DoLongHudText', 'Dev Debug Disabled!', 1)
    debugmodeToggle = false
  end
end)

RegisterNetEvent('np-admin/client/teleport-player', function(Coords)
    local Entity = PlayerPedId()    
    SetPedCoordsKeepVehicle(Entity, Coords.x, Coords.y, Coords.z)
end)

local function LoadModel(mdl)
	RequestModel(mdl)
	local rst = 0
	while not HasModelLoaded(mdl) and rst < 10 do
		Citizen.Wait(100)
		rst = rst + 1
	end
end

RegisterNetEvent('np-admin/client/set-model', function(Model)
    LoadModel(Model)
    SetPlayerModel(PlayerId(), Model)
    SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 0)
end)

RegisterNetEvent('np-admin/client/armor-up', function()
    SetPedArmour(PlayerPedId(), 100)
end)

RegisterNetEvent("np-admin/client/play-sound", function(Sound)
    local Soundfile = nil
    if Sound == 'Fart' then
        Soundfile = 'FartNoise2'
    elseif Sound == 'Wet Fart' then
        Soundfile = 'FartNoise'
    end
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, Soundfile, 0.3)
end)

RegisterNetEvent('np-admin/client/fling-player', function()
    local Ped = PlayerPedId()
    if GetVehiclePedIsUsing(Ped) ~= 0 then
        ApplyForceToEntity(GetVehiclePedIsUsing(Ped), 1, 0.0, 0.0, 100000.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    else
        ApplyForceToEntity(Ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    end
end)

RegisterNetEvent('np-admin/client/DeletePlayerBlips', function()
    if not IsPlayerAdmin() then return end
    DeletePlayerBlips()
end)

RegisterNetEvent('np-admin/client/UpdatePlayerBlips', function(BlipData)
    if not IsPlayerAdmin() then return end
    
    local ServerId = GetPlayerServerId(PlayerId())
    for k, v in pairs(BlipData) do
        if tonumber(v.ServerId) ~= tonumber(ServerId) then
            local PlayerPed = GetPlayerPed(v.ServerId)
            local PlayerBlip = AddBlipForEntity(PlayerPed) 
            SetBlipSprite(PlayerBlip, 1)
            SetBlipColour(PlayerBlip, 0)
            SetBlipScale(PlayerBlip, 0.75)
            SetBlipAsShortRange(PlayerBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('['..v.ServerId..'] '..v.Name)
            EndTextCommandSetBlipName(PlayerBlip)
            table.insert(AllPlayerBlips, PlayerBlip)
        end
    end
end)

RegisterNetEvent("np-admin/client/drunk", function()
    drunkThread()
end)

RegisterNetEvent("np-admin/client/animal-attack", function()
    startWildAttack()
end)

RegisterNetEvent("np-admin/client/set-fire", function()
    local playerPed = PlayerPedId()
    StartEntityFire(playerPed)
end)

RegisterNetEvent('np-admin:setvehstate',function (data)
	local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)
	local licensePlate = GetVehicleNumberPlateText(targetVehicle)
    if data.plate ~=  "" then
        TriggerEvent('DoShortHudText', 'Vehicle with the plate:  '..data.plate.. ' was sent to impound lot',2)
        TriggerServerEvent('np-police:setVehiclestate',data.plate,'C')
    else
        TriggerEvent('DoShortHudText', 'Nothing inputted aborting..',2)
    end
end)

RegisterNetEvent('Admin:GiveCash', function(money)
    TriggerServerEvent('np-adminmenu:server:GiveCash', money['amount'], money['player'])
end)