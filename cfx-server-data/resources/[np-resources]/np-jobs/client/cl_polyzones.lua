NearScubaBoatRental, NearReturnBoat, IronSellSpot, SellUnknown, ProcessFish, NearWeazelNews = false, false, false, false, false, false
CutFish, SellSpotF, ChickenStart, ChickenSpot, MeltingSpot, WashingSpot, NearChopShop, AtChopSell = false, false, false, false, false, false, false, false
Citizen.CreateThread(function()
    -- Mining
    exports["np-polytarget"]:AddBoxZone("ak_storage", vector3(844.4, -2881.44, 11.45), 1.6, 2.0, {
        name="ak_storage",
        heading=358,
        --debugPoly=true,
        minZ=8.25,
        maxZ=12.25
    })  
    exports["np-polytarget"]:AddBoxZone("weap_crafting", vector3(849.58, -2881.74, 11.45), 1.2, 1, {
        name="weap_crafting",
        heading=0,
        --debugPoly=true,
        minZ=8.25,
        maxZ=12.25
    })  
    -- Scuba
    exports["np-polyzone"]:AddBoxZone("scuba_get_boat", vector3(-1607.69, 5264.76, 3.97), 2.3, 1.5, {
        name="scuba_get_boat",
        heading=115,
        --debugPoly=true,
        minZ=2.97,
        maxZ=4.97
    })  
    exports["np-polyzone"]:AddBoxZone("scuba_return_boat", vector3(-1602.02, 5260.31, 2.09), 7.4, 5, {
        name="scuba_return_boat",
        heading=25,
        --debugPoly=true,
        minZ=-1.11,
        maxZ=3.89
    })  
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "scuba_get_boat" then
        NearScubaBoatRental = true
        NearScubaBoat()
        if not canSpawn then
            exports["np-ui"]:showInteraction("[E] Boat already out")
        else
            exports["np-ui"]:showInteraction("[E] Rent Boat ($400)")
        end
    elseif name == 'scuba_return_boat' then
        if veh ~= 0 then
            exports["np-ui"]:showInteraction("[E] Return Boat")
            NearReturnBoat = true
            AtReturnSpot()
        end
    elseif name == "sell_iron_bars" then
        IronSellSpot = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Items")) 
        IronSell()
    elseif name == "sell_unknown_material" then
        SellUnknown = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Items")) 
        SellUnknownSpot()
    elseif name == "fishing_sushi" then
        ProcessFish = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Process Cut Fish")) 
        ProcessFishSpot()
    elseif name == "fishing_cut" then
        CutFish = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Cut Fish")) 
        CutFishSpot()
    elseif name == "fishing_sell" then
        SellSpotF = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Sushi")) 
        SellSpotFish()
    elseif name == "chicken_sell" then
        ChickenSpot = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Sell Chicken")) 
        SellSpotChicken()
    elseif name == "chicken_start" then
        ChickenStart = true
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Start Catching Chicken")) 
        StartSpotChicken()
    elseif name == "Weazel" then
        NearWeazelNews = true
        NearWeazelNews2()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Record The News!"))
    elseif name == "idcard" then
        NearCourthouse = true
        NearCourthouse2()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("To purchase an ID ($50)"))
    elseif name == "melting_spot" then
        MeltingSpot = true
        Meltmaterials()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Melt!"))
    elseif name == "washing_spot" then
        WashingSpot = true
        WashStones()
        TriggerEvent('np-textui:ShowUI', 'show', ("[E] %s"):format("Wash Stones!"))
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "scuba_get_boat" then
        NearScubaBoatRental = false
    elseif name == 'scuba_return_boat' then
        NearReturnBoat = false
    end
    TriggerEvent('np-textui:HideUI')
end)

function NearScubaBoat()
    Citizen.CreateThread(function()
        while NearScubaBoatRental do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                if exports["np-inventory"]:hasEnoughOfItem('oxygentank',1,false) or oxyOn then
                    if canSpawn then
                        TriggerEvent("fuckoffdinghyomfgwhyisntitspawning")
                        TriggerServerEvent('np-scuba:checkAndTakeDepo')
                        Citizen.Wait(500)
                        canSpawn = false
                        SetEntityAsMissionEntity(vehicle, true, true)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        local plate = GetVehicleNumberPlateText(vehicle)
                        TriggerEvent("keys:addNew",vehicle,plate)
                        StartDive()
                    end
                else
                    TriggerEvent('DoLongHudText', 'Sorry Man, You Wont Be Able To Breath Down There, Come Back With A Scuba Tank!.', 1)
                end
            end
        end
    end)
end

function AtReturnSpot()
    Citizen.CreateThread(function()
        while NearReturnBoat do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                DeleteVehicle(veh)
                veh = 0
                TriggerEvent('DoLongHudText', 'Thanks For Returning The Vehicles, Heres some of the Money Back!.', 1)
                RemoveBlip(allBlips)
                RemoveBlip(allBlipsSprite)
                TriggerServerEvent('np-scuba:returnDepo')
                SetEntityCoords(GetPlayerPed(-1), -1605.7166748047, 5259.1162109375, 2.0883903503418)
                SetEntityHeading(GetPlayerPed(-1), 23.752769470215)
                Citizen.Wait(2000)
                canSpawn = true
            end
        end
    end)
end
