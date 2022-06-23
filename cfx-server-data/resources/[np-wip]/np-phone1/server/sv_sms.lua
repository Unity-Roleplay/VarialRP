--[[

    Functions

]]

function formatSMS(sms, phone)
    local numbers ={}
    local convos = {}
    local valid = false

    for k, v in pairs(sms) do
        valid = true

        if v["sender"] == phone then
            for i2, v2 in ipairs(numbers) do
                if v["receiver"] == v2 then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v["receiver"])
            end
        elseif v["receiver"] == phone then
            for i2, v2 in ipairs(numbers) do
                if v["sender"] == v2 then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v["sender"])
            end
        end
    end

    for i, j in pairs(numbers) do
        for g, f in pairs(sms) do
            if j == f["sender"] or j == f["receiver"] then
                table.insert(convos, {
                    ["id"] = f["id"],
                    ["sender"] = f["sender"],
                    ["receiver"] = f["receiver"],
                    ["message"] = f["message"],
                    ["date"] = f["date"],
                })
                break
            end
        end
    end

    return ReverseTable(convos)
end

function getSMS(_src)
    local src = source
    if _src then src = _src end

    local phone = exports["np-base"]:getChar(src, "phone")
    if not phone then return {} end

    local sms = MySQL.query.await([[
        SELECT id, sender, receiver, message, FROM_UNIXTIME(date) AS date
        FROM phone_sms
        WHERE receiver = ? OR sender = ?
        ORDER BY id DESC
    ]],
    { phone, phone })

    return formatSMS(sms, phone)
end

function readSMS(sender, receiver, name, _phone, _src)
    local src = source
    if _src then src = _src end

    local phone = 0
    if _phone then
        phone = _phone
    else
        phone = exports["np-base"]:getChar(src, "phone")
    end

    if not phone then return {} end

    local sms = MySQL.query.await([[
        SELECT id, sender, receiver, message, FROM_UNIXTIME(date) AS date
        FROM phone_sms
        WHERE ((sender = ? AND receiver = ?) OR (sender = ? AND receiver = ?))
    ]],
    { sender, receiver, receiver, sender })

    if receiver == phone then
        MySQL.update.await([[
            UPDATE phone_sms
            SET seen = 1
            WHERE (sender = ? AND receiver = ?)
        ]],
        { sender, receiver })
    end

    return sms, name, phone
end

function sendSMS(number, message, _src)
    local src = source
    if _src then src = _src end

    local phone = exports["np-base"]:getChar(src, "phone")
    if not phone then return false end

    if phone == number then
        TriggerClientEvent("DoLongHudText", src, "really dude?", 2)
        return false
    end

    MySQL.insert.await([[
        INSERT INTO phone_sms (sender, receiver, message, date)
        VALUES (?, ?, ?, UNIX_TIMESTAMP())
    ]],
    { phone, number, message })

    local receiver = exports["np-base"]:getSidWithPhone(number)
    if receiver ~= 0 then
        TriggerClientEvent("np-phone:newSMS", receiver, phone, message)
    end

    return true
end

--[[

    RPCs

]]

RPC.register("np-phone:getSMS", function(src)
    return getSMS(src)
end)

RPC.register("np-phone:readSMS", function(src, sender, receiver, name, phone)
    return readSMS(sender, receiver, name, phone, src)
end)

RPC.register("np-phone:sendSMS", function(src, number, message)
    return sendSMS(number, message, src)
end)