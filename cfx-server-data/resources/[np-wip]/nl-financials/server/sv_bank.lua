--[[

    Variables

]]

local negativeTransactions = { "transfer", "purchase", "payslip", "financing" }

--[[

    RPCs

]]

RPC.register("np-financials:bankWithdraw", function(src, pAccountId, pAmount, pComment)
    if not src then
        return false, "Server id dont fount"
    end

    pAccountId = tonumber(pAccountId)
    if not pAccountId or pAccountId < 1 then
        return false, "Param account id incorrect: " .. pAccountId
    end

    pAmount = tonumber(pAmount)
    if not pAmount or pAmount < 1 then
        return false, "Param amount incorrect: " .. pAmount
    end

    local accountExist = accountExist(pAccountId)
    if not accountExist then
        return false, "Account id " .. pAccountId .. " dont exist?"
    end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then
        return false, "Character id dont found"
    end

    local cash = getCash(src)
    local bank = getBalance(pAccountId)

    if pAmount > bank then
        return false, "This account dont have this amount"
    end

    local success = MySQL.transaction.await({
        {
            ["query"] = "UPDATE financials_accounts SET balance = balance - ? WHERE id = ?",
            ["values"] = { pAmount, pAccountId },
        },
        {
            ["query"] = "UPDATE characters SET cash = cash + ? WHERE id = ?",
            ["values"] = { pAmount, cid },
        },
        {
            ["query"] = "INSERT INTO financials_transactions (sender, receiver, amount, comment, user, type, uid) VALUES (:sender, :receiver, :amount, :comment, :user, :type, :uid)",
            ["values"] = {
                sender = pAccountId,
                receiver = pAccountId,
                amount = pAmount,
                comment = pComment,
                user = cid,
                type = 3,
                uid = uuid()
            },
        },
    })

    if not success then
        return false, "Failed in withdraw $" .. pAmount
    end

    TriggerClientEvent("np-financials:ui", src, "cash", "+", pAmount, (cash + pAmount))

    return true, "Succeeded in withdraw $" .. pAmount
end)

RPC.register("np-financials:bankDeposit", function(src, pAccountId, pAmount, pComment)
    if not src then
        return false, "Server id dont fount"
    end

    pAccountId = tonumber(pAccountId)
    if not pAccountId or pAccountId < 1 then
        return false, "Param account id incorrect: " .. pAccountId
    end

    pAmount = tonumber(pAmount)
    if not pAmount or pAmount < 1 then
        return false, "Param amount incorrect: " .. pAmount
    end

    local accountExist = accountExist(pAccountId)
    if not accountExist then
        return false, "Account id " .. pAccountId .. " dont exist?"
    end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then
        return false, "Character id dont found"
    end

    local cash = getCash(src)

    if pAmount > cash then
        return false, "You dont have this amount"
    end

    local success = MySQL.transaction.await({
        {
            ["query"] = "UPDATE characters SET cash = cash - ? WHERE id = ?",
            ["values"] = { pAmount, cid },
        },
        {
            ["query"] = "UPDATE financials_accounts SET balance = balance + ? WHERE id = ?",
            ["values"] = { pAmount, pAccountId },
        },
        {
            ["query"] = "INSERT INTO financials_transactions (sender, receiver, amount, comment, user, type, uid) VALUES (:sender, :receiver, :amount, :comment, :user, :type, :uid)",
            ["values"] = {
                sender = pAccountId,
                receiver = pAccountId,
                amount = pAmount,
                comment = pComment,
                user = cid,
                type = 2,
                uid = uuid()
            },
        },
    })

    if not success then
        return false, "Failed in deposit $" .. pAmount
    end

    TriggerClientEvent("np-financials:ui", src, "cash", "-", pAmount, (cash - pAmount))

    return true, "Succeeded in deposit $" .. pAmount
end)

RPC.register("np-financials:bankTransfer", function(src, pSenderAccount, pReceiverAccount, pAmount, pComment)
    if not src then
        return false, "Server id dont fount"
    end

    pSenderAccount = tonumber(pSenderAccount)
    if not pSenderAccount or pSenderAccount < 1 then
        return false, "Param sender account id incorrect: " .. pSenderAccount
    end

    pReceiverAccount = tonumber(pReceiverAccount)
    if not pReceiverAccount or pReceiverAccount < 1 then
        return false, "Param receiver account id incorrect: " .. pReceiverAccount
    end

    pAmount = tonumber(pAmount)
    if not pAmount or pAmount < 1 then
        return false, "Param amount incorrect: " .. pAmount
    end

    local accountSenderExist = accountExist(pSenderAccount)
    if not accountSenderExist then
        return false, "Sender account id " .. pSenderAccount .. " dont exist"
    end

    local accountReceiverExist = accountExist(pReceiverAccount)
    if not accountReceiverExist then
        return false, "Receiver account id " .. pReceiverAccount .. " dont exist"
    end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then
        return false, "Character id dont found"
    end

    local senderBank = getBalance(pSenderAccount)
    local receiverBank = getBalance(pReceiverAccount)

    if pAmount > senderBank then
        return false, "This account dont have this amount"
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
                user = cid,
                type = 1,
                uid = uuid()
            },
        },
    })

    if not success then
        return false, "Failed in transfer $" .. pAmount .. " to Account ID: " .. pReceiverAccount
    end

    local userAccountId = exports["np-base"]:getChar(src, "bankid")
    if pSenderAccount == userAccountId then
        TriggerClientEvent("np-phone:notification", src, "fas fa-university", "Bank", "You transferred $" .. pAmount .. " to Account ID: " .. pReceiverAccount, 3000)
    end

    local receiverSid = exports["np-base"]:getSidWithAccountId(pReceiverAccount)
    if receiverSid ~= 0 then
        TriggerClientEvent("np-phone:notification", receiverSid, "fas fa-university", "Bank", "You received a transfer in the amount of $" .. pAmount .. " from Account ID: " .. pSenderAccount, 3000)
    end

    return true, "Succeeded in transfer $" .. pAmount .. " to Account ID:" .. pReceiverAccount
end)

RPC.register("np-financials:bankTransactions", function(src, pAccountId)
    if not src then return {} end

    local transactions = MySQL.query.await([[
        SELECT
	        t.type AS transcation_type,
            tr.amount AS transcation_amount,
            tr.comment AS transcation_comment,
            tr.uid AS transcation_uid,
            tr.date AS transcation_date,

            tr.sender AS transcation_sender,
            tr.receiver AS transcation_receiver,

            (CASE
	        	WHEN a1.type = 1 THEN "Personal Account"
	        	WHEN a1.type = 4 THEN g1.name
	        	ELSE n1.name
	        END) AS transcation_sender_name,
            (CASE
	        	WHEN a2.type = 1 THEN "Personal Account"
	        	WHEN a2.type = 4 THEN g2.name
	        	ELSE n2.name
	        END) AS transcation_receiver_name,

            (CASE
                WHEN a1.type = 4 AND (a1.id != :accountId OR tr.user = 0) THEN g1.name
                WHEN tr.user = 0 THEN n1.name
                WHEN tr.user IS NULL THEN ""
	        	ELSE CONCAT(c3.first_name," ",c3.last_name)
	        END) AS transcation_user_sender,
            (CASE
	        	WHEN a2.type = 1 AND a2.id != a1.id THEN CONCAT(c2.first_name," ",c2.last_name)
	        	ELSE ""
	        END) AS transcation_user_receiver

        FROM financials_transactions tr

        INNER JOIN financials_accounts a1 ON tr.sender = a1.id
        INNER JOIN financials_accounts a2 ON tr.receiver = a2.id

        INNER JOIN financials_transactions_types t ON tr.type = t.id

        LEFT JOIN financials_accounts_names n1 ON a1.id = n1.id
        LEFT JOIN characters c1 ON a1.owner = c1.id
        LEFT JOIN `database-name`.groups g1 ON a1.owner = g1.id

        LEFT JOIN financials_accounts_names n2 ON a2.id = n2.id
        LEFT JOIN characters c2 ON a2.owner = c2.id
        LEFT JOIN `database-name`.groups g2 ON a2.owner = g2.id

        LEFT JOIN characters c3 ON tr.user = c3.id

        WHERE (tr.sender = :accountId) OR (tr.receiver = :accountId)

        ORDER BY tr.id DESC
        LIMIT 50
    ]],
    { accountId = pAccountId })

    for i, v in ipairs(transactions) do
        if (v.transcation_type == "withdraw") or (has_value(negativeTransactions, v.transcation_type) and pAccountId ~= v.transcation_receiver) then
            v.transcation_amount = -v.transcation_amount
        end
    end

    return transactions
end)