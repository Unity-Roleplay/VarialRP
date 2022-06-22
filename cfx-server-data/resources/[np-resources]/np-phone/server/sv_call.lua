local callID = nil

RegisterNetEvent('phone:callContact')
AddEventHandler('phone:callContact', function(cid, targetnumber, toggle)
  local src = source
  local targetid = 0
  local targetIdentifier = getIdentifierByPhoneNumber(targetnumber)
  local srcPhone = getNumberPhone(cid)
  if not toggle then
    TriggerClientEvent('phone:initiateCall', src,targetnumber)
    TriggerClientEvent('phone:makecall', src, targetnumber)
      for _, player in ipairs(GetPlayers()) do
          local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(player))
          local char = user:getVar("character")
          if char.id == targetIdentifier then
              TriggerClientEvent('phone:receiveCall', tonumber(player), targetnumber, src, getPhoneRandomNumber())
          end
      end
  else
    TriggerClientEvent('phone:initiateCall', src,targetnumber)
    TriggerClientEvent('phone:makecall', src, targetnumber)
    TriggerClientEvent('phone:CallingSomeone', src, targetIdentifier, src)
      for _, player in ipairs(GetPlayers()) do
          local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(player))
          local char = user:getVar("character")
          if char.id == targetIdentifier then
              TriggerClientEvent('phone:receiveCall', tonumber(player), targetnumber, src, srcPhone)
          end
      end
  end
end)

RegisterNetEvent('phone:StartCallConfirmed')
AddEventHandler('phone:StartCallConfirmed', function(mySourceID)
  local channel = math.random(10000, 99999)
  local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(src))
    local char = user:getVar("character").phone_number
    local player = exports["np-base"]:getModule("Player"):GetUser(tonumber(mySourceID))
    local zchar = player:getVar("character").phone_number
  TriggerClientEvent('phone:callFullyInitiated', mySourceID, mySourceID, src,char)
  TriggerClientEvent('phone:callFullyInitiated', src, src, mySourceID,zchar)

  TriggerClientEvent('phone:addToCall', source, channel)
  TriggerClientEvent('phone:addToCall', mySourceID, channel)

  TriggerClientEvent('phone:id', src, channel)
  TriggerClientEvent('phone:id', mySourceID, channel)
end)


RegisterNetEvent('phone:EndCall')
AddEventHandler('phone:EndCall', function(mySourceID, stupidcallnumberidk, somethingextra)
  local src = source
  TriggerClientEvent('phone:removefromToko', source, stupidcallnumberidk)

  if mySourceID ~= 0 or mySourceID ~= nil then
      TriggerClientEvent('phone:removefromToko', mySourceID, stupidcallnumberidk)
      TriggerClientEvent('phone:otherClientEndCall', mySourceID)
  end

  if somethingextra then
      TriggerClientEvent('phone:otherClientEndCall', src)
  end
end)

