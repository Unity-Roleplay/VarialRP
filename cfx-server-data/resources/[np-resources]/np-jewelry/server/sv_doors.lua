DOOR_STATES = {
    [1] = {hash = 1425919976, coords = vector3(-631.95538330078, -236.33326721191, 38.206531524658), state = 0},
    [2] = {hash = 9467943, coords = vector3(-630.42651367188, -238.43754577637, 38.206531524658), state = 0}
}

RegisterNetEvent("dark-jewelry:doors:client:setState")
AddEventHandler("dark-jewelry:doors:client:setState", function(pState)
    for i = 1, #DOOR_STATES do
        DOOR_STATES[i].state = pState
    end
    TriggerClientEvent("dark-jewelry:doors:client:setState", -1, pState)
end)

RegisterNetEvent("dark-jewelry:doors:server:getDoors")
AddEventHandler("dark-jewelry:doors:server:getDoors", function()
    TriggerClientEvent("dark-jewelry:doors:client:getDoors", -1, DOOR_STATES)
end)

INITIALIZED = false

RegisterNetEvent("dark-jewelry:doors:server:init")
AddEventHandler("dark-jewelry:doors:server:init", function()
    if INITIALIZED == true then return end
    INITIALIZED = true
    TriggerClientEvent("dark-jewelry:doors:client:setState", -1, 1)
end)