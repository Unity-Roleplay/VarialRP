--[[

    Functions

]]

local function getContacts(_src, _cid)
    local src = source
    if _src then src = _src end

    local cid = 0
    if _cid then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return {} end

    local contacts = MySQL.query.await([[
        SELECT *
        FROM ??
        WHERE ?? = ?
    ]],
    { "phone_contacts", "cid", cid })

    return contacts
end

local function existContact(cid, number)
    if not cid or not number then return false end

    local exist = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ? AND ?? = ?
    ]],
    { "name", "phone_contacts", "cid", cid, "number", number })

    if not exist then return false end

    return true
end

local function addContact(name, number, _src, _cid)
    local src = source
    if _src then src = _src end

    local cid = 0
    if _cid then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return false end

    local exist = existContact(cid, number)

    if exist then
        local contacts = MySQL.update.await([[
            UPDATE ??
            SET ?? = ?
            WHERE ?? = ? AND ?? = ?
        ]],
        { "phone_contacts", "name", name, "cid", cid, "number", number })
    else
        local contacts = MySQL.insert.await([[
            INSERT INTO ?? (??, ??, ??)
            VALUES (?, ?, ?)
        ]],
        { "phone_contacts", "cid", "name", "number", cid, name, number })
    end

    return true
end

local function removeContact(name, number, _src, _cid)
    local src = source
    if _src then src = _src end

    local cid = 0
    if _cid then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return false end

    local exist = existContact(cid, number)

    if exist then
        local contacts = MySQL.update.await([[
            DELETE FROM ??
            WHERE ?? = ? AND ?? = ? AND ?? = ?
        ]],
        { "phone_contacts", "cid", cid, "name", name, "number", number })
    end

    return true
end

--[[

    RPCs

]]

RPC.register("np-phone:getContacts", function(src)
    return getContacts(src)
end)

RPC.register("np-phone:addContact", function(src, name, number)
    return addContact(name, number, src)
end)

RPC.register("np-phone:removeContact", function(src, name, number)
    return removeContact(name, number, src)
end)