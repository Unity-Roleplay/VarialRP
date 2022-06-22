--[[

    Variables

]]

local ServerVars = ServerVars or {}
local ServerUsers = ServerUsers or {}

local DefaultVars = {}

--[[

    Functions

]]

function setServerVar(var, data)
    ServerVars[var] = data
end

function getServerVar(var)
    return ServerVars[var]
end

function setUser(src, var, data)
    if var == "edit" then
        ServerUsers[src] = data
    else
        if not ServerUsers[src] then
            ServerUsers[src] = {}
        end
        ServerUsers[src][var] = data
    end
end

function getUser(src, var)
    if ServerUsers[src] then
        if var then
            return ServerUsers[src][var]
        end

        return ServerUsers[src]
    else
        return
    end
end

function getUsers()
    return ServerUsers
end

function setChar(src, var, data)
    if not ServerUsers[src]["char"] then return end

    ServerUsers[src]["char"][var] = data
end

function getChar(src, var)
    if ServerUsers[src]["char"] then
        if var then
            return ServerUsers[src]["char"][var]
        end

        return ServerUsers[src]["char"]
    else
        return
    end
end

function getSidWithCid(cid)
    for i, v in pairs(ServerUsers) do
        if v["char"] and v["char"]["id"] and v["char"]["id"] == cid then
            return i
        end
    end
    return 0
end

function getSidWithPhone(phone)
    for i,v in pairs(ServerUsers) do
        if v["char"] and v["char"]["phone"] and v["char"]["phone"] == phone then
            return i
        end
    end
    return 0
end

function getSidWithAccountId(account)
    for i,v in pairs(ServerUsers) do
        if v["char"] and v["char"]["bankid"] and v["char"]["bankid"] == account then
            return i
        end
    end
    return 0
end

function JobCount(job)
    local count = 0
    for i,v in pairs(ServerUsers) do
        if v["char"] and v["char"]["job"] and v["char"]["job"] == job then
            count = count + 1
        end
    end
    return count
end

--[[

    Exports

]]

exports("setServerVar", setServerVar)
exports("getServerVar", getServerVar)
exports("setUser", setUser)
exports("getUser", getUser)
exports("getUsers", getUsers)
exports("setChar", setChar)
exports("getChar", getChar)
exports("getSidWithCid", getSidWithCid)
exports("getSidWithPhone", getSidWithPhone)
exports("getSidWithAccountId", getSidWithAccountId)
exports("JobCount", JobCount)