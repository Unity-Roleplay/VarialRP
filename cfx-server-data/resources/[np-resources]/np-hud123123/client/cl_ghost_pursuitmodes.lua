


-- ControlForPursuitMode = 172	

-- local defaultHash, defaultHash2, defaultHash3, defaultHash4, defaultHash5 = "npolchal","npolvette","npolstang","polchar","npolvic"

-- local pursuitEnabled = false

-- local InPursuitModeAPlus = false

-- local InPursuitModeB = false

--local QBCore = exports["qb-core"]:GetCoreObject() -- You don't really have to link your core, in this case I link it so I can notify every time player changes the class
local currentClass = "A"

function validVehicle(vehicleModel)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return true
        end
    end

    return false
end

-- CreateThread(function()
--     while true do 
--         Wait(1)
--         local curVeh = IsPedInAnyVehicle(PlayerPedId(), false)
--      --   GetVehiclePedIsIn(PlayerPedId(), false)
--         --if IsPedInAnyVehicle(PlayerPedId(), false) then
--        -- if GetVehiclePedIsUsing(PlayerPedId()) == true then 
--        if curveh == true then
--             SelectedPursuitMode = 1
--             SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
--         end
--     end
-- end)


function getHandlingConfig(vehicleModel, type)
    for k,v in pairs(Config.VehiclesConfig) do
        if Config.VehiclesConfig[k]["model"] == vehicleModel then
            return Config.VehiclesConfig[k][currentClass][type]
        end
    end
end

function changeClass()
    TriggerEvent('np:motherfucker')
    if currentClass == "A" then
        currentClass = "A+"
        print("Changed to A+ class")
        SelectedPursuitMode = 50
        SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
    elseif currentClass == "A+" then
        currentClass = "S+"
        SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId()), 0)
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, true) -- toggle xenon lights
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, true) -- upgrade turbo to max level
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 11, 2, false) -- upgrade engine to max level
        SetVehicleXenonLightsColor(GetVehiclePedIsIn(PlayerPedId()), 1) -- change xenon lights color
        print("Changed to S+ class")
        SelectedPursuitMode = 100
        SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
    elseif currentClass == "S+" then
        currentClass = "A"
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 22, false) -- toggle off xenon lights
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 18, false) -- toggle off turbo
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId()), 11, -1, false) -- change engine to lowest level
        print("Changed to A class")
        SelectedPursuitMode = 25
        SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
    end
end

RegisterCommand("carhash", function()
    print(GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), -1)))
end)

CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local plyVehicle = GetVehiclePedIsIn(plyPed)
            if validVehicle(GetEntityModel(plyVehicle)) and DoesEntityExist(plyVehicle) then
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                SendNUIMessage({action = "pursuitmode", pursuitmode = 25})
                if IsControlPressed(0, Config.KeyBind) then
                    changeClass()
                   -- QBCore.Functions.Notify("Changed class to " .. currentClass)
                    TriggerEvent("DoLongHudText", "Changed class to " .. currentClass)
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fDriveInertia", getHandlingConfig(GetEntityModel(plyVehicle), "fDriveInertia"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveMaxFlatVel", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveMaxFlatVel"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fBrakeForce", getHandlingConfig(GetEntityModel(plyVehicle), "fBrakeForce"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fSteeringLock", getHandlingConfig(GetEntityModel(plyVehicle), "fSteeringLock"))
                    SetVehicleHandlingFloat(plyVehicle, "CHandlingData", "fInitialDriveForce", getHandlingConfig(GetEntityModel(plyVehicle), "fInitialDriveForce"))
                end
            end
        else
            currentClass = "A"
        end
        Wait(1000)
    end
end)

RegisterNetEvent("vehicleMod:nos100") 
AddEventHandler("vehicleMod:nos100",function()
    SelectedPursuitMode = 100
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos95") 
AddEventHandler("vehicleMod:nos95",function()
    SelectedPursuitMode = 95
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)


RegisterNetEvent("vehicleMod:nos90") 
AddEventHandler("vehicleMod:nos90",function()
    SelectedPursuitMode = 90
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos85") 
AddEventHandler("vehicleMod:nos85",function()
    SelectedPursuitMode = 85
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos80") 
AddEventHandler("vehicleMod:nos80",function()
    SelectedPursuitMode = 80
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos75") 
AddEventHandler("vehicleMod:nos75",function()
    SelectedPursuitMode = 75
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos70") 
AddEventHandler("vehicleMod:nos70",function()
    SelectedPursuitMode = 70
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos65") 
AddEventHandler("vehicleMod:nos65",function()
    SelectedPursuitMode = 65
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos60") 
AddEventHandler("vehicleMod:nos60",function()
    SelectedPursuitMode = 60
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos55") 
AddEventHandler("vehicleMod:nos55",function()
    SelectedPursuitMode = 55
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos50") 
AddEventHandler("vehicleMod:nos50",function()
    SelectedPursuitMode = 50
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos45") 
AddEventHandler("vehicleMod:nos45",function()
    SelectedPursuitMode = 45
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos40") 
AddEventHandler("vehicleMod:nos40",function()
    SelectedPursuitMode = 40
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos35") 
AddEventHandler("vehicleMod:nos35",function()
    SelectedPursuitMode = 35
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos30") 
AddEventHandler("vehicleMod:nos30",function()
    SelectedPursuitMode = 30
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos25") 
AddEventHandler("vehicleMod:nos25",function()
    SelectedPursuitMode = 25
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos20") 
AddEventHandler("vehicleMod:nos20",function()
    SelectedPursuitMode = 20
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos15") 
AddEventHandler("vehicleMod:nos15",function()
    SelectedPursuitMode = 15
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos10") 
AddEventHandler("vehicleMod:nos10",function()
    SelectedPursuitMode = 10
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)

RegisterNetEvent("vehicleMod:nos5") 
AddEventHandler("vehicleMod:nos5",function()
    SelectedPursuitMode = 5
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
end)


RegisterNetEvent("vehicleMod:nosoff") 
AddEventHandler("vehicleMod:nosoff",function()
    SelectedPursuitMode = 0
    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
	TriggerEvent("vehicleMod:endnos")
end)