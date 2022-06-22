RegisterNetEvent('nitro:__sync')
AddEventHandler('nitro:__sync', function (boostEnabled, purgeEnabled, lastVehicle)
  -- Fix for source reference being lost during loop below.
  local source = source

  for _, player in ipairs(GetPlayers()) do
    if player ~= tostring(source) then
      TriggerClientEvent('nitro:__update', player, source, boostEnabled, purgeEnabled, lastVehicle)
    end
  end
end)

RegisterNetEvent("nitro:sync:ptfx:backfire")
AddEventHandler("nitro:sync:ptfx:backfire", function(pVehicle)
  TriggerClientEvent("nitro:sync:ptfx:backfire:client", -1, pVehicle)
end)

RegisterNetEvent("nitro:sync:ptfx:purge")
AddEventHandler("nitro:sync:ptfx:purge", function(pVehicle, pEnabled)
  TriggerClientEvent("nitro:sync:ptfx:purge:client", -1, pVehicle, pEnabled)
end)