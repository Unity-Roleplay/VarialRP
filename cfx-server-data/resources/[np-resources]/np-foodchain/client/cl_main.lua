
local foodConfig = {
    burger = {
        {itemid = "bleederburger", displayName = _L("foodchain-bleeder", "Bleeder"), description = _L("foodchain-bleeder-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "heartstopper", displayName = _L("foodchain-heart-stopper", "Heart Stopper"), description = _L("foodchain-heart-stopper-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "torpedo", displayName = _L("foodchain-torpedo", "Torpedo"), description = _L("foodchain-torpedo-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "moneyshot", displayName = _L("foodchain-moneyshot", "Moneyshot"), description = _L("foodchain-moneyshot-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "meatfree", displayName = _L("foodchain-meat-free", "Meat Free"), description = _L("foodchain-meat-free-recipe", "1 Bun, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "lettuce"}},
        {itemid = "questionablemeatburger", displayName = _L("foodchain-questionable-meat-burger", "Questionable Meat Burger"), description = _L("foodchain-questionable-meat-burge-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
        
    },
    fries = {
        {itemid = "fries", displayName = _L("foodchain-fries", "Fries"), description = _L("foodchain-fries-recipe", "1 Potato"), craftTime = 10, recipe = {"potatoingred"}}
    },
    drinks = {
        {itemid = "water", displayName =  _L("foodchain-tap-water", "Tap Water"), description = _L("foodchain-none-recipe", "None"), craftTime = 5, recipe = {}},
        {itemid = "softdrink", displayName =  _L("foodchain-soft-drink", "Soft Drink"), description = _L("foodchain-soft-drink-recipe", "1 High-Fructose Syrup"), craftTime = 5, recipe = {"hfcs"}},
        {itemid = "mshake", displayName =  _L("foodchain-milkshake", "Milkshake"), description =  _L("foodchain-milkshake-recipe", "1 Milk, 1 Ice Cream"), craftTime = 10, recipe = {"milk", "icecreamingred"}},
        {itemid = "fruitslushy", displayName =  _L("foodchain-fruit-slushy", "Fruit Slushy"), description =  _L("foodchain-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
    },
    misc = {
        {itemid = "donut", displayName = _L("foodchain-donut", "Donut"), description =  _L("foodchain-none-recipe", "None"), craftTime = 15, recipe = {}},
        {itemid = "applepie", displayName = _L("foodchain-cream-pie", "Cream Pie"), description = _L("foodchain-cream-pie-recipe", "Made with love ;)"), craftTime = 15, recipe = {}},
        {itemid = "franksmonster", displayName = _L("foodchain-frankster", "Frankster"), description = _L("foodchain-frankster-recipe", "Zoom zoom zoom"), craftTime = 15, recipe = {}, cid = 1810},
        {itemid = "frankstruth", displayName = _L("foodchain-truth-serum", "Truth Serum"), description = _L("foodchain-truth-serum-recipe", "Speak"), craftTime = 15, recipe = {}, cid = 1810},
        {itemid = "franksflute", displayName = _L("foodchain-franks-flute", "Frank's Flute"), description = _L("foodchain-franks-flute-recipe", "Time to dance"), craftTime = 15, recipe = {}, cid = 1810},
    }
}

local isSignedOn = false

local burgerContext, friesContext, drinksContext, miscContext = {}, {}, {}, {}

local activePurchases = {}

local serverCode = "wl"

Citizen.CreateThread(function()
    serverCode = "wl"
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:signOnPrompt",
        id = "food_chain_sign_on",
        icon = "clock",
        label = _L("foodchain-clock-in", "Clock In"),
        parameters = { location = "main" }
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:getActiveEmployees",
        id = "food_chain_active_employees",
        icon = "list",
        label = _L("foodchain-view-employee-list", "View Active Employees"),
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:signOnPrompt",
        id = "food_chain_sign_on_pier",
        icon = "clock",
        label = _L("foodchain-clock-in", "Clock In"),
        parameters = { location = "pier" }
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:getActiveEmployees",
        id = "food_chain_active_employees",
        icon = "list",
        label = _L("foodchain-view-employee-list", "View Active Employees"),
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon', {{
        event = "np-foodchain:signOffPrompt",
        id = "food_chain_sign_off",
        icon = "clock",
        label = _L("foodchain-clock-out", "Clock Out")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_signon_pier', {{
        event = "np-foodchain:signOffPrompt",
        id = "food_chain_sign_off_pier",
        icon = "clock",
        label = _L("foodchain-clock-out", "Clock Out")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_shelfstorage', {{
        event = "np-foodchain:shelfPrompt",
        id = "food_chain_shelf_storage",
        icon = "box-open",
        label = _L("foodchain-open", "Open")
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_shelfstorage2', {{
        event = "np-foodchain:shelfPrompt2",
        id = "food_chain_shelf_storage_pier",
        icon = "box-open",
        label = _L("foodchain-open", "Open")
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_fridge', {{
        event = "np-foodchain:fridgePrompt",
        id = "food_chain_fridge",
        icon = "box-open",
        label = _L("foodchain-open", "Open")
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_fridge2', {{
        event = "np-foodchain:fridgePrompt2",
        id = "food_chain_fridge_pier",
        icon = "box-open",
        label = _L("foodchain-open", "Open")
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_drivethruwindow', {{
        event = "np-foodchain:pickupPromptWindow",
        id = "food_chain_order_pickup_tray3",
        icon = "hand-holding",
        label = _L("foodchain-open", "Open")
    }}, { distance = { radius = 7.0 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getBag",
        id = "food_chain_get_bag",
        icon = "shopping-bag",
        label = _L("foodchain-get-bag", "Get Bag")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getMeal",
        id = "food_chain_get_meal",
        icon = "box",
        label = _L("foodchain-get-murder-meal", "Get Murder Meal")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_bagging', {{
        event = "np-foodchain:getToysPrompt",
        id = "food_chain_get_toys",
        icon = "meh-rolling-eyes",
        label = _L("foodchain-get-toys", "Get Toys")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    --Stations
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station0', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_0', --Fridge
        icon = "ice-cream",
        label = _L("foodchain-open-station", "Open Station"),
        parameters = { stationId = 0 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station1', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_1', --Fries
        icon = "temperature-high",
        label = _L("foodchain-open-station", "Open Station"),
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station2', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_2', --Burgers
        icon = "hamburger",
        label = _L("foodchain-open-station", "Open Station"),
        parameters = { stationId = 2 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_station3', {{
        event = "np-foodchain:stationPrompt",
        id = 'food_chain_station_3', --Drinks
        icon = "mug-hot",
        label = _L("foodchain-open-station", "Open Station"),
        parameters = { stationId = 3 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np-foodchain:burgerjob_shelfstorage", {{
        event = "np-foodchain:silentAlarm",
        id = "foodchain_silent_alarm",
        icon = "bell",
        label = _L("foodchain-alert-police", "Alert Police")
    }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

    -- exports["np-interact"]:AddPeekEntryByPolyTarget("np-foodchain:burgerjob_shelfstorage2", {{
    --     event = "np-foodchain:silentAlarm",
    --     id = "foodchain_silent_alarm",
    --     icon = "bell",
    --     label = "Alert Police"
    -- }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

    --Cash Registers
    local purchasePeekData = {{
        event = "np-foodchain:registerPurchasePrompt",
        icon = "cash-register",
        label = _L("foodchain-make-payment", "Make Payment"),
        parameters = {}
    }}

    local purchasePeekOptions = { distance = { radius = 3.5 } }

    -- This should 100% not work, but it does because exports serialize/copy the object
    -- If exports were to send references in the future then it would break for sure!

    purchasePeekData[1].id = 'food_chain_register_customer_1'
    purchasePeekData[1].parameters = {registerId = 1}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register1', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_2'
    purchasePeekData[1].parameters = {registerId = 2}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register2', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_3'
    purchasePeekData[1].parameters = {registerId = 3}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register3', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'food_chain_register_customer_4'
    purchasePeekData[1].parameters = {registerId = 4}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_drivethruwindow', purchasePeekData, { distance = { radius = 7.0 } })

    purchasePeekData[1].id = 'food_chain_register_customer_5'
    purchasePeekData[1].parameters = {registerId = 5}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register_pier', purchasePeekData, { distance = { radius = 4.0 } })
    


    local registerPeekData = {{
        event = "np-foodchain:registerChargePrompt",
        icon = "credit-card",
        label = _L("foodchain-charge-customer", "Charge Customer"),
        parameters = {}
    }}

    local registerPeekOptions = { distance = { radius = 3.5 }, isEnabled = isChargeActive }

    registerPeekData[1].id = 'food_chain_register_worker_1'
    registerPeekData[1].parameters = { registerId = 1 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register1', registerPeekData, registerPeekOptions)
    
    registerPeekData[1].id = 'food_chain_register_worker_2'
    registerPeekData[1].parameters = { registerId = 2 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register2', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_3'
    registerPeekData[1].parameters = { registerId = 3 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register3', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_4'
    registerPeekData[1].parameters = { registerId = 4 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register4', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'food_chain_register_worker_5'
    registerPeekData[1].parameters = { registerId = 5 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-foodchain:burgerjob_register_pier', registerPeekData, registerPeekOptions)
end)

function isChargeActive(pEntity, pContext)
    return isSignedOn
end

RegisterUICallback('np-foodchain:orderFood', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local startPos = GetEntityCoords(PlayerPedId())

    local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
    if data.key.context == "burger" then
        tempContext = burgerContext
        tempAction = _L("foodchain-preparing", "Preparing") .. " "
        tempAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
        tempAnim = "fullcut_cycle_v6_cokecutter"
        animLoop = true
    elseif data.key.context == "fries" then
        tempContext = friesContext
        tempAction = _L("foodchain-frying", "Frying") .. " "
        tempAnimDict = "missfinale_c2ig_11"
        tempAnim = "pushcar_offcliff_f"
        animLoop = true
    elseif data.key.context == "drinks" then
        tempContext = drinksContext
        tempAction = _L("foodchain-dispensing", "Dispensing") .. " "
        tempAnimDict = "mp_ped_interaction"
        tempAnim = "handshake_guy_a"
        animLoop = false
    else
        tempContext = miscContext
        tempAction = _L("foodchain-grabbing", "Grabbing") .. " "
        tempAnimDict = "missfinale_c2ig_11"
        tempAnim = "pushcar_offcliff_f"
        animLoop = true
    end

    --Ingredient check
    for _,itemid in pairs(data.key.recipe) do
        local hasItem = exports['np-inventory']:hasEnoughOfItem(itemid, 1, false, true)
        print(hasItem)
        if not hasItem then
            TriggerEvent("DoLongHudText", _L("foodchain-youre-missing", "You're missing") .. " " .. tostring(itemid))
            return
        end
    end

    if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    end

    RequestAnimDict(tempAnimDict)

    while not HasAnimDictLoaded(tempAnimDict) do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
        ClearPedSecondaryTask(PlayerPedId())
    else
        local animLength = animLoop and -1 or GetAnimDuration(tempAnimDict, tempAnim)
        TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, animLength, 18, 0, 0, 0, 0)
    end

    local finished = exports["np-taskbar"]:taskBar(data.key.craftTime * 1000, tempAction .. data.key.displayName)
    if finished == 100 then
        pos = GetEntityCoords(PlayerPedId(), false)
        if(#(startPos - pos) < 2.0) then
            for _,itemid in pairs(data.key.recipe) do
                TriggerEvent("inventory:removeItem", itemid, 1)
            end
            TriggerEvent("player:receiveItem", data.key.itemid, 1, false, {})
            exports['np-ui']:showContextMenu(tempContext)
        end
    end

    StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)
end)

AddEventHandler('np-foodchain:signOnPrompt', function(pParameters, pEntity, pContext)
    isSignedOn, langString, message = RPC.execute("np-foodchain:tryJoinJob", pParameters.location)
    if isSignedOn then
        --Build Context Menus
        local cid = exports["isPed"]:isPed("cid")
        for foodContext, data in pairs(foodConfig) do
            local temp = {}
            for k, item in pairs(data) do
                if not item.cid or item.cid == cid then
                  temp[#temp+1] = {
                      title = item.displayName,
                      description = item.description .. " | " .. item.craftTime .. "s",
                      action = "np-foodchain:orderFood",
                      key = {itemid = item.itemid, displayName = item.displayName, craftTime = item.craftTime, recipe = item.recipe, context = foodContext},
                      disabled = false
                  }
                end
            end

            if foodContext == "burger" then
                burgerContext = temp
            elseif foodContext == "fries" then
                friesContext = temp
            elseif foodContext == "drinks" then
                drinksContext = temp
            else
                miscContext = temp
            end
        end
    end
    TriggerEvent("DoLongHudText", _L(langString, message))
end)

AddEventHandler('np-foodchain:signOffPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("DoLongHudText", _L("foodchain-clocked-out", "Clocked out."))
    RPC.execute("np-foodchain:leaveJob")
    isSignedOn = false
end)

AddEventHandler('np-foodchain:pickupPromptWindow', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_window-" .. serverCode)
end)

AddEventHandler('np-foodchain:shelfPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_shelf-" .. serverCode)
end)

AddEventHandler('np-foodchain:shelfPrompt2', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_shelf2-" .. serverCode)
end)

AddEventHandler('np-foodchain:fridgePrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_fridge-" .. serverCode)
end)

AddEventHandler('np-foodchain:fridgePrompt2', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "burgerjob_fridge2-" .. serverCode)
end)

AddEventHandler('np-foodchain:getBag', function(pParameters, pEntity, pContext)
    local genId = tostring(math.random(10000, 99999999))
    local invId = "container-" .. genId .. "-burgershot bag"

    information = {
        inventoryId = invId,
        slots = 4,
        weight = 4,
    }
    TriggerEvent('player:receiveItem', 'burgershotbag', 1, true, information)
end)

AddEventHandler('np-foodchain:getMeal', function(pParameters, pEntity, pContext)
    RPC.execute("np-foodchain:getMurderMeal")
end)

AddEventHandler('np-foodchain:getToysPrompt', function()
  exports["np-ui"]:openApplication("textbox", {
    callbackUrl = "np-foodchain:ui:getToysPrompt",
    key = "np-foodchain:ui:getToysPrompt",
    items = {
      {
        icon = "meh-rolling-eyes",
        label = _L("foodchain-number-of-toys", "Number of toys"),
        name = "toys",
      }
    },
    show = true,
  });
end)

RegisterUICallback("np-foodchain:ui:getToysPrompt", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "" } })
  exports["np-ui"]:closeApplication("textbox")
  local numToys = tonumber(data[1].value)
  if numToys then
    TriggerEvent('player:receiveItem', 'randomtoy3', numToys, false, {})
  end
end)

AddEventHandler('np-foodchain:stationPrompt', function(pParameters, pEntity, pContext)
    local tempContext, tempBrokeText, tempBrokeAction = {}, "", ""
    if pParameters.stationId == 0 then
        tempContext = miscContext
        tempBrokeText = _L("foodchain-trays-cleaning-need", "The trays need cleaning")
    elseif pParameters.stationId == 1 then
        tempContext = friesContext
        tempBrokeText =  _L("foodchain-fryer-cleaning-need", "The fryer needs cleaning")
    elseif pParameters.stationId == 2 then
        tempContext = burgerContext
        tempBrokeText =  _L("foodchain-table-cleaning-need", "The table needs cleaning")
    elseif pParameters.stationId == 3 then
        tempContext = drinksContext
        tempBrokeText =  _L("foodchain-dispenser-cleaning-need", "The dispenser needs cleaning")
    end

    --Check if station is broken (server handles the random break chance)
    local isActive = RPC.execute("np-foodchain:isStationActive", pParameters.stationId)

    if not isActive then
        --Open failed dialog
        local failedContext = {{
            title = "Clean",
            description = tempBrokeText,
            action = "np-foodchain:cleanStation",
            key = {stationId = pParameters.stationId},
            disabled = false
        }}
        tempContext = failedContext
    end
    
    exports['np-ui']:showContextMenu(tempContext)
end)

AddEventHandler('np-foodchain:registerPurchasePrompt', function(pParameters, pEntity, pContext)
    local activeRegisterId = pParameters.registerId
    local activeRegister = activePurchases[activeRegisterId]
    if not activeRegister or activeRegister == nil then
        TriggerEvent("DoLongHudText", _L("foodchain-no-active-purchase", "No purchase active."))
        return
    end
    local priceWithTax = RPC.execute("PriceWithTaxString", activeRegister.cost, "Goods")
    local acceptContext = {{
        title = _L("foodchain-accept-purchase", "Accept Purchase"),
        description = "$" .. priceWithTax.text .. " | " .. activeRegister.comment,
        action = "np-foodchain:finishPurchasePrompt",
        key = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger},
        disabled = false
    }}
    exports['np-ui']:showContextMenu(acceptContext)
end)

AddEventHandler('np-foodchain:registerChargePrompt', function(pParameters, pEntity, pContext)
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'np-ui:foodchain:charge',
        key = pParameters.registerId,
        items = {
          {
            icon = "dollar-sign",
            label = _L("foodchain-cost", "Cost"),
            name = "cost",
          },
          {
            icon = "pencil-alt",
            label = _L("foodchain-comment", "Comment"),
            name = "comment",
          },
        },
        show = true,
    })
end)


RegisterUICallback('np-foodchain:cleanStation', function(data, cb)
    local tempAnimDict = "amb@world_human_maid_clean@base"
    local tempAnim = "base"

    if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    end

    RequestAnimDict(tempAnimDict)

    while not HasAnimDictLoaded(tempAnimDict) do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
        ClearPedSecondaryTask(PlayerPedId())
    else
        TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, -1, 19, 0, 0, 0, 0)
    end

    --Open taskbar skill
    local failed = false
    for i=1,4 do
        if not failed then
            local finished = exports["np-ui"]:taskBarSkill(3000,  math.random(15, 20))
            if finished ~= 100 then
                failed = true
            end
        end
    end

    StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)

    if not failed then
        RPC.execute("np-foodchain:setStationActive", data.key.stationId)
        TriggerEvent("DoLongHudText", _L("foodchain-station-cleaned", "Station cleaned."))
    end
end)

RegisterUICallback('np-foodchain:finishPurchasePrompt', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local success = RPC.execute("np-foodchain:completePurchase", data.key)
    if not success then
        TriggerEvent("DoLongHudText", _L("foodchain-could-not-complete-purchase", "The purchase could not be completed."))
    end
end)

RegisterUICallback("np-ui:foodchain:charge", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')
    local cost = tonumber(data[1].value)
    local comment = data[2].value
    --check if cost is actually a number
    if cost == nil or not cost then return end
    if comment == nil then comment = "" end

    if cost < 10 then cost = 10 end --Minimum $10

    --Send event to everyone indicating a purchase is ready at specified register
    RPC.execute("np-foodchain:startPurchase", {cost = cost, comment = comment, registerId = data[3].value})
end)

--Add to purchases at registerId pos
RegisterNetEvent('np-foodchain:activePurchase')
AddEventHandler("np-foodchain:activePurchase", function(data)
    activePurchases[data.registerId] = data
end)

--Remove at registerId pos
RegisterNetEvent('np-foodchain:closePurchase')
AddEventHandler("np-foodchain:closePurchase", function(data)
    activePurchases[data.registerId] = nil
end)

--Getting fired
RegisterNetEvent('np-foodchain:firedEmployee')
AddEventHandler("np-foodchain:firedEmployee", function(langString, defaultString)
    isSignedOn = false
    TriggerEvent("DoLongHudText", _L(langString, defaultString), 2)
end)

--Firing someone
RegisterNetEvent('np-foodchain:burgerjob_fire')
AddEventHandler("np-foodchain:burgerjob_fire", function(employee)
    if employee == nil then return end
    local success = RPC.execute("np-foodchain:fireEmployee", employee)
    if success then 
        TriggerEvent("DoLongHudText", _L("foodchain-fired-employee", "Fired Employee"))
    end
end)

AddEventHandler("np-inventory:itemUsed", function(item, info)
    if item == "burgershotbag" or item == "murdermeal" or item == "wrappedgift" then
        data = json.decode(info)
        TriggerEvent("InteractSound_CL:PlayOnOne","unwrap",0.1)
        TriggerEvent("inventory-open-container", data.inventoryId, 4, 4)
    end
    if item == "randomtoy" or item == "randomtoy2" or item == "randomtoy3" then
        local finished = exports["np-taskbar"]:taskBar(1000, _L("foodchain-opening", "Opening"))
        if finished == 100 then
            TriggerServerEvent('loot:useItem', item)
            TriggerEvent("inventory:removeItem", item, 1)
        end
    end
end)

-- active employee list
AddEventHandler('np-foodchain:getActiveEmployees', function ()
    local employees = RPC.execute('np-foodchain:server:getActiveEmployees')

    local mappedEmployees = {}

    for location, list in pairs(employees) do
        local fancyLocationName = _L("foodchain-main-restaurant", "Main Restaurant")
        if location == "pier" then
            fancyLocationName = _L("foodchain-pier-restaurant", "the Pier")
        end
        for _, employee in pairs(employees[location]) do
            table.insert(mappedEmployees, {
                title = string.format("%s (%s)", employee.name, employee.cid),
                description = string.format(_L("foodchain-clocked-in-at", "Clocked in at %s"), fancyLocationName),
            })
        end
    end
    if #mappedEmployees == 0 then
        table.insert(mappedEmployees, {
            title = _L("foodchain-no-active-employees", "Nobody is clocked in currently"),
        })
    end

    exports['np-ui']:showContextMenu(mappedEmployees)
end)

-- Citizen.CreateThread(function()
--   while true do
--     TriggerServerEvent('loot:useItem', 'randomtoy3')
--     Citizen.Wait(100)
--   end
-- end)

local inLine = false

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone == "np-foodchain:burgerjob_outsidenear" then
        TriggerEvent('np-voice:setQuietMode', 'burgershot', true, 2)
    end

    if zone == "np-foodchain:burgerjob_interior" then
        --TriggerEvent('np-voice:setVoiceProximity', 1)
    end

    if zone == "np-foodchain:burgerjob_intercom_outside" then
        TriggerEvent('np:fiber:voice-event', 'intercom', 85, 2, true)
        exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = true })
    end

    if zone == "np-foodchain:burgerjob_line" then
        local canUse = RPC.execute("np-foodchain:canUseStore")
        if canUse then
            inLine = true
            Citizen.CreateThread(function()
                local promptShowing = false
                while inLine do
                    if not promptShowing then
                        exports["np-ui"]:showInteraction(_L("foodchain-wait-in-line", "[E] Wait in Line"))
                        promptShowing = true
                    end
                    if IsControlJustPressed(1, 38) then
                        exports["np-ui"]:hideInteraction()
                        local finished = exports["np-taskbar"]:taskBar(10000, _L("foodchain-ordering", "Ordering Food"), false, true, false, false, nil, 5.0, PlayerPedId())
                        if finished == 100 then
                            TriggerEvent("server-inventory-open", "123", "Shop")
                        end
                    end
                    Wait(0)
                end
            end)
        end
    end
end)

AddEventHandler("np-polyzone:exit", function(zone)
    if zone == "np-foodchain:burgerjob_outsidenear" then
        TriggerEvent('np-voice:setQuietMode', 'burgershot', false)
    end

    if zone == "np-foodchain:burgerjob_intercom_outside" then
        -- TriggerEvent("np:fiber:voice-event", "radioFrequency", 0)
        TriggerEvent('np:fiber:voice-event', 'intercom', 85, 2, false)
        exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = false })
    end

    if zone == "np-foodchain:burgerjob_line" then
        inLine = false
        exports["np-ui"]:hideInteraction()
    end
end)

local headsetConnected = false
AddEventHandler("np-inventory:itemUsed", function(item)
  if item ~= "burgershotheadset" then return end
  if not headsetConnected then
    headsetConnected = true
    TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, true, true)
    exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = true })
else
    headsetConnected = false
    TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, false, false)
    exports["np-ui"]:sendAppEvent("hud", { burgerShotIntercom = false })
  end
end)

RegisterNetEvent('np-inventory:itemCheck')
AddEventHandler('np-inventory:itemCheck', function (item)
  if item ~= "burgershotheadset" or not headsetConnected then return end
  headsetConnected = false
  TriggerEvent('np:fiber:voice-event', 'intercom', 85, 1, false, false)
end)

RegisterNetEvent('np-foodchain:cash:in')
AddEventHandler('np-foodchain:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("np-foodchain:update:pay", cid)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

exports["np-polytarget"]:AddBoxZone("cash_in", vector3(241.67, 226.35, 106.29), 2.2, 1, {
    heading=0
  })



