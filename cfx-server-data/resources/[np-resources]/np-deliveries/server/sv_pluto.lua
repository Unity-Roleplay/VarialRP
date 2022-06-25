local DISCORD_WEBHOOK5 = ""
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