RegisterNetEvent('np-phone:transferWenmo', function(num,amount,comm)
    local src = source
    local zcid = getIdentifierByPhoneNumber(num)
    local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(src))
    local char = user:getVar("character")
    local money = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],
    { zcid})
    local pl = MySQL.query.await([[
        SELECT * FROM characters
        WHERE phone_number = ?
    ]],{num})
    if money[1] ~= nil then
        local amountAdded = money[1].bank+amount
        local affectedRows = MySQL.update.await([[
            UPDATE characters
            SET bank = ?
            WHERE id = ?
        ]],
        { amountAdded, zcid})
        user:removeBank(tonumber(amount))
        for _, player in ipairs(GetPlayers()) do
            local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(player))
            local char = user:getVar("character")
            if char.id == zcid then
                TriggerClientEvent('banking:updateBalance', tonumber(player), amountAdded)
            end
        end

        local insertIdSrc = MySQL.insert.await([[
                INSERT INTO wenmo_logs (cid,numfrom,numto,amount,comment,status)
                VALUES (?, ?, ?, ?, ?, ?)
            ]],
            { tonumber(char.id),tonumber(char.phone_number),tonumber(num),tonumber(amount),comm,"send"})
        local insertIdTarget = MySQL.insert.await([[
            INSERT INTO wenmo_logs (cid,numfrom,numto,amount,comment,status)
            VALUES (?, ?, ?, ?, ?, ?)
        ]],
        { zcid,char.phone_number,num,amount,comm,"receive"})
    end
end)

RPC.register('np-phone:getWenmo', function(source)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(src))
    local cid = user:getVar("character").id

    local wenmo = MySQL.query.await([[
        SELECT * FROM wenmo_logs
        WHERE cid = ?
    ]],{cid})
    return true, wenmo
end)
