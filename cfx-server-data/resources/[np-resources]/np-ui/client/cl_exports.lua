local Events = {}

function SendUIMessage(data)
    SendNUIMessage(data)
end

exports('SendUIMessage', SendUIMessage)

function RegisterUIEvent(eventName)
    if not Events[eventName] then
        Events[eventName] = true

        RegisterNUICallback(eventName, function (...)
            TriggerEvent(('_npx_uiReq:%s'):format(eventName), ...)
        end)
    end
end

exports('RegisterUIEvent', RegisterUIEvent)

function SetUIFocusCustom(hasKeyboard, hasMouse)
    HasNuiFocus = hasKeyboard or hasMouse

    SetNuiFocus(hasKeyboard, hasMouse)
    SetNuiFocusKeepInput(HasNuiFocus)
end

exports('SetUIFocusCustom', SetUIFocusCustom)


function GetUIFocus()
    return HasFocus, HasCursor
end

exports('GetUIFocus', GetUIFocus)

Citizen.CreateThread(function()
    TriggerEvent('_npx_uiReady')
end)

function cashFlash(pCash, pChange)
    SendUIMessage({
        action = "cash",
        data = {
            cash = pCash,
            amountAdjustment = pChange
        },
    })
end

exports("cashFlash", cashFlash)



function sendAppEvent(app, data)
    SendUIMessage({
        action = app,
        data = data or {},
    })
end

exports("sendAppEvent", sendAppEvent)