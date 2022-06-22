Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local get_ped = PlayerPedId()
        local get_ped_veh = GetVehiclePedIsIn(get_ped, false)

        if (IsPlayerFreeAiming(PlayerId())) then
            SendNUIMessage("xhairShow")
        elseif not (IsPlayerFreeAiming(PlayerId())) then
            SendNUIMessage("xhairHide")
        end
    end
end)