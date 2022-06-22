local recentPing = 0

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if recentPing > 0  then
            recentPing = (recentPing - 1)
            if recentPing == 0 then
                recentPing = 0
            end
        end
    end
end)


RegisterNetEvent('phone:ping:request')
AddEventHandler('phone:ping:request', function(targetId, coords, is_anon)
    
    local pSrc = source
	local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
	local char = user:getCurrentCharacter()
    local name
    if is_anon then
        name = "Anonymous"
    else
        name = char.first_name .. " " .. char.last_name
    end
    
	if targetId ~= nil then
        if targetId:lower() == 'accept' then
            TriggerClientEvent('np-ping:client:AcceptPing', pSrc)
        elseif targetId:lower() == 'reject' then
            TriggerClientEvent('np-ping:client:RejectPing', pSrc)
        else
            local tSrc = tonumber(targetId)
            if recentPing == 0 then
                recentPing = 30
                if pSrc ~= tSrc then
                    TriggerClientEvent('phone:ping:receive', targetId, coords, pSrc, name)
                else
                    TriggerClientEvent('DoLongHudText', pSrc, 'Can\'t Ping Yourself', 2)
                end
            else
                TriggerClientEvent('DoLongHudText', pSrc, 'You need to wait '..tonumber(recentPing).." secs to send ping again.", 2)
            end
        end
    end
end)

RegisterServerEvent('requestPing')
AddEventHandler('requestPing', function(target, x,y,z, pIsAnon)
  local src = source
  TriggerClientEvent('AllowedPing', tonumber(target), x,y,z, src, name, pIsAnon)
end)

RegisterServerEvent('pingAccepted')
AddEventHandler('pingAccepted', function(target)
  local target = tonumber(target)
  TriggerClientEvent('notification', target, "You ping was accepted!", 5)
end)

RegisterServerEvent('pingDeclined')
AddEventHandler('pingDeclined', function(target)
  local target = tonumber(target)
  TriggerClientEvent('notification', target, "You ping was declined!", 5)
end)