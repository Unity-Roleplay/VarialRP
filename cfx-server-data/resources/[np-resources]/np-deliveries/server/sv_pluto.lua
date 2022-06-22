local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/870021174283886624/C71wdxQBmf_B0H6ZQDR7DTQHpJHLgjof95QU7L90Mso8xgrKcwB3qHoFA1MgE2rELq-q"
local DISCORD_NAME5 = "Sell Items Log"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}



RegisterServerEvent('sell:stolenitemspluto')
AddEventHandler('sell:stolenitemspluto', function(type, money)    
    local src = source
    local player = GetPlayerName(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
        if money > 300 then
            sendToDiscord5("Sell Items Log", "Player ID: ".. source ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Stolen Items.")
    	end
	end
end)