RegisterServerEvent('fleeca')
AddEventHandler('fleeca', function()
local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(1000)
end)

RegisterServerEvent('PaletoBank')
AddEventHandler('PaletoBank', function()
local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(2000)
end)

RegisterServerEvent('BigBank')
AddEventHandler('BigBank', function()
local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(5000)
end)