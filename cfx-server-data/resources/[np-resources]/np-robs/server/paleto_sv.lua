cooldownglobalPaleto = 0

RegisterServerEvent("np-paleto:startcheck")
AddEventHandler("np-paleto:startcheck", function(bank)
    local _source = source
    globalonactionPaleto = true
    TriggerClientEvent('np-inv:removeItem', _source, 'bluetablet', 1)
    TriggerClientEvent("np-paleto:outcome", _source, true, bank)
end)

RegisterServerEvent("np-paleto:TimePoggers")
AddEventHandler("np-paleto:TimePoggers", function()
    local _source = source
    TriggerClientEvent("np-paleto:outcome", _source, false, "This bank recently robbed. You need to wait "..math.floor((paleto.cooldown - (os.time() - cooldownglobalPaleto)) / 60)..":"..math.fmod((paleto.cooldown - (os.time() - cooldownglobalPaleto)), 60))
end)

RegisterServerEvent("np-paleto:DoorAccessPoggers")
AddEventHandler("np-paleto:DoorAccessPoggers", function()
    local _source = source
    TriggerClientEvent("np-paleto:outcome", _source, false, "There is a bank currently being robbed.")
end)

RegisterServerEvent("np-paleto:lootup")
AddEventHandler("np-paleto:lootup", function(var, var2)
    TriggerClientEvent("np-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("np-paleto:openDoor")
AddEventHandler("np-paleto:openDoor", function(coords, method)
    TriggerClientEvent("np-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("np-paleto:closeDoor")
AddEventHandler("np-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("np-paleto:ClosePaletoDoor", -1)
end)

RegisterServerEvent("np-paleto:startLoot")
AddEventHandler("np-paleto:startLoot", function(data, name)
    TriggerClientEvent("np-paleto:startLoot_c", -1, data, name)
end)

RegisterServerEvent("np-paleto:stopHeist")
AddEventHandler("np-paleto:stopHeist", function(name)
    TriggerClientEvent("np-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("np-paleto:rewardCash")
AddEventHandler("np-paleto:rewardCash", function()
    local reward = math.random(2, 4)
    TriggerClientEvent("np-user:receiveItem", source, "band", reward)
end)

RegisterServerEvent("np-paleto:setCooldown")
AddEventHandler("np-paleto:setCooldown", function(name)
    cooldownglobalPaleto = os.time()
    globalonactionPaleto = false
    TriggerClientEvent("np-paleto:resetDoorState", -1, name)
end)


RegisterServerEvent("np-paleto:getBanksSV")
AddEventHandler("np-paleto:getBanksSV", function()
    TriggerClientEvent('np-paleto:getBanks', -1, paleto.Banks)
end)

local cooldownAttemptsPaleto = 3

RegisterServerEvent("np-paleto:getHitSV")
AddEventHandler("np-paleto:getHitSV", function()
    TriggerClientEvent('np-paleto:getHit', -1, cooldownAttemptsPaleto)
end)

RegisterServerEvent("np-paleto:getHitSVSV")
AddEventHandler("np-paleto:getHitSVSV", function(paletoBanksTimes)
    cooldownAttemptsPaleto = paletoBanksTimes
end)

local doorCheckPaleto = false

RegisterServerEvent("np-paleto:getGetDoorStateSV")
AddEventHandler("np-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('np-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("np-paleto:getGetDoorStateSVSV")
AddEventHandler("np-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)


RegisterServerEvent("np-paleto:getTimeSV")
AddEventHandler("np-paleto:getTimeSV", function()
    TriggerClientEvent('np-paleto:GetTimeCL', -1, cooldownglobalPaleto)
end)

RegisterServerEvent("np-paleto:getTime2SV")
AddEventHandler("np-paleto:getTime2SV", function()
    TriggerClientEvent('np-paleto:GetTime2CL', -1, (os.time() - paleto.cooldown))
end)

RegisterServerEvent("np-paleto:getDoorAccessSV")
AddEventHandler("np-paleto:getDoorAccessSV", function()
    TriggerClientEvent('np-paleto:GetDoorAccessCL', -1, globalonactionPaleto)
end)