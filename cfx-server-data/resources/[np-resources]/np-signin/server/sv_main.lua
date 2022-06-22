local activepolice = 0


RegisterServerEvent("np-signin:duty")
AddEventHandler("np-signin:duty", function(pJobType, pSrc)
    local src = (pSrc == nil and source or pSrc)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local character = user:getCurrentCharacter()
    local jobs = exports["np-base"]:getModule("JobManager")
    if pJobType == nil then pJobType = "police" end
    jobs:SetJob(user, pJobType, false, function()
        if pJobType == "police" then
            exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)

                TriggerClientEvent("DoLongHudText", src, "10-41 and Restocked.", 1)
                TriggerClientEvent("startSpeedo", src)
                TriggerClientEvent("nowCopGarage", src, pJobType)
                TriggerEvent('badBlips:server:registerPlayerBlipGroup', src, 'police')
                if result[1].callsign == nil then
                    TriggerEvent("badBlips:server:registerSourceName", src, character.first_name .. " " ..character.last_name.. " | NO CALLSIGN")
                else
                    TriggerEvent("badBlips:server:registerSourceName", src, character.first_name .. " " ..character.last_name.. " | " .. result[1].callsign)
                end
                activepolice = activepolice + 1
                TriggerClientEvent("job:counts", -1, activepolice)
            end)

        elseif pJobType == "doc" then
            TriggerClientEvent("DoLongHudText", src, "10-41, Signed in as DOC.", 1)
            TriggerClientEvent("nowCopGarage", src, pJobType)
        elseif pJobType == "ems" then
            TriggerClientEvent("DoLongHudText", src, "10-41, Signed in as EMS.", 1)
            TriggerClientEvent("hasSignedOnEms", src)
            TriggerClientEvent('police:officerOnDuty', src)
            
        elseif pJobType == "judge" then
            TriggerClientEvent("isJudge", src)
            Wait(1000)
            TriggerEvent("isJudge", src)
        elseif pJobType == "doctor" then
            TriggerClientEvent("isDoctor", src)
            Wait(1000)
            TriggerEvent("isDoctor",src)
        elseif pJobType == "therapist" then
            TriggerClientEvent("isTherapist", src)
            Wait(1000)
            TriggerEvent("isTherapist", src)
        else
            TriggerClientEvent("DoLongHudText", src, ("You are now signed in as %s"):format(pJobType), 1)
        end
    end)
end)


RegisterServerEvent("np-signoff:duty")
AddEventHandler("np-signoff:duty", function(job)
	local src = source
    if job == 'police' then
        if activepolice > 1 then
            activepolice = activepolice - 1
        else
            activepolice = 0
        end
        TriggerClientEvent("job:counts", -1, activepolice)
        TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'police')
    elseif job == 'ems' then
        TriggerEvent('badBlips:server:removePlayerBlipGroup', src, 'ems')
    end
end)