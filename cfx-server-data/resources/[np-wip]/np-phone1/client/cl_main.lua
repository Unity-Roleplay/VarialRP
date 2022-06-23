--[[

    Variables

]]

phoneOpen = false
phoneNotifications = true
local insidePrompt = false
local focusTaken = false
local curhrs = "00"
local curmins = "00"
local weather = ""

--[[

    Functions

]]

function LoadAnimationDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

function openPhone()
    if not phoneOpen and hasPhone() and not insidePrompt and not focusTaken then
        phoneOpen = true

        SetNuiFocus(true, true)
        SendNUIMessage({
            openPhone = true,
            hasDevice = exports["np-inventory"]:hasEnoughOfItem("mk2usbdevice", 1, false),
            hasDecrypt = exports["np-inventory"]:hasEnoughOfItem("decrypterenzo", 1, false) or exports["np-inventory"]:hasEnoughOfItem("decryptersess", 1, false) or exports["np-inventory"]:hasEnoughOfItem("decrypterfv2", 1, false),
            hasDecrypt2 = exports["np-inventory"]:hasEnoughOfItem("vpnxj", 1, false),
            hasTrucker = false,
            isRealEstateAgent = false,
            playerId = exports["np-base"]:getChar("id"),
        })

        SendNUIMessage({
            openSection = "timeheader",
            timestamp = curhrs .. ":" .. curmins,
        })

        LoadAnimationDic("cellphone@")
        TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
        TriggerEvent("attachItemPhone", "phone01")
    end
end

function closePhone()
    SetNuiFocus(false, false)
    SendNUIMessage({
        openPhone = false
    })

    StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)

    if not IsInActiveCall() then
        TriggerEvent("destroyPropPhone")
    end

    phoneOpen = false
end

function phoneList(list)
    SendNUIMessage({
        openSection = "showOutstandingPayments",
        outstandingPayments = list,
    })
end

function phoneNotification(icon, title, text, timeout)
    SendNUIMessage({
        openSection = "notification",
        icon = icon,
        title = title,
        text = text,
        timeout = timeout,
    })
end

--[[

    Exports

]]

exports("openPhone", openPhone)
exports("closePhone", closePhone)
exports("phoneList", phoneList)
exports("phoneNotification", phoneNotification)

--[[

    Events

]]

RegisterNetEvent("np-weathersync:currentTime", function(hrs, mins)
  	if hrs < 10 then hrs = "0" .. hrs end
  	if mins < 10 then mins = "0" .. mins end

    curhrs = hrs
  	curmins = mins

    if phoneOpen then
    	SendNUIMessage({
      		openSection = "timeheader",
      		timestamp = curhrs .. ":" .. curmins,
    	})
  	end
end)

RegisterNetEvent("hud:insidePrompt")
AddEventHandler("hud:insidePrompt", function(bool)
    insidePrompt = bool
end)

AddEventHandler("np-voice:focus:set", function(pState)
    focusTaken = pState
end)

RegisterNetEvent("np-phone:phoneList")
AddEventHandler("np-phone:phoneList", phoneList)

RegisterNetEvent("np-phone:notification")
AddEventHandler("np-phone:notification", phoneNotification)

RegisterNetEvent("np-weathersync:currentWeather", function(pWeather)
    weather = pWeather
end)

RegisterNetEvent("np-inventory:itemCheck")
AddEventHandler("np-inventory:itemCheck", function(itemId, hasItem)
    if not itemId == "mobilephone" then return end

    if not hasItem then
        closePhone()
    end
end)

--[[

    NUI

]]

RegisterNUICallback("close", function(data, cb)
    closePhone()
    cb("ok")
end)

RegisterNUICallback("btnMute", function()
    if phoneNotifications then
        TriggerEvent("DoLongHudText", "Notificações Desativadas")
    else
        TriggerEvent("DoLongHudText", "Notificações Ativadas")
    end

    phoneNotifications = not phoneNotifications
end)

RegisterNUICallback("getWeather", function(data, cb)
    SendNUIMessage({
        openSection = "weather",
        weather = weather
    })

    cb("ok")
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Phone", "Open", "+generalPhone", "-generalPhone", "P")
    RegisterCommand("+generalPhone", openPhone, false)
    RegisterCommand("-generalPhone", function() end, false)
end)