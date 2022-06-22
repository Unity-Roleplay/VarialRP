function openInventory(type, id)
  if type == "stash" then
    local success = RPC.execute("np-business:hasStashAccess", id)
    if success then
      TriggerEvent("server-inventory-open", "1", "biz-" .. id)
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  elseif type == "craft" then
    local success = RPC.execute("np-business:hasCraftAccess", id)
    if success then
      TriggerEvent("server-inventory-open", "42", "Craft")
    else
      TriggerEvent("DoLongHudText", "Not allowed", 2)
    end
  else
    TriggerEvent("DoLongHudText", "Nothing found", 2)
  end
end

local listening = false
local function listenForKeypress(type, id)
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              listening = false
              exports["np-ui"]:hideInteraction()
              openInventory(string.lower(type), id)
          end
          Wait(0)
      end
  end)
end

function enterPoly(name, data)
  listenForKeypress(name, data.id)
  exports["np-ui"]:showInteraction("[E] " .. name)
end

function leavePoly(name, data)
  listening = false
  exports["np-ui"]:hideInteraction()
end

AddEventHandler("np-polyzone:enter", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    enterPoly(name == "business_stash" and "Stash" or "Craft", data)
  end
end)

AddEventHandler("np-polyzone:exit", function(name, data)
  if name == "business_stash" or name == "business_craft" then
    leavePoly(name == "business_stash" and "Stash" or "Craft", data)
  end
end)
