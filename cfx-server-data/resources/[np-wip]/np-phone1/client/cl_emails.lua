--[[

    Variables

]]

local Emails = {}

--[[

    Functions

]]

local function loadEmails()
    SendNUIMessage({
        openSection = "notifications",
        list = Emails,
    })
end

--[[

    Events

]]

RegisterNetEvent("SpawnEventsClient")
AddEventHandler("SpawnEventsClient", function()
    Emails = {}
end)

RegisterNetEvent("np-phone:addnotification")
AddEventHandler("np-phone:addnotification", function(name, message)
    if not phoneOpen then
        SendNUIMessage({
            openSection = "newemail",
        })
    end

    table.insert(Emails, {
        ["id"] = #Emails + 1,
        ["name"] = name,
        ["message"] = message,
    })
end)

--[[

    NUI

]]

RegisterNUICallback("notifications", function()
    loadEmails()
end)