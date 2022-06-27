LoggedIn = false
 

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    RefreshMenu('All')
    LoggedIn = true
end)
  
AddEventHandler('onResourceStop', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        LoggedIn = false
    end
end)

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "noclip", "No Clip (Devmode)", "+noclip", "-noclip")
    RegisterCommand('+noclip', noclip, false)
    RegisterCommand('-noclip', function() end, false)


    exports["np-keybinds"]:registerKeyMapping("", "adminmenu", "Open Admin Menu", "+openadminfunction", "-openadminfunction")
    RegisterCommand('+openadminfunction', openMenu, false)
    RegisterCommand('-openadminfunction', function() end, false)
end)

-- [ Code ] --

-- [ Mapping ] --

RegisterKeyMapping('adminmenu', 'Open Admin Menu', 'keyboard', 'INSERT')


-- [ Events ] --

RegisterNetEvent('np-admin-AttemptOpen', function(OnPress)
    local Players = GetPlayers()
    SetCursorLocation(0.5, 0.5)
    SetNuiFocus(true, true)
    SendNUIMessage({
        Action = 'Open',
        Debug = Config.MenuDebug,
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end)

RegisterNetEvent('np-admin/client/force-close', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        Action = 'Close',
    })
end)

-- [ NUI Callbacks ] --

RegisterNUICallback('Admin/ToggleFavorite', function(Data, Cb)
    Config.FavoritedItems[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems), "Favorites")
    Cb('Ok')
end)

RegisterNUICallback('Admin/TogglePinnedTarget', function(Data, Cb)
    Config.PinnedTargets[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets), "Targets")
    Cb('Ok')
end)

RegisterNUICallback('Admin/ToggleSetting', function(Data, Cb)
    Config.AdminSettings[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-settings", json.encode(Config.AdminSettings), "Settings")
    Cb('Ok')
end)

RegisterNUICallback('Admin/GetCharData', function(Data, Cb)
    RPC.execute('np-admin/server/get-player-data', function(PlayerData)
        Cb(PlayerData)
    end, Data.License)
end)

RegisterNUICallback("Admin/Close", function(Data, Cb)
   SetNuiFocus(false, false)
   Cb('Ok')
end)

RegisterNUICallback("Admin/DevMode", function(Data, Cb)
    local Bool = Data.Toggle
    if Bool then
        pDevMode = 1
    else
        pDevMode = 0
    end
    ToggleDevMode(Bool)
    Cb('Ok')
end)

RegisterNUICallback('Admin/TriggerAction', function(Data, Cb) 
    -- print(json.encode(Data, Cb))
    if IsPlayerAdmin() then
        if Data.EventType == nil then Data.EventType = 'Client' end
        if Data.Event ~= nil and Data.EventType ~= nil then
            if Data.EventType == 'Client' then
                TriggerEvent(Data.Event, Data.Result)
            else
                TriggerServerEvent(Data.Event, Data.Result)
            end
        end
    end
    Cb('Ok')
end)

function noclip()
    if exports["np-base"]:getModule("LocalPlayer"):getVar("rank") == 'dev' or 'admin' or 'superadmin' or 'mod' or 'owner' then
        if exports['np-admin']:DevMode() then
            TriggerEvent('Admin:Toggle:Noclip')
        end
    end
end

function openMenu()
    if exports["np-base"]:getModule("LocalPlayer"):getVar("rank") == 'dev' or 'admin' or 'superadmin' or 'mod' or 'owner' then
        if exports['np-admin']:DevMode() then
            TriggerEvent('np-admin-AttemptOpen', true) 
        end
    end
end

RegisterCommand('tpm', function()
    if exports["np-base"]:getModule("LocalPlayer"):getVar("rank") == 'dev' or 'admin' or 'superadmin' or 'mod' or 'owner' then
        TriggerEvent('Admin:Teleport:Marker')
    end
end)

RegisterCommand('nc', function()
    if exports["np-base"]:getModule("LocalPlayer"):getVar("rank") == 'dev' or 'admin' or 'superadmin' or 'mod' or 'owner' then
        TriggerEvent('Admin:Toggle:Noclip')
    end
end)

function DevMode()
    if pDevMode == 1 then
      pDevMode = true
    elseif pDevMode == 0 then
      pDevMode = false
    end
    return pDevMode
end