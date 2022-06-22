--[[ Yellow Pages ]]

RegisterNetEvent('getYP')
AddEventHandler('getYP', function()
  local source = source
  exports.ghmattimysql:execute('SELECT * FROM phone_yp LIMIT 30', {}, function(yp)
      local deorencoded = json.encode(yp)
      TriggerClientEvent('YellowPageArray', -1, yp)
      TriggerClientEvent('YPUpdatePhone', source)
  end)
end)

RegisterNetEvent('phone:updatePhoneJob')
AddEventHandler('phone:updatePhoneJob', function(advert)
  --local handle = handle
  local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local mynumber = char.phone_number

  fal = char.first_name .. " " .. char.last_name

  exports.ghmattimysql:execute('INSERT INTO phone_yp (name, job, phoneNumber) VALUES (@name, @job, @phoneNumber)', {
      ['name'] = fal,
      ['job'] = advert,
      ['phoneNumber'] = mynumber
  }, function(result)
      TriggerClientEvent('refreshYP', src)
  end)
end)

RegisterNetEvent('phone:deleteYP')
AddEventHandler('phone:deleteYP', function(number)
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local cid = char.id
  local mynumber = getNumberPhone(cid)
  exports.ghmattimysql:execute('DELETE FROM phone_yp WHERE phoneNumber = @phoneNumber', {
      ['@phoneNumber'] = mynumber
  }, function (result)
      TriggerClientEvent('refreshYP', src)
  end)
end)

RegisterServerEvent('phone:RemovePhoneJobSourceSend')
AddEventHandler('phone:RemovePhoneJobSourceSend', function(srcsent)
  local src = srcsent
  for i = 1, #YellowPageArray do
      if YellowPageArray[i]
      then 
        local a = tonumber(YellowPageArray[i]["src"])
        local b = tonumber(src)

        if a == b then
          table.remove(YellowPageArray,i)
        end
      end
  end
  TriggerClientEvent("YellowPageArray", -1 , YellowPageArray)
end)