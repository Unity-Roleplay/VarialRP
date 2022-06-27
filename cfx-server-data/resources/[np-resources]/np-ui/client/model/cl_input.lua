--[[

    Variables

]]

local success = {}
local await = false

--[[

    Functions

]]

function showInput(data)
    if not data or await then return end

    success = {}

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data,
    })

    await = true
    while await do Wait(0) end

    if success ~= nil and next(success) ~= nil then
        return success
    end

    return {}
end

exports("showInput", showInput)

--[[

    NUI

]]

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    success = data.data
    await = false
    cb("ok")
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
    success = nil
    await = false
end)

--[[

    Threads

]]

-- Citizen.CreateThread(function()
--     Citizen.Wait(500)

--     local keyboard = showInput({
--         {
--             icon = "phone-volume",
--             label = "Phone Number 1",
--             name = "number1",
--         },
--         {
--             icon = "phone-volume",
--             label = "Phone Number 2",
--             name = "number2",
--         },
--     })

--     print(json.encode(keyboard))
-- end)