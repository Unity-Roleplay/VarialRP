RegisterServerEvent('GPSTrack:Accepted')
AddEventHandler('GPSTrack:Accepted', function(x,y,z,stage)
	local srcid = source
	TriggerClientEvent("GPSTrack:Accepted",-1,x,y,z,srcid,stage)
end)


RegisterServerEvent('car:spotlight')
AddEventHandler('car:spotlight', function(state)
	local serverID = source
	TriggerClientEvent('car:spotlight', -1, serverID, state)
end)

RegisterNetEvent("facewear:adjust")
AddEventHandler("facewear:adjust", function(pTargetId, pType, pShouldRemove)
	TriggerClientEvent("facewear:adjust", pTargetId, pType, pShouldRemove)
end)

RegisterCommand("anchor", function(source, args, rawCommand)
    TriggerClientEvent('client:anchor', source)
end)

RegisterServerEvent("actionclose")
AddEventHandler("actionclose", function(string, Coords)
	TriggerClientEvent("Do3DText", -1, string, source, Coords)
end)

RegisterServerEvent('np-hud:buy_can')
AddEventHandler('np-hud:buy_can', function()
	local src = source
	local user = exports['np-base']:getModule('Player'):GetUser(src)

	if user:getCash() >= 200 then
		user:removeMoney(200)
		TriggerClientEvent('player:receiveItem', src, '883325847', 1)
	else
		TriggerClientEvent('DoLongHudText', src, 'You do not have enough money.', 2)
	end
end)

RegisterServerEvent('carfill:checkmoney')
AddEventHandler('carfill:checkmoney', function(costs)
	local src = source
	local player = exports["np-base"]:getModule("Player"):GetUser(src)

	if player:getCash() >= costs then
		TriggerClientEvent("RefuelCarServerReturn", src)
		player:removeMoney(costs)
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('DoLongHudText', src, "Requires $" .. costs)
	end
end)

RegisterServerEvent('np-hud:UpdateStress_SV')
AddEventHandler('np-hud:UpdateStress_SV',function(amount)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	exports.oxmysql:execute("UPDATE characters SET `stress_level` = ? WHERE id = ?",{amount, characterId})
end)


RegisterServerEvent("police:update:hud")
AddEventHandler("police:update:hud", function(health, armour, thirst, hunger)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getCurrentCharacter().id
	if user ~= false then
		meta = { 
			["health"] = health,
			["armour"] = armour,
			["thirst"] = thirst,
			["hunger"] = hunger
		}

		local encode = json.encode(meta)
		exports.oxmysql:execute('UPDATE characters SET metaData = ? WHERE id = ?', {encode, characterId})
	end
end)

RegisterServerEvent('police:SetMeta')
AddEventHandler('police:SetMeta', function()
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.oxmysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(result)
        TriggerClientEvent("police:setClientMeta", src, json.decode(result[1].metaData))
		TriggerClientEvent('client:updateStress', src, result[1].stress_level)
	end)
end)


RegisterServerEvent('police:setEmoteData')
AddEventHandler('police:setEmoteData', function(emoteTable)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	local emote = json.encode(emoteTable)
	exports.oxmysql:execute("UPDATE characters SET `emotes` = @emotes WHERE id = @cid", {['emotes'] = emote, ['cid'] = char.id})
end)

RegisterServerEvent('police:setAnimData')
AddEventHandler('police:setAnimData', function(AnimSet)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	local metaData = json.encode(AnimSet)
	exports.oxmysql:execute("UPDATE characters SET `meta` = @metaData WHERE id = @cid", {['metaData'] = metaData, ['cid'] = char.id})
end)



RegisterServerEvent('police:getAnimData')
AddEventHandler('police:getAnimData', function()
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

	exports.oxmysql:execute("SELECT meta FROM characters WHERE id = @cid", {['cid'] = char.id}, function(result)
		if (result[1]) then
			if not result[1].meta then
				TriggerClientEvent('checkDNA', src)
			else
				local sex = json.decode(result[1].meta)
			if sex == nil then
				TriggerClientEvent('CheckDNA',src)
				return
			end
			TriggerClientEvent('emote:setAnimsFromDB', src, result[1].meta)
			end
		end
	end)
end)


RegisterServerEvent('void:getmapprefrence')
AddEventHandler('void:getmapprefrence', function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    exports.oxmysql:execute("SELECT minimap FROM characters WHERE id = @cid", {['cid'] = char.id}, function(result)
        if result[1].minimap == 1 then
			TriggerClientEvent('minimapchecked',src)
			if result[1].minimap == 0 then
				TriggerEvent('minimapunchecked',src)
			end
        end
    end)
end)

RegisterNetEvent("np-hud:getping:sv")
AddEventHandler("np-hud:getping:sv", function()
    local src = source 
    local ping = GetPlayerPing(src)
    TriggerClientEvent("np-hud:getping:cl", src, ping)
end)