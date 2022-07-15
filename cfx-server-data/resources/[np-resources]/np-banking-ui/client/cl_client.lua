RegisterNetEvent('banking:updateBalance', function(balance, show)
	SendNUIMessage({
		updateBalance = true,
		balance = balance,
		name = "",
		show = show
	})
end)

RegisterNetEvent('banking:updateCash', function(balance, show)
  	local id = PlayerId()
	SendNUIMessage({
		updateCash = true,
		cash = balance,
    	show = show
	})
end)

RegisterNetEvent("banking:viewBalance", function()
  SendNUIMessage({
    viewBalance = true
  })
end)

RegisterNetEvent("banking:addBalance", function(amount)
	SendNUIMessage({
		addBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeBalance", function(amount)
	SendNUIMessage({
		removeBalance = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:addCash", function(amount)
	SendNUIMessage({
		addCash = true,
		amount = amount
	})
end)

RegisterNetEvent("banking:removeCash", function(amount)
	SendNUIMessage({
		removeCash = true,
		amount = amount
	})
end)

RegisterNetEvent("np-base:addedMoney", function(amt, total)
	TriggerEvent("banking:updateCash", total)
	TriggerEvent("banking:addCash", amt)
end)

RegisterNetEvent("np-base:removedMoney", function(amt, total)
	TriggerEvent("banking:updateCash", total)
	TriggerEvent("banking:removeCash", amt)
end)
