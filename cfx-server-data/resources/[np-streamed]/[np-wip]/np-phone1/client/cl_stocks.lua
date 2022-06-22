--[[

    Functions

]]

function loadStocks()
    local stocks = RPC.execute("np-phone:stocksData")
    local mystocks = RPC.execute("np-phone:getStocks")

    local _stocks = {}
    for i,v in ipairs(stocks) do
        table.insert(_stocks, {
            identifier = v["id"],
            name = v["name"],
            value = v["value"],
            change = v["change"],
            available = v["amount"],
            clientStockValue = mystocks[v["id"]],
        })
    end

    SendNUIMessage({
        openSection = "addStocks",
        stocksData = _stocks,
    })
end

--[[

    NUI

]]

RegisterNUICallback("btnStocks", function()
    loadStocks()
end)

RegisterNUICallback("stocksTransfer", function(data, cb)
    local stock = data["identifier"]
    local amount = tonumber(data["amount"])
    local cid = tonumber(data["playerid"])

    if not stock or not amount or not cid then return end

    local update = RPC.execute("np-phone:transferStock", stock, amount, cid)
    if update then
        loadStocks()
    end
end)

RegisterNUICallback("stocksBuy", function(data, cb)
    local stock = data["identifier"]
    local amount = tonumber(data["amount"])

    if not stock or not amount then return end

    local update = RPC.execute("np-phone:buyStock", stock, amount)
    if update then
        loadStocks()
    end
end)

RegisterNUICallback("stocksSell", function(data, cb)
    local stock = data["identifier"]
    local amount = tonumber(data["amount"])

    if not stock or not amount then return end

    local update = RPC.execute("np-phone:sellStock", stock, amount)
    if update then
        loadStocks()
    end
end)