local paycheckTax = 0.2
local salesTax = 0.15

RegisterNetEvent('np-banking:SpawnAlert', function()
    local pSrc = source
    local paycheckTax = math.floor(exports['np-banking']:GetCurrentPayTax() * 1000) / 10
    local salesTax = math.floor(exports['np-banking']:GetCurrentSalesTax() * 1000) / 10
    TriggerClientEvent('DoLongHudText', pSrc, "Paycheck Tax: " .. paycheckTax .. "% | Sales Tax: " .. salesTax .. "%", 1)
end)

RegisterNetEvent('np-banking:GetTaxes', function()
    local pSrc = source
    exports.oxmysql:execute('SELECT paycheckTax FROM taxes', {}, function(data)
        if data[1] ~= nil then
            paycheckTax = data[1].paycheckTax
        end
    end)

    exports.oxmysql:execute('SELECT salesTax FROM taxes', {}, function(result)
        if result[1] ~= nil then
            salesTax = result[1].salesTax
            TriggerClientEvent('np-banking:SetSalesTaxes_CL', pSrc, result[1].salesTax)
        end
    end)
end)

exports('GetCurrentPayTax', function()
    return paycheckTax
end)

exports('GetCurrentSalesTax', function()
    return salesTax
end)