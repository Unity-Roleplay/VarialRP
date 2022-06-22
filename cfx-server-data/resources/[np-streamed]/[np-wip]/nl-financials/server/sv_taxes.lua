--[[

    Variables

]]

local Taxes = {}

--[[

    Functions

]]

function getTax(tax)
    if not tax or not Taxes[tax] then return 0 end

    return Taxes[tax]
end

function priceWithTax(price, tax)
    local porcentage = getTax(tax)
    local tax = math.ceil((price / 100) * porcentage)
    local total = math.ceil(price + tax)

    local data = {
        ["porcentage"] = porcentage,
        ["tax"] = tax,
        ["total"] = total,
    }

    return data
end

function addTax(tax, amount)
    if not tax or not amount then return end

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    if affectedRows and affectedRows ~= 0 then
        updateBalance(1, "+", amount)
    end
end

function addTaxFromValue(tax, amount)
    if not tax or not amount then return end

    local _tax = priceWithTax(amount, tax)

    amount = _tax["tax"]

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    if affectedRows and affectedRows ~= 0 then
        updateBalance(1, "+", amount)
    end
end

--[[

    Exports

]]

exports("getTax", getTax)
exports("priceWithTax", priceWithTax)
exports("addTax", addTax)
exports("addTaxFromValue", addTaxFromValue)

--[[

    RPCs

]]

RPC.register("np-financials:getTax", function(src, tax)
    return getTax(tax)
end)

RPC.register("np-financials:priceWithTax", function(src, price, tax)
    return priceWithTax(price, tax)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local result = MySQL.query.await([[
        SELECT tax, porcentage
        FROM financials_taxes
    ]])

    for i, v in ipairs(result) do
        Taxes[v.tax] = v.porcentage
    end
end)--[[

    Variables

]]

local Taxes = {}

--[[

    Functions

]]

function getTax(tax)
    if not tax or not Taxes[tax] then return 0 end

    return Taxes[tax]
end

function priceWithTax(price, tax)
    local porcentage = getTax(tax)
    local tax = math.ceil((price / 100) * porcentage)
    local total = math.ceil(price + tax)

    local data = {
        ["porcentage"] = porcentage,
        ["tax"] = tax,
        ["total"] = total,
    }

    return data
end

function addTax(tax, amount)
    if not tax or not amount then return end

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    if affectedRows and affectedRows ~= 0 then
        updateBalance(1, "+", amount)
    end
end

function addTaxFromValue(tax, amount)
    if not tax or not amount then return end

    local _tax = priceWithTax(amount, tax)

    amount = _tax["tax"]

    local affectedRows = MySQL.update.await([[
        UPDATE financials_taxes
        SET total = total + ?
        WHERE tax = ?
    ]],
    { amount, tax })

    if affectedRows and affectedRows ~= 0 then
        updateBalance(1, "+", amount)
    end
end

--[[

    Exports

]]

exports("getTax", getTax)
exports("priceWithTax", priceWithTax)
exports("addTax", addTax)
exports("addTaxFromValue", addTaxFromValue)

--[[

    RPCs

]]

RPC.register("np-financials:getTax", function(src, tax)
    return getTax(tax)
end)

RPC.register("np-financials:priceWithTax", function(src, price, tax)
    return priceWithTax(price, tax)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local result = MySQL.query.await([[
        SELECT tax, porcentage
        FROM financials_taxes
    ]])

    for i, v in ipairs(result) do
        Taxes[v.tax] = v.porcentage
    end
end)