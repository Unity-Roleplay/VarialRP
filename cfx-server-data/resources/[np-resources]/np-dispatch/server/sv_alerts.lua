RegisterServerEvent("np-alerts:teenA")
AddEventHandler("np-alerts:teenA",function(targetCoords)
    TriggerClientEvent('np-alerts:policealertA', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:teenB")
AddEventHandler("np-alerts:teenB",function(targetCoords)
    TriggerClientEvent('np-alerts:policealertB', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:teenpanic")
AddEventHandler("np-alerts:teenpanic",function(targetCoords)
    TriggerClientEvent('np-alerts:panic', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:fourA")
AddEventHandler("np-alerts:fourA",function(targetCoords)
    TriggerClientEvent('np-alerts:tenForteenA', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:fourB")
AddEventHandler("np-alerts:fourB",function(targetCoords)
    TriggerClientEvent('np-alerts:tenForteenB', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:downperson")
AddEventHandler("np-alerts:downperson",function(targetCoords)
    TriggerClientEvent('np-alerts:downalert', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:shoot")
AddEventHandler("np-alerts:shoot",function(targetCoords)
    TriggerClientEvent('np-alerts:gunshotInProgress', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:storerob")
AddEventHandler("np-alerts:storerob",function(targetCoords)
    TriggerClientEvent('np-alerts:storerobbery', -1, targetCoords)
	return
end)


RegisterServerEvent("np-alerts:houserob")
AddEventHandler("np-alerts:houserob",function(targetCoords)
    TriggerClientEvent('np-alerts:houserobbery', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:drugsselling")
AddEventHandler("np-alerts:drugsselling",function(targetCoords)
    TriggerClientEvent('np-alerts:drugsales', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:tbank")
AddEventHandler("np-alerts:tbank",function(targetCoords)
    TriggerClientEvent('np-alerts:banktruck', -1, targetCoords)
	return
end)

RegisterServerEvent("np-alerts:robjew")
AddEventHandler("np-alerts:robjew",function()
    TriggerClientEvent('np-alerts:jewelrobbey', -1)
	return
end)


RegisterServerEvent("np-dispatch:fleeca:bank")
AddEventHandler("np-dispatch:fleeca:bank",function(pCoords)
    TriggerClientEvent('np-dispatch:fleeca:bank:receive', -1, pCoords)
end)

