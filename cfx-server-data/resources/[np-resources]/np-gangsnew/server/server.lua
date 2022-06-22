RegisterServerEvent("unwind-gangs:server:setgang")
AddEventHandler("unwind-gangs:server:setgang", function(svid, gang, rank)
    local pSrc = source
    local pUser = exports["np-base"]:getModule("Player"):GetUser(svid)
    local pSteam = pUser:getCurrentCharacter().owner
    local pCid = pUser:getCurrentCharacter().id
	local count = 0
    exports.ghmattimysql:execute('SELECT * FROM characters_gangs', {}, function(players)
		for j = 1, #players do			 
			if players[j].gang == gang then
				count = count + 1
			end
		end	
        exports.ghmattimysql:execute('SELECT * FROM characters_gangs WHERE `owner` = @owner', { ['@owner'] = pSteam }, function(result)
            if result[1] ~= nil then
                -- UPDATE if exists
                exports.ghmattimysql:execute("UPDATE characters_gangs SET `owner` = @owner, `cid` = @cid, `gang` = @gang, `rank` = @rank WHERE `owner` = @zeb", {
                    ['zeb'] = pSteam, 
                    ['owner'] = pSteam, 
                    ['cid'] = pCid,
                    ['gang'] = gang,
                    ['rank'] = rank
                })
                TriggerClientEvent("DoLongHudText", pSrc, "You have successfully added "..pCid.." to "..gang..".")
                TriggerClientEvent("DoLongHudText", svid, "You have been updated to"..Config["Gangs"][gang].label.." Member with the rank of "..rank..".")
            else
                -- INSERT if not exists
                if tonumber(count) > tonumber(Config["Gangs"][gang].max_members) then
                    TriggerClientEvent("DoLongHudText", pSrc, Config["Gangs"][gang].label.." is full.",2)
                else
                    
                    exports.ghmattimysql:execute("INSERT INTO characters_gangs SET `owner` = @owner, `cid` = @cid, `gang` = @gang, `rank` = @rank", {
                        ['owner'] = pSteam, 
                        ['cid'] = pCid,
                        ['gang'] = gang,
                        ['rank'] = rank
                    })
                    TriggerClientEvent("DoLongHudText", pSrc, "You have successfully added "..pCid.." to "..gang..".")
                    TriggerClientEvent("DoLongHudText", svid, "You became a "..Config["Gangs"][gang].label.." Member with the rank of "..rank..".")
                end
            end
        end)
    end)
end)

RegisterServerEvent("unwind-gangs:server:firegang")
AddEventHandler("unwind-gangs:server:firegang", function(svid)
    local pSrc = source
    local SUser = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local SSteam = SUser:getCurrentCharacter().owner
    local pUser = exports["np-base"]:getModule("Player"):GetUser(svid)
    local pCid = pUser:getCurrentCharacter().id
    exports.ghmattimysql:execute('SELECT * FROM characters_gangs WHERE `owner` = @owner', { ['@owner'] = SSteam }, function(result)
        if tonumber(result[1]) ~= nil then
            local gang = result[1].gang
            local SrcRank = tonumber(result[1].rank)
            if SrcRank == 5 then
                exports.ghmattimysql:execute("DELETE FROM characters_gangs WHERE cid = @cid", {['@cid'] = pCid})
            else
                TriggerClientEvent("DoLongHudText", pSrc,"You are not the boss mf.",2)
            end
        else
            TriggerClientEvent("DoLongHudText", pSrc,"You can't do this.",2)
        end
    end)
end)

RegisterServerEvent("unwind-gangs:server:addmember")
AddEventHandler("unwind-gangs:server:addmember", function(svid, rank)
    local pSrc = source
    local SUser = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local SSteam = SUser:getCurrentCharacter().owner
    local pUser = exports["np-base"]:getModule("Player"):GetUser(svid)
    local pSteam = pUser:getCurrentCharacter().owner
    local pCid = pUser:getCurrentCharacter().id
	local count = 0
    exports.ghmattimysql:execute('SELECT * FROM characters_gangs WHERE `owner` = @owner', { ['@owner'] = SSteam }, function(result)
        if tonumber(result[1]) ~= nil then
            local SrcRank = tonumber(result[1].rank)
            if SrcRank == 5 then
                local gang = result[1].gang
                exports.ghmattimysql:execute('SELECT * FROM characters_gangs', {}, function(players)
                    for j = 1, #players do			 
                        if players[j].gang == gang then
                            count = count + 1
                        end
                    end	
                
                    if tonumber(count) > tonumber(Config["Gangs"][gang].max_members) then
                        TriggerClientEvent("DoLongHudText", pSrc, Config["Gangs"][gang].label.." is full.",2)
                    else
                        exports.ghmattimysql:execute('SELECT * FROM characters_gangs WHERE `owner` = @owner', { ['@owner'] = pSteam }, function(result)
                            if result[1] ~= nil then
                                -- UPDATE if exists
                                exports.ghmattimysql:execute("UPDATE characters_gangs SET `owner` = @owner, `cid` = @cid, `gang` = @gang, `rank` = @rank WHERE `owner` = @zeb", {
                                    ['zeb'] = pSteam, 
                                    ['owner'] = pSteam, 
                                    ['cid'] = pCid,
                                    ['gang'] = gang,
                                    ['rank'] = rank
                                })
                                TriggerClientEvent("DoLongHudText", pSrc, "You have successfully added "..pCid.." to "..gang..".")
                                TriggerClientEvent("DoLongHudText", svid, "You have been updated to"..Config["Gangs"][gang].label.." Member with the rank of "..rank..".")
                            else
                                -- INSERT if not exists
                                if tonumber(count) > tonumber(Config["Gangs"][gang].max_members) then
                                    TriggerClientEvent("DoLongHudText", pSrc, Config["Gangs"][gang].label.." is full.",2)
                                else
                                    
                                    exports.ghmattimysql:execute("INSERT INTO characters_gangs SET `owner` = @owner, `cid` = @cid, `gang` = @gang, `rank` = @rank", {
                                        ['owner'] = pSteam, 
                                        ['cid'] = pCid,
                                        ['gang'] = gang,
                                        ['rank'] = rank
                                    })
                                    TriggerClientEvent("DoLongHudText", pSrc, "You have successfully added "..pCid.." to "..gang..".")
                                    TriggerClientEvent("DoLongHudText", svid, "You became a "..Config["Gangs"][gang].label.." Member with the rank of "..rank..".")
                                end
                            end
                        end)
                    end
                end)
            else
                TriggerClientEvent("DoLongHudText", pSrc,"You are not the boss mf.",2)
            end
        else
            TriggerClientEvent("DoLongHudText", pSrc,"You can't do this.",2)
        end
    end)
end)



-- RPC.register("unwind-gangs:server:getgang", function()
--     local GangData = {}
--     local pSrc = source
--     local pUser = exports["np-base"]:getModule("Player"):GetUser(pSrc)
--     local pCid = pUser:getCurrentCharacter().id
--     exports.ghmattimysql:execute("SELECT * FROM characters_gangs WHERE cid= ?", {pCid}, function(data3)
--         if data3[1] ~= nil then
--             print(data3[1].gang)
--             if data3[1].gang ~= nil then
--                 GangData = {
--                     gang = data3[1].gang,
--                     rank = data3[1].rank,
--                 }
--                 Wait(200)
--                 return GangData
--             else
--                 return false
--             end
--         end
--     end)
-- end)


RPC.register('unwind-gangs:server:getgang', function(source, Cb)
    local GangData = {}
    local pSrc = source
    local pUser = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local pCid = pUser:getCurrentCharacter().id
    exports.ghmattimysql:execute("SELECT * FROM characters_gangs WHERE cid= ?", {pCid}, function(data3)
        if data3[1] ~= nil then
            if data3[1].gang ~= nil then
                GangData = {
                    gang = data3[1].gang,
                    rank = data3[1].rank,
                }
            end
        end
    end)
    Wait(200)
    return(GangData)
end)