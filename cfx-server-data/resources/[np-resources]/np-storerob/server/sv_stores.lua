RegisterNetEvent("mission:completed")
AddEventHandler("mission:completed", function(amount)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local remove = tonumber(amount)
    user:addMoney(remove)
    TriggerClientEvent('isPed:UpdateCash', src, user:getCash())
end)