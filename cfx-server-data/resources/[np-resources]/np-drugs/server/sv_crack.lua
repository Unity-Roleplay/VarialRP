local DISCORD_WEBHOOK5 = "https://discord.com/api/webhooks/997869410071097444/-TfGK0qJPc6BEUfUtPqCin1jhVkaNhUHcBzSBi_mYKUFbRC9x0C5CfWqSC4ybnqemjpq"
local DISCORD_NAME5 = "Crack Selling Logs"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png" -- default is FiveM logo

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterServerEvent('crack:givemoney')
AddEventHandler('crack:givemoney', function(money)
    local source = source
    local player = GetPlayerName(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
        if money > 300 then
        	sendToDiscord5("Crack Selling Logs", "Player ID: ".. source ..", Steam: ".. player ..",  Just Received $".. money .." From Selling Crack.")
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