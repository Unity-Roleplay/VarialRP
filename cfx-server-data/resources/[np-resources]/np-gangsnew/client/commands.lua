Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/gang', 'Check your gang.', {})
    TriggerEvent("chat:addSuggestion", "/addmember", "Add a member to your gang", {
        {name = "id", help = "Server ID"},
        {name = "rank", help = "0 - 5"},
    })
    TriggerEvent("chat:addSuggestion", "/removemember", "Remove a member from your gang", {{name = "id", help = "Server ID"}})
end)


function GetGangs()
    AvailableGangs = {}
    for k,v in pairs(Config["Gangs"]) do
        table.insert(AvailableGangs,k)
    end
    return AvailableGangs
end


exports('GetAvailableGangs', GetGangs)


RegisterNetEvent("unwind-gangs:Setgang")
AddEventHandler("unwind-gangs:Setgang", function(ServerID, Gang, Rank)
    if tonumber(Rank) > 5 then
        TriggerEvent("DoLongHudText","Maximum rank is 5.",2)
    else
        for k,v in pairs(Config["Gangs"]) do
            if Gang == k then
                TriggerServerEvent('unwind-gangs:server:setgang', tonumber(ServerID), Gang, tonumber(Rank))
                return
            end
        end
    end
end)

RegisterCommand("addmember", function(source, args)
    if args[1] ~= nil then
        local serverid = tonumber(args[1])
        if args[2] ~= nil then
            local rank = tonumber(args[2])
            if rank <= 5 then
                TriggerServerEvent('unwind-gangs:server:addmember',serverid, rank)
            else
                TriggerEvent("DoLongHudText","Maximum rank is 5.",2)
            end
        else
            TriggerEvent("DoLongHudText","Fill in all the blanks dumb ass.",2)
        end
    else
        TriggerEvent("DoLongHudText","Fill in all the blanks dumb ass.",2)
    end
end)

RegisterCommand("removemember", function(source, args)
    if args[1] ~= nil then
        local serverid = tonumber(args[1])
        TriggerServerEvent('unwind-gangs:server:firegang',serverid)
    else
        TriggerEvent("DoLongHudText","Fill in all the blanks dumb ass.",2)
    end
end)

RegisterCommand("gang", function(source, args)
    local MyGang = RPC.execute("unwind-gangs:server:getgang")
    print(MyGang.gang)
    if MyGang.gang == nil then
        TriggerEvent('chatMessage', 'Character', {0, 0, 0}, "Not in any gang")
    else
        TriggerEvent('chatMessage', 'Character', {0, 0, 0}, "Gang Name : "..Config["Gangs"][MyGang.gang].label.." , Rank : "..MyGang.rank.."")
    end
end)
