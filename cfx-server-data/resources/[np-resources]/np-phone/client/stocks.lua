local pickupLocation = vector3(508.91, 3099.83, 41.31)
local orderItem = false

RegisterNetEvent('stocks:payupdate');
AddEventHandler('stocks:payupdate', function()
  local payamount = 0
  for i = 2, #clientstockamount do
    local mystock = clientstockamount[i]["value"]
    if mystock > 0 then
      local currentlyPaying = serverstockvalues[i]["value"] / 200
      local totalpay = (currentlyPaying * mystock) / 100
      local mypayout = math.ceil(totalpay * 100)
      local haslost = 0.0
      payamount = payamount + mypayout
      if serverstockvalues[i]["value"] < 1000.0 then
        if mystock > 3 then
          if math.random(100) > 90 then
            local stockloss =  math.ceil(((mystock / 100) / 3) * 100) / 100
            clientstockamount[i]["value"] = mystock - stockloss
            TriggerServerEvent("stocks:bleedstocks",i,stockloss)
            haslost = haslost - stockloss
          end
        end
        if mystock > 20 then
          if math.random(100) > 90 then
            local stockloss =  math.ceil(((mystock / 100) / 3) * 100) / 100
            clientstockamount[i]["value"] = mystock - stockloss
            TriggerServerEvent("stocks:bleedstocks",i,stockloss)
            haslost = haslost - stockloss
          end
        end
      end
      if haslost < 0 then
        TriggerEvent("chatMessagess", "EMAIL ", 8, "Interest pay out of $" .. mypayout .. " for stock ID " .. serverstockvalues[i]["identifier"] .. ". The company also cut your shares by " .. haslost .. " to increase profits. ")
      else
        TriggerEvent("chatMessagess", "EMAIL ", 8, "Interest pay out of $" .. mypayout .. " for stock ID " .. serverstockvalues[i]["identifier"])
      end
    end
  end
  payamount = math.floor(payamount)
  if payamount > 0 then
    TriggerServerEvent("server:givepayJob", "Stock Payment", payamount)
  end
end)

RegisterNetEvent('stocks:servervalueupdate');
AddEventHandler('stocks:servervalueupdate', function(sentvalues)
    serverstockvalues = sentvalues
end)

RegisterNetEvent('stocks:clientvalueupdate');
AddEventHandler('stocks:clientvalueupdate', function(sentvalues)
    clientstockamount = sentvalues

end)

RegisterNetEvent('stocks:jailed');
AddEventHandler('stocks:jailed', function()
    for i=2,#clientstockamount do
      if clientstockamount[i]["value"] > 1.0 then
        local loss = math.floor((clientstockamount[i]["value"] / 20) * 100) / 100
        TriggerServerEvent("stocks:reducestock",i,loss)
      end
    end
end)

RegisterNetEvent('stocks:newstocks');
AddEventHandler('stocks:newstocks', function(amountBuying,identifier)
  clientstockamount[identifier]["value"] = clientstockamount[identifier]["value"] + amountBuying
  updateServerClientStocks()
end)

RegisterNetEvent('stocks:losestocks');
AddEventHandler('stocks:losestocks', function(amountBuying,identifier)
  clientstockamount[identifier] = clientstockamount[identifier] - amountBuying
  updateServerClientStocks()
end)

function updateServerClientStocks()
  TriggerServerEvent("stocks:clientvalueupdate",serverstockvalues)
end





RegisterNUICallback('buying-darkMarket', function()
  SendNUIMessage({
    openSection = "buydarkMarket", materials = exports['np-phone']:getBuying(), blueprintid = RPC.execute("np-phone:blueprintid")
  })
end)

RegisterNUICallback('stocksTradeToPlayer', function(data, cb)
  local index = 0
  local amount = 0
  local sending = math.ceil(tonumber(data.amount) * 100) / 100
  -- print(data.identifier)
  for i=1,#serverstockvalues do
    if data.identifier == serverstockvalues[i]["identifier"] then
      index = i
      amount = serverstockvalues[i]["value"]
    end
  end
   
  if index == 0 then
    TriggerEvent("DoShortHudText","Incorrect Identifier.",2)
    TriggerEvent("stocks:refreshstocks")
    return
  end
  if amount < tonumber(data.amount) then
    -- not enough to do the trade
    TriggerEvent("DoShortHudText","Not enough stock.",2)
    TriggerEvent("stocks:refreshstocks")
    return
  end

  if data.identifier == "Shungite" then
      status = RPC.execute("np-phone:buyCrypto",1,data.amount)
    if status then
      serverstockvalues[1]["amountavailable"] = serverstockvalues[1]["amountavailable"] - data.amount
      -- print("what",serverstockvalues[1]["amountavailable"])
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  elseif data.identifier == "Guinea" then
    status = RPC.execute("np-phone:buyCrypto",2,data.amount)
    if status then
      serverstockvalues[2]["amountavailable"] = serverstockvalues[2]["amountavailable"] - data.amount
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  elseif data.identifier == "DVD Prime" then
    status = RPC.execute("np-phone:buyCrypto",3,data.amount)
    if status then
      serverstockvalues[3]["amountavailable"] = serverstockvalues[3]["amountavailable"] - data.amount
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  end
  

  Citizen.Wait(500)
  TriggerEvent("stocks:refreshstocks")

end)

RegisterNUICallback('exchangeCrypto', function(e)
  local amount = e.amount
  local characterId = tonumber(exports["isPed"]:isPed("cid"))
  local playerid = e.cid
  if e.stockID == "Shungite" then
    popo = 1
  elseif e.stockID == "Guinea" then
    popo = 2
  elseif e.stockID == "DVD Prime" then
    popo = 3
  end

  if playerid == characterId then
    RPC.execute("np-phone:exchangeCrypto",popo,amount)
  else
    RPC.execute("np-phone:transferCrypto",popo,amount,playerid)
  end

  sendStocksToPhone()
end)

RegisterNUICallback('buyCrypto', function(e)
  local amount = e.amount
  local characterId = tonumber(exports["isPed"]:isPed("cid"))
  if e.stockID == "Shungite" then
    popo = 1
  elseif e.stockID == "Guinea" then
    popo = 2
  elseif e.stockID == "DVD Prime" then
    popo = 3
  end
    RPC.execute("np-phone:buyCrypto",popo,amount)
    sendStocksToPhone()
end)

RegisterNetEvent('stocks:refreshstocks');
AddEventHandler('stocks:refreshstocks', function()

    sendStocksToPhone(true);
end)

function sendStocksToPhone(isRefresh)

  if isRefresh then
    updateServerClientStocks(serverstockvalues)
    serverstockvalues = RPC.execute("np-phone:incomingCrypto")
  else
    serverstockvalues = RPC.execute("np-phone:incomingCrypto")
  end

  Shungitelol = RPC.execute("np-phone:GetShungite")
  Tgblol = RPC.execute("np-phone:GetTgb")
  Dvdlol = RPC.execute("np-phone:GetDvd")
  SendNUIMessage({ openSection = "addStocks", stocksData = serverstockvalues, ShungiteAmount = Shungitelol, TgbAmount = Tgblol, DvdAmount = Dvdlol})
end

RegisterNUICallback('btnStocks', function()
  TriggerServerEvent('stocks:retrieve')
  sendStocksToPhone();

end)

RegisterNUICallback('purchase-darkMarket', function(data)
    local characterId = exports["isPed"]:isPed("cid")
    local colorLaptop = exports['np-phone']:getBuying()
    local time = math.random(60000,120000)

    if orderItem == false then
      if data.item == "vpn" then
        result = RPC.execute('np-phone:purchaseDarkMarket',1,20)
        print(result)
          if result then
            itemDM = "vpnxj"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your VPN, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Shungite!")
          end
      elseif data.item == "deliverylist" then
        result = RPC.execute('np-phone:purchaseDarkMarket',1,20)
          if result then
            itemDM = "darkmarketdeliveries"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your delivery schedule, please wait a few minutes!")
            orderItem = true
            Wait(time)
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Shungite!")
          end
        elseif data.item == "choplist" then
          result = RPC.execute('np-phone:purchaseDarkMarket',2,20)
            if result then
              itemDM = "choplist"
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for the choplist, please wait a few minutes!")
              Wait(time)
              orderItem = true
              TriggerEvent("addPickUpBlip")
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
            else
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Guinea!")
            end
          -- TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for a chop list is unavailable!")
      elseif data.item == "gdongle" then
        result = RPC.execute('np-phone:purchaseDarkMarket',2,100)
          if result then
            itemDM = "heistusb4"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your dongle, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Guinea!")
          end
      elseif data.item == "boostlaptop" then
        -- result = RPC.execute('np-phone:purchaseDarkMarket',1,100)
        -- if result then
        --   itemDM = "boostinglaptop"
        --   TriggerEvent("addPickUpBlip")
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for an RP laptop has been recieved, please wait a few minutes!")
        --   orderItem = true
        --   Wait(time)
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        -- else
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, 'You dont have enough TGB!')
        -- end
        TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for an RP laptop is unavailable!")
      elseif data.item == "laptopred" then
        result = RPC.execute('np-phone:purchaseDarkMarket',1,65)
        if result then
          itemDM = "heistlaptop4"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Shungite!")
        end
      elseif data.item == "laptopgreen" then
        result = RPC.execute('np-phone:purchaseDarkMarket',1,50)
          if result then
            itemDM = "heistlaptop3"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Shungite!")
          end
      elseif data.item == "laptopgold" then
      elseif data.item == "laptopblue" then
        result = RPC.execute('np-phone:purchaseDarkMarket',1,50)
          if result then
            itemDM = "heistlaptop2"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Shungite!")
          end
      elseif data.item == "thermite" then
        result = RPC.execute('np-phone:purchaseDarkMarket',2,50)
          if result then
            itemDM = "thermite"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your thermite, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Guineas!")
          end
      elseif data.item == "Skorpion" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "skorpionblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Uzi" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "uziblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Mac-10" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "mac10blueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "FN FNX-45" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "fnxblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          TriggerEvent("addPickUpBlip")
          orderItem = true
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Glock 18C" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "glockblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Desert Eagle" then
        result = RPC.execute('np-phone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "pistol50blueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      end
  else
    TriggerEvent("chatMessage", "Suspicious Individual", 8, "Transaction failed! You already have a pending order.")
  end
end)

RegisterNetEvent("addPickUpBlip")
AddEventHandler("addPickUpBlip", function()
  blip = AddBlipForCoord(pickupLocation)
  SetBlipSprite(blip, 440)
  SetBlipScale(blip, 1.2)
  SetBlipColour(blip, 5)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Item Pickup")
  EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('np-phone:takeDMarket')
AddEventHandler('np-phone:takeDMarket', function()
  if orderItem then
    TriggerEvent( "player:receiveItem", itemDM, 1)
    itemDM = nil
    orderItem = false
    RemoveBlip(blip)
    blip = nil
  else
    TriggerEvent('DoLongHudText',"You don't have an order!",2)
  end
end)

function orderingItem()
  return orderItem
end
exports("orderingItem",orderingItem)

function requestUpdate()
  TriggerServerEvent("stocks:retrieve")
end