local serverstockvalues = {
    [1] = { ["name"] = "Shung", ["value"] = 100.0, ["identifier"] = "Shungite", ["lastchange"] = 0.00, ["amountavailable"] = math.random(200,350) },
    [2] = { ["name"] = "Guinea", ["value"] = 50.0, ["identifier"] = "Guinea", ["lastchange"] = 0.00, ["amountavailable"] = math.random(400,500) },
  }

Citizen.CreateThread(function()
  --TriggerEvent('deleteAllTweets')
  TriggerEvent('deleteAllYP')
end)

function getMessagesBetweenUsers(sender, recipient, callback)
  exports.ghmattimysql:execute("SELECT id, sender, receiver, message, date FROM user_messages WHERE (receiver = @from OR sender = @from) and (receiver = @to or sender = @to)", {
  ['from'] = sender,
  ['to'] = recipient
  }, function(result) callback(result) end)
end

function saveSMS(receiver, sender, message, callback)
  exports.ghmattimysql:execute("INSERT INTO user_messages (`receiver`, `sender`, `message`) VALUES (@receiver, @sender, @msg)",
  {['receiver'] = tonumber(receiver), ['sender'] = tonumber(sender), ['msg'] = message}, function(rowsChanged)
      exports.ghmattimysql:execute("SELECT id FROM user_messages WHERE receiver = @receiver AND sender = @sender AND message = @msg",
  {['receiver'] = tonumber(receiver), ['sender'] = tonumber(sender), ['msg'] = message}, function(result) if callback then callback(result) end end)
  end)
end


--[[ Phone calling stuff ]]

function getNumberPhone(cid)
  local penis
  exports.ghmattimysql:execute("SELECT phone_number FROM characters WHERE id = @id", {
      ['id'] = cid
  }, function(result)
      if result[1] ~= nil then
          penis = result[1].phone_number
      else
          penis = nil
      end
  end)
  Wait(200)
  if penis ~= nil then
      return penis
  else
      return nil
  end
end

function getIdentifierByPhoneNumber(phone_number)
  local prick
  exports.ghmattimysql:execute("SELECT id FROM characters WHERE phone_number = @phone_number", {
      ['phone_number'] = phone_number
  }, function(result)
      if result[1] ~= nil then
          prick = result[1].id
      else
          prick = nil
      end
  end)
  Wait(200)
  if prick ~= nil then
      return prick
  else
      return nil
  end
end

-- RegisterServerEvent('ReturnHouseKeys')
-- AddEventHandler('ReturnHouseKeys', function(cid)
--   local src = source
--   local houses = {}
--   local shared = {}
--   exports.ghmattimysql:execute("SELECT * FROM __housedata WHERE cid= ? ", {cid}, function(chicken)
--       for k, v in pairs(chicken) do
--           if v ~= nil then
--               if v.housename ~= nil then
--                   local random = math.random(1111,9999)
--                   houses[random] = {}
--                   table.insert(houses[random], {["house_name"] = v.housename, ["house_model"] = v.house_model, ["house_id"] = v.house_id, ["days"]= v.days, ["overall"] = v.overall, ["payments"] = v.payments, ["amountdue"] = v.due})
--                   TriggerClientEvent('returnPlayerKeys', src, houses, shared)
--               end
--           end
--       end
--   end)
--   exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `cid`= ?', {cid}, function(returnData)
--       for k, r in pairs(returnData) do
--           if r ~= nil then
--               if r.housename ~= nil then
--                   local random = math.random(1111,9999)
--                   shared[random] = {}
--                   table.insert(shared[random], {["house_name"] = r.housename, ["house_model"] = r.house_model, ["house_id"] = r.house_id})
--                  TriggerClientEvent('returnPlayerKeys', src, houses, shared)
--               end
--           end
--       end
--   end)
-- end)

RegisterNetEvent('phone:messageSeen')
AddEventHandler('phone:messageSeen', function(id)
  id = tonumber(id)
  if id ~= nil then
      exports.ghmattimysql:execute("UPDATE user_messages SET isRead = 1 WHERE id = @id", {['id'] = tonumber(id)})
  end
end)



function ReverseTable(t)
  local reversedTable = {}
  local itemCount = #t
  for k, v in ipairs(t) do
      reversedTable[itemCount + 1 - k] = v
  end
  return reversedTable
end

RegisterServerEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
  local src= source
  TriggerClientEvent('phone:setServerTime', src, os.date('%H:%M:%S', os.time()))
end)

function getPlayerID(source)
  local identifiers = GetPlayerIdentifiers(source)
  local player = getIdentifiant(identifiers)
  return player
end
function getIdentifiant(id)
  for _, v in ipairs(id) do
      return v
  end
end

AddEventHandler('playerSpawned',function(source)
  local sourcePlayer = tonumber(source)
  local identifier = getPlayerID(source)
  getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
  end)
end)

function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
  local sourcePlayer = sourcePlayer
  local identifier = identifier
  local user = exports["np-base"]:getModule("Player"):GetUser(sourcePlayer)
  local char = user:getVar("character")
  local myPhoneNumber = getNumberPhone(char.id)
  if myPhoneNumber == '0' or myPhoneNumber == nil then
      repeat
          myPhoneNumber = getPhoneRandomNumber()
          local id = getIdentifierByPhoneNumber(myPhoneNumber)
      until id == nil
      exports.ghmattimysql:execute("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
          ['myPhoneNumber'] = myPhoneNumber,
          ['identifier'] = identifier
      }, function ()
          cb(myPhoneNumber)
      end)
  else
      cb(myPhoneNumber)
  end
end

function getPhoneRandomNumber()
  local numBase0 = 4
  local numBase1 = 15
  local numBase2 = math.random(100,999)
  local numBase3 = math.random(1000,9999)
  local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "" .. numBase3)
  return num
end

RegisterNetEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
  local hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
  TriggerClientEvent('timeheader', -1, tonumber(hours), tonumber(minutes))
end)

RegisterNetEvent('deleteAllYP')
AddEventHandler('deleteAllYP', function()
  local src = source
  exports.ghmattimysql:execute('DELETE FROM phone_yp', {}, function (result) end)
end)

RegisterNetEvent('deleteContactssss')
AddEventHandler('deleteContactssss', function()
  local src = source
  exports.ghmattimysql:execute('DELETE FROM user_contacts', {}, function (result) end)
end)

RegisterNetEvent('deleteAllTweets')
AddEventHandler('deleteAllTweets', function()
  local src = source
  exports.ghmattimysql:execute('DELETE FROM tweets', {}, function (result) end)
end)

--Racing
local BuiltMaps = {}
local Races = {}

RegisterServerEvent('racing-global-race')
AddEventHandler('racing-global-race', function(map, laps, counter, reverseTrack, uniqueid, cid, raceName, startTime, mapCreator, mapDistance, mapDescription, street1, street2)
  Races[uniqueid] = { 
      ["identifier"] = uniqueid, 
      ["map"] = map, 
      ["laps"] = laps,
      ["counter"] = counter,
      ["reverseTrack"] = reverseTrack, 
      ["cid"] = cid, 
      ["racers"] = {}, 
      ["open"] = true, 
      ["raceName"] = raceName, 
      ["startTime"] = startTime, 
      ["mapCreator"] = mapCreator, 
      ["mapDistance"] = mapDistance, 
      ["mapDescription"] = mapDescription,
      ["raceComplete"] = false
  }

  TriggerEvent('racing:server:sendData', uniqueid, -1, 'event', 'open')
  local waitperiod = (counter * 1000)
  Wait(waitperiod)
  Races[uniqueid]["open"] = false
  -- if(math.random(1, 10) >= 5) then
  --     TriggerEvent("dispatch:svNotify", {
  --         dispatchCode = "10-94",
  --         firstStreet = street1,
  --         secondStreet = street2,
  --         origin = {
  --             x = BuiltMaps[map]["checkpoints"][1].x,
  --             y = BuiltMaps[map]["checkpoints"][1].y,
  --             z = BuiltMaps[map]["checkpoints"][1].z
  --         }
  -- })
  -- end
  TriggerEvent('racing:server:sendData', uniqueid, -1, 'event', 'close')
end)

RegisterServerEvent('racing-join-race')
AddEventHandler('racing-join-race', function(identifier)
  local src = source
  local player = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
  local playername = ""..char.first_name.." "..char.last_name..""
  Races[identifier]["racers"][cid] = {["name"] = PlayerName, ["cid"] = cid, ["total"] = 0, ["fastest"] = 0 }
  TriggerEvent('racing:server:sendData', identifier, src, 'event')
end)

RegisterServerEvent('race:completed2')
AddEventHandler('race:completed2', function(fastestLap, overall, sprint, identifier)
  local src = source
  local player = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
--   print("MY CID",char.id)
  local playername = ""..char.first_name.." "..char.last_name..""
  Races[identifier]["racers"][cid] = { ["name"] = PlayerName, ["cid"] = cid, ["total"] = overall, ["fastest"] = fastestLap}
  Races[identifier].sprint = sprint
  TriggerEvent('racing:server:sendData', identifier, -1, 'event')

  if not Races[identifier]["raceComplete"] then
      exports.ghmattimysql:execute("UPDATE racing_tracks SET races = races+1 WHERE id = '"..tonumber(Races[identifier].map).."'", function(results)
          if results.changedRows > 0 then
              Races[identifier]["raceComplete"] = true
          end
      end)
  end

  if(Races[identifier].sprint and Races[identifier]["racers"][cid]["total"]) then
      exports.ghmattimysql:execute("UPDATE racing_tracks SET fastest_sprint = "..tonumber(Races[identifier]["racers"][cid]["total"])..", fastest_sprint_name = '"..tostring(PlayerName).."' WHERE id = "..tonumber(Races[identifier].map).." and (fastest_sprint IS NULL or fastest_sprint > "..tonumber(Races[identifier]["racers"][cid]["total"])..")", function(results)
          if results.changedRows > 0 then
          end
      end)
  else
      exports.ghmattimysql:execute("UPDATE racing_tracks SET fastest_lap = "..tonumber(Races[identifier]["racers"][cid]["fastest"])..", fastest_name = '"..tostring(PlayerName).."' WHERE id = "..tonumber(Races[identifier].map).." and (fastest_lap IS NULL or fastest_lap > "..tonumber(Races[identifier]["racers"][cid]["fastest"])..")", function(results)
          if results.changedRows > 0 then
          end
      end)
  end
end)


RegisterServerEvent("racing:server:sendData")
AddEventHandler('racing:server:sendData', function(pEventId, clientId, changeType, pSubEvent)
  local dataObject = {
      eventId = pEventId, 
      event = changeType,
      subEvent = pSubEvent,
      data = {}
  }
  if (changeType =="event") then
      dataObject.data = (pEventId ~= -1 and Races[pEventId] or Races)
  elseif (changeType == "map") then
      dataObject.data = (pEventId ~= -1 and BuiltMaps[pEventId] or BuiltMaps)
  end
  TriggerClientEvent("racing:data:set", -1, dataObject)
end)

function buildMaps(subEvent)
  local src = source
  subEvent = subEvent or nil
  BuiltMaps = {}
  exports.ghmattimysql:execute("SELECT * FROM racing_tracks", {}, function(result)
      for i=1, #result do
          local correctId = tostring(result[i].id)
          BuiltMaps[correctId] = {
              checkpoints = json.decode(result[i].checkpoints),
              track_name = result[i].track_name,
              creator = result[i].creator,
              distance = result[i].distance,
              races = result[i].races,
              fastest_car = result[i].fastest_car,
              fastest_name = result[i].fastest_name,
              fastest_lap = result[i].fastest_lap,
              fastest_sprint = result[i].fastest_sprint, 
              fastest_sprint_name = result[i].fastest_sprint_name,
              description = result[i].description
          }
      end
      local target = -1
      if(subEvent == 'mapUpdate') then
          target = src
      end
      TriggerEvent('racing:server:sendData', -1, target, 'map', subEvent)
  end)
end

RegisterServerEvent('racing-build-maps')
AddEventHandler('racing-build-maps', function()
  buildMaps('mapUpdate')
end)

RegisterServerEvent('racing-map-delete')
AddEventHandler('racing-map-delete', function(deleteID)
  exports.ghmattimysql.execute("DELETE FROM racing_tracks WHERE id = @id", {
      ['id'] = deleteID })
  Wait(1000)
  buildMaps()
end)

RegisterServerEvent('racing-retreive-maps')
AddEventHandler('racing-retreive-maps', function()
  local src = source
  buildMaps('noNUI', src)
end)

RegisterServerEvent('racing-save-map')
AddEventHandler('racing-save-map', function(currentMap,name,description,distanceMap)
  local src = source
  local player = exports['np-base']:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local playername = char.first_name .." ".. char.last_name

  -- exports.ghmattimysql:execute("INSERT INTO racing_tracks_new ('checkpoints', 'creator', 'track_name', 'distance', 'description') VALUES (@currentMap, @creator, @trackname, @distance, @description)",
  -- {['currentMap'] = json.encode(currentMap), ['creator'] = playername, ['trackname'] = name, ['distance'] = distanceMap, ['description'] = description})

  exports.ghmattimysql:execute("INSERT INTO `racing_tracks` (`checkpoints`, `creator`, `track_name`, `distance`, `description`) VALUES ('"..json.encode(currentMap).."', '"..tostring(playername).."', '"..tostring(name).."', '"..distanceMap.."',  '"..description.."')", function(results)
      Wait(1000)
      buildMaps()
  end)
end)

RegisterServerEvent('phone:RemovePayPhoneMoney')
AddEventHandler('phone:RemovePayPhoneMoney', function()
  local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
  user:removeMoney(25)
end)

RegisterServerEvent("stocks:clientvalueupdate")
AddEventHandler("stocks:clientvalueupdate", function(table)
    serverstockvalues = table
end)

-- RegisterServerEvent("stocks:retrieve")
-- AddEventHandler("stocks:retrieve", function()
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local char = user:getCurrentCharacter()

--     exports.ghmattimysql:execute("SELECT stocks FROM characters WHERE id = @id", {['id'] = char.id}, function(result)
--         if result[1].stocks then
--         TriggerClientEvent("stocks:clientvalueupdate", src, json.decode(result[1].stocks))
--         end
--     end)
-- end)

-- RegisterServerEvent("phone:stockTradeAttempt")
-- AddEventHandler("phone:stockTradeAttempt", function(index, id, sending)
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(id))
--     local char = user:getCurrentCharacter()

--     if user ~= nil then
--         TriggerClientEvent("Crypto:GivePixerium", id, sending)
--     end
-- end)

RegisterServerEvent('phone:triggerPager')
AddEventHandler('phone:triggerPager', function()
  TriggerClientEvent('phone:triggerPager', -1)
end)

RegisterNetEvent('message:tome')
AddEventHandler('message:tome', function(messagehueifh)
  local src = source		
  local first = messagehueifh:sub(1, 3)
  local second = messagehueifh:sub(4, 6)
  local third = messagehueifh:sub(7, 11)

  local msg = first .. "-" .. second .. "-" .. third
  TriggerClientEvent('chatMessage', src, 'Phone Number ', 4, msg)
end)

RegisterNetEvent('message:inDistanceZone')
AddEventHandler('message:inDistanceZone', function(somethingsomething, messagehueifh)
  local src = source		
  local first = messagehueifh:sub(1, 3)
  local second = messagehueifh:sub(4, 6)
  local third = messagehueifh:sub(7, 11)

  local msg = first .. "-" .. second .. "-" .. third
  TriggerClientEvent('chatMessage', somethingsomething, 'Phone Number ', 4, msg)
end)


RegisterNetEvent('account:information:sv')
AddEventHandler('account:information:sv', function(cid)
    local src = source
    local licenceTable = {}
    exports.ghmattimysql:execute("SELECT licenses FROM characters WHERE id = @id",{['id'] = cid}, function(result)
        for k,v in pairs(result[1]) do
            for _, l in pairs(json.decode(v)) do 
                if l.issued ~= 0 then               
                    table.insert(licenceTable,{
                        type = l.license,
                        status = l.issued,
                    })
                end
            end
        end        
    end)

    exports.ghmattimysql:execute("SELECT `paycheck` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
        payslips = data[1].paycheck
    end)
    -- exports.ghmattimysql:execute("SELECT `casino` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
    --     pChips = data[1].casino
    -- end)
    exports.ghmattimysql:execute("SELECT `phone_number` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
        pNumber = data[1].phone_number
    end)
    
    Citizen.Wait(100)
    TriggerClientEvent('account:information:cl', src, licenceTable, payslips, pNumber)
end)

RegisterServerEvent('server:currentpasses')
AddEventHandler('server:currentpasses', function()
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local ply = user:getCurrentCharacter()
  exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {['cid'] = ply.id}, function(result)
      if result[1] ~= nil then
          TriggerClientEvent("client:passes", src, result)
          if result[1].pass_type == "police" or result[1].pass_type == "ems" then
          else
              TriggerClientEvent("np-jobmanager:playerBecameJob", src, result[1].pass_type, result[1].pass_type, false)
          end
      end
  end)
end)

RegisterServerEvent('server:givepass')
AddEventHandler('server:givepass', function(pass_type, rank, cid)
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local ply = user:getCurrentCharacter()
  local SrcName = ply.first_name .. " " ..ply.last_name
--   print("SHIT",pass_type, rank, cid)
  exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE pass_type = ? AND cid = ?", {pass_type, cid}, function(data)
      if not data[1] then
          exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(name)
              if name[1] then
                
                  local name = name[1].first_name.. ' ' ..name[1].last_name
                  exports.ghmattimysql:execute('INSERT INTO character_passes (cid, rank, name, giver, pass_type, business_name) VALUES (@cid, @rank, @name, @giver, @pass_type, @business_name)', {
                      ['cid'] = cid,
                      ['rank'] = rank,
                      ['name'] = name,
                      ['giver'] = SrcName,
                      ['pass_type'] = pass_type,
                      ['business_name'] = pass_type
                  })
                  exports.ghmattimysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(data2)
                      if data2[1] then
                          local pSteam = data2[1].owner
                          exports.ghmattimysql:execute('INSERT INTO jobs_whitelist (owner, cid, job, rank) VALUES (@owner, @cid, @job, @rank)', {
                              ['owner'] = pSteam,
                              ['cid'] = cid,
                              ['job'] = pass_type,
                              ['rank'] = rank
                          })

                      end
                  end)
                  TriggerClientEvent("notification", src, "You hired " ..name.. " !")
                  TriggerClientEvent("Passes:RequestUpdate", -1, cid)
              else
                  TriggerClientEvent("notification", src, "CID does not exist!")
              end
          end)
      else
          exports.ghmattimysql:execute("UPDATE character_passes SET `rank` = ? WHERE cid = ? AND pass_type = ?", {rank, cid, pass_type})
          TriggerClientEvent("notification", src, "You have updated their rank!")
          TriggerClientEvent("Passes:RequestUpdate", -1, cid)
      end
  end)
end)


RegisterServerEvent('server:givepayGroup')
AddEventHandler('server:givepayGroup', function(groupname, amount, cid)
  local src = source
  exports.ghmattimysql:execute("SELECT * FROM group_banking WHERE group_type = @id", {['id'] = groupname}, function(data)
      if data[1].bank >= tonumber(amount) then
          exports.ghmattimysql:execute("SELECT paycheck FROM characters WHERE id = @id", {['id'] = cid}, function(result)
              exports.ghmattimysql:execute("UPDATE characters SET `paycheck` = @paycheck WHERE id = @id", { ['id'] = cid, ['paycheck'] = result[1].paycheck + tonumber(amount)})
              TriggerClientEvent("Yougotpaid", -1, cid)
              exports.ghmattimysql:execute("UPDATE group_banking SET `bank` = @bank WHERE group_type = @group_type", { ['group_type'] = groupname, ['bank'] = data[1].bank - tonumber(amount)})
          end)
      else
      TriggerClientEvent('notification', src, 'You do not have enough money in your account to perform this transaction', 2)
      end
  end)
end)

-- RegisterServerEvent('server:gankGroup')
-- AddEventHandler('server:gankGroup', function(groupid, amount)
--   local src = source
--   local user = exports["np-base"]:getModule("Player"):GetUser(src)
--   if btnTaskGroups >= tonumber(amount) then
--       user:removeMoney(tonumber(amount))
--       exports.ghmattimysql:execute("SELECT * FROM group_banking WHERE group_type = @id", {['id'] = groupid}, function(result)
--           exports.ghmattimysql:execute("UPDATE group_banking SET `bank` = @bank WHERE `group_type` = @id", { ['id'] = groupid, ['bank'] = result[1].bank + amount})
--       end)
--   end
-- end)

RegisterServerEvent("get:vehicle:coords")
AddEventHandler("get:vehicle:coords", function(plate)
  local src = source
  local vehPlate = plate
  exports.ghmattimysql:execute("SELECT `coords` FROM characters_cars WHERE license_plate = @license_plate", {['license_plate'] = plate}, function(result)
      if result[1] then
          TriggerClientEvent("pass:coords:vehicle", src,vehPlate, json.decode(result[1].coords))
      end
  end)
end)

RegisterServerEvent("vehicle:coords")
AddEventHandler("vehicle:coords", function(plate, coords)
  local updatecoords = json.encode(coords)
  exports.ghmattimysql:execute("UPDATE characters_cars SET `coords` = @coords WHERE `license_plate` = @license_plate", { ['license_plate'] = plate, ['coords'] = updatecoords})
end)

RegisterServerEvent("car:Outstanding")
AddEventHandler("car:Outstanding", function()
  local src = source
  exports.ghmattimysql:execute("SELECT * FROM characters_cars WHERE payments_left = ? AND payments_left >= ? AND repoed = ?", {
      "0",
      "1", 
      "0"
    }, function(result)
      local FinalResult = {}
      for _, v in pairs(result) do
          local vname = v.name
          local plate = v.license_plate
          local finance = v.financed
          local payments = v.payments_left
          owner = v.cid
          exports.ghmattimysql:execute('SELECT * FROM characters WHERE `id`= ?', {owner}, function(data)
              for _, d in pairs(data) do
                  phonenum = d.phone_number
                  local name = d.first_name .. ' ' .. d.last_name
                  local string = {
                      Plate = ('Vehicle: %s (%s)'):format(vname, plate),
                      AmountDue = ('Amount Due: $%s'):format(math.floor(finance/payments)),
                      cid = ('CID: %s'):format(owner),
                      Info = ('%s | %s'):format(phonenum, name)
                  }
                  
                  table.insert(FinalResult, string)
                  TriggerClientEvent("phone:listunpaid", src, FinalResult)
              end
          end) 
      end
  end)
end)

RegisterServerEvent("phone:saveWallpaper")
AddEventHandler("phone:saveWallpaper", function(cid, wall)
    exports.ghmattimysql:execute("UPDATE characters SET `wallpaper` = @wallpaper WHERE `id` = @cid", { ['cid'] = cid, ['wallpaper'] = wall})
end)

RegisterServerEvent('checkingLicense')
AddEventHandler('checkingLicense', function()
    --TriggerClientEvent('checkingLicense',-1)
end)

RegisterServerEvent("np-phone:grabWallpaper")
AddEventHandler("np-phone:grabWallpaper", function()
    -- print("GRABING WALLPAPER")
  local src = source
  local player = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
    exports.ghmattimysql:execute("SELECT `wallpaper` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
      if data[1].wallpaper ~= nil then
          TriggerClientEvent('np-phone:grabBackground', src, data[1].wallpaper)
        --   print('Grabbbing',data[1].wallpaper)
      else
          TriggerClientEvent('np-phone:grabBackground', src, "https://i.imgur.com/JVPavDg.jpg")
        --   print('Not Grabbbing')
      end
    end)
end)

RegisterServerEvent("np-phone:GiveCrypto")
AddEventHandler("np-phone:GiveCrypto", function(type,amount)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    if type == 1 then
        local myShungite = getShungiteAmount(id)
        TriggerClientEvent("chatMessage", src, "EMAIL", 8,  "You have recieved " .. amount .. " Shungite")
        exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite+amount ,['id'] = id})
    elseif type == 2 then
        local myTGB = getTgbAmount(id)
        TriggerClientEvent("chatMessage", src, "EMAIL", 8,  "You have recieved " .. amount .. " TGB")
        exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTGB+amount ,['id'] = id})
    elseif type == 3 then
        local myDvd = getDvdAmount(id)
        TriggerClientEvent("chatMessage", src, "EMAIL", 8,  "You have recieved " .. amount .. " TGB")
        exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd+amount ,['id'] = id})
    end
end)

RPC.register("phone:getMyBG", function(pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id

    exports.ghmattimysql:execute("SELECT `wallpaper` FROM characters WHERE id = @id",{['id'] = id}, function(data)
        background = data[1].wallpaper
    end)
    Wait(100)
    return background
end)

RPC.register("np-phone:getChips", function(pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id

    exports.ghmattimysql:execute("SELECT `chips` FROM characters WHERE id = @id",{['id'] = id}, function(data)
        chips = data[1].chips
    end)
    Wait(100)
    return chips
end)

RPC.register("np-phone:getGroupSanitation", function(pSource)
    local src = source
    -- local user = exports["np-base"]:getModule("Player"):GetUser(src)
    -- local char = user:getVar("character")
    -- local id = char.id
    local datas
    local members

    exports.ghmattimysql:execute("SELECT * FROM job_groups WHERE job = @job",{['job'] = 'garbage'}, function(data)
        datas = data
        -- print("DATa",json.encode(data))
    end)
    exports.ghmattimysql:execute("SELECT * FROM job_groups WHERE job = @job AND leader = @leader",{['job'] = 'garbage', ['leader'] = 0}, function(member)
        members = member
        -- print("DATa",json.encode(data))
    end)
    Wait(300)
    -- print("DATaSS",json.encode(datas))
    return datas,members
end)

RPC.register("np-phone:incomingCrypto", function(pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    
    return serverstockvalues
end)

local BPid = math.random(1,6)
RPC.register("np-phone:blueprintid", function(pSource)
    return BPid
end)

-- RPC.register("np-phone:buyCrypto", function(pSource,type,amount)
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local char = user:getVar("character")
--     local id = char.id
--     local myShungite = getShungiteAmount(id)
--     local myTgb = getTgbAmount(id)
--     local myDvd = getDvdAmount(id)
--     local amount = amount.param
--     if type.param == 1 then
--         if tonumber(myShungite) >= tonumber(amount) then
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " Shungite")
--             serverstockvalues[1]["amountavailable"] = serverstockvalues[1]["amountavailable"] + amount
--             exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite-amount ,['id'] = id})
--             user:addBank(amount * 100)
--         else
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
--         end
--     elseif type.param == 2 then
--         if tonumber(myTgb) >= tonumber(amount) then
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " TGB")
--             serverstockvalues[2]["amountavailable"] = serverstockvalues[2]["amountavailable"] + amount
--             exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTgb-amount ,['id'] = id})
--             user:addBank(amount * 50)
--             return true
--         else
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
--         end
--     elseif type.param == 3 then
--         if tonumber(myDvd) >= tonumber(amount) then
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " Davadam Prime")
--             serverstockvalues[3]["amountavailable"] = serverstockvalues[3]["amountavailable"] + amount
--             exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd-amount ,['id'] = id})
--             user:addBank(amount * 1000)
--             return true
--         else
--             TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
--         end
--     end
-- end)

RPC.register("np-phone:exchangeCrypto", function(pSource,type,amount)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local myShungite = getShungiteAmount(id)
    local myTgb = getTgbAmount(id)
    local myDvd = getDvdAmount(id)
    local amount = amount.param
    if type.param == 1 then
        if tonumber(myShungite) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " Shungite")
            serverstockvalues[1]["amountavailable"] = serverstockvalues[1]["amountavailable"] + amount
            exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite-amount ,['id'] = id})
            user:addBank(amount * 100)
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    elseif type.param == 2 then
        if tonumber(myTgb) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " TGB")
            serverstockvalues[2]["amountavailable"] = serverstockvalues[2]["amountavailable"] + amount
            exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTgb-amount ,['id'] = id})
            user:addBank(amount * 50)
            return true
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    elseif type.param == 3 then
        if tonumber(myDvd) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You exchanged " .. amount .. " Davadam Prime")
            serverstockvalues[3]["amountavailable"] = serverstockvalues[3]["amountavailable"] + amount
            exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd-amount ,['id'] = id})
            user:addBank(amount * 1000)
            return true
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    end
end)

RPC.register("np-phone:transferCrypto", function(pSource,type,amount,target)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local myShungite = getShungiteAmount(id)
    local myTgb = getTgbAmount(id)
    local myDvd = getDvdAmount(id)
    local amount = amount.param
    local target = target.param
    local targetShungite = getShungiteAmount(target)
    local targetTgb = getTgbAmount(target)
    local targetDvd = getDvdAmount(target)
    if type.param == 1 then
        if tonumber(myShungite) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You transfered " .. amount .. " Shungite")
            exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite-amount ,['id'] = id})
            exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = targetShungite+amount ,['id'] = target})
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    elseif type.param == 2 then
        if tonumber(myTgb) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You transfered " .. amount .. " TGB")
            exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTgb-amount ,['id'] = id})
            exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = targetTgb+amount ,['id'] = target})
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    elseif type.param == 3 then
        if tonumber(myDvd) >= tonumber(amount) then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You transfered " .. amount .. " TGB")
            exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd-amount ,['id'] = id})
            exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = targetDvd+amount ,['id'] = target})
        else
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "Transaction failed. There isnt enough in your bank")
        end
    end
end)

RPC.register("np-phone:GetShungite", function (pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local Shungite = getShungiteAmount(id)
    return Shungite
end)

RPC.register("np-phone:GetTgb", function (pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local tgb = getTgbAmount(id)
    return tgb
end)

RPC.register("np-phone:GetDvd", function (pSource)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local dvd = getDvdAmount(id)
    return dvd
end)

RPC.register("np-phone:buyCrypto", function (pSource,ctype,amount)
    local src = source
    local amount = amount
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local id = char.id
    local myShungite = getShungiteAmount(id)
    local myTgb = getTgbAmount(id)
    local myDvd = getDvdAmount(id)
    local banko = myBank(id)
    if ctype == 1 then
        local price = (amount*100)
        if banko < price then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You do not have the funds to recieve " .. amount .. " Shungite")
            return false
        else
            user:removeBank(price)
            exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite+amount ,['id'] = id})
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You have recieved " .. amount .. " Shungite")
            return true
        end
    elseif type == 2 then
        local price = (amount*50)
        if banko < price then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You do not have the funds to recieve " .. amount .. " TGB")
            return false
        else
            user:removeBank(price)
            exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTgb+amount ,['id'] = id})
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You have recieved " .. amount .. " TGB")
            return true
        end
    elseif type == 3 then
        local price = (amount*1000)
        if banko < price then
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You do not have the funds to recieve " .. amount .. " Davadam Prime")
            return false
        else
            user:removeBank(price)
            exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd+amount ,['id'] = id})
            TriggerClientEvent("chatMessage", src, "Bank", 8,  "You have recieved " .. amount .. " Davadam Prime")
            return true
        end
    end
end)

RPC.register("np-phone:purchaseDarkMarket", function (pSource,type,price)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local id = char.id
    local price = tonumber(price)
    local myShungite = getShungiteAmount(id)
    local myTgb = getTgbAmount(id)
    local myDvd = getDvdAmount(id)
    if type == 1 then
        if tonumber(myShungite) < price then
            value = false
        else
            exports.ghmattimysql:execute("UPDATE characters SET Shungite = @Shungite WHERE id = @id", {["Shungite"] = myShungite-price ,['id'] = id})
            value = true
        end
    elseif type == 2 then
        if myTgb < price then
            value = false
        else
            exports.ghmattimysql:execute("UPDATE characters SET tgb = @tgb WHERE id = @id", {["tgb"] = myTgb-price ,['id'] = id})
            value = true
        end
    elseif type == 3 then
        if myDvd < price then
            value = false
        else
            exports.ghmattimysql:execute("UPDATE characters SET dvd = @dvd WHERE id = @id", {["dvd"] = myDvd-price ,['id'] = id})
            value = true
        end
    end
    Wait(500)
    print(value)
    return value
end)

function getShungiteAmount(id)
    exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = @id', {['id'] = id}, function(result)
        Shungite = result[1].Shungite
    end)
    Wait(100)
    
    return Shungite
end

function getTgbAmount(id)
    exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = @id', {['id'] = id}, function(result)
        tgb = result[1].tgb
    end)
    Wait(100)
    
    return tgb
end

function getDvdAmount(id)
    exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = @id', {['id'] = id}, function(result)
        dvd = result[1].dvd
    end)
    Wait(100)
    
    return dvd
end

function myBank(id)
    exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = @id', {['id'] = id}, function(result)
        banko = result[1].bank
    end)
    Wait(100)
    return banko
end

------TEBEX-----
RPC.register("tebex-supporter:tier", function (pSource)
    local src = source
    local steamIdentifier = GetPlayerIdentifiers(src)[1]
    -- print(steamIdentifier)
    exports.ghmattimysql:execute('SELECT * FROM tebex_supporters WHERE steamid = @steamid', {['steamid'] = steamIdentifier}, function(result)
        if not result[1] then
            amountOut = 10
        else
            if result.tier == 1 then
                amountOut = 15
            elseif result.tier == 2 then
                amountOut = 25
            else
                amountOut = 35
            end
        end
    end)
    Wait(100)
    return amountOut
end)

RPC.register('np-phone:getMyGroup', function(cid)
    exports.ghmattimysql:execute('SELECT * FROM job_groups WHERE cid = @cid', {['cid'] = cid}, function(result)
        if result[1] then
            crew = result[1].crew_name
        end
    end)
    Wait(100)
    return crew
end)

RPC.register('np-phone:getHouses', function(src)
     exports.ghmattimysql:execute('SELECT * FROM __housedata', {}, function(result)
         if result[1] then
             house = result[1]
         end
     end)
     Wait(100)
    return nil
end)


RPC.register('np-phone:apt', function(source)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id

    exports.ghmattimysql:execute('SELECT * FROM character_motel WHERE cid = @cid', {['cid'] = cid}, function(result)
        if result[1] then
            apt = result[1]
        end
    end)
    Wait(100)
    return apt
end)

RPC.register('np-phone:getCurrentOwned', function()
    local src = source
    local user = exports['np-base']:getModule('Player')(src)
    local cid = user:getCurrentCharacter().id
    local house
    exports.oxmysql:execute('SELECT * FROM __housedata WHERE cid = @cid', {['cid'] = cid}, function(result)
        if result ~= nil then
            house = {}
            for i,k in pairs(result) do
                local houseCat = ''
                if k.house_model == 1 then 
                    houseCat = 'Type: House'
                end
                if k.house_model == 2 then 
                    houseCat = 'Type: Mansion'
                end
                if k.house_model == 3 then 
                    houseCat = 'Type: Mega Mansion'
                end
                table.insert(house, {
                    ['hid'] = k.house_id,
                    ['cid'] = k.cid,
                    ['category'] = houseCat,
                    ['status'] = k.force_locked,
                    ['houseeName'] = k.housename
                })
            end
            return
        end
        house = false
    end)
    Wait(100)
    return house
end)

RegisterNetEvent('np-phone:house:status')
AddEventHandler('np-phone:house:status', function(hid,status)
    -- local src = source
    -- exports.ghmattimysql:execute('UPDATE housing SET status = @status WHERE hid = @hid',{
    --     ['status'] = status,
    --     ['hid'] = hid
    -- }, function()
    -- end)
end)

RPC.register('np-phone:getHousePrice', function(source,hid)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local hIds = hid.param
    -- exports.ghmattimysql:execute('SELECT * FROM housing_price WHERE hid = @hid', {['hid'] = hIds}, function(result)
    --     if result[1] then
    --         hPrice = result[1].price
    --         local amount = (hPrice*0.5)
    --         TriggerClientEvent('DoLongHudText', src, "You received $"..amount.." for selling property.")
    --         user:addMoney(amount)
    --         deleteProperty(src,hIds)
    --     end
    -- end)
    -- Wait(100)
    return hPrice
end)

function deleteProperty(src,hid)
    -- exports.ghmattimysql:execute('DELETE FROM housing WHERE hid = @hid LIMIT 1', {
    --     ['hid'] = hid,
    -- }, function (result)
    --     TriggerClientEvent('updateHousing', src)
    -- end)
end

RPC.register('np-phone:GiveAccess', function(source,hid,cid)
    local src = source
    local hIds = hid.param
    local cid = cid.param
    local access
    exports.ghmattimysql:execute('SELECT * FROM housing_keys WHERE hid = @hid AND cid = @cid', {['hid'] = hIds, ['cid'] = cid}, function(result)
        if result[1] then
            access = false
        else
            exports.ghmattimysql:execute('INSERT INTO housing_keys (hid, cid) VALUES (@hid, @cid)', {
                ['hid'] = hIds,
                ['cid'] = cid,
              }, 
              function(key)
              if key[1] then
                
              end
            end)
            access = true
        end
    end)
    Wait(200)
    return access
end)

-- RPC.register('np-phone:getAccessHouse', function(source)
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local cid = user:getCurrentCharacter().id
--     local house
--     exports.ghmattimysql:execute('SELECT * FROM housing_keys WHERE cid = @cid', {['cid'] = cid}, function(result)
--         if result ~= nil then
--             house = {}
--             for i,k in pairs(result) do
--                 print("MESSAGE",k.hid)
--                 -- local msg = json.decode(k.message)
--                 -- print(msg.text,msg.attachment)
--                 -- table.insert(house, {
--                 --     ['hid'] = k.hid,
--                 --     ['cid'] = cid,
--                 --     ['category'] = "",
--                 --     ['status'] = k.status
--                 -- })
--             end
--             return
--         end
--         house = false
--     end)
-- end)

RPC.register('np-phone:getAccessHouse', function(source,house)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local hid = house.param
    local person

    local q = [[ SELECT k.hid as house_id, k.cid AS player_cid, CONCAT(c.first_name," ",c.last_name) as player_name
    FROM housing_keys k
    INNER JOIN characters c ON c.id = k.cid
    WHERE k.hid = @hid ]]
    local v = {["hid"] = hid}
    exports.ghmattimysql:execute(q, v, function(results)
        person = {}
        for i,k in pairs(results) do
            table.insert(person, {
                ['name'] = k.player_name,
                ['cid'] = k.player_cid,
                ['house'] = k.house_id
            })
        end
    end)
    Wait(100)

    return person
end)

RPC.register('np-phone:getAccessHouse_2', function(house)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user.id
    local hid = house
    local personforce_locked
    local q = [[ SELECT k.house_id as house_id, k.cid AS cid, c.status AS housename
    FROM __housekeys k
    INNER JOIN __housedata c ON c.house_id = k.house_id
    WHERE k.cid = @cid ]]
    local v = {["cid"] = cid}
    exports.oxmysql:execute(q, v, function(results)
        person = {}
 
        for i,k in pairs(results) do

            table.insert(person, {
                -- ['name'] = k.player_name,
                ['cid'] = k.cid,
                ['house'] = k.house_id,
                ['category'] = k.housename
            })
        end
    end)
    Wait(100)
    return person

end)

RPC.register("np-phone:removeKeys", function(src, pHouseId, pPlayerId)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cider = user:getCurrentCharacter().id
    local cid = pPlayerId.param
    local hid = pHouseId.param

   if tonumber(cider) ~= tonumber(cid) then
    -- local removeKey = MySQL.query.await([[
    --     DELETE FROM housing_keys WHERE hid = ? AND cid = ?
    -- ]],{
    --     hid, cid
    -- })
    exports.ghmattimysql:execute('DELETE FROM housing_keys WHERE hid = @hid AND cid = @cid', {
        ['hid'] = hid,
        ['cid'] = cid,
      },function(results)
        TriggerClientEvent('DoLongHudText', src, "You successfully removed key!",1)
            if results[1] then
                TriggerClientEvent('DoLongHudText', src, "You successfully removed key!",1)
            end
        end)
    return
   end
   TriggerClientEvent('DoLongHudText', src, "You can't removed yourself in your house idiot!",2)
--    end
   return true
end)


RPC.register('phone:attempt:sv', function(source, data)
    local src = source
    local plate = data.param

    local car = MySQL.query.await([[
        SELECT * FROM characters_cars
        WHERE license_plate = ?
    ]],
    { plate })
    local coords = json.decode(car[1].coords)
    return car[1], coords
end)

-- RPC.register("np-garages:states",function(pSource,state,plate,curGarage,fuel)
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local char = user:getCurrentCharacter()
--       for k,v in pairs(curGarage) do
--           garage = v
--     end
--   	if curGarage.param == "Police Department" then
--         exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = @plate', { ['@plate'] = plate.param }, function(pIsValid)
-- 			if pIsValid[1] then
-- 				pExist = true
-- 				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, job = @job WHERE license_plate = @plate",  {['garage'] = curGarage.param, ['state'] = state.param, ['fuel'] = fuel.param, ['plate'] = plate.param,['job']='police'})
-- 			else
-- 				pExist = false
-- 			end
-- 		end)
--     else
--         exports.ghmattimysql:execute('SELECT * FROM characters_cars WHERE license_plate = @plate', { ['@plate'] = plate.param }, function(pIsValid)
-- 			if pIsValid[1] then
-- 				pExist = true
-- 				exports.ghmattimysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, job = @job WHERE license_plate = @plate",  {['garage'] = curGarage.param, ['state'] = state.param, ['fuel'] = fuel.param, ['plate'] = plate.param,['job']='(NULL)'})
--         	else
-- 				pExist = false
-- 			end
-- 		end)
--     end
--     Citizen.Wait(100)
-- 	return pExist
-- end)

-- RPC.register("np-phone:Groups", function(source,gIp)
--     local src = source
--   exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE pass_type = @groupid and rank > 0 ORDER BY rank DESC", {['groupid'] = groupid}, function(results)
--       if results ~= nil then
--           exports.ghmattimysql:execute("SELECT bank FROM group_banking WHERE group_type = @groupid", {['groupid'] = groupid}, function(result)
--               local bank = 0
--               if result[1] ~= nil then
--                   bank = result[1].bank
--               end
--               TriggerClientEvent("group:fullList", src, results, bank, groupid)
--           end)
--       else
--           TriggerClientEvent("phone:error", src)
--       end
--   end)
-- end)

RegisterNetEvent('setEyeColor')
AddEventHandler('setEyeColor', function(color)
    local src = source
    TriggerClientEvent('setEyeColor', src,color)
end)
RegisterServerEvent('np-phone:sendVehBill')
AddEventHandler('np-phone:sendVehBill', function(paypal,plate,amount)
    src = source
    TriggerClientEvent('np-phone:sellCar', paypal, plate, amount,src)
end)


RPC.register('np-phone:sellVehicle', function(pSource,pl,py,am)
    local src = pSource
    local plate = pl.param
    local paypal = py.param
    local amount = am.param
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local player = exports["np-base"]:getModule("Player"):GetUser(paypal)
    local ply = user:getCurrentCharacter()
    local playerSteam = ply.owner

    local affectedRows = MySQL.update.await([[
        UPDATE characters_cars
        SET rank = ?
        WHERE cid = ? AND pass_type = ?
    ]],
    { rank, cid, bId })
end)

RegisterServerEvent('np-phone:purchasedCar')
AddEventHandler('np-phone:purchasedCar', function(plate,amount,sID)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local player = exports["np-base"]:getModule("Player"):GetUser(sID)
    local zchar = player:getCurrentCharacter()
    local cid = tonumber(char.id)
    local price = tonumber(amount)

    if tonumber(char.bank) > tonumber(amount) then
        exports.ghmattimysql:execute('UPDATE characters_cars SET owner = @owner, cid = @cid  WHERE license_plate = @license_plate',{
            ['owner'] = char.owner,
            ['cid'] = cid,
            ['license_plate'] = plate
        }, function()
        end)
        user:removeBank(price)
        player:addBank(price)
    else
        TriggerClientEvent('DoLongHudText', sID, "Transaction Failed.",2)
        TriggerClientEvent('DoLongHudText', src, "You don't have enough money.",2)
    end
end)

RegisterNetEvent('np-phone:send_gas_bill')
AddEventHandler('np-phone:send_gas_bill', function(targetId, pFuelCost)
    local pSrc = source
    
	if targetId ~= nil then
        TriggerClientEvent('np-hud:send_fuel_bill', targetId, pFuelCost, pSrc)
    end
end)

AddEventHandler('onResourceStart', function(resource)    
	if resource == GetCurrentResourceName() then
        exports.ghmattimysql:execute('DELETE FROM tweets', {}, function (result) end)
	end
end)