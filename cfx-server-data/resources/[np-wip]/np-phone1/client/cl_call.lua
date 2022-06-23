--[[

    Variables

]]

local RecentCalls = {}
local isDialing = false
local isRinging = false
local incomingCallId = nil
local activeCallId = nil

--[[

    Functions

]]

function IsInActiveCall()
    return isDialing or isRinging or activeCallId
end

function playPhoneCallAnim()
    TriggerEvent("destroyPropPhone")
    TriggerEvent("attachItemPhone", "phone01")

    local dict, anim = "cellphone@", "cellphone_text_to_call"

    Citizen.CreateThread(function()
        LoadAnimationDic(dict)

        local playerPed = PlayerPedId()

        while (isDialing or activeCallId) and not isDisabled() do
            if not IsEntityPlayingAnim(playerPed, dict, anim, 3) then
                TaskPlayAnim(playerPed, dict, anim, 3.0, -1, -1, 50, 0, false, false, false)
            end

            if PayphoneCall then
                local dPB = #(PayphonePos - GetEntityCoords(PlayerPedId()))
                if dPB > 2.0 then
                    endPhoneCall()
                end
            end

            Citizen.Wait(100)
        end

        -- TODO: add transitions between browse and call mode rather than clearing task
        ClearPedTasks(playerPed)
    end)
end

function answerPhoneCall()
    if not incomingCallId then return end

    TriggerServerEvent("np-phone:callAccept", incomingCallId)
end

function endPhoneCall()
    if isRinging then
        TriggerServerEvent("np-phone:callDecline", incomingCallId)
        phoneNotification("fas fa-phone-volume", "Call", "Not answered", 3000)
    elseif isDialing then
        TriggerServerEvent("np-phone:callDecline", incomingCallId)
        phoneNotification("fas fa-phone-volume", "Call", "Not answered", 3000)
    elseif activeCallId then
        TriggerServerEvent("np-phone:callEnd", activeCallId)
        phoneNotification("fas fa-phone-volume", "Call", "Ended", 3000)
    end

    TriggerEvent("destroyPropPhone")
end

--[[

    Events

]]

RegisterNetEvent("phone:call:dialing")
AddEventHandler("phone:call:dialing", function(pNumber, pCallId)
    local contact = getContactName(pNumber)

    SendNUIMessage({
        openSection = "callState",
        callState = 1,
        callInfo = contact,
    })

    isDialing = true
    incomingCallId = pCallId

    table.insert(RecentCalls, {
        ["type"] = 2,
        ["number"] = pNumber,
        ["name"] = contact,
    })

    playPhoneCallAnim()

    for i = 1, 8 do
        if not isDialing then break end

        if hasPhone() then
            phoneNotification("fas fa-phone-volume", "Call", "Ligando para: " .. contact, 3000)

            if PayphoneCall and i < 7 then
                TriggerEvent("InteractSound_CL:PlayOnOne", "payphoneringing", 0.5)
            elseif not PayphoneCall then
                TriggerEvent("InteractSound_CL:PlayOnOne","cellcall",  0.5)
            end
        end

        Citizen.Wait(2500)
    end

    if not activeCallId then
        endPhoneCall()
    end
end)

RegisterNetEvent("phone:call:receive")
AddEventHandler("phone:call:receive", function(pNumber, pCallId)
    local contact = getContactName(pNumber)

    SendNUIMessage({
        openSection = "callState",
        callState = 2,
        callInfo = contact,
    })

    isRinging = true
    incomingCallId = pCallId

    table.insert(RecentCalls, {
        ["type"] = 1,
        ["number"] = pNumber,
        ["name"] = contact,
    })

    for i = 1, 8 do
        if not isRinging then break end

        if hasPhone() then
            phoneNotification("fas fa-phone-volume", "Call", "Ligação de: " .. contact, 3000)

            if phoneNotifications then
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2.0, "cellcall", 0.5)
            end
        end

        Citizen.Wait(2300)
    end

    if not activeCallId then
        endPhoneCall()
    end
end)

RegisterNetEvent("phone:call:in-progress")
AddEventHandler("phone:call:in-progress", function(pNumber, pCallId)
    local contact = getContactName(pNumber)

    SendNUIMessage({
        openSection = "callState",
        callState = 3,
        callInfo = contact,
    })

    isDialing = false
    isRinging = false
    activeCallId = pCallId

    playPhoneCallAnim()

    local seconds = 0
    local minutes = 0

    while activeCallId do
        seconds = seconds + 1

        if seconds > 60 then
            seconds = 0
            minutes = minutes + 1
        end

        local secondsString = seconds
        local minutesString = minutes
        if seconds < 10 then secondsString = "0" .. seconds end
  	    if minutes < 10 then minutesString = "0" .. minutes end

        local time = minutesString .. ":" .. secondsString

        phoneNotification("fas fa-phone-volume", "Ligação com " .. contact, time, 3000)
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("phone:call:inactive")
AddEventHandler("phone:call:inactive", function()
    SendNUIMessage({
        openSection = "callState",
        callState = 0,
        callInfo = "",
    })

    isDialing = false
    isRinging = false
    activeCallId = nil
    incomingCallId = nil

    PayphoneCall = false
    PayphonePos = GetEntityCoords(PlayerPedId())
end)

RegisterNetEvent("np-inventory:itemCheck")
AddEventHandler("np-inventory:itemCheck", function(itemId, hasItem)
    if not itemId == "mobilephone" then return end

    if not hasItem then
        endPhoneCall()
    end
end)

--[[

    NUI

]]

RegisterNUICallback("getCallHistory", function()
    SendNUIMessage({
        openSection = "callHistory",
        callHistory = RecentCalls,
    })
end)

RegisterNUICallback("callContact", function(data, cb)
    local caller_number = exports["np-base"]:getChar("phone")
    local target_number = tonumber(data.number)

    if not caller_number or not target_number then return end

    TriggerServerEvent("np-phone:callStart", caller_number, target_number)
    closePhone()

    cb("ok")
end)

RegisterNUICallback("btnAnswer", function()
    answerPhoneCall()
    closePhone()
end)

RegisterNUICallback("btnHangup", function()
    endPhoneCall()
    closePhone()
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("","Phone", "Call Answer", "+answerPhoneCall", "-answerPhoneCall")
    RegisterCommand("+answerPhoneCall", answerPhoneCall, false)
    RegisterCommand("-answerPhoneCall", function() end, false)

    exports["np-keybinds"]:registerKeyMapping("","Phone", "Call End", "+endPhoneCall", "-endPhoneCall")
    RegisterCommand("+endPhoneCall", endPhoneCall, false)
    RegisterCommand("-endPhoneCall", function() end, false)
end)