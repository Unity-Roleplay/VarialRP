RegisterNUICallback('importados', function()

    SendNUIMessage({ openSection = "importados", showCarPaymentsOwed = showCarPayments, vehicleData = parsedVehicleData})
  end)

  RegisterNUICallback('job-center', function()
    SendNUIMessage({ openSection = "job-center"})
  end)



  RegisterCommand("hunt", function(name,message)
    TriggerEvent("phone:addnotification", "Noticias","Um meteoro vai cair na cidade hoje por volta das 13:40 abriguem se num bunker!")
  end)