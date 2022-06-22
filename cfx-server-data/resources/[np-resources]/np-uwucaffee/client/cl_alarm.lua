AddEventHandler("np-uwucafee:silentAlarm", function()
  local finished = exports["np-taskbar"]:taskBar(4000, _L("uwucafee-pressing-alarm", "Pressing Alarm"))
  if finished ~= 100 then return end
  TriggerServerEvent("np-uwucafee:triggerSilentAlarm", GetEntityCoords(PlayerPedId()))
end)
