--[[

    Functions

]]

function generateAccountId(type)
    for i = 1, 100 do
        local accountId = tonumber(6 .. type .. math.random(100000, 999999))

        local exist = MySQL.scalar.await([[
            SELECT id
            FROM financials_accounts
            WHERE id = ?
        ]],
        { accountId })

        if not exist then
            return accountId
        end

        Citizen.Wait(100)
    end

    return false
end

function createAccount(id, type, owner)
    local result = MySQL.query.await([[
        INSERT INTO financials_accounts (id, type, owner)
        VALUES (?, ?, ?)
    ]],
    { id, type, owner })

    if result and result.affectedRows and result.affectedRows > 0 then
        return true
    end

    return false
end

function accountExist(pAccountId)
    local exist = MySQL.scalar.await([[
        SELECT id
        FROM financials_accounts
        WHERE id = ?
    ]],
    { pAccountId })

    return exist and true or false
end

--[[

    Exports

]]

exports("generateAccountId", generateAccountId)
exports("createAccount", createAccount)

--[[

    Events

]]

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local account = exports["np-base"]:getChar(src, "bankid")
    if account == 0 then
        local accountId = generateAccountId(1)
        if accountId then
            local created = createAccount(accountId, 1, cid)
            if created then
                local affectedRows = MySQL.update.await([[
                    UPDATE characters
                    SET bankid = ?
                    WHERE id = ?
                ]],
                { accountId, cid })

                if affectedRows and affectedRows ~= 0 then
                    exports["np-base"]:setChar(src, "bankid", accountId)
                    TriggerClientEvent("np-base:setChar", src, "bankid", accountId)
                end
            end
        end
    end
end)

--[[

    RPCs

]]

RPC.register("np-financials:getAccounts", function(src)
    if not src then return {} end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return {} end

    local _groups = exports["np-groups"]:groupsBanks(cid)
    local groups = "0"
    for id, v in pairs(_groups) do
        groups = groups .. "," .. id
    end

    local accounts = MySQL.query.await([[
        SELECT
            a.id AS account_id,
            t.type AS account_type,
            (CASE
                WHEN a.type IN (1, 2) THEN "Personal Account"
                WHEN a.type = 4 THEN g.name
                ELSE n.name
            END) AS account_name,
            (CASE
                WHEN a.type IN (1, 2) THEN CONCAT(c.first_name," ",c.last_name)
                ELSE ""
            END) AS account_owner,
            a.balance AS account_balance,
            a.is_frozen,
            a.is_monitored

        FROM financials_accounts a
        INNER JOIN financials_accounts_types t ON a.type = t.id
        LEFT JOIN financials_accounts_names n ON a.id = n.id
        LEFT JOIN characters c ON a.owner = c.id
        LEFT JOIN ?? g ON a.owner = g.id

        WHERE (a.type IN (1, 2, 5) AND a.owner = ?) OR (a.type = 4 AND a.id IN (]] .. groups .. [[))
    ]],
    { "groups", cid })

    for i, v in ipairs(accounts) do
        if _groups[v.account_id] then
            if _groups[v.account_id].withdraw == false then
                v.cantWithdraw = true
            end
            if _groups[v.account_id].deposit == false then
                v.cantDeposit = true
            end
        end
    end

    return accounts
end)