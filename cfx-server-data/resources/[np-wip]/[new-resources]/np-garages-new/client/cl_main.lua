RegisterNetEvent("np-garages:open")
AddEventHandler("np-garages:open", function()
    local house = exports["np-menu"]:NearHouseGarage()
    if house then
        RPC.execute("np-garages:selectShared", exports['np-menu']:currentGarage())
    else
        print(exports['np-menu']:currentGarage())
        RPC.execute("np-garages:select", exports['np-menu']:currentGarage())
    end
end)

RegisterNetEvent("np-garages:attempt:spawn", function(data, pRealSpawn)
    if not pRealSpawn then
        if not data.shared then
            if data.current_garage == "Impound Lot" then 
                TriggerEvent("DoLongHudText", ('%s.'):format(isHeld and 'Your vehicle is being held, visit the impound lot to see more details' or 'You vehicle is repoed, speak to a pdm worker about it'), 1) 
                exports['np-garages']:DeleteViewedCar() 
                return 
            end
        end
            
        RPC.execute("np-garages:attempt:sv", data)
        SpawnVehicle(data.model, exports['np-menu']:currentGarage(), data.fuel, data.body, data.engine, data.customized, data.plate, true)
    else
        SpawnVehicle(data.model, exports['np-menu']:currentGarage(), data.fuel, data.body, data.engine, data.customized, data.plate, false)
    end
end)

RegisterNetEvent("np-garages:select:option", function(pData)
    RPC.execute("np-garages:select", exports['np-menu']:currentGarage(), exports["isPed"]:isPed("myJob"), pData.type)
end)


RegisterNetEvent("np-garages:takeout", function(pData)
    local house = exports["np-menu"]:NearHouseGarage()
    if house then
        RPC.execute("np-garages:spawned:getShared", pData.pVeh)
    else
        RPC.execute("np-garages:spawned:get", pData.pVeh, pData.shared, pData.job)
    end
end)

RegisterNetEvent("np-garages:store", function()
    local pos = GetEntityCoords(PlayerPedId())
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local curVeh = exports['np-garages']:getVehicleInDirection(coordA, coordB)
    if (curVeh ~= 0) then
        local fakePlates = RPC.execute('np-garages:managePlates', '', '', 'get')
        local plate = exports["np-garages"]:NearVehicle("plate")
        if fakePlates[tostring(plate)] ~= nil then
            if fakePlates[tostring(plate)].isOn then
                RPC.execute('np-garages:managePlates', plate, fakePlates[tostring(plate)].oldPlate, "remove")
                plate = fakePlates[tostring(plate)].oldPlate
            end
        end
        local Stored, shared = RPC.execute("np-garages:states", "Stored", plate, exports['np-menu']:currentGarage(), exports["np-garages"]:NearVehicle("Fuel"), exports["np-garages"]:NearVehicle("body"), exports["np-garages"]:NearVehicle("engine"))
        if Stored then
            TriggerEvent('np-vehicles/forget-vehicle', curVeh)
            DeleteVehicle(curVeh)
            DeleteEntity(curVeh)
            TriggerEvent('keys:remove', exports["np-garages"]:NearVehicle("plate"))
            TriggerEvent("DoLongHudText", "Vehicle stored in garage: " ..exports['np-menu']:currentGarage())
           -- TriggerEvent('np-vehicles/forget-vehicle', curVeh) -- FOR DEBUG
        else
            if not shared then
                TriggerEvent("DoLongHudText", "You cant store local cars!", 2)
            end
        end
    else
        TriggerEvent("DoLongHudText", "You need to look at the vehicle in order to store it!", 2)
    end
end)

Citizen.CreateThread(function()
    for _, item in pairs(Garages) do
        if item.blip ~= nil then
            Garage = AddBlipForCoord(item.blip.x, item.blip.y, item.blip.z)

            SetBlipSprite (Garage, 357)
            SetBlipDisplay(Garage, 4)
            SetBlipScale  (Garage, 0.65)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, 3)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(Garage)
        end
    end
end)


exports("getVehicleInDirection", function(coordA, coordB)
    return getVehicleInDirection(coordA, coordB)
end)

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        offset = offset - 1
        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then vehicle = nil end
    return vehicle ~= nil and vehicle or 0
end


exports("NearVehicle", function(pType)
    if pType == "Distance" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return true
        else
            return false
        end
    elseif pType == "plate" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    elseif pType == "Fuel" then
        local coords = GetEntityCoords(PlayerPedId())
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
            return  GetVehicleFuelLevel(vehicle)
        else
            return false
        end
    elseif pType == "sittingplate" then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            return GetVehicleNumberPlateText(vehicle)
        else
            return false
        end
    end
end)
