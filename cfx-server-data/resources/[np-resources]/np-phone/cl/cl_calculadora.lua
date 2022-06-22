RegisterNUICallback('calculadoraInformation', function()
  SendNUIMessage({openSection = "calculadoraInformation"})
end)

RegisterNUICallback('cores', function()
  SendNUIMessage({openSection = "cores"})
end)
  
RegisterNUICallback('rodarphone', function()
  if phoneNotifications then
    SendNUIMessage({openSection = "phonenormal"})
  else
    
    SendNUIMessage({openSection = "rodarphone"})
  end
  phoneNotifications = not phoneNotifications
end)
