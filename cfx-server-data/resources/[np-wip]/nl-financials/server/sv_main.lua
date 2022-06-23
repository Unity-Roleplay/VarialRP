--[[

    Functions

]]

function getBalance(pAccountId)
    if not pAccountId or pAccountId == 0 then
        return 0
    end

    local balance = MySQL.scalar.await([[
        SELECT balance
        FROM financials_accounts
        WHERE id = ?
    ]],
    { pAccountId })

    if not balance then
        return 0
    end

    return balance
end

function updateBalance(pAccountId, pType, pAmount)
    if not pAccountId or not pType or not pAmount then
        return false
    end

    local affectedRows = MySQL.update.await([[
        UPDATE financials_accounts
        SET balance = balance ]] .. pType .. [[ ?
        WHERE id = ?
    ]],
    { pAmount, pAccountId })

    if not affectedRows or affectedRows == 0 then return false end

    return true
end

function transaction(pSenderAccount, pReceiverAccount, pAmount, pComment, pUser, pTransactionType)
    if not pSenderAccount or not pReceiverAccount or not pAmount or not pComment or not pUser or not pTransactionType then
        return false, "Missing params"
    end

    local success = MySQL.transaction.await({
        {
            ["query"] = "UPDATE financials_accounts SET balance = balance - ? WHERE id = ?",
            ["values"] = { pAmount, pSenderAccount },
        },
        {
            ["query"] = "UPDATE financials_accounts SET balance = balance + ? WHERE id = ?",
            ["values"] = { pAmount, pReceiverAccount },
        },
        {
            ["query"] = "INSERT INTO financials_transactions (sender, receiver, amount, comment, user, type, uid) VALUES (:sender, :receiver, :amount, :comment, :user, :type, :uid)",
            ["values"] = {
                sender = pSenderAccount,
                receiver = pReceiverAccount,
                amount = pAmount,
                comment = pComment,
                user = pUser,
                type = pTransactionType,
                uid = uuid()
            },
        },
    })

    if not success then
        return false, "Failed in transfering $" .. pAmount
    end

    return true, "Success in transfering $" .. pAmount
end

function transactionLog(pSenderAccount, pReceiverAccount, pAmount, pComment, pUser, pTransactionType)
    local uid = uuid()

    MySQL.insert.await([[
        INSERT INTO financials_transactions (sender, receiver, amount, comment, user, type, uid)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    ]],
    { pSenderAccount, pReceiverAccount, pAmount, pComment, pUser, pTransactionType, uid })

    return uid
end

--[[

    Exports

]]

exports("getBalance", getBalance)
exports("updateBalance", updateBalance)
exports("transaction", transaction)
exports("transactionLog", transactionLog)

--[[

    RPCs

]]

RPC.register("np-financials:getBalance", function(src, pAccountId)
    return getBalance(pAccountId)
end)