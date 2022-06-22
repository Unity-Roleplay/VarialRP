Doors = {
    ["P1"] = {{loc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), txtloc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), state = nil, locked = true}},
}

RegisterServerEvent("np-paleto:startcheck")
AddEventHandler("np-paleto:startcheck", function(bank)
    local src = source

    if not Paleto.Banks[bank].onaction == true then
        if (os.time() - Paleto.cooldown) > Paleto.Banks[bank].lastrobbed then
            Paleto.Banks[bank].onaction = true
            TriggerClientEvent("np-paleto:outcome", src, true, bank)
            TriggerClientEvent("np-paleto:policenotify", -1, bank)
        else
            TriggerClientEvent("np-paleto:outcome", src, false, "This bank recently robbed. You need to wait "..math.floor((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("np-paleto:outcome", src, false, "This bank is currently being robbed.")
    end
end)

RegisterCommand("testy", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
        -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
    else
        if Paleto.blackmoney then
            TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
            -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
        end
    end
end)

RegisterServerEvent("np-paleto:lootup")
AddEventHandler("np-paleto:lootup", function(var, var2)
    TriggerClientEvent("np-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("np-paleto:toggleVault")
AddEventHandler("np-paleto:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("np-paleto:toggleVault", -1, key, state)
end)

RegisterServerEvent("np-paleto:updateVaultState")
AddEventHandler("np-paleto:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("np-paleto:startLoot")
AddEventHandler("np-paleto:startLoot", function(data, name, players)
    local src = source

    for i = 10, #players, 10 do
        TriggerClientEvent("np-paleto:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("np-paleto:startLoot_c", src, data, name)
end)

RegisterServerEvent("np-paleto:stopHeist")
AddEventHandler("np-paleto:stopHeist", function(name)
    TriggerClientEvent("np-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("np-paleto:rewardCash")
AddEventHandler("np-paleto:rewardCash", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 250)
    else
        TriggerClientEvent("player:receiveItem", src, "markedbills", 425)
    end
end)

RegisterServerEvent("np-paleto:setCooldown")
AddEventHandler("np-paleto:setCooldown", function(name)
    Paleto.Banks[name].lastrobbed = os.time()
    Paleto.Banks[name].onaction = false
    TriggerClientEvent("np-paleto:resetDoorState", -1, name)
end)

RPC.register("np-paleto:getBanks", function(source)
    return Paleto.Banks, Doors
end)

 RegisterCommand("aan", function()
     TriggerClientEvent('np-paleto:UseGreenLapTop', source)
 end)

-- RegisterServerEvent('rick:removeLaptop')
-- AddEventHandler('rick:removeLaptop', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem('green-laptop', 1)
-- end)


local doorCheckPaleto = false

RegisterServerEvent("np-paleto:getGetDoorStateSV")
AddEventHandler("np-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('np-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("np-paleto:getGetDoorStateSVSV")
AddEventHandler("np-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)

RegisterServerEvent("np-paleto:openDoor")
AddEventHandler("np-paleto:openDoor", function(coords, method)
    TriggerClientEvent("np-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("np-paleto:closeDoor")
AddEventHandler("np-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("np-paleto:ClosePaletoDoor", -1)
end)