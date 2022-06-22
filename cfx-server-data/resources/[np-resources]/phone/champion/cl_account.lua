

RegisterNUICallback('accountInformation', function()
    TriggerServerEvent("account:information:sv", exports['isPed']:isPed('cid'))
  end)

RegisterNetEvent("account:information:cl")
AddEventHandler("account:information:cl", function(licences, paycheck, phone)
  local responseObject = {
    cid = exports["isPed"]:isPed("cid"),
    paycheck = paycheck,
    cash = exports["isPed"]:isPed("mycash"),
    bank = exports["isPed"]:isPed("mybank"),
    myNumber = phone,
    job = exports["isPed"]:isPed("myjob"),
    secondaryJob = exports["isPed"]:isPed("secondaryjob"),
    licenses = licences, 
    pagerStatus = exports["isPed"]:isPed("pagerstatus")
  }
  print(phone)
  SendNUIMessage({openSection = "accountInformation", response = responseObject})
end)



  