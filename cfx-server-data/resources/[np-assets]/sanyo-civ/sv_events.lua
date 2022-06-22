
-- misc sv events

RegisterServerEvent("kosta:gumball:money")
AddEventHandler("kosta:gumball:money",function ()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(1)
end)

RegisterServerEvent('kosta:vpn:money')
AddEventHandler('kosta:vpn:money', function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    if (user:getCash() >= 10000) then
        user:removeMoney(10000)
        TriggerClientEvent("player:receiveItem", src, 'vpnxj', 1)
        TriggerClientEvent("DoLongHudText", src, "Configuration was successful.")
        TriggerClientEvent("phone:addnotification", src, "The Seller","You have configured a new VPN.")
    else
        TriggerClientEvent("DoLongHudText", src, "Configuration failed. You are broke.", 2)
    end
end)