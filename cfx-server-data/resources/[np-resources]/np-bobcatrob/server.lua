RegisterServerEvent('efe-bobcat:boom_efe')
AddEventHandler('efe-bobcat:boom_efe', function()
    TriggerClientEvent('efe-bobcat:boom', -1)
end)

RegisterServerEvent("efe:particleserver")
AddEventHandler("efe:particleserver", function(method)
    TriggerClientEvent("efe:ptfxparticle", -1, method)
end)

RegisterServerEvent("efe:particleserversec")
AddEventHandler("efe:particleserversec", function(method)
    TriggerClientEvent("efe:ptfxparticlesec", -1, method)
end)

RegisterServerEvent("efe:particleserverthi")
AddEventHandler("efe:particleserverthi", function(method)
    TriggerClientEvent("efe:ptfxparticlethi", -1, method)
end)

--[[RPC.Register('bobcat-rob:lootDeadGuard')
AddEventHandler('bobcat-rob:lootDeadGuard', function(itemid)
    local pick = math.random(1, 9)
    if pick == 1 then
        TriggerClientEvent('player:receiveItem', source, 'lockpick', 1)
    elseif pick == 2 then
        TriggerClientEvent('player:receiveItem', source, 'sandwich', math.random(1,3))
    elseif pick == 3 then
        TriggerClientEvent('player:receiveItem', source, 'hamburger', 1)
    elseif pick == 4 then
        TriggerClientEvent('player:receiveItem', source, 'oxy', 1)
    elseif pick == 5 then
        TriggerClientEvent('player:receiveItem', source, 'water', math.random(1,3))
    elseif pick == 6 then
        TriggerClientEvent('player:receiveItem', source, '-538741184', 1)
    elseif pick == 7 then
        TriggerClientEvent('player:receiveItem', source, '4192643659', 1)
    elseif pick == 8 then
        TriggerClientEvent('player:receiveItem', source, 'ciggy', math.random(1,5))
    elseif pick == 9 then
        TriggerClientEvent('player:receiveItem', source, 'maleseed', math.random(5,10))
    elseif pick == 10 then
        TriggerClientEvent('player:receiveItem', source, 'femaleseed', math.random(5,10))
    end
end)]]