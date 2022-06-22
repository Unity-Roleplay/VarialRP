RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('np-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('np-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('np-ems:heal')
AddEventHandler('np-ems:heal', function(target)
	TriggerClientEvent('np-ems:heal', target) 	
end)

RegisterServerEvent('np-ems:heal2')
AddEventHandler('np-ems:heal2', function(target)
	TriggerClientEvent('np-ems:big', target)
end)