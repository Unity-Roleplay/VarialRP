NITRO_VEHICLES = {}
START_TIME = 0

function setNitro(pVehicle, pBoolean)
  print(pVehicle, pBoolean)
  NITRO_VEHICLES[pVehicle] = {}
  NITRO_VEHICLES[pVehicle].activated = pBoolean
  NITRO_VEHICLES[pVehicle].mode = "boost"
  NITRO_VEHICLES[pVehicle].flowRate = 1
end

function hasNitro(pVehicle)
  if (NITRO_VEHICLES[pVehicle]) then 
      NITRO_VEHICLES[pVehicle] = NITRO_VEHICLES[pVehicle] 
  else
      NITRO_VEHICLES[pVehicle] = {}
  end

  local nitroDebug = true
  local isActivated = NITRO_VEHICLES[pVehicle].activated or false
  local debugScheme = [[[VEHICLES][DEBUG] Vehicle: %s | Nitro: %s]]
  local debugFormatted = debugScheme:format(pVehicle, isActivated or false)

  if nitroDebug then print(debugFormatted) end

  return isActivated
end


Citizen.CreateThread(function()
  RequestNamedPtfxAsset("veh_xs_vehicle_mods")
  while not HasNamedPtfxAssetLoaded("veh_xs_vehicle_mods") do
      Citizen.Wait(0)
      print("NOT LOADED LOL")
  end
  while true do
    Citizen.Wait(1)
    UseParticleFxAsset("veh_xs_vehicle_mods")
    StartParticleFxNonLoopedAtCoord(
      "veh_nitrous" --[[ string ]], 
      337.95971679688, -1141.1785888672, 29.414377212524,
      0 --[[ number ]], 
      0 --[[ number ]], 
      0 --[[ number ]], 
      scale --[[ number ]], 
      0 --[[ boolean ]], 
      0 --[[ boolean ]], 
      0 --[[ boolean ]], 
      0 --[[ boolean ]]
    )
  end
end)

RegisterCommand('changescale', function(source, args)
  scale = tonumber(args[1])
end)

RegisterCommand("putnitro", function()
  local player = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(player)
  setNitro(vehicle, true)
  local pNitroMode = NITRO_VEHICLES[vehicle].mode
  print(pNitroMode)
end)

RegisterCommand("removenitro", function()
  local player = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(player)
  setNitro(vehicle, false)
end)

function SWITCH_MODE()
  local player = PlayerPedId()
  local pVehicle = GetVehiclePedIsIn(player, false)
  local pNitroMode = NITRO_VEHICLES[pVehicle].mode
  if not pVehicle or pVehicle == 0 or pVehicle == "" then return end
  if pNitroMode == "purge" then
    NITRO_VEHICLES[pVehicle].mode = "boost"
  elseif pNitroMode == "boost" then
    NITRO_VEHICLES[pVehicle].mode = "purge"
  end
  print('CHANGED NITRO MODE ', NITRO_VEHICLES[pVehicle].mode)
end

function INCREASE_MODE()
  
  local player = PlayerPedId()
  local pVehicle = GetVehiclePedIsIn(player, false)
  if NITRO_VEHICLES[pVehicle].flowRate == 10 then
    NITRO_VEHICLES[pVehicle].flowRate = 10
    return
  end
  NITRO_VEHICLES[pVehicle].flowRate = NITRO_VEHICLES[pVehicle].flowRate + 1
  
  print('Increased flow rate ' .. NITRO_VEHICLES[pVehicle].flowRate)
  TriggerEvent('DoShortHudText', 'Increased flow rate ' .. NITRO_VEHICLES[pVehicle].flowRate, 1)
end

function DECREASE_MODE()
  local player = PlayerPedId()
  local pVehicle = GetVehiclePedIsIn(player, false)
  if NITRO_VEHICLES[pVehicle].flowRate == 1 then
    NITRO_VEHICLES[pVehicle].flowRate = 1 
  else
    NITRO_VEHICLES[pVehicle].flowRate = NITRO_VEHICLES[pVehicle].flowRate - 1
  print('Decreased flow rate ' .. NITRO_VEHICLES[pVehicle].flowRate)
  TriggerEvent('DoShortHudText', 'Decreased flow rate ' .. NITRO_VEHICLES[pVehicle].flowRate, 1)
  end
end

function activateNitro()
  START_TIME = GetGameTimer()
  local pPlayer = PlayerPedId()
  local pVehicle = GetVehiclePedIsIn(pPlayer)
  local pDriver = GetPedInVehicleSeat(pVehicle, -1)

  if pVehicle == false or pVehicle == 0 or pVehicle == "" then return end
  if pDriver ~= pPlayer then return end

  if hasNitro(pVehicle) then
    if NITRO_VEHICLES[pVehicle].mode == "boost" then
      SetVehicleNitroBoostEnabled(pVehicle, true)
      TriggerServerEvent("nitro:sync:ptfx:purge", pVehicle, false)
      TriggerServerEvent('nitro:__sync', true, false, false)
    elseif NITRO_VEHICLES[pVehicle].mode == "purge" then
      SetVehicleNitroBoostEnabled(pVehicle, false)
      TriggerServerEvent("nitro:sync:ptfx:purge", pVehicle, true)
      TriggerServerEvent('nitro:__sync', false, true, false)
    end
  end
end

RegisterNetEvent("nitro:sync:ptfx:purge:client")
AddEventHandler("nitro:sync:ptfx:purge:client", function(pVehicle, pEnable)
  SetVehicleNitroPurgeEnabled(pVehicle, pEnable)
end)

function deactiveNitro()
  -- START_TIME = GetGameTimer()
  print("HOLD NITRO FOR", GetGameTimer() - START_TIME)
  local pPlayer = PlayerPedId()
  local pVehicle = GetVehiclePedIsIn(pPlayer)
  local pDriver = GetPedInVehicleSeat(pVehicle, -1)

  if pVehicle == false or pVehicle == 0 or pVehicle == "" then return end
  if pDriver ~= pPlayer then return end

  if hasNitro(pVehicle) then
    if NITRO_VEHICLES[pVehicle].mode == "boost" then
      removeParticles()
      SetVehicleNitroBoostEnabled(pVehicle, false)
      SetVehicleNitroPurgeEnabled(pVehicle, false)
      TriggerServerEvent('nitro:__sync', true, false, false)
    end
    if NITRO_VEHICLES[pVehicle].mode == "purge" then
      removeParticles()
      SetVehicleNitroPurgeEnabled(pVehicle, false)
      TriggerServerEvent('nitro:__sync', false, true, false)
    end
  end
end

RegisterNetEvent('nitro:__update')
AddEventHandler('nitro:__update', function (playerServerId, boostEnabled, purgeEnabled, lastVehicle)
  local playerId = GetPlayerFromServerId(playerServerId)

  if not NetworkIsPlayerConnected(playerId) then
    return
  end

  local player = GetPlayerPed(playerId)
  local vehicle = GetVehiclePedIsIn(player, lastVehicle)
  local driver = GetPedInVehicleSeat(vehicle, -1)

  SetVehicleNitroBoostEnabled(vehicle, boostEnabled)
  SetVehicleNitroPurgeEnabled(vehicle, purgeEnabled)
  if boostEnabled or purgeEnabled then
    removeParticles()
  end
end)
