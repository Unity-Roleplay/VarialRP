local Ack, Temp, IsSpeeding, InVehicle = {}, {}, false, false

function RayCast(origin, target, options, ignoreEntity, radius)
    local handle = StartShapeTestSweptSphere(origin.x, origin.y, origin.z, target.x, target.y, target.z, radius, options, ignoreEntity, 0)
    return GetShapeTestResult(handle)
end

function GetEntityInFrontOfEntity(pEntity, pDistance, pRadius, pFlag)
    local forwardVector = GetEntityForwardVector(pEntity)
    local originCoords = GetEntityCoords(pEntity)
    local targetCoords = originCoords + (forwardVector * pDistance)

    local _, hit, _, _, targetEntity = RayCast(originCoords, targetCoords, pFlag, pEntity, pRadius)

    return targetEntity
end

function GetEntityInSpaceOfEntity(pEntity, pRadius, pFlag)
    local entityCoords = GetEntityCoords(pEntity)

    local _, hit, _, _, targetEntity = RayCast(entityCoords, entityCoords + 0.1, pFlag , pEntity, pRadius)

    return targetEntity
end

AddEventHandler('baseevents:vehicleSpeeding', function (isSpeeding)
    IsSpeeding = isSpeeding

    if not isSpeeding then return end

    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed)
        local dimensions = GetModelDimensions(GetEntityModel(vehicle))
        local size = math.abs(dimensions.y) + 0.5

        while IsSpeeding do
            local entityInFront = GetEntityInFrontOfEntity(vehicle, 5.0, 1.2, 2)
            local entityInSpace = GetEntityInSpaceOfEntity(vehicle, size, 2)

            if not Ack[entityInFront] then
                SetEntityNoCollisionEntity(vehicle, entityInFront, 1)
                SetEntityLocallyInvisible(entityInFront)
            end

            if not Ack[entityInSpace] then
                SetEntityNoCollisionEntity(vehicle, entityInSpace, 1)
                SetEntityLocallyInvisible(entityInSpace)
            end

            Citizen.Wait(0)
        end
    end)

    Citizen.Wait(4000)
end)

AddEventHandler('baseevents:enteredVehicle', function (isSpeeding)
    Ack, Temp = {}, {}

    InVehicle = true

    Citizen.CreateThread(function()
        while InVehicle do
            local idle = 1000

            local vehicles = GetGamePool('CVehicle')

            for _, vehicle in ipairs(vehicles) do
                if not Ack[vehicle] and not Temp[vehicle] then
                    Temp[vehicle] = 1
                elseif not Ack[vehicle] and Temp[vehicle] then
                    Temp[vehicle] = Temp[vehicle] + 1

                    if Temp[vehicle] >= 3 then
                        Ack[vehicle] = true
                        Temp[vehicle] = nil
                    end
                end
            end

            Citizen.Wait(idle)
        end
    end)
end)

AddEventHandler('baseevents:leftVehicle', function ()
    InVehicle = false
end)
