

RegisterServerEvent('np-civjobs:sell-gem-cash')
AddEventHandler('np-civjobs:sell-gem-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(74, 124)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Gem", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('np-civjobs:sell-stone-cash')
AddEventHandler('np-civjobs:sell-stone-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(35, 74)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Gem and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Stone", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('np-civjobs:sell-coal-cash')
AddEventHandler('np-civjobs:sell-coal-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(14, 65)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Coal and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Coal", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('np-civjobs:sell-diamond-cash')
AddEventHandler('np-civjobs:sell-diamond-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(265, 432)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Diamond and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Diamond", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('np-civjobs:sell-sapphire-cash')
AddEventHandler('np-civjobs:sell-sapphire-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(167, 245)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Sapphire and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Sapphire", 
        { amount = tostring(cash) })
end)

RegisterServerEvent('np-civjobs:sell-ruby-cash')
AddEventHandler('np-civjobs:sell-ruby-cash', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(187, 345)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You sold 1x Ruby and got $'..cash, 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Sell Ruby", 
        { amount = tostring(cash) })
end)