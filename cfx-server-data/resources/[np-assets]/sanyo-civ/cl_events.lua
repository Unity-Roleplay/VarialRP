
-- misc events

RegisterNetEvent("np-gov:gavel")
AddEventHandler("np-gov:gavel", function(pArgs, pEntity, pContext)
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 20.0, 'gavel_3hit_mixdown', 0.4)
end)

RegisterNetEvent("kosta:refine")
AddEventHandler("kosta:refine", function()
  TriggerEvent("server-inventory-open", "428", "Craft");
end)

RegisterNetEvent("kosta:gumball")
AddEventHandler("kosta:gumball", function()
  TriggerEvent("animation:PlayAnimation","id")
  local finished = exports["np-taskbar"]:taskBar(2000,"Inserting Quarters",false,false,playerVeh)
  if finished == 100 then
    TriggerServerEvent("kosta:gumball:money")
    TriggerEvent("animation:PlayAnimation","c")
    local chance = math.random(1,13)
    if chance == 1 then
      TriggerEvent( "player:receiveItem", "redgball", 1 )
    elseif chance == 2 then
      TriggerEvent( "player:receiveItem", "bluegball", 1 )
    elseif chance == 3 then
      TriggerEvent( "player:receiveItem", "purplegball", 1 )
    elseif chance == 4 then
      TriggerEvent( "player:receiveItem", "yellowgball", 1 )
    elseif chance == 5 then
      TriggerEvent( "player:receiveItem", "greengball", 1 )
    elseif chance == 6 then
      TriggerEvent( "player:receiveItem", "pinkgball", 1 )
    elseif chance == 7 then
      TriggerEvent( "player:receiveItem", "orangegball", 1 )
    elseif chance == 8 then
      TriggerEvent("DoLongHudText","The machine jammed", 2)
    elseif chance == 9 then
      TriggerEvent("DoLongHudText","The machine jammed", 2)
    elseif chance == 10 then
      TriggerEvent("DoLongHudText","The machine jammed", 2)
    elseif chance == 11 then
      TriggerEvent("DoLongHudText","The machine jammed", 2)
    elseif chance == 12 then
      TriggerEvent( "player:receiveItem", "crackedgball", 1 )
    elseif chance == 13 then
      TriggerEvent( "player:receiveItem", "crackedgball", 1 )
    end
  end
end)

RegisterNetEvent("kosta:vpn")
AddEventHandler("kosta:vpn", function()
  TriggerEvent("animation:PlayAnimation","phone")
  local finished = exports["np-taskbar"]:taskBar(10000,"Attempting to Configure VPN",false,false,playerVeh)
  if finished == 100 then
    TriggerServerEvent("kosta:vpn:money")
    TriggerEvent("animation:PlayAnimation","c")
    Citizen.Wait(1000)
  else
    TriggerEvent("animation:PlayAnimation","c")
  end
end)

-- crim crafting events

RegisterNetEvent("mdm:craft")
AddEventHandler("mdm:craft", function()
  local vxn = exports["isPed"]:GroupRank("mandem")
  if vxn > 0 then
    TriggerEvent("server-inventory-open", "426", "Craft");
  else
    TriggerEvent("DoLongHudText","Who the fuck are you?", 2)
  end
end)

RegisterNetEvent("mango:storage")
AddEventHandler("mango:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-mango")
end)

RegisterNetEvent("gang:craft")
AddEventHandler("gang:craft", function()
  TriggerEvent("server-inventory-open", "431", "Craft");
end)

RegisterNetEvent("gang3:craft")
AddEventHandler("gang3:craft", function()
  TriggerEvent("server-inventory-open", "466", "Craft");
end)

RegisterNetEvent("gang3:storage")
AddEventHandler("gang3:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-gang3")
end)

RegisterNetEvent("gang2:storage")
AddEventHandler("gang2:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-gang2")
end)

RegisterNetEvent("gang2:craft")
AddEventHandler("gang2:craft", function()
  TriggerEvent("server-inventory-open", "432", "Craft");
end)

RegisterNetEvent("gang:storage")
AddEventHandler("gang:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-gang")
end)


RegisterNetEvent("mango:craft")
AddEventHandler("mango:craft", function()
  TriggerEvent("server-inventory-open", "427", "Craft");
end)

RegisterNetEvent("guerro:storage")
AddEventHandler("guerro:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-guerro")
end)

RegisterNetEvent("guerro:craft")
AddEventHandler("guerro:craft", function()
  TriggerEvent("server-inventory-open", "429", "Craft");
end)

RegisterNetEvent("strokers:storage")
AddEventHandler("strokers:storage", function()
  TriggerEvent("server-inventory-open", "1", "storage-strokers")
end)

RegisterNetEvent("strokers:craft")
AddEventHandler("strokers:craft", function()
  TriggerEvent("server-inventory-open", "430", "Craft");
end)

-- 
