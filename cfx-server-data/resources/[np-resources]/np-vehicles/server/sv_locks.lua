RegisterServerEvent('np-keys:attemptLockSV')
AddEventHandler('np-keys:attemptLockSV', function(targetVehicle, plate)
    TriggerClientEvent('np-keys:attemptLock', source, targetVehicle, plate)
end)