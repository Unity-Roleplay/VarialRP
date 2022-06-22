local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/903025721243496518/GUUwv2Lg_W8xN8a_NIh3c7VOvdWfKHDMCX6Hv3nsWnmp8Ffuo9shSbG8ZGiJW07kTxbS"
local DISCORD_NAME5 = "Chicken Selling Logs"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png"

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterServerEvent('chickenpayment:pay')
AddEventHandler('chickenpayment:pay', function(money)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if money ~= nil then
        user:addMoney(money)

        exports["np-log"]:AddLog("Civ Jobs", 
            src, 
            "Chicken Payment", 
            { amount = tostring(money) })
        if money > 150 then
        	sendToDiscord5("Chicken Selling Logs", "Player ID: ".. src ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Chicken.")
    	end
	end
end)


function sendToDiscord5(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
      }
    }
    PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

