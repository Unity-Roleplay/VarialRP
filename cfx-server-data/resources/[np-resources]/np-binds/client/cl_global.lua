local isHandcuffed, isSoftCuffed = false, false

RegisterNetEvent("police:currentHandCuffedState")
AddEventHandler("police:currentHandCuffedState", function(pIsHandcuffed, pIsHandcuffedAndWalking)
    isHandcuffed = pIsHandcuffed
    isSoftCuffed = pIsHandcuffedAndWalking
end)

-- Binds that are used globaly and do not fit in a single resouce
-- All Binds should use the event name and bool

Citizen.CreateThread(function()

    RegisterCommand('+showPlayerList', function() end, false)
    RegisterCommand('-showPlayerList', function() end, false)
    exports["np-binds"]:registerKeyMapping("PlayerList", "Player", "View Online Players", "+showPlayerList", "-showPlayerList", "U", true)

    RegisterCommand('+generalUse', function() end, false)
    RegisterCommand('-generalUse', function() end, false)
    exports["np-binds"]:registerKeyMapping("general", "Player", "General Use", "+generalUse", "-generalUse", "E", true)

    RegisterCommand('+housingMain', function() end, false)
    RegisterCommand('-housingMain', function() end, false)
    exports["np-binds"]:registerKeyMapping("housingMain", "Housing", "Housing Main", "+housingMain", "-housingMain", "H", true)

    RegisterCommand('+housingSecondary', function() end, false)
    RegisterCommand('-housingSecondary', function() end, false)
    exports["np-binds"]:registerKeyMapping("housingSecondary", "Housing", "Housing Secondary", "+housingSecondary", "-housingSecondary", "G", true)

    RegisterCommand('+generalUseThird', function() end, false)
    RegisterCommand('-generalUseThird', function() end, false)
    exports["np-binds"]:registerKeyMapping("generalUseThird", "Player", "General Use Third", "+generalUseThird", "-generalUseThird", "G", true)

    -- exports["np-binds"]:registerKeyMapping("", "Radio", "Open", "+handheld", "-handheld", ";")
    -- RegisterCommand('+handheld', handheld, false)
    -- RegisterCommand('-handheld', function() end, false)
    
    --[[exports["np-binds"]:registerKeyMapping("", "Phone", "Open", "+generalPhone", "-generalPhone", "P")
    RegisterCommand('+generalPhone', generalPhone, false)
    RegisterCommand('-generalPhone', function() end, false)]]
    
    exports["np-binds"]:registerKeyMapping("", "Inventory", "Open", "+generalInventory", "-generalInventory", "K")
    RegisterCommand('+generalInventory', generalInventory, false)
    RegisterCommand('-generalInventory', function() end, false)
    
    -- exports["np-binds"]:registerKeyMapping("", "Player", "Escape menu", "+generalEscapeMenu", "-generalEscapeMenu", "ESCAPE")
    -- RegisterCommand('+generalEscapeMenu', generalEscapeMenu, false)
    -- RegisterCommand('-generalEscapeMenu', function() end, false)
end)

Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do

        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        -- HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(15)
        --HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        -- HideHudComponentThisFrame(21)
        -- HideHudComponentThisFrame(22)

        HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
        DisableControlAction(0, 37, true)
        
        HideMinimapInteriorMapThisFrame()
        SetRadarZoom(1100)

        Citizen.Wait(0)
    end
end)

-- No idle cams
Citizen.CreateThread(function()
    while true do
        InvalidateIdleCam()
        N_0x9e4cfff989258472() -- Disable the vehicle idle camera
        Wait(10000) --The idle camera activates after 30 second so we don't need to call this per frame
    end 
end)

function handheld() 
if not insidePrompt and not focusTaken then
        TriggerEvent("radioGui")
    end
end
  
function generalPhone()
    if exports["np-inventory"]:hasEnoughOfItem("mobilephone",1,false) then 
        if not isHandcuffed and not isSoftCuffed then
            if not exports["isPed"]:isPed("dead") then
                TriggerEvent("phoneGui2")
            else
                TriggerEvent("DoLongHudText" ,'You are unconcious. You can not communicate.', 2)
            end
        else
            TriggerEvent("DoLongHudText" ,'What are you trying to do bro you are in cuffs!', 2)
        end
    else
        TriggerEvent("DoLongHudText" ,'You do not have a phone. You can not communicate.', 2)
    end
end

function generalInventory()
    if not insidePrompt and not inventoryDisabled and not focusTaken then
        TriggerEvent("inventory-open-request")
    end
end