--[[

    Functions

]]

local function checkExists(cid)
    local exist = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
    ]],
    { "cid", "stocks_characters", "cid", cid })

    if not exist then
        MySQL.insert.await([[
            INSERT INTO ?? (??)
            VALUES (?)
        ]],
        { "stocks_characters", "cid", cid })
    end

    return true
end

local function stocksData()
    local stocks = MySQL.query.await([[
        SELECT *
        FROM ??
    ]],
    { "stocks" })

    for i, v in ipairs(stocks) do
        stocks[i]["value"] = tonumber(v["value"])
        stocks[i]["change"] = tonumber(v["change"])
        stocks[i]["amount"] = tonumber(v["amount"])
    end

    return stocks
end

local function stockData(stock)
    if not stock then return false end

    local _stock = MySQL.single.await([[
        SELECT *
        FROM ??
        WHERE ?? = ?
    ]],
    { "stocks", "id", stock })

    if not _stock then return false end

    _stock["value"] = tonumber(_stock["value"])
    _stock["change"] = tonumber(_stock["change"])
    _stock["amount"] = tonumber(_stock["amount"])

    return _stock
end

local function stockUpdate(stock, info, value)
    if not stock or not info or not value then return false end

    MySQL.update.await([[
        UPDATE ??
        SET ?? = ?
        WHERE ?? = ?
    ]],
    { "stocks", info, value, "id", stock })

    return true
end

local function getStocks(_src, _cid)
    local src = source
    if _src then src = _src end

    local cid = 0
    if _cid then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return {} end

    local stocks = MySQL.single.await([[
        SELECT *
        FROM ??
        WHERE ?? = ?
    ]],
    { "stocks_characters", "cid", cid })

    if not stocks then return {} end

    local _stocks = {}
    for k, v in pairs(stocks) do
        if k ~= "cid" then
            _stocks[k] = v
        end
    end

    return _stocks
end

local function buyStock(stock, amount, _src)
    if not stock or not amount then return false end

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local _stockData = stockData(stock)
    if not _stockData then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Failed to retrieve stock data", 5000)
        return false
    end

    if amount > _stockData["amount"] then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Invalid amount", 5000)
        return false
    end

    local accountId = exports["np-base"]:getChar(src, "bankid")
    local bank = exports["np-financials"]:getBalance(accountId)
    local value = math.ceil(amount * _stockData["value"])

    if value > bank then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "You dont have this much in your bank account", 5000)
        return false
    end

    local comment = "Brought " .. amount .. " " ..stock
    local success, message = exports["np-financials"]:transaction(accountId, 7, value, comment, cid, 5)
    if not success then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", message, 5000)
        return false
    end

    if not stockUpdate(stock, "amount", _stockData["amount"] - amount) then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Stock update error", 5000)
        return false
    end

    MySQL.update.await([[
        UPDATE ??
        SET ?? = ?? + ?
        WHERE ?? = ?
    ]],
    { "stocks_characters", stock, stock, amount, "cid", cid })

    TriggerClientEvent("np-phone:notification", src, "fas fa-chart-bar", "Stocks", "You buyed " .. amount .. " " .. stock, 5000)

    return true
end

local function sellStock(stock, amount, _src)
    if not stock or not amount then return false end

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local _stockData = stockData(stock)
    if not _stockData then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Failed to retrieve stock data", 5000)
        return false
    end

    local _stocks = getStocks(src)
    if not _stocks[stock] then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Failed to retrieve stocks", 5000)
        return
    end

    if amount > _stocks[stock] then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Invalid amount", 5000)
        return false
    end

    local accountId = exports["np-base"]:getChar(src, "bankid")
    local value = math.ceil(amount * _stockData["value"])

    local comment = "Selled " .. amount .. " " ..stock
    local success, message = exports["np-financials"]:transaction(7, accountId, value, comment, 0, 5)
    if not success then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", message, 5000)
        return false
    end

    if not stockUpdate(stock, "amount", _stockData["amount"] + amount) then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Stock update error", 5000)
        return false
    end

    MySQL.update.await([[
        UPDATE ??
        SET ?? = ?? - ?
        WHERE ?? = ?
    ]],
    { "stocks_characters", stock, stock, amount, "cid", cid })

    TriggerClientEvent("np-phone:notification", src, "fas fa-chart-bar", "Stocks", "You selled " .. amount .. " " .. stock, 5000)

    return true
end

local function transferStock(stock, amount, _cid, _src)
    if not stock or not amount or not _cid then return false end

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    if cid == _cid then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Really dude?", 5000)
        return
    end

    local exist = characterExist(_cid)
    if not exist then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Invalid ID", 5000)
        return
    end

    checkExists(_cid)

    local _stocks = getStocks(src)
    if not _stocks[stock] then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Failed to retrieve stocks", 5000)
        return
    end

    if amount > _stocks[stock] then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Invalid amount", 5000)
        return false
    end

    local success = MySQL.transaction.await({
        {
            ["query"] = [[UPDATE ?? SET ?? = ?? - ? WHERE ?? = ?]],
            ["values"] = { "stocks_characters", stock, stock, amount, "cid", cid },
        },
        {
            ["query"] = [[UPDATE ?? SET ?? = ?? + ? WHERE ?? = ?]],
            ["values"] = { "stocks_characters", stock, stock, amount, "cid", _cid },
        },
    })

    if not success then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "Failed in transfer " .. amount .. " " .. stock .. " to ID: " .. _cid, 5000)
        return false
    end

    TriggerClientEvent("np-phone:notification", src, "fas fa-chart-bar", "Stocks", "You transfered " .. amount .. " " .. stock .. " to ID: " .. _cid, 5000)

    return true
end

local function StockUpdate()
    local stocks = stocksData()

    local function round(num, numDecimalPlaces)
        local mult = 10^(numDecimalPlaces or 0)
        return math.floor(num * mult + 0.5) / mult
    end

    for i, v in ipairs(stocks) do
        if v["id"] ~= "SHUNG" then
            local currentValue = v["value"]
            local random = math.random(-100.0, 100.0)

            local newValue = currentValue + random
            local lastChange = round((random * 100 / currentValue),2)

            if newValue > 1750.0 then
                newValue = 1750.0

                if currentValue >= 1750.0 then
                    lastChange = 0.00
                end
            end

            if newValue < 250.0 then
                newValue = 250.0

                if currentValue <= 250.0 then
                    lastChange = 0.00
                end
            end

            stockUpdate(v["id"], "value", newValue)
            stockUpdate(v["id"], "change", lastChange)
        end
    end
end

local function checkLastStockUpdate()
    local last_update = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
    ]],
    { "value", "variables", "name", "last_stock_update" })

    if last_update ~= nil then
        local lastupdate = tonumber(last_update)
            local curtime = os.time()

            if curtime > lastupdate then
                local nextupdate = os.time() + (math.random(86400, 172800)) -- 1-2 days

            local affectedRows = MySQL.update.await([[
                    UPDATE ??
                    SET ?? = ?
                    WHERE ?? = ?
                ]],
            { "variables", "value", nextupdate, "name", "last_stock_update" })

            if affectedRows and affectedRows ~= 0 then
                    StockUpdate()
            end
        end
    end
end

--[[

    Events

]]

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    checkExists(cid)
end)

--[[

    RPCs

]]

RPC.register("np-phone:stocksData", function(src)
    return stocksData()
end)

RPC.register("np-phone:getStocks", function(src)
    return getStocks(src)
end)

RPC.register("np-phone:buyStock", function(src, stock, amount)
    return buyStock(stock, amount, src)
end)

RPC.register("np-phone:sellStock", function(src, stock, amount)
    return sellStock(stock, amount, src)
end)

RPC.register("np-phone:transferStock", function(src, stock, amount, cid)
    return transferStock(stock, amount, cid, src)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    -- Citizen.Wait(60000)

    while true do
        checkLastStockUpdate()
        Citizen.Wait(3600000)
    end
end)