local inReadSMS = false
-- SMS Callbacks
RegisterNUICallback('messages', function(data, cb)
  loadSMS(exports['isPed']:isPed('cid'))
  cb('ok')
end)

function loadSMS(cid)
  print("LOAD SMS")
  local messages, phone = RPC.execute("np-phone:getSMS",cid)
  local _messages = {}
  for i, v in ipairs(messages) do
      local name = ""

      if v["receiver"] == phone then
          name = getContactName(v["sender"])
      else
          name = getContactName(v["receiver"])
      end

      table.insert(_messages, {
          ["id"] = v["id"],
          ["msgDisplayName"] = name,
          ["sender"] = v["sender"],
          ["receiver"] = v["receiver"],
          ["date"] = v["date"],
          ["message"] = v["message"],
          ["unread"] = v["unread"]
      })
  end

  SendNUIMessage({
      openSection = "messages",
      list = _messages,
      clientNumber = phone,
  })
end



--$.post...


RegisterNUICallback('messageDelete', function(data, cb)
  TriggerServerEvent('phone:removeSMS', data.id, data.number)
  cb('ok')
end)

RegisterNUICallback('newMessage', function(data, cb)
  SendNUIMessage({openSection = "newMessage"})
  cb('ok')
end)

RegisterNUICallback('readMessage', function(data,cb)
  TriggerServerEvent('phone:messageSeen', data.id)
end)



RegisterNUICallback('messageReply', function(data, cb)
  SendNUIMessage({openSection = "newMessageReply", number = data.number})
  cb('ok')
end)

RegisterNUICallback('newMessageSubmit', function(data, cb)
  if not isDead then
    TriggerEvent('phone:sendSMS', tonumber(data.number), data.message)
    cb('ok')
  else
    TriggerEvent("DoLongHudText","You can not do this while injured.",2)
  end
end)

RegisterNUICallback('messageRead', function(data, cb)
  TriggerServerEvent('phone:serverGetMessagesBetweenParties', data.sender, data.receiver, data.displayName)
  cb('ok')
end)

RegisterNetEvent('phone:clientGetMessagesBetweenParties')
AddEventHandler('phone:clientGetMessagesBetweenParties', function(messages, displayName, clientNumber)
  TriggerEvent('msgReads')
  SendNUIMessage({openSection = "messageRead", messages = messages, displayName = displayName, clientNumber = clientNumber})
end)

RegisterNetEvent('phone:newSMS')
AddEventHandler('phone:newSMS', function(number, message, date,numbers)
lastnumber = number
TriggerEvent('addUnreadMsg')
local handle = getContactName(number)
local data = message
local app = "sms"
if exports["np-phone"]:phasPhone() then
  if exports['np-phone']:pNotify() == true then
    TriggerEvent("DoLongHudText", "You just received a new SMS.", 1)
    if inReadSMS then
      TriggerServerEvent('phone:serverGetMessagesBetweenParties', number, numbers, handle)
    end
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
    phoneNotification(app,data,handle)
  end
end
end)


RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(number, message)
if(number ~= nil and message ~= nil) then
  TriggerServerEvent('phone:sendSMS', exports['isPed']:isPed('cid'), number, message)
  Citizen.Wait(1000)
  TriggerServerEvent('phone:getSMSc', exports['isPed']:isPed('cid'))
else
  phoneMsg("You must fill in a number and message!")
end
end)

local lastnumber = 0

RegisterNetEvent('animation:sms')
AddEventHandler('animation:sms', function(enable)
  TriggerEvent("destroyPropPhone")
  local lPed = PlayerPedId()
  inPhone = enable

  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Citizen.Wait(0)
  end

  if not isInTrunk then
    TaskPlayAnim(lPed, "cellphone@", "cellphone_text_in", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
  end
  Citizen.Wait(300)
  if inPhone then
    TriggerEvent("attachItemPhone","phone01")
    Citizen.Wait(150)
    while inPhone do
      if isDead then
        closeGui()
        inPhone = false
      end
      if not isInTrunk and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_text_read_base", 3) and not IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_swipe_screen", 3) then
        TaskPlayAnim(lPed, "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
      end    
      Citizen.Wait(1)
    end
    if not isInTrunk then
      ClearPedTasks(PlayerPedId())
    end
  else
    if not isInTrunk then
      Citizen.Wait(100)
      ClearPedTasks(PlayerPedId())
      TaskPlayAnim(lPed, "cellphone@", "cellphone_text_out", 2.0, 1.0, 5.0, 49, 0, 0, 0, 0)
      Citizen.Wait(400)
      TriggerEvent("destroyPropPhone")
      Citizen.Wait(400)
      ClearPedTasks(PlayerPedId())
    else
      TriggerEvent("destroyPropPhone")
    end
  end
end)


RegisterNetEvent('phone:reply')
AddEventHandler('phone:reply', function(message)
if lastnumber ~= 0 then
  TriggerServerEvent('phone:sendSMS', exports['isPed']:isPed('cid'), lastnumber, message)
  TriggerEvent("chatMessage", "You", 6, message)
else
  phoneMsg("No user has recently SMS'd you.")
end
end)



function phoneMsg(inputText)
TriggerEvent("chatMessage", "Service ", 5, inputText)
end


RegisterNetEvent('phone:loadSMSOther')
AddEventHandler('phone:loadSMSOther', function(messages,mynumber)
openGui()
lstMsgs = {}
if (#messages ~= 0) then
  for k,v in pairs(messages) do
    if v ~= nil then
      local msgDisplayName = ""
      if v.receiver == mynumber then
        msgDisplayName = getContactName(v.sender)
      else
        msgDisplayName = getContactName(v.receiver)
      end
      local message = {
        id = tonumber(v.id),
        msgDisplayName = msgDisplayName,
        sender = tonumber(v.sender),
        receiver = tonumber(v.receiver),
        date = tonumber(v.date),
        message = v.message
      }
      lstMsgs[#lstMsgs+1]= message
    end
  end
end
SendNUIMessage({openSection = "messagesOther", list = lstMsgs, clientNumber = mynumber})
end)


RegisterNetEvent('refreshSMS')
AddEventHandler('refreshSMS', function()
TriggerServerEvent('phone:getSMS', exports['isPed']:isPed('cid'))
Citizen.Wait(250)
SendNUIMessage({openSection = "messages"})
end)

RegisterNUICallback('refreshMySMS', function(data)
  if data.status then
    inReadSMS = true
  else
    inReadSMS = false
  end
end)
