--[[

    Functions

]]

function getCash(src)
    if not src then return 0 end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return 0 end

    local cash = MySQL.scalar.await([[
        SELECT cash
        FROM characters
        WHERE id = ?
    ]],
    { cid })

    if not cash then return 0 end

    return cash
end

function updateCash(src, type, amount)
    if not src or not type or not amount then return false end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local affectedRows  = MySQL.update.await([[
        UPDATE characters
        SET cash = cash ]] .. type .. [[ ?
        WHERE id = ?
    ]],
    { amount, cid })

    if not affectedRows or affectedRows == 0 then return false end

    TriggerClientEvent("np-financials:ui", src, "cash", type, amount, getCash(src))

    return true
end

--[[

    Exports

]]

exports("getCash", getCash)
exports("updateCash", updateCash)

--[[

    Events

]]

RegisterNetEvent("np-financials:giveCash")
AddEventHandler("np-financials:giveCash", function(pPlayer, pAmount)
    local src = source

    if pPlayer == -1 or pPlayer == 0 then return end

    updateCash(src, "-", pAmount)
    updateCash(pPlayer, "+", pAmount)
end)

--[[

    RPCs

]]

RPC.register("np-financials:getCash", function(src)
    return getCash(src)
end)