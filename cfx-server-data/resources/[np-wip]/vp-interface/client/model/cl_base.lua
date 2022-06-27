-- CLOSE APP
function SetInterfaceFocus(hasKeyboard, hasMouse)
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetInterfaceFocus', SetInterfaceFocus)

RegisterNUICallback("np-interface:closeApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("np-interface:applicationClosed", function(data, cb)
    TriggerEvent("np-interface:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("np-interface:force-close", function()
    SendInterfaceMessage({source = "np-nui", app = "", show = false});
    SetInterfaceFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("np-interface:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendInterfaceMessage({ source = "np-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("np-interface:restarted")
  SendInterfaceMessage({ app = "hud", data = { display = true }, source = "np-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("np-interface:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("np-interface:server-restart")
AddEventHandler("np-interface:server-restart", restartUI)

RegisterCommand("np-interface:debug:show", function()
    SendInterfaceMessage({ source = "np-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("np-interface:debug:hide", function()
    SendInterfaceMessage({ source = "np-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("np-interface:resetApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("np-interface:server-relay")
AddEventHandler("np-interface:server-relay", function(data)
    SendInterfaceMessage(data)
end)