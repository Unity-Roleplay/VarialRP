RegisterNetEvent('explosionEvent')
AddEventHandler("explosionEvent", function()
    TriggerClientEvent('dark-vaultrob:lower:vaultdoor', -1)
end)