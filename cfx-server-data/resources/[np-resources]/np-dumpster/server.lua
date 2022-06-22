local dumpsterItems = {
    [1] = {chance = 2, id = 'sandwich', quantity = math.random(1,2)},
    [2] = {chance = 2, id = 'water', quantity = math.random(1,2)},
    [3] = {chance = 5, id = 'plastic', quantity = math.random(1,3)},
    [4] = {chance = 4, id = 'chemicals', quantity = math.random(1,3)},
    [5] = {chance = 3, id = 'methlabbaggy', quantity = math.random(1,3)},

}


RegisterServerEvent('novel:startDumpsterTimer')
AddEventHandler('novel:startDumpsterTimer', function(dumpster)
    startTimer(source, dumpster)
end)

RegisterServerEvent('novel:giveDumpsterReward')
AddEventHandler('novel:giveDumpsterReward', function()
    local source = tonumber(source)
    local item = {}
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    local gotID = {}

    for i = 1, math.random (1,2) do
        item = dumpsterItems[math.random(1, #dumpsterItems)]
        if math.random(1, 10) >= item.chance then
            if tonumber(item.id) == 0 and not gotID[item.id] then
                gotID[item.id] = true
                user:addMoney(item.quantity)
                TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
            elseif not gotID[item.id] then
                gotID[item.id] = true
                TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
                TriggerClientEvent('DoLongHudText', source, 'You found '..item.id, 1)
            end
        else
            TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
        end
  end
end)

function startTimer(id, object)
    local timer = 10 * 60000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            TriggerClientEvent('novel:removeDumpster', id, object)
        end
    end
end