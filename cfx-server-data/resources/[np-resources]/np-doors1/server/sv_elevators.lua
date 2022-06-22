RPC.register("np-doors:elevators:fetch",function()
    return ELEVATOR_CONFIG
end)

RegisterServerEvent("np-doors:change-elevator-state")
AddEventHandler("np-doors:change-elevator-state",function(elevatorId, floorId, locked)
    if ELEVATOR_CONFIG[elevatorId] then
        doors[pDoorId].locked = locked
        TriggerClientEvent("np-doors:elevators:updateState", -1, elevatorId,floorId,locked,doors[pDoorId].forceUnlocked)
    end
end)