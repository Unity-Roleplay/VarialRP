RegisterServerEvent('keys:send')
AddEventHandler('keys:send', function(player, data)
    TriggerClientEvent('keys:received', player, data)
end)

-- RegisterServerEvent("login:get:keys", function(cid)
--     local pSrc = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
--     exports.ghmattimysql:execute("SELECT `license_plate` FROM characters_cars WHERE cid = ?", {cid}, function(data)
--         if data[1] ~= nil then
--             for i = 1, #data do
--                 TriggerClientEvent("keys:addNew:login", pSrc, data[i].license_plate)
--             end
--         end
--     end)
-- end)