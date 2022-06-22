RegisterNetEvent('GetTweets')
AddEventHandler('GetTweets', function(srcId)
  local src = source
  if srcId ~= nil then
    src = srcId
  end
  exports.ghmattimysql:execute('SELECT * FROM (SELECT * FROM tweets ORDER BY `time` DESC LIMIT 50) sub ORDER BY time ASC', {}, function(tweets) -- Get most recent 100 tweets
      if src then
        local allTweet = {}
        for i,k in pairs(tweets) do

            table.insert(allTweet, {
                ['handle'] = k.handle,
                ['message'] = json.encode(k.message),
                ['attachment'] = k.attachment,
                ['time'] = k.time
            })
        end
          TriggerClientEvent('Client:UpdateTweets', src, tweets)
          return
      else
      end
  end)
end)

RegisterNetEvent('Tweet')
AddEventHandler('Tweet', function(handle, data, time)
    local src = source
    TriggerClientEvent('addTwat-notify', -1, handle, data.text)
  exports.ghmattimysql:execute('INSERT INTO tweets (handle, message, attachment) VALUES (@handle, @message, @attachment)', {
      ['handle'] = handle,
      ['message'] = data.text,
      ['attachment'] = data.attachment
    }, 
    function(result)
  end)
    -- local twat = MySQL.query.await([[
    --     SELECT * FROM tweets
    -- ]])
    -- local allTweet = {}
    -- for i,k in pairs(twat) do
    --     table.insert(allTweet, {
    --         ['handle'] = k.handle,
    --         ['message'] = k.message,
    --         ['attachment'] = k.attachment,
    --         ['time'] = k.time,
    --     })
    -- end
  local newtwat = { ['handle'] = handle, ['message'] = data.text, ['attachment'] = data.attachment, ['time'] = time}
  TriggerClientEvent('np-phone:insertTwat', -1, handle,data.text,time,data.attachment)
  -- TriggerClientEvent('Client:UpdateTweet1', src, newtwat,allTweet)
 
end)

RegisterNetEvent('np-phone:twatSendNotification')
AddEventHandler('np-phone:twatSendNotification', function(handle, data, time)

  local newtwat = { ['handle'] = handle, ['message'] = data, ['time'] = time}
  TriggerClientEvent('np-phone:TwatNotify', -1, newtwat)
end)

RegisterNetEvent('np-phone:openGetTweets')
AddEventHandler('np-phone:openGetTweets', function()
  local src = source
  exports.ghmattimysql:execute('SELECT * FROM (SELECT * FROM tweets ORDER BY `time` DESC LIMIT 50) sub ORDER BY time ASC', {}, function(tweets) -- Get most recent 100 tweets
        TriggerClientEvent('Client:UpdateTweets', -1, tweets)
  end)
end)

RegisterNetEvent('Server:GetHandle')
AddEventHandler('Server:GetHandle', function()
  local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
local char = user:getCurrentCharacter()
  fal = "@" .. char.first_name .. "_" .. char.last_name
  local handle = fal
  TriggerClientEvent('givemethehandle', src, handle)
  TriggerClientEvent('updateNameClient', src, char.first_name, char.last_name)
end)

RPC.register('np-phone:getTwatters', function(source)
    exports.ghmattimysql:execute('SELECT * FROM tweets', {}, function(result)
        twat = result
    end)
    Wait(100)
    return twat
end)

RegisterServerEvent('testTwitter')
AddEventHandler('testTwitter', function(name, msg)
  local src = source
  TriggerClientEvent('upTwit', -1, name,msg)
end)

RPC.register("np-phone:twitterhandle", function(pSource)
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getVar("character")
  local id = char.id

  exports.ghmattimysql:execute('SELECT * FROM characters WHERE id = @id', {['id'] = id}, function(result)
      twitterhandle = result[1].twitterhandle
  end)
  
  return twitterhandle
end)