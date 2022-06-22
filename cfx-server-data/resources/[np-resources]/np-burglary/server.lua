local robbableItems = {
 [1] = {chance = 10, id = 0, quantity = math.random(50, 70)},
 [2] = {chance = 1, id = 'rollcash', quantity = math.random(5,10)},
 [3] = {chance = 5, id = 'oxy', quantity = math.random(2,3)},
 [4] = {chance = 8, id = 'band', quantity = math.random(1,5)},
 [5] = {chance = 98, id = '1593441988', quantity = 1},
 [6] = {chance = 99, id = 'stolentv', quantity = 1},
 [7] = {chance = 92, id = 'stolenmusic', quantity = 1},
 [8] = {chance = 95, id = 'stolenart', quantity = 1},
 [9] = {chance = 93, id = 'stolenmicrowave', quantity = 1},
 [10] = {chance = 94, id = 'stolencomputer', quantity = 1},
 [11] = {chance = 90, id = 'stolencoffee', quantity = 1},
 [12] = {chance = 4, id = 'joint', quantity = math.random(3,5)},
 [13] = {chance = 35, id = 'stolencasinowatch', quantity = math.random(1,2)},
 [14] = {chance = 25, id = 'stolengameboy', quantity = math.random(1,2)},
 [15] = {chance = 25, id = 'stoleniphone', quantity = math.random(1,2)},
 [16] = {chance = 15, id = 'stolennokia', quantity = math.random(1,2)},
 [17] = {chance = 25, id = 'stolenpsp', quantity = math.random(1,2)},
 [18] = {chance = 25, id = 'stolenoakleys', quantity = math.random(1,2)},
 [19] = {chance = 25, id = 'stolens8', quantity = math.random(1,2)},
 [20] = {chance = 35, id = 'stolenraybans', quantity = math.random(1,2)},
}

 RegisterServerEvent('houseRobberies:removeLockpick')
 AddEventHandler('houseRobberies:removeLockpick', function()
  local source = tonumber(source)
  local user = exports["np-base"]:getModule("Player"):GetUser(source)
  TriggerClientEvent('inventory:removeItem', source, 'lockpick', 1)
  TriggerClientEvent('DoLongHudText',  source, 'The lockpick bent out of shape' , 1)
 end)
 
 RegisterServerEvent('houseRobberies:giveMoney')
 AddEventHandler('houseRobberies:giveMoney', function()
  local source = tonumber(source)
  local user = exports["np-base"]:getModule("Player"):GetUser(source)
  local cash = math.random(500, 1200)
  user:addMoney(cash)
  TriggerClientEvent('DoLongHudText',  source, 'You found a $'..cash , 1)
  TriggerClientEvent("robbery:register:finishedLockpick", source)
  TriggerClientEvent("houseRobberies:reset", source)
 end)
 
 
 RegisterServerEvent('houseRobberies:searchItem')
 AddEventHandler('houseRobberies:searchItem', function()
  local source = tonumber(source)
  local item = {}
  local user = exports["np-base"]:getModule("Player"):GetUser(source)
  local gotID = {}
 
  for i=1, math.random(1, 2) do
   item = robbableItems[math.random(1, #robbableItems)]
   if math.random(1, 100) >= item.chance then
     if tonumber(item.id) == 0 and not gotID[item.id] then
       gotID[item.id] = true
       user:addMoney(item.quantity)
       TriggerClientEvent('DoLongHudText',  source, 'You found $'..item.quantity , 1)
     elseif not gotID[item.id] then
       gotID[item.id] = true
       TriggerClientEvent('player:receiveItem', source, item.id, item.quantity)
     end
   else
     --TriggerClientEvent('DoLongHudText', source, 'You found nothing', 1)
     end
   end
 end)