RegisterNetEvent("ethicalpixel-boosting:authorized:ReciveS")
AddEventHandler("ethicalpixel-boosting:authorized:ReciveS"  , function(identifier)
  SendNUIMessage({type = 'ui' , auth = identifier})
end)