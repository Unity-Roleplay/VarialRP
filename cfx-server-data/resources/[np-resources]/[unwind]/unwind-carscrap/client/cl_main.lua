local OnAMission = false
local CanTarget = false
local WayPointSet = false
local BlipHangarSet = false

local ScrapLocationsVin = {
    {1979.32, 5172.81, 47.64},

}

local ScrappingLocations = {
    {1564.38, -2164.58, 77.53},
    {2351.64, 3134.44, 48.21},
    {-556.01, -1696.41, 19.18},
    {431.09, 6467.33, 28.77},
}

local VehicleSpawnCoords = {
    [1] = {x = -1132.395, y = -1070.607, z = 1.64372, h = 120.00},
    [2] = {x = -935.1176, y = -1080.552, z = 1.683342, h = 120.1060},
    [3] = {x = -1074.953,y = -1160.545,z = 1.661577, h = 119.0},
    [4] = {x = -1023.625,y = -890.4014,z = 5.202, h = 216.0399},
    [5] = {x = -1609.647,y = -382.792,z = 42.70383, h = 52.535},
    [6] = {x = -1527.88,y = -309.8757,z = 47.88678, h= 323.43},
    [7] = {x = -1658.969,y = -205.1732,z = 54.8448,h = 71.138},
    [8] = {x = 97.57888,y = -1946.472,z = 20.27978,h = 215.933},
    [9] = {x = -61.59007,y = -1844.621,z = 26.1685,h = 138.9848},
    [10] = {x = 28.51439,y = -1734.881,z = 28.5415,h = 231.968},
    [11] = {x = 437.5428,y = -1925.465,z = 24.004,h = 28.82286},
    [12] = {x = 406.5316,y = -1920.471,z = 24.51589,h = 224.6432},
    [13] = {x = 438.4482,y = -1838.672,z = 27.47369,h = 42.8129   },
    [14] = {x = 187.353,y = -1542.984,z = 28.72487,h = 39.00627},
    [15] = {x = 1153.467,y = -330.2682,z = 68.60548,h = 7.20},
    [16] = {x = 1144.622,y = -465.7694,z = 66.20689,h = 76.612770},
    [17] = {x = 1295.844,y = -567.6,z = 70.77858,h = 166.552},
    [18] = {x = 1319.566,y = -575.9492,z = 72.58221,h = 155.9249},
    [19] = {x = 1379.466,y = -596.0999,z = 73.89736,h = 230.594},
    [20] = {x = 1256.648,y = -624.0594,z = 68.93141,h = 117.415},
    [21] = {x = 1368.127,y = -748.2613,z = 66.62316,h = 231.535},
    [22] = {x = 981.7167,y = -709.7389,z = 57.18427,h = 128.729},
    [23] = {x = 958.206,y = -662.7545,z = 57.57119,h = 116.9299},
    [24] = {x = -2012.404,y = 484.0458,z = 106.5597,h = 78.13},
    [25] = {x = -2001.294,y = 454.7647,z = 102.0194,h = 108.1178},
    [26] = {x = -1994.725,y = 377.4933,z = 94.04324,h = 89.64067},
    [27] = {x = -1967.549,y = 262.1507,z = 86.23506,h = 109.1846},
    [28] = {x = -989.6796,y = 418.4977,z = 74.731,h = 20.262},
    [29] = {x = -979.6517,y = 518.119,z = 81.03075,h = 328.386},
    [30] = {x = -1040.915,y = 496.5622,z = 82.52803,h = 54.439},
    [31] = {x = -1094.621,y = 439.2605,z = 74.84596,h = 84.936},
    [32] = {x = -1236.895,y = 487.9722,z = 92.82943,h = 330.6634},
    [33] = {x = -1209.098,y = 557.9588,z = 99.04235,h = 3.2526},
    [34] = {x = -1155.296,y = 565.4297,z = 101.3919,h = 7.4106},
    [35] = {x = -1105.378,y = 551.5797,z = 102.1759,h = 211.7110},
    [36] = {x = 1708.02,y = 3775.486,z = 34.08183,h = 35.04580},
    [37] = {x = 2113.365,y = 4770.113,z = 40.72895,h = 297.5323},
    [38] = {x = 2865.448,y = 1512.715,z = 24.12726,h = 252.3262},
    [39] = {x = 1413.973,y = 1119.024,z = 114.3981,h = 305.99868},
    [40] = {x = -78.39651,y = 497.4749,z = 143.9646,h = 160.2948},
    [41] = {x = -248.9841,y = 492.9105,z = 125.0711,h = 208.5761},
    [42] = {x = 14.09792,y = 548.8402,z = 175.7571,h = 241.4019775},
    [43] = {x = 51.48445,y = 562.2509,z = 179.8492,h = 203.159},
    [44] = {x = -319.3912,y = 478.9731,z = 111.7186,h = 298.7645},
    [45] = {x = -202.0035,y = 410.2064,z = 110.0086,h = 195.6136},
    [46] = {x = -187.1009, y = 379.9514, z = 108.0138, h = 176.9462},
    [47] = {x = 213.5159, y = 389.3123, z = 106.4154, h = 348.890255},
    [48] = {x = 323.7256, y = 343.3308, z = 104.761, h = 345.49426},
    [49] = {x = 701.1197, y = 254.4424, z = 92.85217, h = 240.62884},
    [50] = {x = 656.4758, y = 184.8482, z = 94.53828, h = 248.9376},
    [51] = {x = 615.5524, y = 161.4801, z = 96.91451, h = 69.2577},
    [52] = {x = 899.2693, y = -41.99047, z = 78.32366, h = 28.13086},
    [53] = {x = 873.3314, y = 9.008331, z = 78.32432, h = 329.343},
    [54] = {x = 941.2477, y = -248.0161, z = 68.15629, h = 328.122},
    [55] = {x = 842.7501, y = -191.9954, z = 72.1975, h = 329.2124},
    [56] = {x = 534.3583, y = -26.7027, z = 70.18916, h = 30.70978},
    [57] = {x = 302.5077, y = -176.5727, z = 56.95071, h = 249.3339},
    [58] = {x = 85.26346, y = -214.7179, z = 54.05132, h = 160.2142},
    [59] = {x = 78.38569, y = -198.4182, z = 55.79539, h = 70.1377},
    [60] = {x = -30.09893, y = -89.37914, z = 56.8136, h = 340.32879},
    [61] = {x = -44.49, y = -1840.32, z = 25.6, h = 319.63},
    [62] = {x = -249.98, y = 289.2, z = 91.21, h = 270.42},
    [63] = {x = -1025.03, y = -1511.77, z = 4.99, h = 33.83},
    [64] = {x = 1141.52, y = -409.9, z = 66.54, h = 229.15},
    [65] = {x = 571.99, y = -2726.88, z = 5.45, h = 181.17},
    [66] = {x = 1423.64, y = 3625.77, z = 34.24, h = 18.8},
    [67] = {x = 1690.79, y = 4782.16, z = 41.32, h = 89.78},
    [68] = {x = -24.0, y = 6440.13, z = 30.8, h = 225.07},
    [69] = {x = 1579.97, y = 6449.37, z = 24.43, h = 333.17},
    [70] = {x = 624.34, y = 2724.23, z = 41.21, h = 183.38},
    [71] = {x = -1920.59, y = 2048.72, z = 140.13, h = 77.69},
    [72] = {x = -3133.4, y = 1130.7, z = 20.08, h = 338.02},
    [73] = {x = 3554.21, y = 3781.53, z = 29.32, h = 171.21},
    [74] = {x = -2336.38, y = 271.16, z = 168.86, h = 203.96},
    [75] = {x = 116.94, y = -1233.02, z = 28.69, h = 272.56},
}


local Vehicles = {

    ---------- S CLASS --------------
    {"t20"},
    {"Zion2"},
    {"Felon"},
    {"Zentorno"},
    -- ---------- A CLASS --------------
    {"Oracle2"},
    {"Windsor2"},
    {"SabreGT2"},
    {"Sentinel2"},
    {"Zion"},
    {"Phoenix"},
    {"Washington"},
    {"Banshee2"},
    {"Infernus2"},
    {"Nero"},
    {"Nero2"},
    {"Brawler"},
    ---------- B CLASS --------------
    {"Prairie"},
    {"Chino"},
    {"Dukes"},
    {"Virgo3"},
    {"Tampa"},
    {"Blade"},
    {"Nightshade"},
    {"Primo"},
    {"Primo2"},
    {"Regina"},
    {"ZType"},
    {"Bison3"},
    {"Bison"},
    {"blista"},
    {"blista2"},
    {"Issi2"},
    {"Issi2"},
    {"Buccaneer2"},
    {"Picador"},
    ---------- C CLASS --------------
    {"Emperor2"},
    {"Tornado3"},
    {"BType"},
    {"Sadler"},
    {"Bison2"},
    {"Minivan2"},
    {"RatLoader"},
    {"Virgo2"},
    ---------- D CLASS --------------
    {"Dilettante"},
    ---------- M CLASS --------------
    {"manchez"},
}




function IsNearScrapLocationVin()
    local location = {}
    local hasFound = false
    local pos = GetEntityCoords(PlayerPedId(), false)
    for k,v in ipairs(ScrapLocationsVin) do
        if(Vdist(v[1], v[2], v[3], pos.x, pos.y, pos.z) < 10.0)then
            hasFound = true
        end
    end


    if hasFound then 
        return true 
    end
    return false
end

function IsNearScrapingLocationNormal()
    local location = {}
    local hasFound = false
    local pos = GetEntityCoords(PlayerPedId(), false)
    for k,v in ipairs(ScrappingLocations) do
        if(Vdist(v[1], v[2], v[3], pos.x, pos.y, pos.z) < 10.0)then
            hasFound = true
        end
    end


    if hasFound and OnAMission and CanTarget then 
        return true 
    end
    return false
end


exports('InNormalScrapLocation', IsNearScrapingLocationNormal)
exports('InScrapLocation', IsNearScrapLocationVin)


function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle
    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset,
            10, PlayerPedId(), 0)
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)

        offset = offset - 1

        if vehicle ~= 0 then
            break
        end
    end
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    if distance > 25 then
        vehicle = nil
    end
    return vehicle ~= nil and vehicle or 0
end

-----------------------------------------------------------------------------
RegisterNetEvent("unwind-carscrap:ScrapVehicle")
AddEventHandler("unwind-carscrap:ScrapVehicle", function()
    if exports["np-inventory"]:hasEnoughOfItem("scraptoolset",1,false) then
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)    
        local targetVehicle = getVehicleInDirection(coordA, coordB)
        local licensePlate = GetVehicleNumberPlateText(targetVehicle)
        if licensePlate ~= nil then
            local isVehicleScraptched = RPC.execute("unwind-carscrap:GetVehicleScrapState", licensePlate)
            if isVehicleScraptched then
                TriggerEvent("unwind-carscrap:StartScrappingVin")
            else
                TriggerEvent("DoLongHudText", "You can only scrap scrathced vehicles!",2)
            end

        else
            TriggerEvent("DoLongHudText", "You have to look at the vehicle to scrap it!",2)
        end
    else
        TriggerEvent("DoLongHudText", "Missing scrapping tool!",2)
    end
end)

RegisterNetEvent("unwind-carscrap:StartScrappingVin")
AddEventHandler("unwind-carscrap:StartScrappingVin", function()
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)    
    local targetVehicle = getVehicleInDirection(coordA, coordB)
    local licensePlate = GetVehicleNumberPlateText(targetVehicle)
    FreezeEntityPosition(playerped, true)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true)
    local finished = exports["np-taskbar"]:taskBar(20000,"Scrapping Car")
  	if finished == 100 then	
        SetEntityAsMissionEntity(targetVehicle, true, true)
        DeleteVehicle(targetVehicle)
        TriggerEvent("player:receiveItem", "recyclablematerial", math.random(50,80))
        FreezeEntityPosition(playerped, false)
        ClearPedTasksImmediately(playerped)
        TriggerServerEvent("unwind-carscrap:DeleteScrappedVehVin",licensePlate)
    else
        FreezeEntityPosition(playerped, false)
        ClearPedTasksImmediately(playerped)
    end
end)

-----------------------------------------------------------------------------
local ActiveChopping = {}

local VehicleChopBones = {
    {name = "wheel_lf", index = 0, type = "tyre"},
    {name = "wheel_rf", index = 1, type = "tyre"},
    {name = "wheel_lm", index = 2, type = "tyre"},
    {name = "wheel_rm", index = 3, type = "tyre"},
    {name = "wheel_lr", index = 4, type = "tyre"},
    {name = "wheel_rr", index = 5, type = "tyre"},
    {name = "wheel_lm1", index = 2, type = "tyre"},
    {name = "wheel_rm1", index = 3, type = "tyre"},
    {name = "door_dside_f", index = 0, type = "door"},
    {name = "door_pside_f", index = 1, type = "door"},
    {name = "door_dside_r", index = 2, type = "door"},
    {name = "door_pside_r", index = 3, type = "door"},
    {name = "bonnet", index = 4, type = "door"},
    {name = "boot", index = 5, type = "door"},
}

function CreateVeh(model , coord)
    local ModelHash = tostring(model)
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Citizen.Wait(10)
    end
    Vehicle = CreateVehicle(ModelHash, coord.x, coord.y , coord.z, 0.0, true, false)
    print(ModelHash)
    print(coord.x, coord.y , coord.z)
    SetModelAsNoLongerNeeded(ModelHash) 
    SetVehicleEngineOn(Vehicle, false, false)
    SetEntityHeading(Vehicle, coord.h)
    blip = AddBlipForCoord(coord.x, coord.y , coord.z)
    SetBlipSprite(blip, 57)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.7)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vehicle To Scrap")
    EndTextCommandSetBlipName(blip)
    SetNewWaypoint(coord.x, coord.y)
end


RegisterNetEvent("unwind-carscrap:StarRegularMission")
AddEventHandler("unwind-carscrap:StarRegularMission", function()
    if not OnAMission then
        if exports["np-inventory"]:hasEnoughOfItem("vpnxj",1,false) then
            TriggerEvent("unwind-carscrap:FirstEmail")
            local Data1 = Vehicles[math.random(#Vehicles)]
            local Data2 = VehicleSpawnCoords[math.random(#VehicleSpawnCoords)]
            for k,v in pairs(Data1) do
                VehicleModel = v
            end
            CreateVeh(VehicleModel, Data2)
            OnAMission = true
            BlipHangarSet = false
        else
            TriggerEvent("DoLongHudText", "You have no business with me!",2)
        end
    else
        TriggerEvent("DoLongHudText", "You can only start 1 mission at a time!",2)
    end
end)

RegisterNetEvent("unwind-carscrap:StartCarScrappingProcess")
AddEventHandler("unwind-carscrap:StartCarScrappingProcess", function()
    local vehicle = exports['np-target']:GetCurrentEntity()

    if not vehicle then return end

    InteractiveChopping(vehicle)
    CanTarget = false
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        while OnAMission do
            Wait(1000)
            if not WayPointSet then
                local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
                if(veh ~= 0) then
                    local PlayerPed = PlayerPedId()
                    local CuurPlate = GetVehicleNumberPlateText(veh)
                    local MissionPlate = GetVehicleNumberPlateText(Vehicle)
                    if CuurPlate == MissionPlate then
                        local PedVehicle = GetVehiclePedIsIn(PlayerPed)
                        local Driver = GetPedInVehicleSeat(PedVehicle, -1)
                        if Driver == PlayerPed then
                            if DoesBlipExist(blip) then
                                RemoveBlip(blip)
                            end
                            Wait(1000)
                            if not BlipHangarSet then
                                local ScrapHangar = ScrappingLocations[math.random(#ScrappingLocations)]
                                blip = AddBlipForCoord(ScrapHangar[1], ScrapHangar[2], ScrapHangar[3])
                                SetBlipSprite(blip, 57)
                                SetBlipColour(blip, 3)
                                SetBlipScale(blip, 0.7)
                                SetBlipAsShortRange(blip, false)
                                BeginTextCommandSetBlipName("STRING")
                                AddTextComponentString("Scrap Hangar")
                                EndTextCommandSetBlipName(blip)
                                SetNewWaypoint(ScrapHangar[1], ScrapHangar[2])
                                TriggerEvent("unwind-carscrap:SecondEmail")
                                BlipHangarSet = true
                                CanTarget = true
                                WayPointSet = true
                            end
                        end
                    end
                end
            end
        end
    end
end)



function AnimationTask(entity, coordsType, coordsOrigin, coordsDist, animationType, animDict, animName, animFlag)
    local self = {}

    self.active = true

    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local playerCoords, coords = GetEntityCoords(playerPed)

        if animationType == "scenario" then
            TaskStartScenarioInPlace(playerPed, animDict, 0, true)
        elseif animationType == "normal" then
            LoadAnimationDic(animDict)
        end

        while self.active do
            local idle = 100

            playerCoords = GetEntityCoords(playerPed)

            if coordsType == "bone" then
                coords = GetWorldPositionOfEntityBone(entity, coordsOrigin)
            else
                coords = GetEntityCoords(entity)
            end

            if animationType == "normal" and not IsEntityPlayingAnim(playerPed, animDict, animName, 3) then
                TaskPlayAnim(playerPed, animDict, animName, -8.0, -8.0, -1, animFlag, 0, 0, 0, 0)
            end

            if #(coords - playerCoords) > coordsDist then
                self.abort()
            end

            Citizen.Wait(idle)
        end

        if animationType == "scenario" then
            ClearPedTasks(playerPed)
        else
            StopAnimTask(playerPed, animDict, animName, 1.5)
        end
    end)

    self.abort = function()
        self.active = false
    end

    return self
end

function GetValidBones(entity, list)
    local bones = {}

    for _, bone in ipairs(list) do
        local boneID = GetEntityBoneIndexByName(entity, bone.name)

        if boneID ~= -1 then
            if bone.type == "door" and not IsVehicleDoorDamaged(entity, bone.index) or bone.type == "tyre" and not IsVehicleTyreBurst(entity, bone.index, 1) then
                bone.id = boneID
                bones[#bones + 1] = bone
            end

        end
    end

    return bones
end

function GetClosestBone(entity, list)
    local playerCoords, bone, coords, distance = GetEntityCoords(PlayerPedId())

    for _, element in pairs(list) do
        local boneCoords = GetWorldPositionOfEntityBone(entity, element.id or element)
        local boneDistance = GetDistanceBetweenCoords(playerCoords, boneCoords, true)

        if not coords then
            bone, coords, distance = element, boneCoords, boneDistance
        elseif distance > boneDistance then
            bone, coords, distance = element, boneCoords, boneDistance
        end
    end

    if not bone then
        bone = {id = GetEntityBoneIndexByName(entity, "bodyshell"), type = "remains", name = "bodyshell"}
        coords = GetWorldPositionOfEntityBone(entity, bone.id)
        distance = #(coords - playerCoords)
    end

    return bone, coords, distance
end

function ChopVehicleTyre(vehicle, boneID, tyreIndex)
    if IsVehicleTyreBurst(vehicle, tyreIndex, 1) then return end

    local task = AnimationTask(vehicle, "bone", boneID, 1.2, "normal", "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1)

    local finished = exports["np-taskbar"]:taskBar(10000,"Scrapping Car")

    local success = finished == 100 and task.active == true

    task.abort()

    if success then
        SetVehicleTyreBurst(vehicle, tyreIndex, true, 1000.0)
    end

    return success
end

function ChopVehicleDoor(vehicle, boneID, doorIndex)
    if IsVehicleDoorDamaged(vehicle, doorIndex) then return end

    SetVehicleDoorOpen(vehicle, doorIndex, 0, 1)

    local task = AnimationTask(vehicle, "bone", boneID, 1.6, "scenario", "WORLD_HUMAN_WELDING")

    local finished = exports["np-taskbar"]:taskBar(14000,"Scrapping Car")

    local success = finished == 100 and task.active == true

    task.abort()

    if success then
        SetVehicleDoorBroken(vehicle, doorIndex, 1)
    end

    return success
end

function ChopVehicleRemains(vehicle, boneID)
    local task = AnimationTask(vehicle, "bone", boneID, 1.8, "normal", "mp_car_bomb", "car_bomb_mechanic", 17)

    local finished = exports["np-taskbar"]:taskBar(25000,"Scrapping Car")

    local success = finished == 100 and task.active == true

    task.abort()

    if finished then
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)    
        local targetVehicle = getVehicleInDirection(coordA, coordB)
        local licensePlate = GetVehicleNumberPlateText(targetVehicle)
        SetEntityAsMissionEntity(targetVehicle, true, true)
        DeleteVehicle(targetVehicle)
        OnAMission = false
    end

    return success
end

function ChopVehiclePart(vehicle)
    if not DoesEntityExist(vehicle) then return end

    local vehicleModel = GetEntityModel(vehicle)

    local boneList = GetValidBones(vehicle, VehicleChopBones)

    local bone, coords, distance = GetClosestBone(vehicle, boneList)

    local success = false

    PedFaceCoord(PlayerPedId(), coords)

    if bone.type == "tyre" and distance < 1.2 then
        success = ChopVehicleTyre(vehicle, bone.id, bone.index)
    elseif bone.type == "door" and distance < 1.6 then
        success = ChopVehicleDoor(vehicle, bone.id, bone.index)
    elseif bone.type == "remains" and distance < 1.8 then
        success = ChopVehicleRemains(vehicle)
    end

    return success, bone.type, vehicleModel
end

function InteractiveChopping(vehicle)
    if ActiveChopping[vehicle] then return end

    local state = { active = true }
    local netId = NetworkGetNetworkIdFromEntity(vehicle)

    ActiveChopping[vehicle] = state

    local boneList = GetValidBones(vehicle, VehicleChopBones)

    Citizen.CreateThread(function()
        while state.active do
            boneList = GetValidBones(vehicle, VehicleChopBones)

            Citizen.Wait(100)
        end
    end)

    Citizen.CreateThread(function()
        while state.active do
            local idle = 500

            local bone, coords, distance = GetClosestBone(vehicle, boneList)

            if not IsInsideVehicle and distance and distance <= 10.0 then
                local inDistance, chopText

                if bone.type == "door" and distance <= 1.6 then
                    local rawText = "Press ~w~~g~[E]~w~ to Chop Vehicle Door"
                    inDistance, chopText = true, rawText
                elseif bone.type == "tyre" and distance <= 1.6 then
                    local rawText = "Press ~w~~g~[E]~w~ to Chop Vehicle Tyre"
                    inDistance, chopText = true, rawText
                elseif bone.type == "remains" and distance <= 1.8 then
                    local rawText = "Press ~w~~g~[E]~w~ to Chop Vehicle Remains"
                    inDistance, chopText = true, rawText
                end

                if inDistance then
                    Draw3DText(coords.x, coords.y, coords.z, chopText)

                    if IsControlJustReleased(0, 38) then
                        local success, boneType, vehicleModel = ChopVehiclePart(vehicle)

                        if success then
                            if boneType == "remains" then
                                if DoesBlipExist(blip) then
                                    RemoveBlip(blip)
                                end
                                OnAMission = false
                                WayPointSet = false
                                BlipHangarSet= false
                                TriggerEvent("unwind-carscrap:ThirdEmail")
                            end
                            TriggerServerEvent("unwind-carscrap:ScrappingRewardPls",boneType)
                        end
                    end
                end

                idle = 0
            end

            if not distance or distance > 10.0 then
                state.active = false
                CanTarget = true
            end

            Citizen.Wait(idle)
        end

        ActiveChopping[vehicle] = nil
    end)
end