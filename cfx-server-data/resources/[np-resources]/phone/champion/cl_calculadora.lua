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


  RegisterCommand("mudar", function()
    SendNUIMessage({openSection = "mudar"})
    print("android")
  end)

  RegisterCommand("iphone", function()
    SendNUIMessage({openSection = "iphone"})
    print("iphone")
  end)






    RegisterCommand("phonemedio", function()
      SendNUIMessage({
        openSection = "phonemedio", timeout = "3000" }) 
    end)