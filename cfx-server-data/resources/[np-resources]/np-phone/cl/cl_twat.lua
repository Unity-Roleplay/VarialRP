local currentTwats = {}
local openTwatter = false


RegisterNetEvent('addTwat-notify')
AddEventHandler('addTwat-notify', function(handle,data)
  local datas = data
  local twatNotify = false
  local enablet = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ntwat")
  TriggerEvent('addUnreadTwt')
  if enablet == 1 then
    twatNotify = true
  end
  if twatNotify then
   phoneNotification("twat", datas,handle)  
  end
end)

local getTwat = false
RegisterNUICallback('btnTwatter', function()
    local handle = exports["isPed"]:isPed("twitterhandle")
    currentTwats = {}
    TriggerEvent('twtReads')
    -- TriggerServerEvent('GetTweets')
    local twattermessages = RPC.execute("np-phone:getTwatters")
    -- if not getTwat then
      for i,v in pairs(twattermessages) do
        table.insert(currentTwats,{ 
          ['handle'] = v.handle,
          ['message'] = v.message,
          ['attachment'] = v.attachment,
          ['time'] = v.time,
        })
      end
      getTwat = true
    -- end
    SendNUIMessage({openSection = "twatter", myhandle = handle})
    openTwatter = true
end)
  
RegisterNUICallback('newTwatSubmit', function(data, cb)
    local handle = exports["isPed"]:isPed("twitterhandle")
    TriggerServerEvent('Tweet', handle, data.twat, data.time)
    TriggerServerEvent('np-phone:twatSendNotification', handle, data, data.time)
    local data = {twat = data.twat} 
   
end)

RegisterNUICallback('closeTwat', function(cb)
  openTwatter = false
end)

RegisterNUICallback("np-phone:getTwatter", function(data, cb)
  cb({ data = currentTwats, meta = { ok = success, message = (not success and currentTwats or 'done') } })
end)



RegisterNetEvent('np-phone:insertTwat')
AddEventHandler('np-phone:insertTwat', function(name,msg,time,attach)
  table.insert(currentTwats, {
    handle = name,
    message = msg,
    attachment = attach,
    time = time
  })
  if openTwatter then
    SendNUIMessage({openSection = "twatter", myhandle = handle})
  end
end)