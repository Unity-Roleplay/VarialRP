local PointingTask = {
    {
        0xD5BB4025AE449A4E, "__GetPlayerPed", "Pitch", "__Pitch"
    },
    {
        0xD5BB4025AE449A4E, "__GetPlayerPed", "Heading", "__Heading"
    },
    {
        0x2D537BA194896636, "__GetPlayerPed", "task_mp_pointing", 0.5, 0, "anim@mp_point", 24
    },
    { 
        0xD3BD40951412FEF6, "anim@mp_point" 
    },
    { 
        0xD031A9162D01088C, "anim@mp_point" 
    }
}

RegisterServerEvent("fetchPointingNatives")
AddEventHandler("fetchPointingNatives", function()
    local src = source 
    TriggerClientEvent("receivePointingNatives", src, PointingTask)
end)