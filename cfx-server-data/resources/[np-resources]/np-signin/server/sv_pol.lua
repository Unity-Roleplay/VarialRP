local activepolice = 0

RegisterServerEvent('reset:blips')
AddEventHandler('reset:blips', function()
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local characterID = user:getCurrentCharacter().id
	exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {['cid'] = characterID}, function(result)
        if result[1] then
			if  result[1].pass_type == "police" then
				TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'police')
				if activepolice > 1 then
					activepolice = activepolice - 1
				else
					activepolice = 0
				end
				TriggerClientEvent("job:counts", -1, activepolice)
			elseif result[1].pass_type == "ems" then
				TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'ems')
			end
		end
	end)
end)