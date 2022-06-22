local horseModel = "a_c_deer"
local horsehash = GetHashKey(horseModel)
local currentPed = nil

function goHorseMode()
    currentPed = exports["raid_clothes"]:GetCurrentPed()
    RequestModel(horseModel)
    while not HasModelLoaded(horseModel) do
        Wait(0)
    end
    SetPlayerModel(PlayerId(),horsehash)
end

function goNormalMode()
    exports["raid_clothes"]:LoadPed(currentPed)
end

function cloneMyPed()
    local ped = ClonePed(PlayerPedId())
    while not DoesEntityExist(ped) do
        Wait(0)
    end
    return ped
end

local inHorseMode = false
local ped = nil

RegisterCommand("veado",function()
    ped = cloneMyPed()
    goHorseMode()
    Wait(200)
    AttachEntityToEntity(ped,PlayerPedId(), 0, 0.4, 0.0, 0.3, 90.0, 180.0, 90.0, 0, 1, 0, 1, 0, 1)
    inHorseMode = true
    Citizen.CreateThread(function()
        while inHorseMode do
            SetEntityHeading(ped, GetEntityHeading(PlayerPedId()))
            Wait(0)
        end
    end)
    Citizen.CreateThread(function()
        local dict = "amb@code_human_on_bike_idles@quad@front@idle_a"
        local anim = "idle_d"
        while not HasAnimDictLoaded(dict) do
            RequestAnimDict(dict)
            Citizen.Wait(0)
        end
        while inHorseMode do
            if not IsEntityPlayingAnim(ped,dict,anim,3) then
                TaskPlayAnim(ped,dict,anim,1.0,0.0,4000,1,0.1,false,false,false)
            end
            Wait(500)
        end
    end)
end,false)

RegisterCommand("normal",function()
    goNormalMode()
end,false)

RegisterCommand("sairveado",function()
    DetachEntity(ped, 0, 0)
    DeleteEntity(ped)
    goNormalMode()
end,false)

function loadmodel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
end

--ch3_12_ff46 --ecra rua
