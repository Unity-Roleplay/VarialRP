local fishes = nil
local fishingRod = nil
local jobCallback = nil
local validFishes = {}

local buffStartTime = 0
local buffItems = {
  ["sushiplate"] = true,
  ["sushiplatec"] = true,
}
AddEventHandler("buffs:triggerBuff", function(item)
  if not buffItems[item] then return end
  if buffStartTime ~= 0 then return end
  buffStartTime = GetGameTimer()
  Citizen.CreateThread(function()
    Citizen.Wait(60000 * 60) -- 1hr
    buffStartTime = 0
  end)
end)

local function createFishes()
    fishes = RPC.execute("fishing:getAvailableFishes")
    for _, fish in pairs(fishes) do
        validFishes[fish.itemName] = true
    end
end

Citizen.CreateThread(function()
    createFishes()
end)

local blip = nil
local fishingLocation = nil

AddEventHandler("fishing:justincase", function()
    if fishingLocation == nil then
        local location = RPC.execute("fishing:getActiveLocation")
        fishingLocation = location
    end

end)


AddEventHandler("fishing:addFishingBlip", function()
    if blip ~= nil then
        RemoveBlip(blip)
    end
    if fishingLocation == nil then
        local location = RPC.execute("fishing:getActiveLocation")
        fishingLocation = location
    end
    blip = AddBlipForCoord(fishingLocation.coords)
    SetBlipSprite(blip, 304)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Fishing")
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent("np-fishing:updateLocation")
AddEventHandler("np-fishing:updateLocation", function(location)
    fishingLocation = location
end)

Citizen.CreateThread(function()
    Citizen.Wait(60000)
    local location = RPC.execute("fishing:getActiveLocation")
    fishingLocation = location
end)

-- wave stuff
local baseWave = 1.2
local bwMod = 0.075
local bwMulti = 0
local function modi()
    bwMulti = bwMulti + 1
    return baseWave + (bwMod * bwMulti) * 1.0
end
local waveHeights = {
    ["EXTRASUNNY"] = baseWave,
    ["CLEAR"] = modi(),
    ["CLEARING"] = modi(),
    ["CLOUDS"] = modi(),
    ["OVERCAST"] = modi(),
    ["FOGGY"] = modi(),
    ["SMOG"] = modi(),
    ["RAIN"] = modi(),
    ["THUNDER"] = modi(),
}
local currentWeather = "CLEAR"
RegisterNetEvent("nns_weather:weatherHasChanged")
AddEventHandler("nns_weather:weatherHasChanged", function(weatherProg)
    currentWeather = weatherProg.weathers[1]
end)
-- Citizen.CreateThread(function()
--     while true do
--         local waveH = waveHeights[currentWeather]
--         ResetDeepOceanScaler()
--         SetDeepOceanScaler(waveH)
--         Citizen.Wait(15000)
--     end
-- end)
--

local function isValidFish(fish)
    return validFishes[fish] ~= nil
end

local function loopSkill(count)
    local loopCount = 0
    while loopCount < count do
        loopCount = loopCount + 1
        local finished = exports["np-ui"]:taskBarSkill(math.random(2000, 8000), math.random(7, 12))
        if finished ~= 100 then
            return false
        end
        Wait(100)
    end
    TriggerEvent("client:newStress", false, 250)
    return true
end

local function reelInFish()
    TriggerEvent("DoLongHudText", "A little nibble...", 1)
    local fishChance = math.random(10)
    print("!", fishChance)
    if buffStartTime ~= 0 and math.random() < 0.2 then
        fishChance = math.random(97, 99) / 100
    end
    local found = false
    for _, fish in pairs(fishes) do
        if not found and fish.chance > fishChance then
            found = true

            local success = loopSkill(fish.skill)
            if success then
                TriggerEvent("DoLongHudText", "You caught a " .. fish.name, 1)
                TriggerEvent("player:receiveItem", fish.itemName, 1)
                TriggerServerEvent("np-gallery:generateGem", "fishing")

                if jobCallback ~= nil then
                    local oData = jobCallback('getObjectiveData', 'collect_twenty_fishes')
                    local jobCount = oData.data.count
                    if jobCount < 30 then
                        jobCount = jobCount + 1
                        jobCallback('updateObjectiveData', 'collect_twenty_fishes', 'count', jobCount)
                        if jobCount == 30 then
                            jobCallback('updateObjectiveData', 'collect_twenty_fishes', 'status', 'completed')
                        end
                    else
                        jobCallback = nil
                    end
                end
            else
                TriggerEvent("DoLongHudText", "It got away!!!!!!!", 2)
            end
        end
    end
    if not found then
        TriggerEvent("DoLongHudText", "No fish was hooked...", 1)
    end

    -- local rod = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, `prop_fishing_rod_01`, false, false, false)
    -- SetEntityAsMissionEntity(rod, 1, 1)
    if fishingRod ~= nil then
        Sync.DeleteObject(fishingRod)
        fishingRod = nil
    end
    ClearPedTasks(GetPlayerPed(-1))
end

local fishing = false
local trackedFishing = false
local function startFishing()
    if fishing then return end
    fishing = true
    -- TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)

    if not trackedFishing then
      TriggerServerEvent("np-fishing:registerFisher");
      trackedFishing = true
    end

    local rodModel = "prop_fishing_rod_01"
    local rodHash = `prop_fishing_rod_01`

    RequestAnimDict("amb@world_human_stand_fishing@idle_a")
    RequestModel(rodModel)
    while not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a") or not HasModelLoaded(rodModel) do
        Citizen.Wait(0)
    end

    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
    local bone = GetPedBoneIndex(PlayerPedId(), 60309)
    
    if fishingRod ~= nil then
        Sync.DeleteObject(fishingRod)
        fishingRod = nil
    end
    fishingRod = CreateObject(rodHash, 1.0, 1.0, 1.0, 1, 1, 0)

    ClearPedTasksImmediately(PlayerPedId())

    AttachEntityToEntity(fishingRod, PlayerPedId(), bone, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 2, 1)
    Wait(0)
    TaskPlayAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 20.0, -8, -1, 49, 0, 0, 0, 0)

    local seconds = 0
    Citizen.CreateThread(function()
        while fishing do
            Citizen.Wait(5000)
            seconds = seconds + 5
            local chance = math.random() * 100
            if chance + seconds > 100 then
                fishing = false
                reelInFish()
            end
        end
    end)
    Citizen.CreateThread(function()
        while fishing do
            if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
                TaskPlayAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 20.0, -8, -1, 49, 0, 0, 0, 0)
            end
            Citizen.Wait(250)
        end
    end)
end

AddEventHandler("np-inventory:itemUsed", function(item)
    if item == "fishingrod" then
        local coords = GetEntityCoords(PlayerPedId())
        if fishingLocation == nil then
            TriggerEvent('fishing:justincase')
        else
            if #(fishingLocation.coords - coords) < 250 and not IsEntityInWater(PlayerPedId()) then
                startFishing()
            else
                TriggerEvent('DoLongHudText', "You can't fish here...", 2)
            end
        end
        return
    end
    if not isValidFish(item) then return end
    TriggerEvent("inventory:removeItem", item, 1)
    local anim = "anim@heists@ornate_bank@hack"
    local type = "hack_enter"
    local fishName = "a_c_fish"
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        RequestAnimDict(anim)
        RequestModel(fishName)

        while not HasAnimDictLoaded(anim) or not HasModelLoaded(fishName) do
            Citizen.Wait(0)
        end
        TaskPlayAnim(ped, anim, type, 1.0, 1.0, 2575, 0, 0, 0, 0, 0)

        Citizen.Wait(800)

        local boneIndex = GetPedBoneIndex(ped, 0xfa70)
        local bonePos = GetWorldPositionOfEntityBone(ped, boneIndex)
        local obj = CreatePed(28, `a_c_fish`, bonePos.x, bonePos.y, bonePos.z, true, true, true)
        AttachEntityToEntity(obj, ped, GetPedBoneIndex(ped, 57005), 0.1, 0, -0.1, -45.0, 45.0, 0.0, true, true, false, true, 1, true)

        Citizen.Wait(1750)

        Sync.DetachEntity(obj)
        ClearPedTasksImmediately(ped)

        Citizen.Wait(2000)

        Sync.DeletePed(obj)
        SetModelAsNoLongerNeeded(fishName)
    end)
end)

AddEventHandler("np-fishing:jobEvent", function(pActivityId, pTaskName, pReferences, pObjectives, pCallback)
    jobCallback = pCallback
end)