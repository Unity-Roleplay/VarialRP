--[[

    Functions

]]

function loadSMS()
    local messages = RPC.execute("np-phone:getSMS")
    local phone = exports["np-base"]:getChar("phone")

    local _messages = {}
    for i, v in ipairs(messages) do
        local name = ""

        if v["receiver"] == phone then
            name = getContactName(v["sender"])
        else
            name = getContactName(v["receiver"])
        end

        table.insert(_messages, {
            ["id"] = v["id"],
            ["msgDisplayName"] = name,
            ["sender"] = v["sender"],
            ["receiver"] = v["receiver"],
            ["date"] = v["date"],
            ["message"] = v["message"],
        })
    end

    SendNUIMessage({
        openSection = "messages",
        list = _messages,
        clientNumber = phone,
    })
end

function readSMS(sender, receiver, name)
    if not sender or not receiver or not name then return end

    local messages, name, phone = RPC.execute("np-phone:readSMS", sender, receiver, name)

    SendNUIMessage({
		openSection = "messageRead",
		messages = messages,
		displayName = name,
		clientNumber = phone,
	})
end

--[[

    Events

]]

RegisterNetEvent("np-phone:newSMS")
AddEventHandler("np-phone:newSMS", function(number, message)
    if hasPhone() then
        SendNUIMessage({
            openSection = "newsms",
            show = true,
        })

        if phoneNotifications then
            phoneNotification("fas fa-comment", "SMS", message, 5000)
            PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        end
    end
end)

--[[

    NUI

]]

RegisterNUICallback("messages", function(data, cb)
    loadSMS()

    cb("ok")
end)

RegisterNUICallback("messageRead", function(data, cb)
    local sender = tonumber(data["sender"])
    local receiver = tonumber(data["receiver"])
    local name = data["displayName"]

    if not sender or not receiver or not name then return end

    readSMS(sender, receiver, name)

    cb("ok")
end)

RegisterNUICallback("newMessageSubmit", function(data, cb)
    local number = tonumber(data["number"])
    local message = data["message"]

    if not number or not message then return end

    local update = RPC.execute("np-phone:sendSMS", number, message)
    if update then
        local phone = exports["np-base"]:getChar("phone")
        local name = getContactName(number)

        readSMS(phone, number, name)
    end

    cb("ok")
end)