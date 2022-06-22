AddEventHandler("np-foodchain:silentAlarm", function()
  local finished = exports["np-taskbar"]:taskBar(4000, _L("foodchain-pressing-alarm", "Pressing Alarm"))
  if finished ~= 100 then return end
  TriggerServerEvent("np-foodchain:triggerSilentAlarm", GetEntityCoords(PlayerPedId()))
end)
