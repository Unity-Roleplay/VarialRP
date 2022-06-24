function GroupName(groupid)
    local name = "Error Retrieving Name"
    local mypasses = exports["isPed"]:isPed("passes")
    for i=1, #mypasses do
      if mypasses[i]["pass_type"] == groupid then
        name = mypasses[i]["business_name"]
      end 
    end
    return name
  end

RegisterNUICallback('addEmployee', function(data)
    TriggerServerEvent('np-phone:business_hired', data.state_id, data.rank, data.business)
end)

RegisterNUICallback('editEmployee', function(data)
  TriggerServerEvent('np-phone:business_edit', data.rank, data.state_id, data.business)
end)

RegisterNUICallback('fireEmployee', function(data)
    local business = data.business
    local cid = data.state_id
    local rank = GroupRank(business)
    if rank < 4 then
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end
      TriggerServerEvent('np-phone:business_fire', business, cid)
end)

RegisterNUICallback('payCheckEmployee', function(data)
    local business = data.business
    local cid = data.state_id
    local amount = data.amount
    local rank = GroupRank(business)
    if rank < 4 then
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end
    local complete, paid = RPC.execute('np-phone:business_paycheck', business,cid,amount)
    if complete then
        local data = 'You generate a paycheck of $'..paid..''
        phoneNotification("email",data,getBusinessName(business))
    end
end)


function GroupRank(groupid)
    local rank = 0
    local mypasses = exports["isPed"]:isPed("passes")
    for i=1, #mypasses do
      if mypasses[i]["pass_type"] == groupid then
        rank = mypasses[i]["rank"]
      end 
    end
    return rank
  end
  
  RegisterNUICallback('bankGroup', function(data)
      local gangid = data.gangid
      local cashamount = data.cashamount
      TriggerServerEvent("server:gankGroup", gangid,cashamount)
  end)
  
  RegisterNUICallback('payGroup', function(data)
      local gangid = data.gangid
      local cid = data.cid
      local cashamount = data.cashamount
      TriggerEvent('DoLongHudText', 'You generated a paycheck to your employee.')
      local rank = GroupRank(gangid)
      if rank < 5 then
        SendNUIMessage({
          openSection = "error",
          textmessage = "Permission Error",
        })   
        return
      end
  
      TriggerServerEvent("server:givepayGroup", gangid,cashamount,cid)
  end)

  RegisterNUICallback('promoteGroup', function(data)
    local gangid = data.gangid
    local cid = data.cid
    local newrank = data.newrank

    local rank = GroupRank(gangid)
    if rank < 4 then
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end

    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })
    TriggerServerEvent("server:givepass", gangid,newrank,cid)
end)

RegisterNUICallback('btnTaskGroups', function()

    local mypasses = exports["isPed"]:isPed("passes")
  
    local groupObject = {}
    for i = 1, #mypasses do
        local rankConverted = "Employee"
        rank = mypasses[i]["rank"]
        if rank == 1 then
          rankConverted = "Employee"
        elseif rank == 2 then
          rankConverted = "Employee"
        elseif rank == 3 then
          rankConverted = "Asst. Manager"
        elseif rank == 4 then
          rankConverted = "Manager"
        elseif rank == 5 then
          rankConverted = "Owner"
        end
        if rank > 0 then
          table.insert(groupObject, {
            namesent = mypasses[i]["business_name"],
            ranksent = rankConverted,
            idsent = mypasses[i]["pass_type"]
          })
        end
    end
    -- local groups,bank,gIp = RPC.execute("np-phone:Groups")
    SendNUIMessage({
      openSection = "groups",
      groups = groupObject
    })
  end)
  
  
  RegisterNetEvent("group:fullList")
  AddEventHandler("group:fullList", function(result,bank,groupid)
    local myjob = exports["isPed"]:isPed("myjob")
    local rank = GroupRank(myjob)
      -- group-manage
      local groupname = GroupName(groupid)
      SendNUIMessage({
        openSection = "groupManage",
        groupData = {
          groupName = groupname,
          bank = bank,
          groupId = groupid,
          employees = result,
          ranking = rank,
        }
      })
  
  end)
  
  RegisterNUICallback('manageGroup', function(data)
    -- print("MAANGED GROUP",data.GroupID)
    local groupid = data.GroupID
    
    local rank = GroupRank(groupid)
    if rank < 3 then
        -- print("WYYYWYWYWYWYW")
      SendNUIMessage({
        openSection = "error",
        textmessage = "Permission Error",
      })   
      return
    end
  
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })   
  
    TriggerServerEvent("group:pullinformation",groupid,rank)
  
  end)

  RegisterNUICallback('btnTaskGang', function()
    TriggerEvent("gangTasks:updated")
  end)

  RegisterNUICallback('np-phone:fireEmp', function(data,cb)
    TriggerServerEvent('np-phone:fireEmp', data.id,data.group,data.name)
  end)

  RegisterNUICallback('addCashBank', function(data)
    local bid = data.bid
    local amount = data.amount
    local bank = RPC.execute("np-phone:bus_addBank",bid,amount)
    if bank then
      local data = 'You add $'..amount..' in bank.'
      phoneNotification("email",data,getBusinessName(bid))
    end
  end)

  function getBusinessName(bId)
    local businessName = ""
    if bId == "hayes_autos" then
        businessName = "Hayes Auto"
    elseif bId == "burger_shot" then
        businessName = "Burger Shot"
    elseif bId == "casino" then
        businessName = "Casino Diamond"
    elseif bId == "vanilla_unicorn" then
        businessName = "Vanilla Unicorn"
    elseif bId == "car_shop" then
        businessName = "PDM"
    elseif bId == "pizzaria" then
        businessName = "Maldini's Pizza"
    elseif bId == "ems" then
        businessName = "Pillbox Hospital"
    elseif bId == "police" then
        businessName = "Police"
    elseif bId == "gallery" then
        businessName = "Gallery"
    elseif bId == "ug_racing" then
        businessName = "Underground"
    elseif bId == "lostmc" then
        businessName = "Lost MC"
    elseif bId == "sacredflowers" then
        businessName = "Sacred Flowers"
    elseif bId == "bcso" then
        businessName = "BCSO"
    elseif bId == "DOJ" then
        businessName = "DOJ"
    elseif bId == "taco_shop" then
        businessName = "Taco Shop"
    elseif bId == "serpents" then
        businessName = "Serpents"
    end
    return businessName
end