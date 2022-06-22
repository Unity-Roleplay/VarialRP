--[[

    Variables

]]

local Twitter = {}

--[[

    Function

]]

local function getTwitter()
    return Twitter
end

local function addTwitter(name, message, image, time, _src)
    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local data = {
        ["cid"] = cid,
        ["name"] = name,
        ["message"] = message,
        ["image"] = image,
        ["time"] = time,
    }

    table.insert(Twitter, data)
    TriggerClientEvent("np-phone:updateTwitter", -1, data)

    return true
end

--[[

    RPCs

]]

RPC.register("np-phone:getTwitter", function(src)
    return getTwitter()
end)

RPC.register("np-phone:addTwitter", function(src, name, message, image, time)
    return addTwitter(name, message, image, time, src)
end)