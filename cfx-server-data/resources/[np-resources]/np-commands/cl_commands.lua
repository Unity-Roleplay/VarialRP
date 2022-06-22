 


 AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  TriggerServerEvent("np-commands:buildCommands","")
end)

RegisterCommand("cpr", function(source, args, rawCommand)
  TriggerEvent('pixerium:check', 3, 'trycpr', false)
end, false)

RegisterCommand("givekey", function(source, args, rawCommand)
  TriggerEvent("keys:give")
end, false)

RegisterCommand("window", function(source, args, rawCommand)
  TriggerEvent("car:windows",args[2], args[3])
end, false)


RegisterCommand("rollup", function(source, args, rawCommand)
  TriggerEvent("car:windowsup")
end, false)

RegisterCommand("finance", function(source, args, rawCommand)
  TriggerEvent('finance1')
end, false)


RegisterCommand("news", function(source, args, rawCommand)
  TriggerEvent('NewsStandCheck')
end, false)

RegisterCommand("confirm", function(source, args, rawCommand)
  TriggerEvent('housing:confirmed')
end, false)

RegisterCommand("notes", function(source, args, rawCommand)
  TriggerEvent('Notepad:open')
end, false)

RegisterCommand("trunkkidnap", function(source, args, rawCommand)
  TriggerEvent('ped:forceTrunk')
end, false)

RegisterCommand("trunkeject", function(source, args, rawCommand)
  TriggerEvent('ped:releaseTrunkCheck')
end, false)

RegisterCommand("trunkgetin", function(source, args, rawCommand)
  TriggerEvent('ped:forceTrunkSelf')
end, false)

RegisterCommand("trunkejectself", function(source, args, rawCommand)
  TriggerEvent('ped:releaseTrunkCheckSelf')
end, false)

RegisterCommand("anchor", function(source, args, rawCommand)
  TriggerEvent('client:anchor')
end, false)

RegisterCommand("atm", function(src, args, raw)
  TriggerEvent('bank:checkATM')
end)

RegisterCommand("seat", function(src, args, rawCommand)
  TriggerEvent('vehicle:swapSeat')
end)

RegisterCommand("getpos", function(source, args, raw)
  local ped = GetPlayerPed(PlayerId())
  local coords = GetEntityCoords(ped, false)
  local heading = GetEntityHeading(ped)
  Citizen.Trace(tostring("X: " .. coords.x .. " Y: " .. coords.y .. " Z: " .. coords.z .. " HEADING: " .. heading))
end, false)




