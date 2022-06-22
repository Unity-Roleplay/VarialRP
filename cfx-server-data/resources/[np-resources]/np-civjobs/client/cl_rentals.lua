local boatsValeted = 0
local currentlyRentedBoat

local function returnBoat()
    if currentlyRentedBoat == nil or not DoesEntityExist(currentlyRentedBoat) then
        return
    end
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    local finished = exports["np-taskbar"]:taskBar(1000, "Returning Boat")
    FreezeEntityPosition(ped, false)
    if finished ~= 100 then
        return
    end
    DeleteEntity(currentlyRentedBoat)
    currentlyRentedBoat = nil
    TriggerEvent("np-fishing:currentlyRentedBoat", currentlyRentedBoat)
end

function rentBoat()
    boatsValeted = boatsValeted + 1
    FreezeEntityPosition(PlayerPedId(), true)
    local finished = exports["np-taskbar"]:taskBar(1000, "Valeting Boat")
    FreezeEntityPosition(PlayerPedId(), false)
    if finished ~= 100 then
        return
    end
    DoScreenFadeOut(200)
    local model = "suntrap"
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
    SetModelAsNoLongerNeeded(model)

    local veh = CreateVehicle(model, vector4(-814.48, -1504.66, -0.47, 109.29), true, false)
    currentlyRentedBoat = veh
    TriggerEvent("np-fishing:currentlyRentedBoat", currentlyRentedBoat)

    local vehplate = "BOA"..math.random(10000, 99999) 
    SetVehicleNumberPlateText(veh, vehplate)
    Citizen.Wait(100)
    TriggerEvent("keys:addNew", veh, vehplate)
    SetModelAsNoLongerNeeded(model)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)

    DoScreenFadeIn(2000)
end

AddEventHandler("np-fishing:rentBoat", function(name)
    -- local boatsRented = RPC.execute("fishing:getBoatsRented")
    -- if boatsRented > 3 then
    --   TriggerEvent("DoLongHudText", "We're out of stock currently!", 2)
    --   return
    -- end
    rentBoat()
end)

AddEventHandler("np-fishing:returnBoat", function()
    if currentlyRentedBoat == nil then
        TriggerEvent("DoLongHudText", "You don't have a boat to return!", 2)
        return
    end
    returnBoat()
end)

AddEventHandler("jobs:checkOut", function(pParams, pEntity, pContext)
    if not pEntity or not pContext.job or pContext.job.id ~= "fishing" or currentlyRentedBoat == nil then
        return
    end
    SetVehicleAsNoLongerNeeded(currentlyRentedBoat)
    currentlyRentedBoat = nil
    TriggerEvent("np-fishing:currentlyRentedBoat", currentlyRentedBoat)
end)
