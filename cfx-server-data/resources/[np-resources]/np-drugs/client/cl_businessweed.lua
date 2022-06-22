RegisterNetEvent("np-weedstore:startpicking")
AddEventHandler("np-weedstore:startpicking", function()
    local rank = exports["isPed"]:GroupRank("weed_store")
    if rank > 0 then  
        if exports['np-inventory']:hasEnoughOfItem("purifiedwater", 1) and exports['np-inventory']:hasEnoughOfItem("plantpot", 1) and exports['np-inventory']:hasEnoughOfItem("fertilizer", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 355.69338989258)
            local finished = exports['np-taskbar']:taskBar(20000, 'Harvesting')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'smallbud', 6)
                TriggerEvent("inventory:removeItem", "purifiedwater", 1)
                TriggerEvent("inventory:removeItem", "plantpot", 1)
                TriggerEvent("inventory:removeItem", "fertilizer", 1)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
            
        else
            TriggerEvent('DoLongHudText', 'You are missing an item', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a license', 2)
    end
end)

RegisterNetEvent("np-weedstore:startpacking")
AddEventHandler("np-weedstore:startpacking", function()
    local rank = exports["isPed"]:GroupRank("weed_store")
    if rank > 0 then  
        if exports['np-inventory']:hasEnoughOfItem("smallbud", 3) and exports['np-inventory']:hasEnoughOfItem("plastic", 1) then
            local dict = 'missfinale_c2ig_11'
            LoadDict(dict)
            FreezeEntityPosition(GetPlayerPed(-1),true)
            TaskPlayAnim(GetPlayerPed(-1), dict, "pushcar_offcliff_f", 3.0, -8, -1, 63, 0, 0, 0, 0 )
            SetEntityHeading(GetPlayerPed(-1), 186.32456970215)
            local finished = exports['np-taskbar']:taskBar(20000, 'Packaging')
            if (finished == 100) then
                TriggerEvent('player:receiveItem', 'weedq', 10)
                TriggerEvent("inventory:removeItem", "plastic", 1)
                TriggerEvent("inventory:removeItem", "smallbud", 3)
                FreezeEntityPosition(GetPlayerPed(-1),false)
                ClearPedTasks(GetPlayerPed(-1))
                Citizen.Wait(1000)
            end
        else
            TriggerEvent('DoLongHudText', 'You are missing an item', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You need a license', 2)
    end
end)


RegisterNetEvent("weedstore:register")
AddEventHandler("weedstore:register", function(registerID)
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "weed_store" then
        local order = exports["np-applications"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("weedstore:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("weedstore:get:receipt")
AddEventHandler("weedstore:get:receipt", function(registerid)
    TriggerServerEvent('weedstore:retreive:receipt', registerid)
end)

RegisterNetEvent('weedstore:cash:in')
AddEventHandler('weedstore:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("weedstore:update:pay", cid)
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end