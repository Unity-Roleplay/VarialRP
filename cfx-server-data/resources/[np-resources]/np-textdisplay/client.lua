local p = nil

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    p:resolve(data.data)
    p = nil
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    SetNuiFocus(false)
    --p:resolve(nil)
    p = nil
    cb("ok")
end)

function DisplayText(data)
    Wait(150)
    if not data then return end
    --if p then return end
    
    --p = promise.new()

    --SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })

    return Citizen.Await(p)
end

exports("DisplayText", DisplayText)

function HideText()
    SendNUIMessage({
        action = "CLOSE_MENU",
        data = data
    })
end

exports("HideText", HideText)

--[[local keyboard = exports["nh-keyboard"]:DisplayText({
    header = "Add Items", 
    rows = {
        {
            id = 0, 
            icon = "fas fa-pecil-alt",
            txt = "Spawn Name"
        },
        {
            id = 1, 
            icon = "fas fa-pecil-alt",
            txt = "Amount"
        }
    }
})

if keyboard ~= nil then
    if keyboard[1].input == nil or keyboard[2].input == nil then return end
    TriggerEvent('additem', keyboard[1].input, keyboard[2].input)
end]]