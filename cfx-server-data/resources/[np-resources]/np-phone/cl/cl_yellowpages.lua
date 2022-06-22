local guiEnabled = false
local YellowPageArray = {}
local YellowPages = {}

RegisterNUICallback('deleteYP', function()
    TriggerServerEvent('phone:deleteYP')
end)
  
RegisterNetEvent("yellowPages:retrieveLawyersOnline")
AddEventHandler("yellowPages:retrieveLawyersOnline", function()
local isFound = false
TriggerEvent('chatMessage', "", 2, "Searching for a lawyer...")
for i = 1, #YellowPageArray do
    local job = string.lower(YellowPageArray[tonumber(i)].job)
    if string.find(job, 'attorney') or string.find(job, 'lawyer') or string.find(job, 'public defender') then
    isFound = true
    TriggerEvent('chatMessage', "", 2, "⚖️ " .. YellowPageArray[i].name .. " ☎️ " .. YellowPageArray[i].phonenumber)
    end
end
if not isFound then
    TriggerEvent('chatMessage', "", 2, "There are no lawyers available right now. 😢")
end
end)

RegisterNUICallback('notificationsYP', function()
    TriggerServerEvent('getYP')
    Citizen.Wait(200)
    TriggerEvent("YPUpdatePhone")
end)
  
  
RegisterNetEvent('YPUpdatePhone')
AddEventHandler('YPUpdatePhone', function()

lstnotifications = {}

for i = 1, #YellowPageArray do
    lstnotifications[#lstnotifications + 1] = {
        id = tonumber(i),
        name = YellowPageArray[tonumber(i)].name,
        message = YellowPageArray[tonumber(i)].job,
        phoneNumber = YellowPageArray[tonumber(i)].phonenumber
    }
end
SendNUIMessage({openSection = "notificationsYP", list = lstnotifications})
end)

RegisterNetEvent('YellowPageArray')
AddEventHandler('YellowPageArray', function(pass)
    local notdecoded = json.encode(pass)
    YellowPages = notdecoded

    YellowPageArray = pass
end)

RegisterNetEvent('refreshYP')
AddEventHandler('refreshYP', function()
  if checkGuiEnable() then
    TriggerServerEvent('getYP')
    Citizen.Wait(250)
    TriggerEvent('YPUpdatePhone')
  end
end)

RegisterNUICallback('newPostSubmit', function(data, cb)
    if data.advert == "" then
      TriggerEvent('DoLongHudText', 'You need to put words in fill.',2)
      return
    end
      TriggerServerEvent('phone:updatePhoneJob', data.advert)
end)