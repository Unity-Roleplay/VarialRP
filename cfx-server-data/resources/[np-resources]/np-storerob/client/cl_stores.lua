ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end 
end)

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


RegisterNetEvent('dark-storerob:stores:store_safe_1')
AddEventHandler('dark-storerob:stores:store_safe_1', function()
if store_safe_1 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_1 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_1 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_1')
                store_crack_1 = false
                store_safe_1 = true
            end,
            function() -- failure
                store_cracked_1 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_1 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_2')
AddEventHandler('dark-storerob:stores:store_safe_2', function()
if store_safe_2 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_2 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_2 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_2')
                store_crack_2 = false
                store_safe_2 = true
            end,
            function() -- failure
                store_cracked_2 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_2 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_3')
AddEventHandler('dark-storerob:stores:store_safe_3', function()
if store_safe_3 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_3 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_3 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_3')
                store_crack_3 = false
                store_safe_3 = true
            end,
            function() -- failure
                store_cracked_3 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_3 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_4')
AddEventHandler('dark-storerob:stores:store_safe_4', function()
if store_safe_4 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_4 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_4 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_4')
                store_crack_4 = false
                store_safe_4 = true
            end,
            function() -- failure
                store_cracked_4 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_4 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_5')
AddEventHandler('dark-storerob:stores:store_safe_5', function()
if store_safe_5 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_5 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_5 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_5')
                store_crack_5 = false
                store_safe_5 = true
            end,
            function() -- failure
                store_cracked_5 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_5 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_6')
AddEventHandler('dark-storerob:stores:store_safe_6', function()
if store_safe_6 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_6 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_6 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_6')
                store_crack_6 = false
                store_safe_6 = true
            end,
            function() -- failure
                store_cracked_6 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_6 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_7')
AddEventHandler('dark-storerob:stores:store_safe_7', function()
if store_safe_7 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_7 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_7 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_7')
                store_crack_7 = false
                store_safe_7 = true
            end,
            function() -- failure
                store_cracked_7 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_7 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_8')
AddEventHandler('dark-storerob:stores:store_safe_8', function()
if store_safe_8 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_8 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_8 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_8')
                store_crack_8 = false
                store_safe_8 = true
            end,
            function() -- failure
                store_cracked_8 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_8 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_9')
AddEventHandler('dark-storerob:stores:store_safe_9', function()
if store_safe_9 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_9 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_9 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_9')
                store_crack_9 = false
                store_safe_9 = true
            end,
            function() -- failure
                store_cracked_9 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_9 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_10')
AddEventHandler('dark-storerob:stores:store_safe_10', function()
if store_safe_10 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_10 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_10 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_10')
                store_crack_10 = false
                store_safe_10 = true
            end,
            function() -- failure
                store_cracked_10 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_10 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_11')
AddEventHandler('dark-storerob:stores:store_safe_11', function()
if store_safe_11 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_11 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_11 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_11')
                store_crack_11 = false
                store_safe_11 = true
            end,
            function() -- failure
                store_cracked_11 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_11 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_12')
AddEventHandler('dark-storerob:stores:store_safe_12', function()
if store_safe_12 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_12 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_12 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_12')
                store_crack_12 = false
                store_safe_12 = true
            end,
            function() -- failure
                store_cracked_12 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_12 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_13')
AddEventHandler('dark-storerob:stores:store_safe_13', function()
if store_safe_13 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_13 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_13 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_13')
                store_crack_13 = false
                store_safe_13 = true
            end,
            function() -- failure
                store_cracked_13 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_13 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_14')
AddEventHandler('dark-storerob:stores:store_safe_14', function()
if store_safe_14 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_14 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_14 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_14')
                store_crack_14 = false
                store_safe_14 = true
            end,
            function() -- failure
                store_cracked_14 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_14 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_15')
AddEventHandler('dark-storerob:stores:store_safe_15', function()
if store_safe_15 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_15 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_15 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_15')
                print(random)
                store_crack_15 = false
                store_safe_15 = true
            end,
            function() -- failure
                store_cracked_15 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_15 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_16')
AddEventHandler('dark-storerob:stores:store_safe_16', function()
if store_safe_16 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_16 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_16 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_16')
                store_crack_16 = false
                store_safe_16 = true
            end,
            function() -- failure
                store_cracked_16 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_16 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_17')
AddEventHandler('dark-storerob:stores:store_safe_17', function()
if store_safe_17 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_17 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_17 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_17')
                store_crack_17 = false
                store_safe_17 = true
            end,
            function() -- failure
                store_cracked_17 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_17 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_18')
AddEventHandler('dark-storerob:stores:store_safe_18', function()
if store_safe_18 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_18 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_18 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_18')
                store_crack_18 = false
                store_safe_18 = true
            end,
            function() -- failure
                store_cracked_18 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_18 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_19')
AddEventHandler('dark-storerob:stores:store_safe_19', function()
if store_safe_19 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_19 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_19 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_19')
                store_crack_19 = false
                store_safe_19 = true
            end,
            function() -- failure
                store_cracked_19 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_19 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_20')
AddEventHandler('dark-storerob:stores:store_safe_20', function()
if store_safe_20 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_20 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_20 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_20')
                store_crack_20 = false
                store_safe_20 = true

            end,
            function() -- failure
                store_cracked_20 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_20 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_safe_21')
AddEventHandler('dark-storerob:stores:store_safe_21', function()
if store_safe_21 == false then
    if exports["np-inventory"]:hasEnoughOfItem("safecrackingkit", 1) then
        if store_crack_21 == true then
            exports["np-memory"]:thermiteminigame(1, 1, 1, 1,
            function() -- success
                store_cracked_21 = true
                TriggerEvent('dark-storerob:stores:store_attemptSafe_21')
                store_crack_1 = false
                store_safe_21 = true
            end,
            function() -- failure
                store_cracked_21 = false
                TriggerEvent('inventory:removeItem', 'safecrackingkit', random) 
                store_safe_21 = false
            end)
        end
    else
        TriggerEvent("notification","Something is mising!",2)
    end
else
    TriggerEvent("notification","This place is robbed or cracked!",2)
end
end)

RegisterNetEvent('dark-storerob:stores:store_openSafe_1')
AddEventHandler('dark-storerob:stores:store_openSafe_1', function()
    if store_getmoney_1 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_1 = false
        Wait(1800000)
        store_getmoney_1 = true
           store_cracked_1 = false
           store_crack_1 = true
           Wait(20000) -- cooldown
           store_safe_1 = false
           store_crack_1 = true
           store_cracked_1 = false
           store_getmoney_1 = false
        Wait(1800000)
        store_getmoney_1 = true
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_2')
AddEventHandler('dark-storerob:stores:store_openSafe_2', function()
    if store_getmoney_2 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_2 = false
           store_cracked_2 = false
           store_crack_2 = true
           Wait(20000) -- cooldown
           store_safe_2 = false
           store_crack_2 = true
           store_cracked_2 = false
           store_getmoney_2 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_3')
AddEventHandler('dark-storerob:stores:store_openSafe_3', function()
    if store_getmoney_3 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_3 = false
           store_cracked_3 = false
           store_crack_3 = true
           Wait(20000) -- cooldown
           store_safe_3 = false
           store_crack_3 = true
           store_cracked_3 = false
           store_getmoney_3 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_4')
AddEventHandler('dark-storerob:stores:store_openSafe_4', function()
    if store_getmoney_4 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_4 = false
           store_cracked_4 = false
           store_crack_4 = true
           Wait(20000) -- cooldown
           store_safe_4 = false
           store_crack_4 = true
           store_cracked_4 = false
           store_getmoney_4 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_5')
AddEventHandler('dark-storerob:stores:store_openSafe_5', function()
    if store_getmoney_5 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_5 = false
           store_cracked_5 = false
           store_crack_5 = true
           Wait(20000) -- cooldown
           store_safe_5 = false
           store_crack_5 = true
           store_cracked_5 = false
           store_getmoney_5 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_6')
AddEventHandler('dark-storerob:stores:store_openSafe_6', function()
    if store_getmoney_6 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_6 = false
           store_cracked_6 = false
           store_crack_6 = true
           Wait(20000) -- cooldown
           store_safe_6 = false
           store_crack_6 = true
           store_cracked_6 = false
           store_getmoney_6 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_7')
AddEventHandler('dark-storerob:stores:store_openSafe_7', function()
    if store_getmoney_7 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_7 = false
           store_cracked_7 = false
           store_crack_7 = true
           Wait(20000) -- cooldown
           store_safe_7 = false
           store_crack_7 = true
           store_cracked_7 = false
           store_getmoney_7 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_8')
AddEventHandler('dark-storerob:stores:store_openSafe_8', function()
    if store_getmoney_8 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_8 = false
           store_cracked_8 = false
           store_crack_8 = true
           Wait(20000) -- cooldown
           store_safe_8 = false
           store_crack_8 = true
           store_cracked_8 = false
           store_getmoney_8 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_9')
AddEventHandler('dark-storerob:stores:store_openSafe_9', function()
    if store_getmoney_9 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_9 = false
           store_cracked_9 = false
           store_crack_9 = true
           Wait(20000) -- cooldown
           store_safe_9 = false
           store_crack_9 = true
           store_cracked_9 = false
           store_getmoney_9 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_10')
AddEventHandler('dark-storerob:stores:store_openSafe_10', function()
    if store_getmoney_10 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_10 = false
           store_cracked_10 = false
           store_crack_10 = true
           Wait(20000) -- cooldown
           store_safe_10 = false
           store_crack_10 = true
           store_cracked_10 = false
           store_getmoney_10 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_11')
AddEventHandler('dark-storerob:stores:store_openSafe_11', function()
    if store_getmoney_11 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_11 = false
           store_cracked_11 = false
           store_crack_11 = true
           Wait(20000) -- cooldown
           store_safe_11 = false
           store_crack_11 = true
           store_cracked_11 = false
           store_getmoney_11 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_12')
AddEventHandler('dark-storerob:stores:store_openSafe_12', function()
    if store_getmoney_12 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_12 = false
           store_cracked_12 = false
           store_crack_12 = true
           Wait(20000) -- cooldown
           store_safe_12 = false
           store_crack_12 = true
           store_cracked_12 = false
           store_getmoney_12 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_13')
AddEventHandler('dark-storerob:stores:store_openSafe_13', function()
    if store_getmoney_13 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_13 = false
           store_cracked_13 = false
           store_crack_13 = true
           Wait(20000) -- cooldown
           store_safe_13 = false
           store_crack_13 = true
           store_cracked_13 = false
           store_getmoney_13 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_14')
AddEventHandler('dark-storerob:stores:store_openSafe_14', function()
    if store_getmoney_14 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_14 = false
           store_cracked_14 = false
           store_crack_14 = true
           Wait(20000) -- cooldown
           store_safe_14 = false
           store_crack_14 = true
           store_cracked_14 = false
           store_getmoney_14 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_15')
AddEventHandler('dark-storerob:stores:store_openSafe_15', function()
    if store_getmoney_15 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_15 = false
           store_cracked_15 = false
           store_crack_15 = true
           Wait(20000) -- cooldown
           store_safe_15 = false
           store_crack_15 = true
           store_cracked_15 = false
           store_getmoney_15 = false
    else
        TriggerEvent("notification", "You could not crack the password!" ,2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_16')
AddEventHandler('dark-storerob:stores:store_openSafe_16', function()
    if store_getmoney_16 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_16 = false
           store_cracked_16 = false
           store_crack_16 = true
           Wait(20000) -- cooldown
           store_safe_16 = false
           store_crack_16 = true
           store_cracked_16 = false
           store_getmoney_16 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_17')
AddEventHandler('dark-storerob:stores:store_openSafe_17', function()
    if store_getmoney_17 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_17 = false
           store_cracked_17 = false
           store_crack_17 = true
           Wait(20000) -- cooldown
           store_safe_17 = false
           store_crack_17 = true
           store_cracked_17 = false
           store_getmoney_17 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_18')
AddEventHandler('dark-storerob:stores:store_openSafe_18', function()
    if store_getmoney_18 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_18 = false
           store_cracked_18 = false
           store_crack_18 = true
           Wait(20000) -- cooldown
           store_safe_18 = false
           store_crack_18 = true
           store_cracked_18 = false
           store_getmoney_18 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_19')
AddEventHandler('dark-storerob:stores:store_openSafe_19', function()
    if store_getmoney_19 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_19 = false
           store_cracked_19 = false
           store_crack_19 = true
           Wait(20000) -- cooldown
           store_safe_19 = false
           store_crack_19 = true
           store_cracked_19 = false
           store_getmoney_19 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_20')
AddEventHandler('dark-storerob:stores:store_openSafe_20', function()
    if store_getmoney_20 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_20 = false
           store_cracked_20 = false
           store_crack_20 = true
           Wait(20000) -- cooldown
           store_safe_20 = false
           store_crack_20 = true
           store_cracked_20 = false
           store_getmoney_20 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)


RegisterNetEvent('dark-storerob:stores:store_openSafe_21')
AddEventHandler('dark-storerob:stores:store_openSafe_21', function()
    if store_getmoney_21 == true then
        local random = math.random(24, 42)
        ClearPedTasks(PlayerPedId())
           TriggerEvent('player:receiveItem', 'markedbills', random) 
           ClearPedTasks(PlayerPedId())
           store_getmoney_21 = false
           store_cracked_21 = false
           store_crack_21 = true
           Wait(20000) -- cooldown
           store_safe_21 = false
           store_crack_21 = true
           store_cracked_21 = false
           store_getmoney_21 = false
    else
        TriggerEvent("notification","You could not crack the password!",2)
    end
end)



RegisterNetEvent('dark-storerob:stores:store_attemptSafe_1', function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(500)
            if store_cracked_1 then
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_1 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_2 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_3 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_4 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_5 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_6 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_7 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_8 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_9 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_10 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_11 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_12 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_13 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_14 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_15 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_16 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_17 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_18 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_19 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_20 = true
                TriggerEvent("notification","Grab the money!",1)
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
                TriggerEvent("notification","You should wait!",1)
                Citizen.Wait(8000)
                store_getmoney_21 = true
                TriggerEvent("notification","Grab the money!",1)
                break
            end
        end
    end)
end)


local safe_robbed_1 = true
local safe_robbed_1s = true
local safe_robbed_2 = true
local safe_robbed_2s = true
local safe_robbed_3 = true
local safe_robbed_4 = true
local safe_robbed_4s = true
local safe_robbed_5 = true
local safe_robbed_6 = true
local safe_robbed_6s = true
local safe_robbed_7 = true
local safe_robbed_7s = true
local safe_robbed_8 = true
local safe_robbed_8s = true
local safe_robbed_9 = true
local safe_robbed_10 = true
local safe_robbed_10s = true
local safe_robbed_11 = true
local safe_robbed_11s = true
local safe_robbed_12 = true
local safe_robbed_12s = true
local safe_robbed_13 = true
local safe_robbed_13s = true
local safe_robbed_14 = true
local safe_robbed_15 = true
local safe_robbed_16 = true
local safe_robbed_16s = true
local safe_robbed_17 = true
local safe_robbed_17s = true
local safe_robbed_18 = true
local safe_robbed_18s = true
local safe_robbed_19 = true

RegisterNetEvent("dark-storerob:stores:crackwritesafe1", function()
if safe_robbed_1 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_1 = false
        Wait(1800000)
        safe_robbed_1 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe1s", function()
    if safe_robbed_1s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_1s = false
            Wait(1800000)
            safe_robbed_1s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe2", function()
if safe_robbed_2 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_2 = false
        Wait(1800000)
        safe_robbed_2 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe2s", function()
    if safe_robbed_2s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_2s = false
            Wait(1800000)
            safe_robbed_2s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)


RegisterNetEvent("dark-storerob:stores:crackwritesafe3", function()
if safe_robbed_3 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_3 = false
        Wait(1800000)
        safe_robbed_3 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe4", function()
if safe_robbed_4 then
    TaskGoStraightToCoord(PlayerPedId(), -46.35, -1757.81, 29.42, 1.0, -1, 60.77, 0.0)
    Wait(7000)
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_4 = false
        Wait(1800000)
        safe_robbed_4 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe4s", function()
    if safe_robbed_4s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_4s = false
            Wait(1800000)
            safe_robbed_4s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe5", function()
if safe_robbed_5 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_5 = false
        Wait(1800000)
        safe_robbed_5 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe6", function()
if safe_robbed_6 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_6 = false
        Wait(1800000)
        safe_robbed_6 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe6s", function()
    if safe_robbed_6s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_6s = false
            Wait(1800000)
            safe_robbed_6s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe7", function()
if safe_robbed_7 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_7 = false
        Wait(1800000)
        safe_robbed_7 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe7s", function()
    if safe_robbed_7s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_7s = false
            Wait(1800000)
            safe_robbed_7s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe8", function()
if safe_robbed_8 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_8 = false
        Wait(1800000)
        safe_robbed_8 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe8s", function()
    if safe_robbed_8s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_8s = false
            Wait(1800000)
            safe_robbed_8s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe9", function()
if safe_robbed_9 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_9 = false
        Wait(1800000)
        safe_robbed_9 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe10", function()
if safe_robbed_10 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_10 = false
        Wait(1800000)
        safe_robbed_10 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe10s", function()
if safe_robbed_10s then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_10s = false
        Wait(1800000)
        safe_robbed_10s = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe11", function()
if safe_robbed_11 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_11 = false
        Wait(1800000)
        safe_robbed_11 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe11s", function()
if safe_robbed_11s then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_11s = false
        Wait(1800000)
        safe_robbed_11s = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe12", function()
if safe_robbed_12 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_12 = false
        Wait(1800000)
        safe_robbed_12 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe12s", function()
    if safe_robbed_12s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_12s = false
            Wait(1800000)
            safe_robbed_12s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe13", function()
if safe_robbed_13 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_13 = false
        Wait(1800000)
        safe_robbed_13 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe13s", function()
    if safe_robbed_13s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_13s = false
            Wait(1800000)
            safe_robbed_13s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe14", function()
if safe_robbed_14 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_14 = false
        Wait(1800000)
        safe_robbed_14 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe15", function()
if safe_robbed_15 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_15 = false
        Wait(1800000)
        safe_robbed_15 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe16", function()
if safe_robbed_16 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_16 = false
        Wait(1800000)
        safe_robbed_16 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe16", function()
    if safe_robbed_16s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_16s = false
            Wait(1800000)
            safe_robbed_16s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe17", function()
if safe_robbed_17 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_17 = false
        Wait(1800000)
        safe_robbed_17 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe17", function()
    if safe_robbed_17s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_17s = false
            Wait(1800000)
            safe_robbed_17s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe18", function()
if safe_robbed_18 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_18 = false
        Wait(1800000)
        safe_robbed_18 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe18", function()
    if safe_robbed_18s then
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
        if GetEntityHealth(obj) < 800 then
            ClearPedTasks(PlayerPedId())
            TriggerEvent("notification","You should wait!",1)
            Wait(5000)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mission:completed")
            TriggerServerEvent('dark-storerob:stores:giveMoney')
            safe_robbed_18s = false
            Wait(1800000)
            safe_robbed_18s = true
        else
            TriggerEvent("notification","Locked!",2)
        end
    else
        TriggerEvent("notification","Robbed!",2)
    end
    end)

RegisterNetEvent("dark-storerob:stores:crackwritesafe19", function()
if safe_robbed_19 then
    local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.0, 303280717, false, false, false)
    if GetEntityHealth(obj) < 800 then
        ClearPedTasks(PlayerPedId())
        TriggerEvent("notification","You should wait!",1)
        Wait(5000)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent("mission:completed")
        TriggerServerEvent('dark-storerob:stores:giveMoney')
        safe_robbed_19 = false
        Wait(1800000)
        safe_robbed_19 = true
    else
        TriggerEvent("notification","Locked!",2)
    end
else
    TriggerEvent("notification","Robbed!",2)
end
end)