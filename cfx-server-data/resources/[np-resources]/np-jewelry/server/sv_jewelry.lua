RegisterServerEvent("dark-jewelry:ptfx")
AddEventHandler("dark-jewelry:ptfx", function(method)
    TriggerClientEvent("dark-jewelry:ptfx_c", -1, method)
end)

AddEventHandler('onResourceStart', function(resourceName)
if (GetCurrentResourceName() ~= resourceName) then
 	return
end
print('dark-jewelry:jewelry | Succesfuly Loaded')
end)