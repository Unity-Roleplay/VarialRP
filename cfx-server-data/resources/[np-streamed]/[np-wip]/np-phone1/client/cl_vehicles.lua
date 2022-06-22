--[[

    Functions

]]

function loadVehicle()
    local vehicles = RPC.execute("np-phone:getVehicles")

    local _vehicles = {}
    for i, v in ipairs(vehicles) do
        local coords = json.decode(v["coords"])

        local spawn = 0
        if coords and coords["x"] and #(vector3(coords["x"], coords["y"], coords["z"]) - GetEntityCoords(PlayerPedId())) < 20.0 and v["state"] == "Out" then
            spawn = 1
        end

        table.insert(_vehicles, {
            id = v["id"],
            name = GetLabelText(GetDisplayNameFromVehicleModel(v["model"])),
            plate = v["plate"],
            garage = v["garage"],
            state = v["state"],
            enginePercent = v["engine_damage"] / 10,
            bodyPercent = v["body_damage"] / 10,
            payments = v["payment_left"],
            lastPayment = v["payment_last"],
            amountDue = v["payment_price"],
            canSpawn = allowspawnattempt
        })
    end

    SendNUIMessage({
        openSection = "Garage",
        vehicleData = _vehicles,
    })
end

--[[

    NUI

]]

RegisterNUICallback("btnGarage", function()
    loadVehicle()
end)

RegisterNUICallback("vehtrack", function(data)
    local identifier = tonumber(data["id"])
    if not identifier then return end

    local coords = RPC.execute("np-phone:vehicleCoords", identifier)
    if not coords then return end

    SetNewWaypoint(coords["x"], coords["y"])
    phoneNotification("fas fa-car", "Vehicles", "Localização do veiculo marcada no GPS!", 3000)
end)

RegisterNUICallback("vehiclePay", function(data)
    local identifier = tonumber(data["id"])
    if not identifier then return end

    local update = RPC.execute("np-phone:payVehicle", identifier)
    if update then
        loadVehicle()
    end
end)

RegisterNUICallback("carshopOutstandings", function(data)
    local group = data["group"]
    if not group then return end

    local logs = RPC.execute("np-phone:carshopOutstandings", group)

    local list = {}
    for i, v in ipairs(logs) do
        if v["payment_last"] > 7 then
            table.insert(list, "<b>Veiculo -</b> " .. GetLabelText(GetDisplayNameFromVehicleModel(v["model"])) .. "<br><b>Plate -</b> " .. v["plate"] .. "<br><b>Owner -</b> " .. v["name"] .. "<br><b>Phone -</b> " .. v["phone"] .. "<br><b>Last Payment -</b> " .. v["payment_last"] .. "<br><b>Payment Price -</b> " .. v["payment_price"] .. "<br><b>Payments Left -</b> " .. v["payment_left"])
        end
    end

    phoneList(list)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local inVehicle = false

    while true do
        inVehicle = false

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                local identifier = exports["np-vehicles"]:GetVehicleIdentifier(vehicle)

                if identifier then
                    inVehicle = true
                    TriggerServerEvent("np-phone:vehicleCoords", identifier, GetEntityCoords(vehicle))
                end
            end
        end

        if inVehicle then
            Citizen.Wait(1000)
        else
            Citizen.Wait(3000)
        end
    end
end)