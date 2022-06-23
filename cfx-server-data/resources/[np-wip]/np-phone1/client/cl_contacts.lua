--[[

    Variables

]]

local myContacts = {}

--[[

    Functions

]]

function loadContacts()
    local contacts = RPC.execute("np-phone:getContacts")

    myContacts = contacts

    SendNUIMessage({
        emptyContacts = true,
    })

    for i, v in ipairs(contacts) do
        SendNUIMessage({
            newContact = true,
            contact = {
                name = v.name,
                number = v.number,
                activated = 0,
            },
        })
    end
end

function getContactName(number)
    for i, v in ipairs(myContacts) do
        if v["number"] == number then
            return v["name"]
        end
    end
    return number
end

--[[

    Events

]]

AddEventHandler("SpawnEventsClient", function()
    myContacts = RPC.execute("np-phone:getContacts")
end)

--[[

    NUI

]]

RegisterNUICallback("contacts", function(data, cb)
    SendNUIMessage({
        openSection = "contacts"
    })

    loadContacts()

    cb("ok")
end)

RegisterNUICallback("newContact", function(data, cb)
    SendNUIMessage({
        openSection = "newContact"
    })

    cb("ok")
end)

RegisterNUICallback("newContactSubmit", function(data, cb)
    local name = data["name"]
    local number = tonumber(data["number"])

    if not name or not number then
        return
    end

    local update = RPC.execute("np-phone:addContact", name, number)
    if update then
        loadContacts()
    end

    cb("ok")
end)

RegisterNUICallback("removeContact", function(data, cb)
    local name = data["name"]
    local number = tonumber(data["number"])

    if not name or not number then
        return
    end

    local update = RPC.execute("np-phone:removeContact", name, number)
    if update then
        loadContacts()
    end

    cb("ok")
end)