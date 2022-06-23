--[[

    Variables

]]

local YellowPages = {}

--[[

    Function

]]

local function getYellowPages()
    return YellowPages
end

local function existYellowPages(cid)
    for i, v in ipairs(YellowPages) do
        if v["cid"] == cid then
            return i
        end
    end
    return 0
end

local function addYellowPages(message, _src)
    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    local phone = exports["np-base"]:getChar(src, "phone")
    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")

    if not cid or not phone or not name then return false end

    local data = {
        ["cid"] = cid,
        ["phone"] = phone,
        ["name"] = name,
        ["message"] = message,
    }

    local exist = existYellowPages(cid)
    if exist ~= 0 then
        YellowPages[exist] = nil
    end

    table.insert(YellowPages, data)

    return true
end

local function removeYellowPages(_src)
    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local exist = existYellowPages(cid)
    if exist ~= 0 then
        YellowPages[exist] = nil
    end

    return true
end

--[[

    RPCs

]]

RPC.register("np-phone:getYellowPages", function(src)
    return getYellowPages()
end)

RPC.register("np-phone:addYellowPages", function(src, message)
    return addYellowPages(message, src)
end)

RPC.register("np-phone:removeYellowPages", function(src)
    return removeYellowPages(src)
end)