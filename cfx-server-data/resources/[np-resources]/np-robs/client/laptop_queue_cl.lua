
local purpleLap = false
local orangeLap = false

--- Blip shit ---
blip = nil

function AddOrangeBlip()
    blip = AddBlipForCoord(1401.37, -1490.43, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 47)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

function AddPurpleBlip()
    blip = AddBlipForCoord(509.93, 3098.93, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

--- Purple Tablet ---

RegisterNetEvent('np-robberies:purpleQueue')
AddEventHandler('np-robberies:purpleQueue', function()
    if exports["np-inventory"]:hasEnoughOfItem("purpleusb", 1) then
        TriggerServerEvent('np-robberies:purplelaptopSV')
    else
        TriggerEvent('DoLongHudText', "I don't give work out for free!", 2)
    end
end)

RegisterNetEvent('np-robberies:getPTablet')
AddEventHandler('np-robberies:getPTablet', function()
    Wait(3000)
    TriggerEvent('DoLongHudText', 'Please allow up to 2 hours while we get in contact with our dealer!', 1)
    Citizen.Wait(3.6e+6)
    purpleLap = true
    TriggerEvent('DoLongHudText', 'Head to the location we marked on your gps to pick up the tablet.', 1)
    AddPurpleBlip()
    SetNewWaypoint(509.93, 3098.93)
    Citizen.Wait(3000)
end)

RegisterNetEvent('np-robberies:receivePTablet')
AddEventHandler('np-robberies:receivePTablet', function()
    if purpleLap == true then 
        if exports["np-inventory"]:hasEnoughOfItem("purpleusb", 1) then
            TriggerEvent('inventory:removeItem', 'purpleusb', 1)
            FreezeEntityPosition(PlayerPedId(),true)
            local finished = exports["np-taskbar"]:taskBar(45000,"Waiting for a response...")
            TriggerServerEvent('np-robberies:removeQueuePurple')
            TriggerEvent('player:receiveItem', 'purplelaptop', 1)
            FreezeEntityPosition(PlayerPedId(),false)
            purpleLap = false
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent('DoLongHudText', 'You owe me something in return!', 2)
        end
    end
end)

RegisterNetEvent("np-robberies:leavePurpleQueueClient")
AddEventHandler("np-robberies:leavePurpleQueueClient", function()
    TriggerServerEvent("np-robberies:leavePurpleQueueServer")
end)

--- Orange Tablet ---

RegisterNetEvent('np-robberies:orangeQueue')
AddEventHandler('np-robberies:orangeQueue', function()
    if exports["np-inventory"]:hasEnoughOfItem("orangeusb", 1) then
        TriggerServerEvent('np-robberies:orangelaptopSV')
    else
        TriggerEvent('DoLongHudText', 'You are going to need some tools to start working for us!', 2)
    end
end)

RegisterNetEvent('np-robberies:getOTablet')
AddEventHandler('np-robberies:getOTablet', function()
    Wait(3000)
    TriggerEvent('DoLongHudText', 'Please allow up to 2 hours while we get in contact with our dealer!', 1)
    Citizen.Wait(3.6e+6)
    orangeLap = true
    TriggerEvent('DoLongHudText', 'Head to the location we marked on your gps to pick up the tablet.', 1)
    AddOrangeBlip()
    SetNewWaypoint(1401.37, -1490.43)
    Citizen.Wait(3000)
end)

RegisterNetEvent('np-robberies:receiveOTablet')
AddEventHandler('np-robberies:receiveOTablet', function()
    if orangeLap == true then 
        if exports["np-inventory"]:hasEnoughOfItem("orangeusb", 1) then
            TriggerEvent('inventory:removeItem', 'orangeusb', 1)
            FreezeEntityPosition(PlayerPedId(),true)
            local finished = exports["np-taskbar"]:taskBar(45000,"Waiting for a response...") 
            TriggerServerEvent('np-robberies:removeQueueOrange')
            TriggerEvent('player:receiveItem', 'orangelaptop', 1)
            FreezeEntityPosition(PlayerPedId(),false)
            orangeLap = false
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent('DoLongHudText', 'You owe me something in return!', 2)
        end  
    end
end)

RegisterNetEvent("np-robberies:leaveOrangeQueueClient")
AddEventHandler("np-robberies:leaveOrangeQueueClient", function()
    TriggerServerEvent("np-robberies:leaveOrangeQueueServer")
end)