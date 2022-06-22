
local foodConfig = {
    burger = {
        {itemid = "bleederburger", displayName = _L("uwucafee-sweet-rice-balls", "Sweet Rice Balls"), description = _L("uwucafee-sweet-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "heartstopper", displayName = _L("uwucafee-rice-ball-pudding", "Rice Ball Pudding"), description = _L("uwucafee-rice-ball-pudding-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "torpedo", displayName = _L("uwucafee-soothing-rice-balls", "Soothing Rice Balls"), description = _L("uwucafee-soothing-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "moneyshot", displayName = _L("uwucafee-energising-rice-balls", "Energising Rice Balls"), description = _L("uwucafee-energising-rice-balls-recipe", "1 Bun, 1 Cheese, 1 Lettuce, 1 Patty"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "lettuce", "hamburgerpatty"}},
        {itemid = "meatfree", displayName = _L("uwucafee-charismatic-rice-balls", "Charismatic Rice Balls"), description = _L("uwucafee-charismatic-rice-balls-recipe", "1 Bun, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "lettuce"}},
        {itemid = "questionablemeatburger", displayName = _L("uwucafee-smart-rice-balls", "Smart Rice Balls"), description = _L("uwucafee-questionable-smart-rice-balls-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
        {itemid = "questionablemeatburger", displayName = _L("uwucafee-filling-rice-balls", "Filling Rice Balls"), description = _L("uwucafee-questionable-filling-rice-balls-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},
        {itemid = "questionablemeatburger", displayName = _L("uwucafee-strong-rice-balls", "Strong Rice Balls"), description = _L("uwucafee-questionable-strong-rice-recipe", "1 Bun, 1 Questionable Meat, 1 Cheese, 1 Lettuce"), craftTime = 10, recipe = {"hamburgerbuns", "cheese", "questionablemeat", "lettuce"}},

    },
    drinks = {
        {itemid = "water", displayName =  _L("uwucafee-energising-matcha-coffee", "Energising Matcha Coffee"), description = _L("uwucafee-none-recipe", "None"), craftTime = 5, recipe = {}},
        {itemid = "softdrink", displayName =  _L("uwucafee-filling-matcha-coffee", "Filling Matcha Coffee"), description = _L("uwucafee-soft-drink-recipe", "1 High-Fructose Syrup"), craftTime = 5, recipe = {"hfcs"}},
        {itemid = "mshake", displayName =  _L("uwucafee-soothing-match-coffee", "Soothign Matcha Coffee"), description =  _L("uwucafee-milkshake-recipe", "1 Milk, 1 Ice Cream"), craftTime = 10, recipe = {"milk", "icecreamingred"}},
        {itemid = "fruitslushy", displayName =  _L("uwucafee-strengthening-booba-milk-tea", "Strengthening Booba Milk Tea"), description =  _L("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
        {itemid = "fruitslushy", displayName =  _L("uwucafee-charismatic-booba-milk-tea", "Charismatic Booba Milk Tea"), description =  _L("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
        {itemid = "fruitslushy", displayName =  _L("uwucafee-smart-booba-milk-tea", "Smart Booba Milk Tea"), description =  _L("uwucafee-fruit-slushy-recipe", "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry"), craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},

    },
}

local isSignedOn = false

local burgerContext, drinksContext = {}, {}

local activePurchases = {}

local serverCode = "wl"

Citizen.CreateThread(function()
    serverCode = "wl"
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_signon', {{
        event = "np-uwucafee:signOnPrompt",
        id = "uwu_chain_sign_on",
        icon = "clock",
        label = _L("uwucafee-clock-in", "Clock In"),
        parameters = { location = "main" }
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return not isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_signon', {{
        event = "np-uwucafee:getActiveEmployees",
        id = "uwu_chain_active_employees",
        icon = "list",
        label = _L("uwucafee-view-employee-list", "View Active Employees"),
    }}, { distance = { radius = 3.5 }  , isEnabled = function(pEntity, pContext) return isSignedOn end })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_signon', {{
        event = "np-uwucafee:signOffPrompt",
        id = "uwu_chain_sign_off",
        icon = "clock",
        label = _L("uwucafee-clock-out", "Clock Out")
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })


    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_shelfstorage', {{
        event = "np-uwucafee:shelfPrompt",
        id = "uwu_chain_shelf_storage",
        icon = "box-open",
        label = _L("uwucafee-open", "Open")
    }}, { distance = { radius = 3.5 }  })


    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_fridge', {{
        event = "np-uwucafee:fridgePrompt",
        id = "uwu_chain_fridge",
        icon = "box-open",
        label = _L("uwucafee-open", "Open Fridge")
    }}, { distance = { radius = 3.5 }  })

    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_station2', {{
        event = "np-uwucafee:stationPrompt",
        id = 'uwu_chain_station_2', --Drinks
        icon = "utensils",
        label = _L("uwucafee-open-station", "Prepare Food"),
        parameters = { stationId = 2 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })
    print("here")

    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_station3', {{
        event = "np-uwucafee:stationPrompt",
        id = 'uwu_chain_station_3', --Drinks
        icon = "mug-hot",
        label = _L("uwucafee-open-station", "Open Station"),
        parameters = { stationId = 3 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np-uwucafee:cafeejob_shelfstorage", {{
        event = "np-uwucafee:silentAlarm",
        id = "foodchain_silent_alarm",
        icon = "bell",
        label = _L("uwucafee-alert-police", "Alert Police")
    }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

    -- exports["np-interact"]:AddPeekEntryByPolyTarget("np-uwucafee:cafeejob_shelfstorage2", {{
    --     event = "np-uwucafee:silentAlarm",
    --     id = "foodchain_silent_alarm",
    --     icon = "bell",
    --     label = "Alert Police"
    -- }}, { distance = { radius = 3.0 }, isEnabled = isChargeActive })

    --Cash Registers
    local purchasePeekData = {{
        event = "np-uwucafee:registerPurchasePrompt",
        icon = "cash-register",
        label = _L("uwucafee-make-payment", "Make Payment"),
        parameters = {}
    }}

    local purchasePeekOptions = { distance = { radius = 3.5 } }

    -- This should 100% not work, but it does because exports serialize/copy the object
    -- If exports were to send references in the future then it would break for sure!

    purchasePeekData[1].id = 'uwu_chain_register_customer_1'
    purchasePeekData[1].parameters = {registerId = 1}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register1', purchasePeekData, purchasePeekOptions)

    purchasePeekData[1].id = 'uwu_chain_register_customer_2'
    purchasePeekData[1].parameters = {registerId = 2}
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register2', purchasePeekData, purchasePeekOptions)
    


    local registerPeekData = {{
        event = "np-uwucafee:registerChargePrompt",
        icon = "credit-card",
        label = _L("uwucafee-charge-customer", "Charge Customer"),
        parameters = {}
    }}

    local registerPeekOptions = { distance = { radius = 3.5 }, isEnabled = isChargeActive }

    registerPeekData[1].id = 'uwu_chain_register_worker_1'
    registerPeekData[1].parameters = { registerId = 1 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register1', registerPeekData, registerPeekOptions)
    
    registerPeekData[1].id = 'uwu_chain_register_worker_2'
    registerPeekData[1].parameters = { registerId = 2 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register2', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'uwu_chain_register_worker_3'
    registerPeekData[1].parameters = { registerId = 3 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register3', registerPeekData, registerPeekOptions)

    registerPeekData[1].id = 'uwu_chain_register_worker_4'
    registerPeekData[1].parameters = { registerId = 4 }
    exports['np-interact']:AddPeekEntryByPolyTarget('np-uwucafee:cafeejob_register4', registerPeekData, registerPeekOptions)

end)

function isChargeActive(pEntity, pContext)
    return isSignedOn
end

RegisterUICallback('np-uwucafee:orderFood', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local startPos = GetEntityCoords(PlayerPedId())

    local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
    if data.key.context == "burger" then
        tempContext = burgerContext
        tempAction = _L("uwucafee-preparing", "Preparing") .. " "
        tempAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
        tempAnim = "fullcut_cycle_v6_cokecutter"
        animLoop = true
    elseif data.key.context == "drinks" then
        tempContext = drinksContext
        tempAction = _L("uwucafee-dispensing", "Dispensing") .. " "
        tempAnimDict = "mp_ped_interaction"
        tempAnim = "handshake_guy_a"
        animLoop = false
    end

    --Ingredient check
    for _,itemid in pairs(data.key.recipe) do
        local hasItem = exports['np-inventory']:hasEnoughOfItem(itemid, 1, false, true)
        print(hasItem)
        if not hasItem then
            TriggerEvent("DoLongHudText", _L("uwucafee-youre-missing", "You're missing") .. " " .. tostring(itemid))
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

AddEventHandler('np-uwucafee:signOnPrompt', function(pParameters, pEntity, pContext)
    isSignedOn, langString, message = RPC.execute("np-uwucafee:tryJoinJob", pParameters.location)
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
                      action = "np-uwucafee:orderFood",
                      key = {itemid = item.itemid, displayName = item.displayName, craftTime = item.craftTime, recipe = item.recipe, context = foodContext},
                      disabled = false
                  }
                end
            end

            if foodContext == "burger" then
                burgerContext = temp
            elseif foodContext == "drinks" then
                drinksContext = temp
            end
        end
    end
    TriggerEvent("DoLongHudText", _L(langString, message))
end)

AddEventHandler('np-uwucafee:signOffPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("DoLongHudText", _L("uwucafee-clocked-out", "Clocked out."))
    RPC.execute("np-uwucafee:leaveJob")
    isSignedOn = false
end)

AddEventHandler('np-uwucafee:shelfPrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "cafeejob_shelf-" .. serverCode)
end)

AddEventHandler('np-uwucafee:fridgePrompt', function(pParameters, pEntity, pContext)
    TriggerEvent("server-inventory-open", "1", "cafeejob_fridge-" .. serverCode)
end)


AddEventHandler('np-uwucafee:stationPrompt', function(pParameters, pEntity, pContext)
    local tempContext, tempBrokeText, tempBrokeAction = {}, "", ""
    if pParameters.stationId == 0 then
        tempContext = miscContext
        tempBrokeText = _L("uwucafee-trays-cleaning-need", "The trays need cleaning")
    elseif pParameters.stationId == 2 then
        tempContext = burgerContext
        tempBrokeText =  _L("uwucafee-table-cleaning-need", "The table needs cleaning")
    elseif pParameters.stationId == 3 then
        tempContext = drinksContext
        tempBrokeText =  _L("uwucafee-dispenser-cleaning-need", "The dispenser needs cleaning")
    end

    --Check if station is broken (server handles the random break chance)
    local isActive = RPC.execute("np-uwucafee:isStationActive", pParameters.stationId)

    if not isActive then
        --Open failed dialog
        local failedContext = {{
            title = "Clean",
            description = tempBrokeText,
            action = "np-uwucafee:cleanStation",
            key = {stationId = pParameters.stationId},
            disabled = false
        }}
        tempContext = failedContext
    end
    
    exports['np-ui']:showContextMenu(tempContext)
end)

AddEventHandler('np-uwucafee:registerPurchasePrompt', function(pParameters, pEntity, pContext)
    local activeRegisterId = pParameters.registerId
    local activeRegister = activePurchases[activeRegisterId]
    if not activeRegister or activeRegister == nil then
        TriggerEvent("DoLongHudText", _L("uwucafee-no-active-purchase", "No purchase active."))
        return
    end
    local priceWithTax = RPC.execute("PriceWithTaxString", activeRegister.cost, "Goods")
    local acceptContext = {{
        title = _L("uwucafee-accept-purchase", "Accept Purchase"),
        description = "$" .. priceWithTax.text .. " | " .. activeRegister.comment,
        action = "np-uwucafee:finishPurchasePrompt",
        key = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger},
        disabled = false
    }}
    exports['np-ui']:showContextMenu(acceptContext)
end)

AddEventHandler('np-uwucafee:registerChargePrompt', function(pParameters, pEntity, pContext)
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'np-ui:uwuwcaffee:charge',
        key = pParameters.registerId,
        items = {
          {
            icon = "dollar-sign",
            label = _L("uwucafee-cost", "Cost"),
            name = "cost",
          },
          {
            icon = "pencil-alt",
            label = _L("uwucafee-comment", "Comment"),
            name = "comment",
          },
        },
        show = true,
    })
end)


RegisterUICallback('np-uwucafee:cleanStation', function(data, cb)
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
        RPC.execute("np-uwucafee:setStationActive", data.key.stationId)
        TriggerEvent("DoLongHudText", _L("uwucafee-station-cleaned", "Station cleaned."))
    end
end)

RegisterUICallback('np-uwucafee:finishPurchasePrompt', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local success = RPC.execute("np-uwucafee:completePurchase", data.key)
    if not success then
        TriggerEvent("DoLongHudText", _L("uwucafee-could-not-complete-purchase", "The purchase could not be completed."))
    end
end)

RegisterUICallback("np-ui:uwuwcaffee:charge", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')
    local cost = tonumber(data[1].value)
    local comment = data[2].value
    --check if cost is actually a number
    if cost == nil or not cost then return end
    if comment == nil then comment = "" end

    if cost < 10 then cost = 10 end --Minimum $10

    --Send event to everyone indicating a purchase is ready at specified register
    RPC.execute("np-uwucafee:startPurchase", {cost = cost, comment = comment, registerId = data[3].value})
end)

--Add to purchases at registerId pos
RegisterNetEvent('np-uwucafee:activePurchase')
AddEventHandler("np-uwucafee:activePurchase", function(data)
    activePurchases[data.registerId] = data
end)

--Remove at registerId pos
RegisterNetEvent('np-uwucafee:closePurchase')
AddEventHandler("np-uwucafee:closePurchase", function(data)
    activePurchases[data.registerId] = nil
end)

--Getting fired
RegisterNetEvent('np-uwucafee:firedEmployee')
AddEventHandler("np-uwucafee:firedEmployee", function(langString, defaultString)
    isSignedOn = false
    TriggerEvent("DoLongHudText", _L(langString, defaultString), 2)
end)

--Firing someone
RegisterNetEvent('np-uwucafee:cafeejob_fire')
AddEventHandler("np-uwucafee:cafeejob_fire", function(employee)
    if employee == nil then return end
    local success = RPC.execute("np-uwucafee:fireEmployee", employee)
    if success then 
        TriggerEvent("DoLongHudText", _L("uwucafee-fired-employee", "Fired Employee"))
    end
end)

-- active employee list
AddEventHandler('np-uwucafee:getActiveEmployees', function ()
    local employees = RPC.execute('np-uwucafee:server:getActiveEmployees')

    local mappedEmployees = {}

    for location, list in pairs(employees) do
        local fancyLocationName = _L("uwucafee-main-restaurant", "Main Cafee")
        for _, employee in pairs(employees[location]) do
            table.insert(mappedEmployees, {
                title = string.format("%s (%s)", employee.name, employee.cid),
                description = string.format(_L("uwucafee-clocked-in-at", "Clocked in at %s"), fancyLocationName),
            })
        end
    end
    if #mappedEmployees == 0 then
        table.insert(mappedEmployees, {
            title = _L("uwucafee-no-active-employees", "Nobody is clocked in currently"),
        })
    end

    exports['np-ui']:showContextMenu(mappedEmployees)
end)


RegisterNetEvent('np-uwucafee:cash:in')
AddEventHandler('np-uwucafee:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("np-uwucafee:update:pay", cid)
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end




