local currentCops = 0
local currentEMS = 0

RegisterServerEvent('np-duty:AttemptDuty')
AddEventHandler('np-duty:AttemptDuty', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	local job = pJobType and pJobType or 'police'
	exports.ghmattimysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		jobs:SetJob(user, job, false, function()
			TriggerClientEvent('np-duty:PDSuccess', src)
			TriggerClientEvent("DoLongHudText", src,"10-41 and Restocked.",17)
			TriggerClientEvent("startSpeedo",src)
			currentCops = currentCops + 1
			TriggerClientEvent("job:policecount", -1, currentCops)
			TriggerEvent('badBlips:server:registerPlayerBlipGroup', src, 'police')
			TriggerEvent("badBlips:server:registerSourceName", src, character.first_name .. " " ..character.last_name.. " | " .. result[1].callsign)
		end)
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyEMS')
AddEventHandler('np-duty:AttemptDutyEMS', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	local job = pJobType and pJobType or 'ems'
	exports.ghmattimysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		jobs:SetJob(user, job, false, function()
			TriggerClientEvent('np-duty:EMSSuccess', src)
			TriggerClientEvent("DoLongHudText", src,"On-Duty.",17)
			currentEMS = currentEMS + 1
			TriggerClientEvent("job:emscount", -1, currentEMS)
			TriggerEvent('badBlips:server:registerPlayerBlipGroup', src, 'ems')
			TriggerEvent("badBlips:server:registerSourceName", src, character.first_name .. " " ..character.last_name.. " | " .. result[1].callsign)
		end)
	end)
end)

RegisterServerEvent('np-duty:OffDutyComplete')
AddEventHandler('np-duty:OffDutyComplete', function()
	if currentCops ~= 0 then
		currentCops = currentCops - 1
	else
		currentCops = 0
	end
	TriggerClientEvent("job:policecount", -1, currentCops)
	TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'police')
end)

RegisterServerEvent('np-duty:OffDutyCompleteEMS')
AddEventHandler('np-duty:OffDutyCompleteEMS', function()
	if currentEMS ~= 0 then
		currentEMS = currentEMS - 1
	else
		currentEMS = 0
	end
	TriggerClientEvent("job:emscount", -1, currentEMS)
	TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'ems')
end)

RegisterServerEvent('np-duty:AttemptDutyJudge')
AddEventHandler('np-duty:AttemptDutyJudge', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'judge'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'judge', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:JudgeSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyDA')
AddEventHandler('np-duty:AttemptDutyDA', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'da'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'da', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:DASuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyPublic')
AddEventHandler('np-duty:AttemptDutyPublic', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'defender'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'defender', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:PublicSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyADA')
AddEventHandler('np-duty:AttemptDutyADA', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'ada'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'ada', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:ADASuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyPDM')
AddEventHandler('np-duty:AttemptDutyPDM', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'pdm'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'pdm', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:PDMSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutySanders')
AddEventHandler('np-duty:AttemptDutySanders', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'sanders'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'sanders', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:SandersSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('np-duty:AttemptDutyTow')
AddEventHandler('np-duty:AttemptDutyTow', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'towunion'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'towunion', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('np-duty:TowSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

AddEventHandler('playerDropped', function()
	local src = source
	if src ~= nil then
		local steamIdentifier = GetPlayerIdentifiers(src)[1]
		exports.ghmattimysql:execute('SELECT * FROM characters WHERE owner = ?', {steamIdentifier}, function(result)
			if result[1].job == 'police' then
				if currentCops ~= 0 then
					currentCops = currentCops - 1
				else
					currentCops = 0
				end
                print('Active PD:', currentCops)
                exports.ghmattimysql:execute("UPDATE characters SET `job` = @job WHERE `owner` = @owner", {['@owner'] = steamIdentifier, ['@job'] = 'unemployed'})
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'police')
				TriggerClientEvent('np-duty:OffDuty' ,src)
            elseif result[1].job == 'ems' then
                if currentEMS ~= 0 then
					currentEMS = currentEMS - 1
				else
					currentEMS = 0
				end
                print('Active EMS:', currentEMS)
				TriggerClientEvent('np-duty:OffDutyEMS' ,src)
                exports.ghmattimysql:execute("UPDATE characters SET `job` = @job WHERE `owner` = @owner", {['@owner'] = steamIdentifier, ['@job'] = 'unemployed'})
				TriggerClientEvent("job:emscount", -1, currentEMS)
				TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'ems')
			end
		end)
	end
end)


function SignOnRadio(src)

	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()

	local q = [[SELECT id, cid, job, callsign, rank FROM jobs_whitelist WHERE cid = @cid AND (job = 'police' or job = 'doc')]]
	local v = {["cid"] = char.id}

	exports.ghmattimysql:execute(q, v, function(results)
		if not results then return end
		local callsign = ""
		if results[1].callsign ~= nil and results[1].callsign == "" then callsign = results[1].callsign else callsign = "TBD" end
		if (src ~= nil and char.first_name ~= nil and char.last_name ~= nil) then
			TriggerClientEvent("DoLongHudText", "Sessioned!?", 2)
		else
			TriggerClientEvent("SignOnRadio", src)
		end
	end)
end

RegisterCommand('callsign', function(source, args)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		if result[1].job == 'police' or result[1].job == 'ems' then
			exports.ghmattimysql:execute("UPDATE jobs_whitelist SET `callsign` = @callsign WHERE cid = @cid", {['callsign'] = args[1], ['cid'] = character.id})
			TriggerClientEvent('police:setCallSign',src, args[1])
		else
			TriggerClientEvent('DoLongHudText', src, 'You are not Police or EMS!', 2)
		end
	end)
end)


RegisterServerEvent('np-duty:AttemptDutySuits')
AddEventHandler('np-duty:AttemptDutySuits', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["np-base"]:getModule("JobManager")
	local job = pJobType and pJobType or 'suits'
	exports.ghmattimysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		if result[1].job == "suits" then
			exports.ghmattimysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result2)
				jobs:SetJob(user, job, false, function()
					TriggerClientEvent('np-duty:SuitsSuccess', src)
					TriggerClientEvent("DoLongHudText", src,"On-Duty.",17)
					TriggerClientEvent("job:suitscount", -1, currentSuits)
				end)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,'You are not qualified for this', 2)
		end
	end)
end)




