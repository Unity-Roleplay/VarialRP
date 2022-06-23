RegisterNetEvent("np-financials:ui")
AddEventHandler("np-financials:ui", function(type, change, amount, amount2)
    if change == "+" then
        change = "add"
    elseif change == "-" then
        change = "remove"
    end

    SendNUIMessage({
		[change..type] = true,
		["amount"] = amount,
        ["amount2"] = amount2,
	})
end)