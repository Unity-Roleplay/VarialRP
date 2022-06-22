
local Coords = {
    [1] = {x = 319.32, y = -268.59, z = 53.76},
    [2] = {x = -345.76, y = -29.81, z = 47.38},
    [3] = {x = 1173.53, y = 2696.9, z = 37.96},
    [4] = {x = -2973.14, y = 480.65, z = 15.25},
    [5] = {x = -118.28, y = 6460.21, z = 31.47},
}

local store_cracked_1 = false
local store_cracked_2 = false 
local store_cracked_3 = false
local store_cracked_4 = false
local store_cracked_5 = false
local store_cracked_6 = false
local store_cracked_7 = false
local store_cracked_8 = false
local store_cracked_9 = false
local store_cracked_10 = false
local store_cracked_11 = false
local store_cracked_12 = false
local store_cracked_13 = false
local store_cracked_14 = false
local store_cracked_15 = false
local store_cracked_16 = false
local store_cracked_17 = false
local store_cracked_18 = false
local store_cracked_19 = false
local store_cracked_20 = false
local store_cracked_21 = false
local store_getmoney_1 = false
local store_getmoney_2 = false
local store_getmoney_3 = false
local store_getmoney_4 = false
local store_getmoney_5 = false
local store_getmoney_6 = false
local store_getmoney_7 = false
local store_getmoney_8 = false
local store_getmoney_9 = false
local store_getmoney_10 = false
local store_getmoney_11 = false
local store_getmoney_12 = false
local store_getmoney_13 = false
local store_getmoney_14 = false
local store_getmoney_15 = false
local store_getmoney_16 = false
local store_getmoney_17 = false
local store_getmoney_18 = false
local store_getmoney_19 = false
local store_getmoney_20 = false
local store_getmoney_21 = false
local store_crack_1 = true
local store_crack_2 = true
local store_crack_3 = true
local store_crack_4 = true
local store_crack_5 = true
local store_crack_6 = true
local store_crack_7 = true
local store_crack_8 = true
local store_crack_9 = true
local store_crack_10 = true
local store_crack_11 = true
local store_crack_12 = true
local store_crack_13 = true
local store_crack_14 = true
local store_crack_15 = true
local store_crack_16 = true
local store_crack_17 = true
local store_crack_18 = true
local store_crack_19 = true
local store_crack_20 = true
local store_crack_21 = true
local store_safe_1 = false
local store_safe_2 = false
local store_safe_3 = false
local store_safe_4 = false
local store_safe_5 = false
local store_safe_6 = false
local store_safe_7 = false
local store_safe_8 = false
local store_safe_9 = false
local store_safe_10 = false
local store_safe_11 = false
local store_safe_12 = false
local store_safe_13 = false
local store_safe_14 = false
local store_safe_15 = false
local store_safe_16 = false
local store_safe_17 = false
local store_safe_18 = false
local store_safe_19 = false
local store_safe_20 = false
local store_safe_21 = false



function GetClosestPlayers(targetVector,dist)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local plyCoords = targetVector
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(distance < dist) then
				valueID = GetPlayerServerId(value)
				closestplayers[#closestplayers+1]= valueID
				closestdistance[#closestdistance+1]= distance
				closestcoords[#closestcoords+1]= {targetCoords["x"], targetCoords["y"], targetCoords["z"]}

			end
		end
	end
	return closestplayers, closestdistance, closestcoords
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+10]= i
        end
    end

    return players
end



RegisterNetEvent('dark-storerob:stores:store_safe_1')
AddEventHandler('dark-storerob:stores:store_safe_1', function()
if store_safe_1 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_1 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_1 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_1')
                    store_crack_1 = false
                    store_safe_1 = true
                end,
                function() -- failure
                    store_cracked_1 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_1 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_2')
AddEventHandler('dark-storerob:stores:store_safe_2', function()
if store_safe_2 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_2 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_2 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_2')
                    store_crack_2 = false
                    store_safe_2 = true
                end,
                function() -- failure
                    store_cracked_2 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_2 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_3')
AddEventHandler('dark-storerob:stores:store_safe_3', function()
if store_safe_3 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_3 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_3 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_3')
                    store_crack_3 = false
                    store_safe_3 = true
                end,
                function() -- failure
                    store_cracked_3 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_3 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_4')
AddEventHandler('dark-storerob:stores:store_safe_4', function()
if store_safe_4 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_4 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_4 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_4')
                    store_crack_4 = false
                    store_safe_4 = true
                end,
                function() -- failure
                    store_cracked_4 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_4 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_5')
AddEventHandler('dark-storerob:stores:store_safe_5', function()
if store_safe_5 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_5 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_5 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_5')
                    store_crack_5 = false
                    store_safe_5 = true
                end,
                function() -- failure
                    store_cracked_5 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_5 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_6')
AddEventHandler('dark-storerob:stores:store_safe_6', function()
if store_safe_6 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_6 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_6 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_6')
                    store_crack_6 = false
                    store_safe_6 = true
                end,
                function() -- failure
                    store_cracked_6 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_6 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_7')
AddEventHandler('dark-storerob:stores:store_safe_7', function()
if store_safe_7 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_7 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_7 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_7')
                    store_crack_7 = false
                    store_safe_7 = true
                end,
                function() -- failure
                    store_cracked_7 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_7 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_8')
AddEventHandler('dark-storerob:stores:store_safe_8', function()
if store_safe_8 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_8 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_8 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_8')
                    store_crack_8 = false
                    store_safe_8 = true
                end,
                function() -- failure
                    store_cracked_8 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_8 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_9')
AddEventHandler('dark-storerob:stores:store_safe_9', function()
if store_safe_9 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_9 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_9 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_9')
                    store_crack_9 = false
                    store_safe_9 = true
                end,
                function() -- failure
                    store_cracked_9 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_9 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_10')
AddEventHandler('dark-storerob:stores:store_safe_10', function()
if store_safe_10 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_10 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_10 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_10')
                    store_crack_10 = false
                    store_safe_10 = true
                end,
                function() -- failure
                    store_cracked_10 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_10 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_11')
AddEventHandler('dark-storerob:stores:store_safe_11', function()
if store_safe_11 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_11 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_11 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_11')
                    store_crack_11 = false
                    store_safe_11 = true
                end,
                function() -- failure
                    store_cracked_11 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_11 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_12')
AddEventHandler('dark-storerob:stores:store_safe_12', function()
if store_safe_12 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_12 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_12 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_12')
                    store_crack_12 = false
                    store_safe_12 = true
                end,
                function() -- failure
                    store_cracked_12 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_12 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_13')
AddEventHandler('dark-storerob:stores:store_safe_13', function()
if store_safe_13 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_13 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_13 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_13')
                    store_crack_13 = false
                    store_safe_13 = true
                end,
                function() -- failure
                    store_cracked_13 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_13 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_14')
AddEventHandler('dark-storerob:stores:store_safe_14', function()
if store_safe_14 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_14 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_14 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_14')
                    store_crack_14 = false
                    store_safe_14 = true
                end,
                function() -- failure
                    store_cracked_14 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_14 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_15')
AddEventHandler('dark-storerob:stores:store_safe_15', function()
if store_safe_15 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_15 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_15 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_15')
                    store_crack_15 = false
                    store_safe_15 = true
                end,
                function() -- failure
                    store_cracked_15 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_15 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_16')
AddEventHandler('dark-storerob:stores:store_safe_16', function()
if store_safe_16 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_16 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_16 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_16')
                    store_crack_16 = false
                    store_safe_16 = true
                end,
                function() -- failure
                    store_cracked_16 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_16 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_17')
AddEventHandler('dark-storerob:stores:store_safe_17', function()
if store_safe_17 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_17 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_17 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_17')
                    store_crack_17 = false
                    store_safe_17 = true
                end,
                function() -- failure
                    store_cracked_17 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_17 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_18')
AddEventHandler('dark-storerob:stores:store_safe_18', function()
if store_safe_18 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_18 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_18 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_18')
                    store_crack_18 = false
                    store_safe_18 = true
                end,
                function() -- failure
                    store_cracked_18 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_18 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_19')
AddEventHandler('dark-storerob:stores:store_safe_19', function()
if store_safe_19 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_19 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_19 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_19')
                    store_crack_19 = false
                    store_safe_19 = true
                end,
                function() -- failure
                    store_cracked_19 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_19 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_20')
AddEventHandler('dark-storerob:stores:store_safe_20', function()
if store_safe_20 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_20 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_20 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_20')
                    store_crack_20 = false
                    store_safe_20 = true
                end,
                function() -- failure
                    store_cracked_20 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_20 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_21')
AddEventHandler('dark-storerob:stores:store_safe_21', function()
if store_safe_21 == false then
    local police = exports["isPed"]:isPed("countpolice")
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    if police >= 0 then
        if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
            if store_crack_21 == true then
                TriggerEvent("np-dispatch:storerobbery")
                exports["memorygame"]:thermiteminigame(5, 2, 3, 5,
                function() -- success
                    store_cracked_21 = true
                    TriggerEvent('dark-storerob:stores:store_attemptSafe_21')
                    store_crack_21 = false
                    store_safe_21 = true
                end,
                function() -- failure
                    store_cracked_21 = false
                    TriggerEvent('inventory:removeItem', 'safecrackingkit', 1) 
                    store_safe_21 = false
                end)
            end
        else
            TriggerEvent("DoLongHudText","Something is mising!",2)
        end
    else
        TriggerEvent("DoLongHudText","Not enough cops around",2)
    end
else
    TriggerEvent("DoLongHudText","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_openSafe_1')
AddEventHandler('dark-storerob:stores:store_openSafe_1', function()
    if store_getmoney_1 == true then
        local random = math.random(144, 242)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_1 = false
        Wait(1800000)
        store_getmoney_1 = true
           store_cracked_1 = false
           store_crack_1 = true
           Wait(1000000) -- cooldown
           store_safe_1 = false
           store_crack_1 = true
           store_cracked_1 = false
           store_getmoney_1 = false
        Wait(1800000)
        store_getmoney_1 = true
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_2')
AddEventHandler('dark-storerob:stores:store_openSafe_2', function()
    if store_getmoney_2 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_2 = false
           store_cracked_2 = false
           store_crack_2 = true
           Wait(1000000) -- cooldown
           store_safe_2 = false
           store_crack_2 = true
           store_cracked_2 = false
           store_getmoney_2 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_3')
AddEventHandler('dark-storerob:stores:store_openSafe_3', function()
    if store_getmoney_3 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_3 = false
           store_cracked_3 = false
           store_crack_3 = true
           Wait(1000000) -- cooldown
           store_safe_3 = false
           store_crack_3 = true
           store_cracked_3 = false
           store_getmoney_3 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_4')
AddEventHandler('dark-storerob:stores:store_openSafe_4', function()
    if store_getmoney_4 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_4 = false
           store_cracked_4 = false
           store_crack_4 = true
           Wait(1000000) -- cooldown
           store_safe_4 = false
           store_crack_4 = true
           store_cracked_4 = false
           store_getmoney_4 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_5')
AddEventHandler('dark-storerob:stores:store_openSafe_5', function()
    if store_getmoney_5 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_5 = false
           store_cracked_5 = false
           store_crack_5 = true
           Wait(1000000) -- cooldown
           store_safe_5 = false
           store_crack_5 = true
           store_cracked_5 = false
           store_getmoney_5 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_6')
AddEventHandler('dark-storerob:stores:store_openSafe_6', function()
    if store_getmoney_6 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_6 = false
           store_cracked_6 = false
           store_crack_6 = true
           Wait(1000000) -- cooldown
           store_safe_6 = false
           store_crack_6 = true
           store_cracked_6 = false
           store_getmoney_6 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_7')
AddEventHandler('dark-storerob:stores:store_openSafe_7', function()
    if store_getmoney_7 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_7 = false
           store_cracked_7 = false
           store_crack_7 = true
           Wait(1000000) -- cooldown
           store_safe_7 = false
           store_crack_7 = true
           store_cracked_7 = false
           store_getmoney_7 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_8')
AddEventHandler('dark-storerob:stores:store_openSafe_8', function()
    if store_getmoney_8 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_8 = false
           store_cracked_8 = false
           store_crack_8 = true
           Wait(1000000) -- cooldown
           store_safe_8 = false
           store_crack_8 = true
           store_cracked_8 = false
           store_getmoney_8 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_9')
AddEventHandler('dark-storerob:stores:store_openSafe_9', function()
    if store_getmoney_9 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_9 = false
           store_cracked_9 = false
           store_crack_9 = true
           Wait(1000000) -- cooldown
           store_safe_9 = false
           store_crack_9 = true
           store_cracked_9 = false
           store_getmoney_9 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_10')
AddEventHandler('dark-storerob:stores:store_openSafe_10', function()
    if store_getmoney_10 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_10 = false
           store_cracked_10 = false
           store_crack_10 = true
           Wait(1000000) -- cooldown
           store_safe_10 = false
           store_crack_10 = true
           store_cracked_10 = false
           store_getmoney_10 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_11')
AddEventHandler('dark-storerob:stores:store_openSafe_11', function()
    if store_getmoney_11 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_11 = false
           store_cracked_11 = false
           store_crack_11 = true
           Wait(1000000) -- cooldown
           store_safe_11 = false
           store_crack_11 = true
           store_cracked_11 = false
           store_getmoney_11 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_12')
AddEventHandler('dark-storerob:stores:store_openSafe_12', function()
    if store_getmoney_12 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_12 = false
           store_cracked_12 = false
           store_crack_12 = true
           Wait(1000000) -- cooldown
           store_safe_12 = false
           store_crack_12 = true
           store_cracked_12 = false
           store_getmoney_12 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_13')
AddEventHandler('dark-storerob:stores:store_openSafe_13', function()
    if store_getmoney_13 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_13 = false
           store_cracked_13 = false
           store_crack_13 = true
           Wait(1000000) -- cooldown
           store_safe_13 = false
           store_crack_13 = true
           store_cracked_13 = false
           store_getmoney_13 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_14')
AddEventHandler('dark-storerob:stores:store_openSafe_14', function()
    if store_getmoney_14 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_14 = false
           store_cracked_14 = false
           store_crack_14 = true
           Wait(1000000) -- cooldown
           store_safe_14 = false
           store_crack_14 = true
           store_cracked_14 = false
           store_getmoney_14 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_15')
AddEventHandler('dark-storerob:stores:store_openSafe_15', function()
    if store_getmoney_15 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_15 = false
           store_cracked_15 = false
           store_crack_15 = true
           Wait(1000000) -- cooldown
           store_safe_15 = false
           store_crack_15 = true
           store_cracked_15 = false
           store_getmoney_15 = false
    else
        TriggerEvent("DoLongHudText", "You could not crack the password!" ,2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_16')
AddEventHandler('dark-storerob:stores:store_openSafe_16', function()
    if store_getmoney_16 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_16 = false
           store_cracked_16 = false
           store_crack_16 = true
           Wait(1000000) -- cooldown
           store_safe_16 = false
           store_crack_16 = true
           store_cracked_16 = false
           store_getmoney_16 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_17')
AddEventHandler('dark-storerob:stores:store_openSafe_17', function()
    if store_getmoney_17 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_17 = false
           store_cracked_17 = false
           store_crack_17 = true
           Wait(1000000) -- cooldown
           store_safe_17 = false
           store_crack_17 = true
           store_cracked_17 = false
           store_getmoney_17 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_18')
AddEventHandler('dark-storerob:stores:store_openSafe_18', function()
    if store_getmoney_18 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_18 = false
           store_cracked_18 = false
           store_crack_18 = true
           Wait(1000000) -- cooldown
           store_safe_18 = false
           store_crack_18 = true
           store_cracked_18 = false
           store_getmoney_18 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_19')
AddEventHandler('dark-storerob:stores:store_openSafe_19', function()
    if store_getmoney_19 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_19 = false
           store_cracked_19 = false
           store_crack_19 = true
           Wait(1000000) -- cooldown
           store_safe_19 = false
           store_crack_19 = true
           store_cracked_19 = false
           store_getmoney_19 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_20')
AddEventHandler('dark-storerob:stores:store_openSafe_20', function()
    if store_getmoney_20 == true then
        local random = math.random(24, 42)
        local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
        local missionplayers = {}
        local ply = PlayerId()
    
        for i = 1, #closePlayers, 1 do
            if closePlayers[i] ~= ply then
                table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
            end
        end
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_20 = false
           store_cracked_20 = false
           store_crack_20 = true
           Wait(1000000) -- cooldown
           store_safe_20 = false
           store_crack_20 = true
           store_cracked_20 = false
           store_getmoney_20 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_21')
AddEventHandler('dark-storerob:stores:store_openSafe_21', function()
    if store_getmoney_21 == true then
        local random = math.random(24, 42)
        local markedbills = math.random(5, 7)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'rollcash', random)
           TriggerEvent('player:receiveItem', 'markedbills', markedbills) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_21 = false
           store_cracked_21 = false
           store_crack_21 = true
           Wait(1000000) -- cooldown
           store_safe_21 = false
           store_crack_21 = true
           store_cracked_21 = false
           store_getmoney_21 = false
    else
        TriggerEvent("DoLongHudText","You could not crack the password!",2)
    end
end)



RegisterNetEvent('dark-storerob:stores:store_attemptSafe_1', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_1 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_1 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_2', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_2 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_2 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_3', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_3 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_3 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_4', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_4 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_4 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_5', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_5 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_5 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_6', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_6 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_6 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_7', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_7 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_7 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_8', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_8 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_8 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_9', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_9 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_9 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_10', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_10 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_10 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_11', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_11 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_11 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_12', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_12 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_12 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_13', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_13 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_13 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_14', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_14 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_14 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_15', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_15 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_15 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_16', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_16 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_16 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_17', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_17 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_17 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_18', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_18 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_18 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_19', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_19 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_19 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)


RegisterNetEvent('dark-storerob:stores:store_attemptSafe_20', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_20 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_20 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent('dark-storerob:stores:store_attemptSafe_21', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_21 then
                TriggerEvent("DoLongHudText","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_21 = true
                TriggerEvent("DoLongHudText","Grab the money!",1)
                break
            end
        end
    end)
end)

RegisterNetEvent("np-heists:safe:rob", function()
    local policecount = exports["isPed"]:isPed("countpolice")
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    local networkId = NetworkGetNetworkIdFromEntity(obj)
    local isRobbed = RPC.execute("checkIfRobbed", networkId)
    if isRobbed then
        TriggerEvent("DoLongHudText", "This safe is already robbed!")
        return
    end
    if policecount >= 1 then
        if GetEntityHealth(obj) < 800 then
            local finished = exports["np-ui"]:taskBarSkill(25000, math.random(10, 20))
            if (finished == 100) then
                TriggerEvent("np-dispatch:storerobbery")
                local finished = exports["np-ui"]:taskBarSkill(30000, math.random(10, 20))
                if (finished == 100) then
                    TriggerEvent("np-dispatch:storerobbery")
                    ClearPedTasks(PlayerPedId())
                    -- TriggerServerEvent("bank:cashbal")
                    TriggerServerEvent('dark-storerob:stores:giveMoney')
                    RPC.execute("robbedNow", networkId)
                else
                    TriggerEvent("DoLongHudText", "Locked!", 2)
                end
            else
                TriggerEvent("DoLongHudText", "Failed Attempt", 2)
            end
        else
            TriggerEvent("DoLongHudText", "Locked!", 2)
        end
    
    else
        TriggerEvent("DoLongHudText", "Not enough cops", 2)
    end
end)