-- Green Tablet

RegisterNetEvent('np-robberies:geenGTabletSV')
AddEventHandler('np-robberies:geenGTabletSV', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'geentablet'})
            TriggerClientEvent('np-robberies:getGTablet', src)
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('np-robberies:removeQueueGreen')
AddEventHandler('np-robberies:removeQueueGreen', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

--- Blue Tablet --

RegisterNetEvent('np-robberies:blueBTabletSV')
AddEventHandler('np-robberies:blueBTabletSV', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'bluetablet'})
            TriggerClientEvent('np-robberies:getBTablet', src)
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('np-robberies:removeQueueBlue')
AddEventHandler('np-robberies:removeQueueBlue', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

--- Red Tablet --

RegisterNetEvent('np-robberies:redTabletSV')
AddEventHandler('np-robberies:redTabletSV', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
    exports.ghmattimysql:execute('SELECT * FROM tablet_queue WHERE cid = ?', {cid}, function(result2)
        if result2[1] ~= nil then
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are already in queue or you were recently in queue!'})
        else
            exports.ghmattimysql:execute("INSERT INTO tablet_queue (cid, type) VALUES (@cid, @type)", {['@cid'] = cid, ['@type'] = 'redtablet'})
            TriggerClientEvent('np-robberies:getRedTablet', src)
            TriggerClientEvent('np-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You have been placed in a queue!'})
        end
    end)
end)

RegisterNetEvent('np-robberies:removeQueueRed')
AddEventHandler('np-robberies:removeQueueRed', function()
    local src = source
    local cid = exports["np-exports"]:GetPlayerCid(src)
	exports.ghmattimysql:execute("DELETE FROM tablet_queue WHERE cid = @cid", {['cid'] = cid})
    TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You have been removed from the queue!'})
end)

AddEventHandler('onResourceStart', function(resourceName)
    exports.ghmattimysql:execute('DELETE FROM tablet_queue', {}, function (result) end)
end)