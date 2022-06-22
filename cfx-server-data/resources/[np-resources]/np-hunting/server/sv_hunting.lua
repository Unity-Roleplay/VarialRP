RPC.register("givePlayerJobPay",function(pSource,pInfo,pCash)
    local src = pSource
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    print("AddMoney",pCash.param)
    user:addMoney(pCash.param)
    return
end)

RPC.register("np-hunting:getSettings",function()
    return Config.Hunting
end)

RPC.register("np-hunting:getSkinnedItem",function(pSource,pNetId,pMySpawn,pIllegal,pAnimalName)
    print("getSkinnedItem",pSource,pNetId.param,pMySpawn.param,pIllegal.param,pAnimalName.param)
    local src = pSource
    DeleteEntity(NetworkGetEntityFromNetworkId(pNetId.param))
    local chance1 = math.random(1,3)
    if chance1 == 1 then
        TriggerClientEvent("player:receiveItem", src, "huntingcarcass1", 1)
        return
    end
    if chance1 == 2 then
        TriggerClientEvent("player:receiveItem", src, "huntingcarcass2", 1)
        return
    end
    if chance1 == 3 then
        TriggerClientEvent("player:receiveItem", src, "huntingcarcass3", 1)
        return
    end
end)

RegisterServerEvent('np-hunting:skinReward')
AddEventHandler('np-hunting:skinReward', function()
  local _source = source
  local user = exports["np-base"]:getModule("Player"):GetUser(source)
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 15 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass1', 1)
  elseif randomAmount > 15 and randomAmount < 23 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass2', 1)
  elseif randomAmount > 23 and randomAmount < 29 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass3', 1)
  else 
    TriggerClientEvent('player:receiveItem', _source, "huntingcarcass4", 1)
  end
end)