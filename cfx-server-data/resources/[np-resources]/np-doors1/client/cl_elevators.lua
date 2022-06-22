local Elevators = {}
local currentFloorId = nil
local currentElevator = nil

Citizen.CreateThread(function()
    Elevators = RPC.execute('np-doors:elevators:fetch')

    setSecuredAccesses(Elevators, 'elevator')

    for _, elevator in ipairs(Elevators) do
        local floors = elevator.floors

        for floorId, floor in ipairs(floors) do
            local zone = floor.zone

            if not zone.options.data then zone.options.data = {} end

            local data, lib = zone.options.data or {}, zone.target and 'np-polytarget' or 'np-polyzone'

            data.floorId = floorId
            data.elevatorId = elevator.id

            exports[lib]:AddBoxZone("np-doors:elevator", zone.center, zone.width, zone.length, zone.options)
        end
    end

    

    -- PolyZoneInteraction('np-doors:elevator:prompt', '[E] For Elevator', 38, function (data)
    --     if not data or not Elevators[data.elevatorId] then return end

    --     OpenElevatorMenu(data.elevatorId, data.floorId)
    -- end)

    exports['np-interact']:AddPeekEntryByPolyTarget('np-doors:elevator', {
        {
            id = "elevatorPrompt",
            event = "np-doors:elevator:prompt",
            icon = "fas fa-chevron-circle-up",
            label = "Elevator"
        }}, { distance = { radius = 1.5 } })
end)

AddEventHandler('np-doors:elevator:prompt', function(pParameters, pEntity, pContext)
    local data = pContext.zones and pContext.zones['np-doors:elevator']

    if not data or not Elevators[data.elevatorId] then return end

    OpenElevatorMenu(data.elevatorId, data.floorId)
end)

function OpenElevatorMenu(pElevator, pCurrentFloor)
    local elevator = Elevators[pElevator]

    if not elevator then return end

    currentElevator = elevator

    local elements, access, hasAccess = {}, {}, hasSecuredAccess(pElevator, 'elevator')

    for floorId, floor in ipairs(elevator.floors) do
        local isCurrentFloor = floorId == pCurrentFloor
        local isRestricted = floor.locked and not hasAccess

        local status = ''

        if isCurrentFloor then
            currentFloorId = floorId
            status = status .. ' | Current'
        end

        if isRestricted then
            status = status .. ' | Restricted'
        end

        elements[#elements+1] = {
            title = floor.name .. status,
            description = floor.description,
            action = (not isCurrentFloor and not isRestricted) and 'np-doors:elevator:teleport' or '',
            key = floor.teleport,
            disabled = isCurrentFloor or isRestricted
        }

        if hasAccess then
            access[#access+1] = {
                title = floor.name .. (floor.locked and ' | Restricted' or ' | Unrestricted'),
                action = 'np-doors:elevator:access',
                key = { elevatorId = pElevator, floorId = floorId, locked = floor.locked}
            }
        end
    end

    if hasAccess then
        elements[#elements+1] = {
            title = 'Access Control',
            children = access
        }
    end

    exports['np-ui']:showContextMenu(reverse(elements))
end

function TeleportPlayer(pCoords, pHeading, pOnArriveEvent)
    local heading = pHeading * 1.0
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local teleportCoords = vector3(pCoords.x, pCoords.y, pCoords.z)

    local time = math.floor((#(teleportCoords - playerCoords) / 50) * 100)
    local entity = IsPedInAnyVehicle(playerPed) and GetVehiclePedIsIn(playerPed) or playerPed

    DoScreenFadeOut(400)

    for floorId, floor in ipairs(currentElevator.floors) do
        if floorId == currentFloorId then
          if floor.teleport and floor.teleport.onLeaveEvent then
            TriggerEvent(floor.teleport.onLeaveEvent)
          end
        end
    end

    while IsScreenFadingOut() do
        Citizen.Wait(0)
    end

    NetworkFadeOutEntity(playerPed, true, true)

    SetPedCoordsKeepVehicle(playerPed, teleportCoords)

    SetEntityHeading(entity, heading)

    SetGameplayCamRelativeHeading(0.0)

    Citizen.Wait(time)

    if pOnArriveEvent then
      TriggerEvent(pOnArriveEvent)
    end

    NetworkFadeInEntity(playerPed, true)

    DoScreenFadeIn(400)
end

RegisterNetEvent('np-doors:elevators:updateState')
AddEventHandler('np-doors:elevators:updateState', function (pElevatorId, pFloorId, pRestricted, pForceUnlock)
    local elevator = Elevators[pElevatorId]

    if not elevator then return end

    elevator['forceUnlocked'] = pForceUnlock
    elevator['floors'][pFloorId]['locked'] = pRestricted
end)

RegisterUICallback('np-doors:elevator:teleport', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local taskActive, coords, heading, onArriveEvent = true, data.key.coords, data.key.heading, data.key.onArriveEvent

    Citizen.CreateThread(function ()
        local playerPed = PlayerPedId()
        local startingCoords = GetEntityCoords(playerPed)

        while taskActive do
            local playerCoords = GetEntityCoords(playerPed)

            if #(startingCoords - playerCoords) >= 1.6 or IsPedRagdoll(playerPed) or IsPedBeingStunned(playerPed) then
                exports['np-taskbar'].taskCancel()
            end

            Citizen.Wait(100)
        end
    end)

    local time = math.random(4000, 12000)
    local finished = exports["np-taskbar"]:taskBar(time, "Waiting for the Elevator", false)

    taskActive = false

    if finished ~= 100 then return end

    TeleportPlayer(coords, heading, onArriveEvent)
end)

RegisterUICallback('np-doors:elevator:access', function (data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })

    local elevatorId, floorId, locked = data.key.elevatorId, data.key.floorId, data.key.locked

    if not hasSecuredAccess(elevatorId, 'elevator') then return end

    TriggerServerEvent('np-doors:change-elevator-state', elevatorId, floorId, not locked)
end)
