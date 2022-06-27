RegisterNetEvent("np-ui:openATM", function()
    local isNearATM = isNearATM()
    local stateId = exports['isPed']:isPed('cid')

    if isNearATM then
        financialAnimation(isNearATM, true)
        Citizen.Wait(1400)
        Wait(50)

        SetNuiFocus(true, true)

        SendNUIMessage({
            type = "open",
            character_id = stateId,
            account_id = nil,
            account_name = nil
        })
        -- exports["np-ui"]:openApplication("atm")
    end
end)

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(false, false)
end)

RegisterNUICallback("np-ui:getCash", function(data, cb)
    local LocalPlayer = exports["np-base"]:getModule("LocalPlayer")
    local Player = LocalPlayer:getCurrentCharacter()
    local cash = Player.cash
    cb(cash)
end)
