TriggerServerEvent("np:server:blackout")

RegisterNetEvent('np:client:blackout')
AddEventHandler('np:client:blackout', function(blackout)
    SetArtificialLightsStateAffectsVehicles(false)
    SetArtificialLightsState(blackout)
end)