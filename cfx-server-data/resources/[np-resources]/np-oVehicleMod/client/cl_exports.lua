CurrentNetworkId, CurrentVehicle, CurrentSeat, IsDriving = nil, nil, nil, false

AddEventHandler('baseevents:enteredVehicle', function(pVehicle, pSeat, pName, pClass)
    CurrentSeat = pSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)

    IsDriving = pSeat == -1
end)

AddEventHandler('baseevents:leftVehicle', function(pVehicle, pSeat, pName, pClass)
    CurrentSeat = nil
    CurrentVehicle = nil
    CurrentNetworkId = nil
    IsDriving = false
end)

AddEventHandler('baseevents:vehicleChangedSeat', function(pVehicle, pCurrentSeat, pPreviousSeat)
    CurrentSeat = pCurrentSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)
    IsDriving = pCurrentSeat == -1
end)

AddEventHandler('baseevents:vehicleHotreload', function(pVehicle, pSeat, pEngineOn)
    CurrentSeat = pSeat
    CurrentVehicle = pVehicle
    CurrentNetworkId = NetworkGetNetworkIdFromEntity(pVehicle)
    IsDriving = pSeat == -1
end)

-- Exports Function
function HotwireVehicle(cb)
    -- if IsDriving then
    --     if not IsEmergencyVehicle then
    --         local finished = exports["arp-taskbarskill"]:taskBar(25000, 3)
    --         if finished ~= 100 then
    --             cb({
    --                 success = false,
    --                 stage = 1,
    --             })
    --         end

    --         local finished = exports["arp-taskbarskill"]:taskBar(15000, 3)
    --         if finished ~= 100 then
    --             cb({
    --                 success = false,
    --                 stage = 2,
    --             })
    --         end

    --         local finished = exports["arp-taskbarskill"]:taskBar(5000,3)
    --         if finished ~= 100 then
    --             cb({
    --                 success = false,
    --                 stage = 3,
    --             })
    --         end

    --         local finished = exports["arp-taskbarskill"]:taskBar(2000, 8)
    --         if finished ~= 100 then
    --             cb({
    --                 success = false,
    --                 stage = 4,
    --             })
    --         end
    --         --add key to system
    --         cb({
    --             success = true,
    --         })
    --     else
    --         TriggerEvent("DoShortHudText","Kendaraan ini tidak bisa di rampok.")
    --         cb({
    --             success = false,
    --             stage = 1,
    --         })
    --     end
    -- else
    --     TriggerEvent("DoShortHudText","Anda tidak di posisi pengemudi")
    --     cb({
    --         success = false,
    --         stage = 1,
    --     })
    -- end
end

exports("HotwireVehicle",HotwireVehicle)

function GetVehicleIdentifier(pVehicle)
    local plat = GetVehicleNumberPlateText(pVehicle)
    return plat
end

exports("GetVehicleIdentifier",GetVehicleIdentifier)

function HasVehicleKey(pVehicle)
    --print("HasVehicleKey",pVehicle,GetVehicleNumberPlateText(pVehicle))
    return true
end

exports("HasVehicleKey",HasVehicleKey)

function GetVehicleDegradation(pVehicle)
    --print("GetVehicleDegradation",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetVehicleDegradation",GetVehicleDegradation)

function GetVehicleFuel(pVehicle)
    --print("GetVehicleFuel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetVehicleFuel",GetVehicleFuel)

function CurrentFuel(pVehicle)
    print("CurrentFuel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("CurrentFuel",CurrentFuel)

function IsOnParkingSpot(pEntity, pEntity, pRadius)
    return false
end

exports("IsOnParkingSpot",IsOnParkingSpot)

function VehicleHasHarness(pVehicle)
    print("VehicleHasHarness",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("VehicleHasHarness",VehicleHasHarness)

function GetHarnessLevel(pVehicle)
    --print("GetHarnessLevel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetHarnessLevel",GetHarnessLevel)

function IsUsingNitro()
    return false
end

exports("IsUsingNitro",IsUsingNitro)

function VehicleHasNitro(pVehicle)
    print("VehicleHasNitro",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("VehicleHasNitro",VehicleHasNitro)

function GetNitroLevel(pVehicle)
   -- print("GetNitroLevel",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("GetNitroLevel",GetNitroLevel)

function GetVehicleMetadata(pVehicle, pKey)
   -- print("GetVehicleMetadata",pVehicle,pKey,GetVehicleNumberPlateText(pVehicle))
    return true
end

exports("GetVehicleMetadata",GetVehicleMetadata)

function TurnOnEngine(pVehicle, pInstant)
   -- print("TurnOnEngine",pVehicle,pInstant,GetVehicleNumberPlateText(pVehicle))
end

exports("TurnOnEngine",TurnOnEngine)

function TurnOffEngine(pVehicle, pInstant)
    --print("TurnOffEngine",pVehicle,pInstant,GetVehicleNumberPlateText(pVehicle))
end

exports("TurnOffEngine",TurnOffEngine)

function SwapVehicleSeat(pSeat, pVehicle)
   -- print("SwapVehicleSeat",pVehicle,pSeat,GetVehicleNumberPlateText(pVehicle))
end

exports("SwapVehicleSeat",SwapVehicleSeat)

function IsVinScratched(pVehicle)
   -- print("IsVinScratched",pVehicle,GetVehicleNumberPlateText(pVehicle))
end

exports("IsVinScratched",IsVinScratched)

RegisterNetEvent("keys:addNew")
AddEventHandler("keys:addNew", function(veh,plate)

end)