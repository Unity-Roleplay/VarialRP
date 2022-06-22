local crashReports = {}

function checkOverwrites(char)
    local rev = nil
    if char.jail then
        rev = "jail"
    end

    return rev
end

AddEventHandler('playerDropped', function(reason)
    local src = source
    local name = GetPlayerName(src)
    local ped = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(ped)
    if string.find(reason,"crash") or string.find(reason, "timed out") or string.find(reason,"Exiting") or string.find(reason,"Disconnected") then
        print(name, playerCoords.x, playerCoords.y, playerCoords.z, reason)
        crashReports[name] = {}
        crashReports[name].timedOut = os.time()
        crashReports[name].coords = playerCoords
    end
end)

-- RegisterServerEvent("character:savespawns")
-- AddEventHandler("character:savespawns", function()
--     local src = source
--     local name = GetPlayerName(src)
--     local ped = GetPlayerPed(src)
--     local playerCoords = GetEntityCoords(ped)
    
--     print(name, playerCoords.x, playerCoords.y, playerCoords.z)
--     crashReports[name] = {}
--     crashReports[name].timedOut = os.time()
--     crashReports[name].coords = playerCoords

-- end)

RegisterServerEvent("character:loadspawns")
AddEventHandler("character:loadspawns", function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = tonumber(char.id)
    local name = GetPlayerName(src)
    exports.ghmattimysql:execute("SELECT ho.*, cm.cid, cm.building_type, hp.level, hp.illness, hp.time FROM character_motel cm LEFT JOIN __housedata ho on ho.cid = cm.cid LEFT JOIN hospital_patients hp on hp.cid = cm.cid WHERE cm.cid = @cid ",{
        ["@cid"] = cid
    },function(housingMotels)
        exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `cid` = @id', {
            ['@id'] = cid
        },function(housing_keys)
            if housingMotels[1] then
                local spawnData = {
                    ["overwrites"] = checkOverwrites(char),
                    ["hospital"] = {
                        ["illness"] = housingMotels[1].illness,
                        ["level"] = housingMotels[1].level,
                        ["time"] = housingMotels[1].time,
                    },
                    ["motelRoom"] = {
                        ["roomType"] = housingMotels[1].building_type,
                        ["cid"] = housingMotels[1].cid,
                    },
                    ["houses"] = {},
                    ["keys"] = {},
                }

                if crashReports[name] ~= nil then  
                    if (os.time() - crashReports[name].timedOut) < 600 then
                    local spawnData2 = {
                        ["crash"] = {
                            ['x'] = crashReports[name].coords.x,
                            ['y'] = crashReports[name].coords.y,
                            ['z'] = crashReports[name].coords.z
                        }
                    }
                    TriggerClientEvent("spawn:clientSpawnData",src,spawnData, spawnData2)
                else
                    crashReports[name] = nil
                    TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
                end
            else
                TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
            end
            else
                exports.ghmattimysql:execute("INSERT INTO character_motel (cid) VALUES (@cid)",{
                    ["cid"] = cid
                })
                exports.ghmattimysql:execute("INSERT INTO hospital_patients (cid,level,illness,time) VALUES (@cid,@level,@illness,@time)",{
                    ["cid"] = cid,
                    ["level"] = 0,
                    ["illness"] = "none",
                    ["time"] = 0
                })

                local spawnData = {
                    ["overwrites"] = "new",
                    ["hospital"] = {
                        ["illness"] = "none",
                        ["level"] = 0,
                        ["time"] = 0,
                    },
                    ["motelRoom"] = {
                        ["roomType"] = 1,
                        ["cid"] = cid,
                    },
                    ["houses"] = {},
                    ["keys"] = {},
                }
                TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
            end
        end)
    end)
end)


---------------------------

-- RegisterServerEvent("character:loadspawns")
-- AddEventHandler("character:loadspawns", function()
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local char = user:getCurrentCharacter()
--     local cid = tonumber(char.id)
--     local name = GetPlayerName(src)

--     exports.ghmattimysql:execute("SELECT ho.*, cm.cid, cm.building_type, hp.level, hp.illness, hp.time FROM character_motel cm LEFT JOIN houses ho on ho.cid = cm.cid LEFT JOIN hospital_patients hp on hp.cid = cm.cid WHERE cm.cid = @cid ",{
--         ["@cid"] = cid
--     },function(housingMotels)
--         exports.ghmattimysql:execute('SELECT * FROM houses WHERE `cid` = @id', {
--             ['@id'] = cid
--         },function(housing_keys)
--             if housingMotels[1] then
--                 local spawnData = {
--                     ["overwrites"] = checkOverwrites(char),
--                     ["hospital"] = {
--                         ["illness"] = housingMotels[1].illness,
--                         ["level"] = housingMotels[1].level,
--                         ["time"] = housingMotels[1].time,
--                     },
--                     ["motelRoom"] = {
--                         ["roomType"] = housingMotels[1].building_type,
--                         ["cid"] = housingMotels[1].cid,
--                     },
--                     ["houses"] = {},
--                     ["keys"] = {},
--                 }

--                 if crashReports[name] ~= nil then  
--                     if (os.time() - crashReports[name].timedOut) < 600 then
--                     local spawnData2 = {
--                         ["crash"] = {
--                             ['x'] = crashReports[name].coords.x,
--                             ['y'] = crashReports[name].coords.y,
--                             ['z'] = crashReports[name].coords.z
--                         }
--                     }
--                     TriggerClientEvent("spawn:clientSpawnData",src,spawnData, spawnData2)
--                 else
--                     crashReports[name] = nil
--                     TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
--                 end
--             else
--                 TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
--             end
--             else
--                 --This assumes a New Character
--                 exports.ghmattimysql:execute("INSERT INTO character_motel (cid) VALUES (@cid)",{
--                     ["cid"] = cid
--                 })
--                 exports.ghmattimysql:execute("INSERT INTO hospital_patients (cid,level,illness,time) VALUES (@cid,@level,@illness,@time)",{
--                     ["cid"] = cid,
--                     ["level"] = 0,
--                     ["illness"] = "none",
--                     ["time"] = 0
--                 })

--                 local spawnData = {
--                     ["overwrites"] = "new",
--                     ["hospital"] = {
--                         ["illness"] = "none",
--                         ["level"] = 0,
--                         ["time"] = 0,
--                     },
--                     ["motelRoom"] = {
--                         ["roomType"] = 1,
--                         ["cid"] = cid,
--                     },
--                     ["houses"] = {},
--                     ["keys"] = {},
--                 }
--                 TriggerClientEvent("spawn:clientSpawnData",src,spawnData)
--             end
--         end)
--     end)
-- end)