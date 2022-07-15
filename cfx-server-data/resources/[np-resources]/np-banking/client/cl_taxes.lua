local currentSalesTaxes = 0

RegisterNetEvent('np-banking:SetSalesTaxes_CL', function(tdata)
    print(tdata)
    currentSalesTaxes = tdata
end)

exports('GetCurrentSalesTax', function()
    return currentSalesTaxes
end)