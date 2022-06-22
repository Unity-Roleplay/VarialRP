local pingCoords = vector3(0, 0, 0)
local lastPingerId = -1

RegisterNetEvent("phone:ping:receive")
AddEventHandler("phone:ping:receive", function(pCoords, pSrc, pCharacterName)
  pingCoords = pCoords
  lastPingerId = pSrc

  -- TODO: Check Notification (Export)
  PlaySound(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
 
  phonePingNotification("ping",pCharacterName)
  -- SendUIMessage({
  --   source = "np-nui",
  --   app = "phone",
  --   data = {
  --     action = "ping-receive",
  --     name = pCharacterName
  --   }
  -- })
end)

RegisterNUICallback("np-ui:pingSend", function(data, cb)
  local targetId, is_anon, coords = data.number, data.anonymous, GetEntityCoords(PlayerPedId())
  TriggerServerEvent("phone:ping:request", targetId, coords, is_anon)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)


RegisterNUICallback("np-ui:pingAccept", function(data, cb)
  if DoesBlipExist(blipMarker) then
    RemoveBlip(blipMarker)
  end
  blipMarker = AddBlipForCoord(pingCoords)
  SetBlipSprite(blipMarker, 280)
  SetBlipAsShortRange(blipMarker, false)
  BeginTextCommandSetBlipName("STRING")
  SetBlipColour(blipMarker, 4)
  SetBlipScale(blipMarker, 1.2)
  AddTextComponentString("Accepted GPS Marker")
  EndTextCommandSetBlipName(blipMarker)
  TriggerEvent("DoLongHudText", "Their GPS ping has been marked on the map")
  TriggerServerEvent("pingAccepted", lastPingerId)
  cb({ data = {}, meta = { ok = true, message = '' } })
  SetTimeout(60000, function()
    if DoesBlipExist(blipMarker) then
      RemoveBlip(blipMarker)
    end
  end)
end)

RegisterNUICallback("np-ui:pingReject", function(data, cb)
  if lastPingerId ~= -1 then
    TriggerServerEvent("phone:ping:rejected", lastPingerId)
  end
  lastPingerId = -1
  pingCoords = vector3(0, 0, 0)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterNUICallback('pingEnded', function(data,cb)
  TriggerEvent('DoLongHudText', "Ping time is ended.",2)
  SendNUIMessage({
    openSection = 'pingEnded'
  })
  lastPingerId = -1
  pingCoords = vector3(0, 0, 0)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)
