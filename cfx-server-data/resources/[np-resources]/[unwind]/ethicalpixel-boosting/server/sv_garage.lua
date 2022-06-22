local CoreName = nil
ESX = nil

if Config['General']["Core"] == "QBCORE" then
    if Config['CoreSettings']["QBCORE"]["Version"] == "new" then
        CoreName = Config['CoreSettings']["QBCORE"]["Export"]
    elseif Config['CoreSettings']["QBCORE"]["Version"] == "old" then
        TriggerEvent(Config['CoreSettings']["QBCORE"]["Trigger"], function(obj) CoreName = obj end)
    end
elseif Config['General']["Core"] == "ESX" then
    TriggerEvent(Config['CoreSettings']["ESX"]["Trigger"], function(obj) ESX = obj end)
end


RegisterServerEvent('ethicalpixel-boosting:AddVehicle')
AddEventHandler('ethicalpixel-boosting:AddVehicle', function(model, plate, vehicleProps)
    if Config['General']["Core"] == "QBCORE" then
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local vehicle = model
        local vehicleMods = "{}"
        SQL('INSERT INTO player_vehicles (steam, citizenid, vehicle, hash, mods, plate, state) VALUES (?, ?, ?, ?, ?, ?, ?)',{
            pData.PlayerData.steam,
            pData.PlayerData.citizenid, 
            model, 
            GetHashKey(vehicle),
            vehicleMods, 
            plate, 
            1
        })
    elseif Config['General']["Core"] == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local steam = xPlayer.identifier
        SQL('INSERT INTO owned_vehicles (owner, vehicle, plate, type, `stored`) VALUES (@owner, @vehicle, @plate, @job, @stored)', {
            ['@owner'] = steam,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@plate'] = plate,
            ['@job'] = xPlayer.job.name,
            ['@stored'] = true
        })
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local v = {
            ["owner"] = user:getVar("hexid"),
            ["cid"] = user:getCurrentCharacter().id,
            ['name'] = model,
            ["model"] = model,
            ["vehicle_state"] = "Out",
            ["fuel"] = 100,
            ["engine_damage"] = 1000,
            ["body_damage"] = 1000,
            ["current_garage"] = "T",
            ["license_plate"] = plate
        }
        local k = [[INSERT INTO characters_cars (owner, cid, name, model, vehicle_state, fuel, engine_damage, body_damage, current_garage, license_plate) VALUES(@owner, @cid, @name, @model, @vehicle_state, @fuel, @engine_damage, @body_damage, @current_garage, @license_plate);]]
        SQL(k, v)
    end
end)
