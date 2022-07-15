Citizen.CreateThread(function()
	while true do
		Citizen.Wait((60 * 1000) * 45) -- 45 mins
		TriggerClientEvent('np-paycheck:client:call', -1)
		print("^1[np-banking] Paychecks Sent^0")
	end
end)

RegisterServerEvent('np-paycheck:server:send', function(cid)
	local pSrc = source
    local user = exports['np-fw']:GetModule('GetPlayer')(pSrc)
    local userjob = exports['np-fw']:getPlayerJob(user)

    if userjob == "unemployed" then
        TriggerEvent("np-paycheck:server:add", pSrc, cid, userjob, 50, 50)
    elseif userjob == "police" or userjob == "sheriff" or userjob == "state" or userjob == "ems" then
        local numHit = exports['np-banking']:GetCurrentPayTax()
        setTax = math.ceil(1000 * numHit)
        setPaycheck = math.ceil(1000 - setTax)
        TriggerEvent("np-paycheck:server:add", pSrc, cid, userjob, 1000, setPaycheck)
    end
end)

RegisterServerEvent('np-paycheck:server:add', function(srcID, cid, pJob, oldAmount, newAmount)
	exports.oxmysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local totalAmount = data[1].paycheck + tonumber(newAmount)
		exports.oxmysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {totalAmount, cid})
		Citizen.Wait(500)
        if pJob == "unemployed" then
            TriggerClientEvent('DoLongHudText', srcID, 'A payslip of $'.. tonumber(oldAmount) ..' making a total of $' .. newAmount ..' with 0% tax withheld on your last payment.', 1)
        else
            TriggerClientEvent('DoLongHudText', srcID, 'A payslip of $'.. tonumber(oldAmount) ..' making a total of $' .. newAmount ..' with '.. math.floor(exports['np-banking']:GetCurrentPayTax() * 1000) / 10 .. '% tax withheld on your last payment.', 1)
        end
	end)
end)

RegisterNetEvent("np-paycheck:collect", function(cid)
	local pSrc = source
	exports.oxmysql:execute('SELECT `paycheck` FROM characters WHERE `id`= ?', {cid}, function(data)
		local amount = tonumber(data[1].paycheck)
		if amount > 0 then
			exports.oxmysql:execute("UPDATE characters SET `paycheck` = ? WHERE `id` = ?", {"0", cid})
            exports['np-fw']:GetModule('AddBank')(pSrc, amount)
		else
			TriggerClientEvent("DoLongHudText", pSrc, "You're broke, go work!")
		end
	end)
end)