



SQL = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    if Config['General']["SQLWrapper"] == "ghmattimysql" then
        exports.ghmattimysql:execute(query, parameters, function(result)
            if cb then
                cb(result)
            else
                res = result
                IsBusy = false
            end
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return res
end

if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:GetExpireTime", function()
        local shit = (os.time() + 6 * 3600)
        return shit
    end)
end


if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:getCurrentBNE", function()
        local src = source
        local user = exports["np-base"]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM bropixel_boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1] == nil then
                SQL('INSERT INTO bropixel_boosting (citizenid) VALUES (?)',{cid})
                value = 0
            else
                if sql[1].BNE ~= nil then
                    value = ({BNE = sql[1].BNE , background = sql[1].background})
                else
                    value = 0
                end
            end
        end
        return value
    end)
end

  




RegisterNetEvent("boosting:server:setBacgkround")
AddEventHandler("boosting:server:setBacgkround" , function(back)
    local src = source
    if Config['General']["Core"] == "NPBASE" then
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('UPDATE bropixel_boosting SET background=@b WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@b'] = back})
        end 
    end
end)




if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:removeBNE", function(amount)
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM bropixel_boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                RemoveBNE(cid, pBNE, amount)
            else
                value = 0
            end
        
        end
        return value
    end)   
end


if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:addBne", function(amount)
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM bropixel_boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                AddBNE(cid, pBNE, amount)
            else
                value = 0
            end
        end
        return value
    end)
end


if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:server:checkVin", function()
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM bropixel_boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if(sql[1] ~= nil) then
                if(sql[1].vin == 0) then
                    value = true
                    SQL('UPDATE bropixel_boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                else
                    local d1 = os.date("*t",   os.time())
                    local d2 = os.date("*t", sql[1].vin)
                    local zone_diff = os.difftime(os.time(d1), os.time(d2))
                    if(math.floor(zone_diff  / 86400) >= Config['Utils']["VIN"] ["VinDays"]) then
                        value = true
                        SQL('UPDATE bropixel_boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                    end
                end
            end
        end
        return value
    end)
end


if Config['General']["Core"] == "NPBASE" then
    RPC.register("boosting:GetTimeLeft", function()
        local shit = 2
        cb(shit)
    end)
end


RegisterServerEvent("boosting:joinQueue")
AddEventHandler("boosting:joinQueue", function()
  pSrc = source
  if Config['General']["Core"] == "NPBASE" then
  local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(pSrc)
  local cid = user:getCurrentCharacter().id
    local result = SQL('SELECT * FROM boost_queue WHERE identifier = ?', {cid})
    if result[1] == nil then
      SQL("INSERT INTO boost_queue (identifier, pSrc) VALUES (@cid, @pSrc)", {['@cid'] = cid, ['@pSrc'] = pSrc })
	  print("added" .. " " .. "CID: " .. cid .. " " .."ID:".. pSrc .. " " .. "to boosting queue") 
    else
      print(cid.." already in queue")
    end
  end
end)

RegisterServerEvent('boosting:leaveQueue')
AddEventHandler('boosting:leaveQueue', function()
  pSrc = source
  if Config['General']["Core"] == "NPBASE" then
  local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(pSrc)
  local cid = user:getCurrentCharacter().id
  
    local result = SQL('SELECT * FROM boost_queue WHERE identifier = ?', {cid})
    if result[1] ~= nil then
      SQL("DELETE FROM boost_queue WHERE `identifier` = @cid", {['@cid'] = cid})
      print("removed" .. " " .. "CID: " .. cid .. " " .."ID:".. pSrc .. " " .. "from boosting queue") 
    end  
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(Config['Utils']["Contracts"]["TimeBetweenContracts"])
    local result = SQL('SELECT * FROM boost_queue',{})
      if #result ~= 0 then
        local random = math.random(1, #result)
        if result[random] ~= nil then
          local pSrc = result[random].pSrc
          local cid = result[random].identifier
		  local shit = math.random(1,10)
          local DVTen = Config['Utils']["Contracts"]["ContractChance"] / 10
          if(shit <= DVTen) then
          TriggerClientEvent('boosting:CreateContract', pSrc, true)
		  else
		  TriggerClientEvent('boosting:CreateContract', pSrc)
		  end
        end
      end
  end
end)

RegisterServerEvent('boosting:transfercontract')
AddEventHandler('boosting:transfercontract', function(contract, target)
    TriggerClientEvent('boosting:ReceiveContract', target, contract)
end)
    
  

---------------- Cop Blip Thingy ------------------



RegisterServerEvent('boosting:alertcops')
AddEventHandler('boosting:alertcops', function(cx,cy,cz)
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in pairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:setcopblip', src, cx,cy,cz)
            end
        end
    end
end)





RegisterServerEvent('boosting:AddVehicle')
AddEventHandler('boosting:AddVehicle', function(model, plate, vehicleProps)
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        VehicleData = {
            cid = user:getCurrentCharacter().id,
            steam = user:getVar("hexid"),
            vehicle = model,
            vehicleplate = plate,
            vehiclestate = 1,
        }
        AddVehicle(VehicleData)
    end
end)



RegisterServerEvent('boosting:removeblip')
AddEventHandler('boosting:removeblip', function()
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in ipairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")

            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:removecopblip', src)
            end
        end
    end
end)

RegisterServerEvent('boosting:SetBlipTime')
AddEventHandler('boosting:SetBlipTime', function()
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in ipairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('boosting:setBlipTime', src)
            end
        end  
    end
end)

  


RegisterNetEvent('boosting:finished')
AddEventHandler('boosting:finished' , function()
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        local worthamount = math.random(13000, 17000)
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        if Config['Utils']["Rewards"]["Type"] == 'item' then
            TriggerClientEvent('player:receiveItem', src, Config['Utils']["Rewards"]["RewardItemName"], 1)
        elseif Config['Utils']["Rewards"]["Type"] == 'money' then
            if Config['Utils']["Rewards"]["RewardAccount"] == 'cash' then
                user:addMoney(Config['Utils']["Rewards"]["RewardMoneyAmount"])
            elseif Config['Utils']["Rewards"]["RewardAccount"] == 'bank' then
                user:addBank(Config['Utils']["Rewards"]["RewardMoneyAmount"])
            end
            TriggerClientEvent("DoLongHudText", src, "You recieved "..Config['Utils']["Rewards"]["RewardMoneyAmount"].."$ in "..Config['Utils']["Rewards"]["RewardAccount"].." - boosting")
        end 
    end
end)



local color_msg = 195000

RegisterNetEvent('boosting:logs')
AddEventHandler('boosting:logs' , function(class, vehiclename)
	sendToDiscordBoostingLogs(class, discord_msg, color_msg,identifier)
end)

function sendToDiscordBoostingLogs(class,message,color,identifier)
    local src = source
    local name = GetPlayerName(src)
    if not color then
        color = color_msg
    end
    local sendD = {
        {
            ["color"] = color,
            ["title"] = message,
            ["description"] = "`Player Recieved a new contract with the class of`: **"..name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."**",
            ["footer"] = {
                ["text"] = "Â© </BroPixel > - "..os.date("%x %X %p")
            },
        }
    }

    PerformHttpRequest(logs, function(err, text, headers) end, 'POST', json.encode({username = "</BroPixel > - boosting", embeds = sendD}), { ['Content-Type'] = 'application/json' })
end

local authorized = true

RegisterNetEvent('boosting:loadNUI')
AddEventHandler('boosting:loadNUI' , function()
    local source = source
    TriggerClientEvent('boosting:StartUI', source)
end)


RegisterServerEvent("boosting:CallCopsNotify" , function(plate , model , color , streetLabel)
    if Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in pairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent("boosting:SendNotify" ,src , {plate = plate , model = model , color = color , place = place})
            end
        end
    end
end)