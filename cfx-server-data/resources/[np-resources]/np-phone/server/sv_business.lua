pFirstNLastName = 

RegisterNetEvent('np-phone:fireEmp')
AddEventHandler('np-phone:fireEmp', function(id, job, name)
  local src = source
  local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local cid = char.id
  local mynumber = getNumberPhone(cid)
  exports.ghmattimysql:execute('DELETE FROM character_passes WHERE cid = @cid AND pass_type = @pass_type', {
      ['@cid'] = id,
      ['@pass_type'] = job
  }, function (result)
      TriggerClientEvent('DoLongHudText', src, 'You Fired '..name,2)
  end)
end)

RegisterServerEvent('np-phone:business_hired', function(StateID, Rank, pBusiness)
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    local ply = user:getCurrentCharacter()
    local pHiringName = ply.first_name .. " " ..ply.last_name

    exports.oxmysql:execute("INSERT INTO character_passes (cid, rank, name, giver, pass_type, business_name) VALUES (@cid, @rank, @name, @giver, @pass_type, @business_name)",
    {
        ['@cid'] = StateID,
        ['@rank'] = Rank,
        ['@name'] = '',
        ['@giver'] = pHiringName,
        ['@pass_type'] = pBusiness,
        ['@business_name'] = pBusiness,
    })
end)

RegisterServerEvent('np-phone:business_edit', function(pRank, pStateID, pPassType)
    exports.oxmysql:execute('UPDATE character_passes SET rank = @rank WHERE cid = @cid and pass_type = @pass_type',
    {
        ['@rank'] = pRank,
        ['@cid'] = pStateID,
        ['@pass_type'] = pPassType,
    })
end)

RPC.register('np-phone:business_paycheck', function(source,bus,p,a)
    local src = source
    local bId = bus.param
    local cid = p.param
    local amount = a.param

   local isPaycheck = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],
    { cid })
    local isBusinessBank = MySQL.query.await([[
        SELECT * FROM group_banking
        WHERE group_type = ?
    ]],
    { bId })
    
    local payCheck = (isPaycheck[1].paycheck+amount)
    local updateBank = (isBusinessBank[1].bank-amount)
    -- print(isPaycheck[1].paycheck,payCheck,isBusinessBank[1].bank)
    local affectedRows = MySQL.update.await([[
        UPDATE characters
        SET paycheck = ?
        WHERE id = ?
    ]],
    { tonumber(payCheck), cid })
    local updateBusBank = MySQL.update.await([[
        UPDATE group_banking
        SET bank = ?
        WHERE group_type = ?
    ]],
    { tonumber(updateBank), bId })
    if affectedRows and affectedRows ~= 0 and updateBusBank and updateBusBank ~= 0 then
        return true,amount
    end
end)

RPC.register('np-phone:bus_addBank', function(source,id,a)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local ply = user:getCurrentCharacter()
    local bId = id.param
    local amount = a.param
    local bank = MySQL.query.await([[
        SELECT * FROM group_banking
        WHERE group_type = ?
    ]],{bId})
    if tonumber(user:getCash()) >= tonumber(amount) then
        local affectedRows = MySQL.update.await([[
            UPDATE group_banking
            SET bank = ?
            WHERE group_type = ?
        ]],{bank[1].bank+amount, bId})
        user:removeMoney(tonumber(amount))
        return true
    end
end)

RegisterServerEvent('np-phone:business_fire', function(pBusinessName, pStateID)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local cid = char.id

    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE cid = @cid AND pass_type = @pass_type", {['@cid'] = pStateID, ['@pass_type'] = pBusinessName}, function()end)
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


RegisterServerEvent('group:pullinformation')
AddEventHandler('group:pullinformation', function(groupid,rank)
  local src = source
  exports.ghmattimysql:execute("SELECT * FROM character_passes WHERE pass_type = @groupid and rank > 0 ORDER BY rank DESC", {['groupid'] = groupid}, function(results)
      if results ~= nil then
          exports.ghmattimysql:execute("SELECT bank FROM group_banking WHERE group_type = @groupid", {['groupid'] = groupid}, function(result)
              local bank = 0
              if result[1] ~= nil then
                  bank = result[1].bank
              end
              TriggerClientEvent("group:fullList", src, results, bank, groupid)
          end)
      else
          TriggerClientEvent("phone:error", src)
      end
  end)
end)