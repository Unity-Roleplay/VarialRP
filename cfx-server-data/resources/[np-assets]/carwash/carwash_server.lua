RegisterServerEvent('carwash:checkmoney')
AddEventHandler('carwash:checkmoney', function()
	local src = source
	local player = exports["drp-base"]:getModule("Player"):GetUser(src)
	local costs = 70

	if player:getCash() >= costs then
		TriggerClientEvent("carwash:success", src, costs)
		player:removeMoney(costs)
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('carwash:notenoughmoney', src, moneyleft)
	end
end)