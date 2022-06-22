RegisterServerEvent('laptop1cash')
AddEventHandler('laptop1cash', function()
local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(2500)
end)

RegisterServerEvent('jimpass')
AddEventHandler('jimpass', function()
local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:removeMoney(2500)
end)