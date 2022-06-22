RPC.register("unwind-carscrap:GetVehicleScrapState", function(pSource, data)
    local plate = tostring(data)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = @license_plate', {['@license_plate'] = plate}, function (result) 
        if result ~= nil then
            if result[1].vin == 1 then
                value =  true
            else
                value =  false
            end    
        else
            TriggerClientEvent('DoLongHudText', src, 'Cannot scrap local cars', 2)
        end
    end)
    Wait(100)
    return value
end)


RegisterServerEvent("unwind-carscrap:ScrappingRewardPls")
AddEventHandler("unwind-carscrap:ScrappingRewardPls", function(boneType)
    local src = source
    if boneType == "tyre" then
        TriggerClientEvent('player:receiveItem',src,"recyclablematerial", 15)
    elseif boneType == "door" then
        TriggerClientEvent('player:receiveItem',src,"recyclablematerial", 15)
    elseif boneType == "remains" then
        TriggerClientEvent('player:receiveItem',src,"rollcash", 5)
    end
end)


RegisterServerEvent("unwind-carscrap:DeleteScrappedVehVin")
AddEventHandler("unwind-carscrap:DeleteScrappedVehVin", function(data)
    local plate = tostring(data)
    exports.ghmattimysql:execute("DELETE FROM characters_cars WHERE `license_plate` = @license_plate", {['@license_plate'] = plate})
end)