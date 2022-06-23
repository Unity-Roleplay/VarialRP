RPC.register("np-phone:racingAliasesSave", function(src, aliases)
    local exist = MySQL.scalar.await([[
        SELECT id
        FROM characters
        WHERE aliases = ?
    ]],
    { aliases })

    if exist then
        TriggerClientEvent("DoLongHudText", src, "This name is already in use", 2)
        return false
    end


    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    MySQL.update.await([[
        UPDATE characters
        SET aliases = ?
        WHERE id = ?
    ]],
    { aliases, cid })

    exports["np-base"]:setChar(src, "aliases", aliases)

    return true
end)