SQL = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    exports.oxmysql:execute(query, parameters, function(result)
        if cb then
            cb(result)
        else
            res = result
            IsBusy = false
        end
    end)
    while IsBusy do
        Citizen.Wait(0)
    end
    return res
end

remoteCalls.register("np-banking:getBankingInfo", function()
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    TriggerClientEvent('banking:updateCash', src, user["PlayerData"]["cash"], true)
    TriggerClientEvent('banking:updateBalance', src, user["PlayerData"]["bank"], true)
    return user["PlayerData"]["first_name"], user["PlayerData"]["last_name"], user["PlayerData"]["bank"], user["PlayerData"]["cash"], user["PlayerData"]["id"]
end)

remoteCalls.register("np-banking:getBusiness", function()
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local result = SQL("SELECT business_name, rank FROM character_passes WHERE cid = @cid", {
        ["cid"] = user["PlayerData"]["id"]
    })

    local data = SQL("SELECT id, bank FROM group_banking WHERE group_type = @group_type", {
        ["group_type"] = result[1].business_name
    })

    if result[1] ~= nil or data[1] ~= nil then
        if result[1].rank >= 4 then
            return result[1].business_name, data[1].id, data[1].bank
        end
    else
        return nil 
    end
end)

remoteCalls.register("np-banking:bank:withdraw", function(pAmount, pComment, pDate)
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local ply = user["PlayerData"]["id"]
    local type = "neg"
    local iden = "WITHDRAW"
    local sender = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
    local target = sender
    local pSteam = GetPlayerName(src)
    if(not src or src == -1) then
        return
    end

    if pAmount <= 0 then
        TriggerClientEvent('DoShortHudText', src, 'Not enough money', 2)
    else
        exports['np-fw']:GetModule('RemoveBank')(src, pAmount)
        exports['np-fw']:GetModule('AddCash')(src, pAmount)
    end
    exports['np-fw']:sendToDiscord(pSteam, ""..sender.." Withdrew $"..pAmount .. " [Personal Account]", color, "https://discord.com/api/webhooks/XXXXXXXXXXXXXX-XXXXXXXXXXXXXX")
    TriggerEvent("np-banking:updaterecent", src, ply, pAmount, pComment, pDate, type, sender, target, iden) --adds to recent sql
    TriggerClientEvent("np-banking:refresh", src)

    return true
end)

remoteCalls.register("np-banking:bank:deposit", function(pAmount, pComment, pDate)
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local ply = user["PlayerData"]["id"]
    local type = "pos"
    local iden = "DEPOSIT"
    local sender = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
    local target = sender
    local pSteam = GetPlayerName(src)
    if(not src or src == -1) then
        return
    end

    if pAmount <= 0 then
        TriggerClientEvent('DoShortHudText', src, 'Not enough money', 2)
    else
        exports['np-fw']:GetModule('RemoveCash')(src, pAmount)
        exports['np-fw']:GetModule('AddBank')(src, pAmount)
    end
    exports['np-fw']:sendToDiscord(pSteam, ""..sender.." Deposited $"..pAmount .. " [Personal Account]", color, "https://discord.com/api/webhooks/XXXXXXXXXXXXXX/XXXXXXXXXXXXXX-usk7Iun_35DxwL")
    TriggerEvent("np-banking:updaterecent", src, ply, pAmount, pComment, pDate, type, sender, target, iden) --adds to recent sql
    TriggerClientEvent("np-banking:refresh", src)

    return true
end)

remoteCalls.register("np-banking:bank:transfer", function(pAmount, pComment, pId, pDate)
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local user2 = exports['np-fw']:GetModule('GetPlayer')(tonumber(pId))

    local sendertype = "neg"
    local receivertype = "pos"
    local iden = "TRANSFER"
    local sender = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
    local ply = user["PlayerData"]["id"]
    local pSteam = GetPlayerName(src)
    if(not src or src == -1) then
        return
    end

    local result = SQL("SELECT first_name, last_name FROM characters WHERE id = @cid", {
        ["cid"] = other
    })


    local target = user2["PlayerData"]["first_name"] .. " " .. user2["PlayerData"]["last_name"]

    if pId == src then
        TriggerClientEvent('DoLongHudText', src, "You can't transfer money to yourself!", 2)
        return
    end
    
    TriggerClientEvent("np-banking:refresh", src)

    if comment == nil then
        comment = ""
    end

    if pAmount <= 0 then
        TriggerClientEvent('DoShortHudText', src, 'Invaild Amount', 2)
    else
        if tonumber(pAmount) <= exports['np-fw']:GetModule('GetBalance')(src) then
            exports['np-fw']:GetModule('RemoveBank')(src, pAmount)
            exports['np-fw']:GetModule('AddBank')(tonumber(pId), pAmount)
            TriggerEvent("np-banking:updaterecent", src, ply, pAmount, pComment, pDate, sendertype, sender, target, iden)
            TriggerEvent("np-banking:updaterecent", pId, other, pAmount, pComment, pDate, receivertype, sender, target, iden)
        else
            TriggerClientEvent('DoShortHudText', src, 'Not enough money', 2)
        end
    end
    
    exports['np-fw']:sendToDiscord(pSteam, ""..sender.." Transferred $"..pAmount .. " to " .. target .. " [Personal Account]", color, "https://discord.com/api/webhooks/XXXXXXXXXXXXXX/XXXXXXXXXXXXXX")

    return true
end)

-- BIZ STUFF

remoteCalls.register("np-banking:business:withdraw", function(pAmount, pComment, pDate, pBizName)
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local ply = user["PlayerData"]["id"]
    local type = "neg"
    local iden = "WITHDRAW"
    local sender = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
    local target = sender

    SQL("UPDATE group_banking SET bank = bank - @amount WHERE group_type = @group_type", {
        ["amount"] = pAmount,
        ["group_type"] = pBizName
    })

    exports['np-fw']:GetModule('AddCash')(src, pAmount)

    TriggerEvent("np-banking:updaterecentBiz", src, pBizName, pAmount, pComment, pDate, type, sender, target, iden)
    TriggerClientEvent("np-banking:refreshBiz", src, pBizName)

    return true
end)

remoteCalls.register("np-banking:business:deposit", function(pAmount, pComment, pDate, pBizName) --recode
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    local ply = user["PlayerData"]["id"]
    local type = "pos"
    local iden = "DEPOSIT"
    local sender = user["PlayerData"]["first_name"] .. " " .. user["PlayerData"]["last_name"]
    local target = sender

    if pAmount <= 0 then
        TriggerClientEvent('DoShortHudText', src, 'Invaild Amount', 2)
    else
        if tonumber(pAmount) <= exports['np-fw']:GetModule('GetBalance')(src) then
            exports['np-fw']:GetModule('RemoveCash')(src, pAmount)

            SQL("UPDATE group_banking SET bank = bank + @amount WHERE group_type = @group_type", {
                ["amount"] = pAmount,
                ["group_type"] = pBizName
            })
        else
            TriggerClientEvent('DoShortHudText', src, 'Not enough money', 2)
        end
    end

    TriggerEvent("np-banking:updaterecentBiz", src, pBizName, pAmount, pComment, pDate, type, sender, target, iden)
    TriggerClientEvent("np-banking:refreshBiz", src, pBizName)

    return true
end)

remoteCalls.register("np-banking:business:transfer", function(pAmount, pComment, pId, pDate, pBizName)
    local src = source
    -- local sender = exports["np-base"]:getModule("Player"):GetUser(src)
    -- local senderchar = sender:getCurrentCharacter()
    -- local player = exports["np-base"]:getModule("Player"):GetUser(tonumber(pId))
    -- local type = "neg"
    -- local iden = "TRANSFER"
    -- local bizsender = pBizName
    
    -- local result2 = SQL("SELECT first_name, last_name, bankid FROM characters WHERE id = @cid", {
    --     ["cid"] = senderchar.id
    -- })
    -- local firstname = result2[1].first_name lastname = result2[1].last_name
    -- local sender = firstname.. " " ..lastname
    -- local result = SQL("SELECT first_name, last_name FROM characters WHERE id = @cid", {
    --     ["cid"] = pId
    -- })
    -- local fn2 = result[1].first_name
    -- local ln2 = result[1].last_name
    -- local target = fn2.. " ".. ln2

    TriggerClientEvent('DoLongHudText', src, "Coming Soon", 2)

    return true
end)

RegisterServerEvent("np-banking:updaterecentBiz")
AddEventHandler("np-banking:updaterecentBiz", function(src, bizname, amount, comment, date, type, sender, target, iden)
    exports.oxmysql:execute('INSERT INTO character_business_statments (bizname, sender, target, label, amount, iden, type, date) VALUES (@bizname, @sender, @target, @label, @amount, @iden, @type, @date)', {
        ['bizname'] = bizname,
        ['sender'] = sender,
        ['target'] = target,
        ['label'] = comment,
        ['amount'] = amount,
        ['iden'] = iden,
        ['type'] = type,
        ['date'] = date
    }, function(result)
        TriggerClientEvent("np-banking:refreshBiz", src, bizname)
    end)
end)

-- BIZ STUFF

RegisterServerEvent("np-banking:updaterecent")
AddEventHandler("np-banking:updaterecent", function(src, maincid, amount, comment, date, type, sender, target, iden)
    local src = source
    exports.oxmysql:execute('INSERT INTO character_bank_statments (cid, sender, target, label, amount, iden, type, date) VALUES (@cid, @sender, @target, @label, @amount, @iden, @type, @date)', {
        ['cid'] = maincid,
        ['sender'] = sender,
        ['target'] = target,
        ['label'] = comment,
        ['amount'] = amount,
        ['iden'] = iden,
        ['type'] = type,
        ['date'] = date
    }, function(result)
        TriggerClientEvent("np-banking:refresh", src)
    end)
end)

remoteCalls.register("np-banking:bank:recent", function()
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)

    local result = SQL("SELECT id, sender, target, label, amount, iden, type, date FROM character_bank_statments WHERE cid = @identifier", {
        ["identifier"] = user["PlayerData"]["id"]
    })
    return result
end)

remoteCalls.register("np-banking:business:recent", function(pBizName)
    local result = SQL("SELECT id, sender, target, label, amount, iden, type, date FROM character_business_statments WHERE bizname = @bizname", {
        ["bizname"] = pBizName
    })
    return result
end)

RegisterCommand('cash', function(source, args)
    local src = source
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    TriggerClientEvent('banking:updateCash', source, user["PlayerData"]["cash"], true)
end)

RegisterServerEvent('cash:remove')
AddEventHandler('cash:remove', function(src, amount)
    local user = exports['np-fw']:GetModule('GetPlayer')(src)
    exports['np-fw']:GetModule('RemoveCash')(src, tonumber(amount))
end)

RegisterCommand('givecash', function(source, args)
    if tonumber(args[2]) then
        TriggerClientEvent("bank:givecash", source, source, args[1], tonumber(args[2]))
    end
end)

RegisterServerEvent('bank:givemecash')
AddEventHandler('bank:givemecash', function(sender, reciever, amount)
    local src = source

    local user = exports['np-fw']:GetModule('GetPlayer')(src)

    local user2 = exports['np-fw']:GetModule('GetPlayer')(tonumber(reciever))

    local pSteam = GetPlayerName(src)

    local senderfirstname = user["PlayerData"]["first_name"]
    local senderlastname = user["PlayerData"]["last_name"]
    local receiverfirstname = user2["PlayerData"]["first_name"]
    local receiverlastname = user2["PlayerData"]["last_name"]

    if tonumber(amount) <= 0 then
        TriggerClientEvent('DoShortHudText', sender, 'Invaild Amount', 2)
    else
        if tonumber(amount) <= exports['np-fw']:GetModule('GetCash')(src) then
            exports['np-fw']:GetModule('RemoveCash')(src, amount)
            exports['np-fw']:GetModule('AddCash')(tonumber(reciever), amount)
            TriggerClientEvent("DoLongHudText", user["PlayerData"]["source"], "You have handed $" ..amount.. " to ID: " ..reciever)
            TriggerClientEvent("DoLongHudText", user2["PlayerData"]["source"], "You have been handed $"..amount.." from ID: " ..sender)
            exports['np-fw']:sendToDiscord(pSteam, ""..senderfirstname.." "..senderlastname.." Gave $ "..amount .. " to "..receiverfirstname.." "..receiverlastname.."", color, "https://discord.com/api/webhooks/XXXXXXXXXXXXXX/XXXXXXXXXXXXXX-XXXXXXXXXXXXXX-ot2cWOHf-mvLnNVZ")
        else
            TriggerClientEvent('DoShortHudText', sender, 'Not enough money', 2)
        end 
    end
end)
