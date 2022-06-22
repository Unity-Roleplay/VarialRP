local currentTwats = {}
local openTwatter = false

RegisterNetEvent('Client:UpdateTweets')
AddEventHandler('Client:UpdateTweets', function(data)
    local handle = exports["isPed"]:isPed("twitterhandle")
    local tweet = {}
    for i,v in pairs(data) do
      table.insert(tweet,{ 
      ['handle'] = v.handle,
      ['message'] = v.message,
      ['time'] = v.time,
    })
    end
    if openTwatter then
      SendNUIMessage({openSection = "twatter", twats = data, myhandle = handle})
    end
    -- SendNUIMessage({openSection = "tweetnotify", twats2 = data, myhandle2 = handle})
end)

RegisterNetEvent('Client:UpdateTweet')
AddEventHandler('Client:UpdateTweet', function(tweet)
    local handle = exports["isPed"]:isPed("twitterhandle")

      currentTwats[#currentTwats+1] = tweet 

    if not phasPhone() then
      return
    end
    TriggerEvent('addUnreadTwt')

    if openTwatter then
      SendNUIMessage({openSection = "twatter", twats = currentTwats, myhandle = handle})
    end

    if string.find(tweet["message"],handle) then
      if tweet["handle"] ~= handle then
        SendNUIMessage({openSection = "newtweet"})
      end

      if pNotify() and exports['np-phone']:pOpen() then
        -- PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        TriggerEvent("DoLongHudText","You were just mentioned in a tweet on your phone.",1)
      end
    end

end)


RegisterNetEvent('addTwat-notify')
AddEventHandler('addTwat-notify', function(handle,data)
  local datas = {twat = {text = data}}
  phoneNotification("twat", datas,handle)  
end)
RegisterNUICallback('btnTwatter', function()
    local handle = exports["isPed"]:isPed("twitterhandle")
    TriggerEvent('twtReads')
    TriggerServerEvent('GetTweets')
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
