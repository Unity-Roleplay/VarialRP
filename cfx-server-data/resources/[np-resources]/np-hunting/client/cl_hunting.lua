local validHuntingZones = nil
local animals = nil
local baitDistanceInUnits = nil
local spawnDistanceRadius = nil

local baitLocation = nil
local baitLastPlaced = 0
local targetedEntity = nil

local animalList = {
    { name = "Boar", hash = `a_c_boar` },
    { name = "Cat", hash = `a_c_cat_01` },
    { name = "Chicken", hash = `a_c_chickenhawk` },
    { name = "Chimp", hash = `a_c_chimp` },
    { name = "Chop", hash = `a_c_chop` },
    { name = "Cormorant", hash = `a_c_cormorant` },
    { name = "Cow", hash = `a_c_cow` },
    { name = "Coyote", hash = `a_c_coyote` },
    { name = "Crow", hash = `a_c_crow` },
    { name = "Deer", hash = `a_c_deer` },
    { name = "Hen", hash = `a_c_hen` },
    { name = "Husky", hash = `a_c_husky` },
    { name = "Mountain-Lion", hash = `a_c_mtlion` },
    { name = "Pig", hash = `a_c_pig` },
    { name = "Pigeon", hash = `a_c_pigeon` },
    { name = "Poodle", hash = `a_c_poodle` },
    { name = "Pug", hash = `a_c_pug` },
    { name = "Rabbit", hash = `a_c_rabbit_01` },
    { name = "Rat", hash = `a_c_rat` },
    { name = "Retriever", hash = `a_c_retriever` },
    { name = "Chimp", hash = `a_c_rhesus` },
    { name = "Rottweiler", hash = `a_c_rottweiler` },
    { name = "Seagull", hash = `a_c_seagull` },
    { name = "Shepherd", hash = `a_c_shepherd` },
    { name = "Westy", hash = `a_c_westy` },
    { name = "Panther", hash = `a_c_panther` },
}

DecorRegister("HuntingMySpawn", 2)
DecorRegister("HuntingIllegal", 2)

Citizen.CreateThread(function()
    local result = RPC.execute("np-hunting:getSettings")
    animals = result.animals
    baitDistanceInUnits = result.baitDistanceInUnits
    spawnDistanceRadius = result.spawnDistanceRadius
    validHuntingZones = result.validHuntingZones
end)

AddEventHandler("np:target:changed", function(pEntity)
    targetedEntity = pEntity
end)

local function isValidZone()
    print(GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId()))))
    return validHuntingZones[GetLabelText(GetNameOfZone(GetEntityCoords(PlayerPedId())))] == true
end

local function getSpawnLoc()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = nil
    while spawnCoords == nil do
        local spawnX = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnY = math.random(-spawnDistanceRadius, spawnDistanceRadius)
        local spawnZ = baitLocation.z
        local vec = vector3(baitLocation.x + spawnX, baitLocation.y + spawnY, spawnZ)
        if #(playerCoords - vec) > spawnDistanceRadius then
            spawnCoords = vec
        end
    end
    local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(spawnCoords.x, spawnCoords.y, 1023.9)
    spawnCoords = vector3(spawnCoords.x, spawnCoords.y, groundZ)
    return spawnCoords
end

local function spawnAnimal(loc)
    local chance = math.random()
    print("spawnAnimal",chance)
    local foundAnimal = false
    for _, animal in pairs(animals) do
        if foundAnimal == false and animal.chance > chance then
            foundAnimal = animal
        end
    end
    local modelName = foundAnimal.model
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Citizen.Wait(0)
    end
    local spawnLoc = getSpawnLoc()
    local spawnedAnimal = CreatePed(28, foundAnimal.hash, spawnLoc, true, true, true)
    DecorSetBool(spawnedAnimal, "HuntingMySpawn", true)
    DecorSetBool(spawnedAnimal, "HuntingIllegal", foundAnimal.illegal)
    if foundAnimal.illegal and math.random() < 0.4 then
        local plyPos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('dispatch:svNotify', {
            dispatchCode = "10-45",
            origin = {
            x = plyPos.x,
            y = plyPos.y,
            z = plyPos.z,
            },
        })
    end
    SetModelAsNoLongerNeeded(modelName)
    TaskGoStraightToCoord(spawnedAnimal, loc, 1.0, -1, 0.0, 0.0)
    Citizen.CreateThread(function()
        local finished = false
        while not IsPedDeadOrDying(spawnedAnimal) and not finished do
            local spawnedAnimalCoords = GetEntityCoords(spawnedAnimal)
            if #(loc - spawnedAnimalCoords) < 0.5 then
                ClearPedTasks(spawnedAnimal)
                Citizen.Wait(1500)
                TaskStartScenarioInPlace(spawnedAnimal, "WORLD_DEER_GRAZING", 0, true)
                Citizen.SetTimeout(7500, function()
                    finished = true
                end)
            end
            if #(spawnedAnimalCoords - GetEntityCoords(PlayerPedId())) < 15.0 then
                ClearPedTasks(spawnedAnimal)
                TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
                finished = true
            end
            Citizen.Wait(1000)
        end
        if not IsPedDeadOrDying(spawnedAnimal) then
            TaskSmartFleePed(spawnedAnimal, PlayerPedId(), 600.0, -1)
        end
    end)
end

local function baitDown()
    Citizen.CreateThread(function()
        while baitLocation ~= nil do
            local coords = GetEntityCoords(PlayerPedId())
            if #(baitLocation - coords) > baitDistanceInUnits then
                if math.random() < 1.0 then
                    spawnAnimal(baitLocation)
                    baitLocation = nil
                end
            end
            Citizen.Wait(10000)
        end
    end)
end

AddEventHandler("np-inventory:itemUsed", function(item)
    if item == "huntingbait" then
        print("using huntingbait")
        if not isValidZone() then
            TriggerEvent("DoLongHudText", "You can't hunt here...", 2)
            return
        end
        if baitLastPlaced ~= 0 and GetGameTimer() < (baitLastPlaced + (60000 * 3)) then -- 3 minutes
            TriggerEvent("DoLongHudText", "Your nose can't take it yet...", 2)
            return
        end
        baitLocation = nil
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["np-taskbar"]:taskBar(15000, "Placing Bait", false, true, false, false, nil, 5.0, PlayerPedId())
        ClearPedTasks(PlayerPedId())
        if finished ~= 100 then
            baitLocation = nil
            TriggerEvent("DoLongHudText", "Placement Cancelled", 2)
            return
        end
        TriggerEvent("evidence:dna","Animal-Bait")
        baitLastPlaced = GetGameTimer()
        baitLocation = GetEntityCoords(PlayerPedId())
        TriggerEvent("DoLongHudText", "Wew, pungenty...", 1)
        TriggerEvent("inventory:removeItem", item, 1)
        baitDown()
    end
    if item == "huntingknife" then
        print("using huntingknife")
        if GetPedType(targetedEntity) ~= 28 or not IsPedDeadOrDying(targetedEntity) then
            TriggerEvent("DoLongHudText", "No animal found", 2)
            return
        end
        local myAnimal = targetedEntity
        TaskTurnPedToFaceEntity(PlayerPedId(), myAnimal, -1)
        Citizen.Wait(1500)
        ClearPedTasksImmediately(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["np-taskbar"]:taskBar(30000, "Preparing Animal", false, true, false, false, nil, 5.0, targetedEntity)
        if finished ~= 100 then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerEvent("DoLongHudText", "Preparing Cancelled", 2)
            return
        end
        -- this is a model to leave it up the 
        local animalName = GetAnimalName(myAnimal)
        TriggerEvent("Evidence:StateSet",28,1200)
        TriggerEvent("evidence:dna",animalName)
        ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        local mySpawn = DecorExistOn(myAnimal, "HuntingMySpawn") and DecorGetBool(myAnimal, "HuntingMySpawn")
        local illegalSpawn = DecorExistOn(myAnimal, "HuntingIllegal") and DecorGetBool(myAnimal, "HuntingIllegal")
        TriggerServerEvent('np-hunting:skinReward',  NetworkGetNetworkIdFromEntity(myAnimal), mySpawn, illegalSpawn, animalName)
        DeleteEntity(myAnimal)
     --   RPC.execute("np-hunting:getSkinnedItem", NetworkGetNetworkIdFromEntity(myAnimal), mySpawn, illegalSpawn, animalName)
        TriggerEvent("client:newStress", true, 150)
    end
end)

local skinnedHumans = {}
AddEventHandler("np-inventory:itemUsed", function(item)
    if item == "huntingknife" then
        print(GetPedType(targetedEntity), IsPedDeadOrDying(targetedEntity))
        if (GetPedType(targetedEntity) ~= 4 and GetPedType(targetedEntity) ~= 5) or not IsPedDeadOrDying(targetedEntity) then
            TriggerEvent("DoLongHudText", "No animal found", 2)
            return
        end
        local myAnimal = targetedEntity
        TaskTurnPedToFaceEntity(PlayerPedId(), myAnimal, -1)
        Citizen.Wait(1500)
        ClearPedTasksImmediately(PlayerPedId())
        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
        local finished = exports["np-taskbar"]:taskBar(30000, "Preparing", false, true, false, false, nil, 5.0, targetedEntity)
        if finished ~= 100 then
            ClearPedTasksImmediately(PlayerPedId())
            TriggerEvent("DoLongHudText", "Preparing Cancelled", 2)
            return
        end
        ClearPedTasks(PlayerPedId())
        ClearPedSecondaryTask(PlayerPedId())
        if skinnedHumans[targetedEntity] then
            return
        end
        if skinnedHumans ~= nil then
            if targetedEntity ~= nil then
                skinnedHumans[targetedEntity] = true
            end
        end
        TriggerEvent("player:receiveItem", "questionablemeat", 1)
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanfinger", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanfinger", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanfinger", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanfinger", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanear", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanear", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humankidney", 1)
        end
        if math.random() < 0.1 then
            TriggerEvent("player:receiveItem", "humanliver", 1)
        end
    end
end)

function GetAnimalName(myAnimal)
    local animalHash = GetEntityModel(myAnimal)
    local animalDNA = "Unknown-Animal"
    for i,v in ipairs(animalList) do
        if v.hash == animalHash then
            animalDNA = v.name
        end
    end
    return animalDNA
end


