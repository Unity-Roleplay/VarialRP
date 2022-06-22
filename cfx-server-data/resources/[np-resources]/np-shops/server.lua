RegisterServerEvent("itemMoneyCheck")
AddEventHandler("itemMoneyCheck", function(itemType,askingPrice,location)
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= askingPrice) then
		user:removeMoney(askingPrice) 
		if askingPrice > 0 then
			TriggerClientEvent('np-notification:client:Alert', src, {style = 'info', duration = 3000, message = "Purchased"})
		end
		TriggerClientEvent("player:receiveItem",src,itemType,1)

	else
		TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent("shop:useVM:server")
AddEventHandler("shop:useVM:server", function(locatoion)
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (tonumber(pCash) >= 20) then
		TriggerClientEvent("shop:useVM:finish",src)
		user:removeMoney(20) 
	else
		TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You need 20$"})
	end
end)

local locations = {}
local itemTypes = {}

RegisterServerEvent("take100")
AddEventHandler("take100", function(tgtsent)
    local user = exports["np-base"]:getModule("Player"):GetUser(tgtsent)
    local char = user:getCurrentCharacter()
	user:removeMoney(100) 
end)

RegisterServerEvent("movieticket")
AddEventHandler("movieticket", function(askingPrice)
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= askingPrice) then
		user:removeMoney(askingPrice) 
		TriggerClientEvent("startmovies",src)
	else
		TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent('shops:GetIDCardSV')
AddEventHandler('shops:GetIDCardSV', function()
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if (user:getCash() >= 500) then
		user:removeMoney(500)
		TriggerClientEvent("player:receiveItem", src, 'idcard', 1)
	else
		TriggerClientEvent('np-notification:client:Alert', src, {style = 'error', duration = 3000, message = "Not enough money!"})
	end
end)

RegisterServerEvent("weapon:general:check")
AddEventHandler("weapon:general:check", function()
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local characterId = user:getVar("character").id

    local query = "SELECT licenses FROM `characters` WHERE id = ?"
    local result = Await(SQL.execute(query, characterId)) 

	notFound = true
	
    exports.ghmattimysql:execute("SELECT licenses FROM characters WHERE id = @id",{['id'] = characterId}, function(result)
        for _, i in pairs(result[1]) do
			print(json.encode(result[1]))
            for _, l in pairs(json.decode(i)) do
				print(json.encode(l))
				if (l.license == "Weapon") then 
					print(json.encode(l))
	                if (l.issued == 1) then
						TriggerClientEvent("weapon:general:yes", src, true)
						notFound = false
					end					
				end
            end
        end
    end)

	if notFound then
		TriggerClientEvent("weapon:general:no", src, true)
	end
	
end)