local lstContacts = {}

Citizen.CreateThread(function()
    while true do
      Wait(1)
      if serverSpawn then
        TriggerServerEvent('phone:getContacts')
        serverSpawn = false
      end
    end
  end)
  -- Contact Events
  RegisterNetEvent('phone:loadContacts')
  AddEventHandler('phone:loadContacts', function(contacts)
    lstContacts = {}
    if (#contacts ~= 0) then
      for k,v in pairs(contacts) do
        if v ~= nil then
          local contact = {
          }
          if activeNumbersClient['active' .. tonumber(v.number)] then
          
            contact = {
              name = v.name,
              number = v.number,
              activated = 1
            }
          else
      
            contact = {
              name = v.name,
              number = v.number,
              activated = 0
            }
          end
          lstContacts[#lstContacts+1]= contact
  
          SendNUIMessage({
            newContact = true,
            contact = contact,
          })
        end
      end
    else
         SendNUIMessage({
          emptyContacts = true
        })
    end
  end)

RegisterNetEvent('refreshContacts')
AddEventHandler('refreshContacts', function()
  TriggerServerEvent('phone:getContacts')
  TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
  SendNUIMessage({openSection = "contacts"})
end)

RegisterNUICallback('refreshContacts', function()
    TriggerEvent('contacts')
  end)
  
  -- Contact Callbacks
  RegisterNUICallback('contacts', function(data, cb)
    TriggerServerEvent('phone:getSMSc')
    TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
    SendNUIMessage({openSection = "contacts"})
    cb('ok')
  end)
  
--   RegisterNUICallback('newContact', function(data, cb)
--     print("NEW CONTACT SUBMIT 2")
--     SendNUIMessage({openSection = "newContact"})
--     cb('ok')
--   end)
  
RegisterNUICallback('newContactSubmit', function(data, cb)
    TriggerEvent('phone:addContact', data.name, tonumber(data.number),data.fmsg)
    cb('ok')
end)
  
  RegisterNUICallback('editContactSubmit', function(data, cb)
    SendNUIMessage({
      emptyContacts = true
    })
    TriggerServerEvent('phone:editContact', data.name, tonumber(data.number),data.oldName)
    Wait(100)
    TriggerServerEvent('phone:getContacts')
    cb('ok')
  end)

  RegisterNUICallback('removeContact', function(data, cb)
    TriggerServerEvent('phone:removeContact', data.name, data.number)
    cb('ok')
  end)
  
RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number, inmsg)
  if(name ~= nil and number ~= nil) then
    number = tonumber(number)
    TriggerServerEvent('phone:addContact', name, number, inmsg)
  else
     phoneMsg("You must fill in a name and number!")
  end
end)

RegisterNetEvent('phone:newContact')
AddEventHandler('phone:newContact', function(name, number)
  local contact = {
      name = name,
      number = number
  }
  lstContacts[#lstContacts+1]= contact

  -- SendNUIMessage({
  --   newContact = true,
  --   contact = contact,
  -- })
  phoneMsg("Contact Saved!")
  TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
end)

RegisterNetEvent('phone:deleteContact')
AddEventHandler('phone:deleteContact', function(name, number)

  local contact = {
      name = name,
      number = number
  }

  table.remove( lstContacts, tablefind(lstContacts, contact))
  
  SendNUIMessage({
    removeContact = true,
    contact = contact,
  })
  TriggerEvent('resetPhone')

end)

RegisterNUICallback('removeContact', function(data, cb)
  TriggerServerEvent('deleteContact', data.name, data.number)
  cb('ok')
end)

  function getContactName(number)
    if (#lstContacts ~= 0) then
      for k,v in pairs(lstContacts) do
        -- print(v)
        if v ~= nil then
          if (v.number ~= nil and tonumber(v.number) == tonumber(number)) then
            return v.name
          end
        end
      end
    end
  
    return number
  end

  