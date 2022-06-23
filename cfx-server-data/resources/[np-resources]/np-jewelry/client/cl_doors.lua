DOORS = {}
RegisterNetEvent("dark-jewelry:doors:client:getDoors")
AddEventHandler("dark-jewelry:doors:client:getDoors", function(pDoors)
    DOORS = pDoors
    for i = 1, #DOORS do
       AddDoorToSystem(DOORS[i].hash, DOORS[i].hash, DOORS[i].coords.x, DOORS[i].coords.y, DOORS[i].coords.z, false, true, false)
       Wait(100) 
       print(IsDoorRegisteredWithSystem(DOORS[i].hash))
       print("[JEWEL] [DEBUG] Door added to system", DOORS[i].hash, DOORS[i].hash, DOORS[i].coords)
    end
end)
RegisterNetEvent("dark-jewelry:doors:client:setState")
AddEventHandler("dark-jewelry:doors:client:setState", function(pState)
    if DOORS == {} or DOORS == "" or DOORS == nil then return end
    for i = 1, #DOORS do
        DOORS[i].state = pState
        DoorSystemSetDoorState(DOORS[i].hash, pState, false, true)
        print("[JEWEL] [DEBUG] Door state has been set to:", DOORS[i].hash, DOORS[i].state)
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent("dark-jewelry:doors:server:getDoors")
end)

RegisterNetEvent("dark-jewelry:doors:client:getDoors")
AddEventHandler("dark-jewelry:doors:client:getDoors", function(pDoors)
    DOORS = pDoors

    for i = 1, #DOORS do
       AddDoorToSystem(DOORS[i].hash, DOORS[i].hash, DOORS[i].coords.x, DOORS[i].coords.y, DOORS[i].coords.z, false, true, false)
       Wait(100) 
       TriggerServerEvent("dark-jewelry:doors:server:init")
    end
end)
