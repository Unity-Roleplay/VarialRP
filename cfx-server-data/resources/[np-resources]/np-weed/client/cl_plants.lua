local WeedPlants = {}
local ActivePlants = {}

local inZone = 0
local setDeleteAll = false

--Creates da weed
--TODO: cache close plants
Citizen.CreateThread(function()
    while true do
        local plyCoords = GetEntityCoords(PlayerPedId())
        if WeedPlants == nil then WeedPlants = {} end
        for idx,plant in ipairs(WeedPlants) do
            if idx % 100 == 0 then
                Wait(0) --Process 100 per frame
            end
            --convert timestamp -> growth percent
            local plantGrowth = getPlantGrowthPercent(plant)
            if #(plyCoords - plant.coords) < (50.0 + plantGrowth) and not setDeleteAll then
                local curStage = getStageFromPercent(plantGrowth)
                local isChanged = (ActivePlants[plant.id] and ActivePlants[plant.id].stage ~= curStage)

                if isChanged then
                    removeWeed(plant.id)
                end

                if not ActivePlants[plant.id] or isChanged then
                    local weedPlant = createWeedStageAtCoords(curStage, plant.coords)
                    ActivePlants[plant.id] = {
                        object = weedPlant,
                        stage = curStage,
                        coords = plant.coords
                    }
                end
            else
                removeWeed(plant.id)
            end
        end
        if setDeleteAll then
            WeedPlants = {}
            setDeleteAll = false
        end
        Wait(inZone > 0 and 5000 or 10000)
    end
end)

AddEventHandler("np-inventory:itemUsed", function(item)
    if item == "femaleseed" then
        if inZone > 0 then
            local plyCoords = GetEntityCoords(PlayerPedId())
            local offsetCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.7, 0)
            local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(offsetCoords.x, offsetCoords.y, offsetCoords.z, offsetCoords.x, offsetCoords.y, offsetCoords.z - 2, 1, 0, 4)
            local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
            if hit then
                local foundHash = false
                for matHash,matType in pairs(MaterialHashes) do
                    if materialHash == matHash then
                        local typeMod = PlantConfig.TypeModifiers[matType]
                        foundHash = true
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                        local finished = exports["np-taskbar"]:taskBar(3000, _L('weed-plants-plant-seed', 'Planting Seed'), false, true, false, false, nil, 5.0, PlayerPedId())
                        ClearPedTasks(PlayerPedId())
                        if finished == 100 then
                            RPC.execute("np-weed:plantSeed", endCoords, typeMod)
                            TriggerEvent("inventory:removeItem", item, 1)
                        end
                    end
                end
                if not foundHash then
                    TriggerEvent("DoLongHudText", _L('weed-plants-better-soil', 'I should find better soil to plant this'))
                end
            end
        else
            TriggerEvent("DoLongHudText", _L('weed-plants-better-area', 'I should find a better area to plant this'))
        end
    end
end)

RegisterNetEvent('np-weed:checkPlant')
AddEventHandler("np-weed:checkPlant", function(pContext, pEntity)
    local plantId = getPlantByPos(pContext["polyZoneCoordinates"])
    if not plantId then return end
    showPlantMenu(plantId)
end)

RegisterNetEvent('np-weed:addWater')
AddEventHandler('np-weed:addWater', function (pPlantId)
    playPourAnimation()
    local finished = exports["np-taskbar"]:taskBar(2000, "Adding Water", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local success = RPC.execute("np-weed:addWater", pPlantId)
        if not success then
            TriggerEvent("DoLongHudText", "[ERR]: Could not add water.")
        else
            TriggerEvent("inventory:removeItem", "water", 1)
        end
    end
    showPlantMenu(pPlantId)
end)

RegisterNetEvent('np-weed:addFertilizer')
AddEventHandler('np-weed:addFertilizer', function (pPlantId, key)
    playPourAnimation()
    local finished = exports["np-taskbar"]:taskBar(2000, _L('weed-plants-add-fertilizer', 'Adding Fertilizer'), false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local success = RPC.execute("np-weed:addFertilizer", {["id"] = pPlantId, ["type"] = key})
        if not success then
            TriggerEvent("DoLongHudText", "[ERR]: Could not add fertilizer")
        else
            TriggerEvent("inventory:removeItem", "fertilizer", 1)
        end
    end
    showPlantMenu(pPlantId)
end)

RegisterNetEvent('np-weed:addMaleSeed')
AddEventHandler('np-weed:addMaleSeed', function (pPlantId)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    local finished = exports["np-taskbar"]:taskBar(3000, "Adding Male Seed", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("np-weed:addMaleSeed", pPlantId)
        TriggerEvent("inventory:removeItem", "maleseed", 1)
    end
    showPlantMenu(pPlantId)
end)

RegisterNetEvent('np-weed:removePlant')
AddEventHandler('np-weed:removePlant', function ( pPlantId)
    TriggerEvent("animation:PlayAnimation","layspike")
    local finished = exports["np-taskbar"]:taskBar(3000, _L('weed-plants-remove', 'Removing'), false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local getFertilizer = getPlantGrowthPercent(getPlantById( pPlantId)) > 20.0
        local success = RPC.execute("np-weed:removePlant", pPlantId, getFertilizer)
        if not success then
            print("[ERR]: Could not remove. pid:",  pPlantId)
        end
    end
end)

RegisterNetEvent('np-weed:pickPlant')
AddEventHandler("np-weed:pickPlant", function(pContext, pEntity)
    local plantId = getPlantId(pEntity)
    if not plantId then return end

    local plant = getPlantById(plantId)
    local timeSinceHarvest = GetCloudTimeAsInt() - plant.last_harvest
    if getPlantGrowthPercent(plant) < PlantConfig.HarvestPercent or timeSinceHarvest <= (PlantConfig.TimeBetweenHarvest * 60) then
        TriggerEvent("DoLongHudText", _L('weed-plants-not-ready', 'Not ready for harvesting'), 2)
        return
    end

    local plyWeight = exports["np-inventory"]:getCurrentWeight()
    if plyWeight + 35.0 > 250.0 and plant.gender == 0 then
        TriggerEvent("DoLongHudText", "You do not have enough room to hold the bud.", 2)
        return
    end

    TriggerEvent("animation:PlayAnimation","layspike")
    local finished = exports["np-taskbar"]:taskBar(10000, _L('weed-plants-harvest', 'Harvesting'), false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("np-weed:harvestPlant", plantId)
    end
end)

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone == "np-weed:weed_zone" then
        inZone = inZone + 1
        if inZone == 1 then
            RPC.execute("np-weed:getPlants")
        end
    end
end)

AddEventHandler("np-polyzone:exit", function(zone, data)
    if zone == "np-weed:weed_zone" then
        inZone = inZone - 1
        if inZone < 0 then inZone = 0 end
        if inZone == 0 then
            setDeleteAll = true
        end
    end
end)

RegisterNetEvent('np-weed:trigger_zone')
AddEventHandler("np-weed:trigger_zone", function (type, pData)
    --Update all plants
    if type == 1 then
        for _,plant in ipairs(WeedPlants) do
            local keep = false
            for _,newPlant in ipairs(pData) do
                if plant.id == newPlant.id then
                    keep = true
                    break
                end
            end

            if not keep then
                removeWeed(plant.id)
            end
        end
        WeedPlants = pData
    end
    --New plant being added
    if type == 2 then
        WeedPlants[#WeedPlants+1] = pData
    end
    --Plant being harvested/updated
    if type == 3 then
        for idx,plant in ipairs(WeedPlants) do
            if plant.id == pData.id then
                WeedPlants[idx] = pData
                break
            end
        end
    end
    --Plant being removed
    if type == 4 then
        for idx,plant in ipairs(WeedPlants) do
            if plant.id == pData.id then
                table.remove(WeedPlants, idx)
                removeWeed(plant.id)
                break
            end
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for idx,plant in pairs(ActivePlants) do
        DeleteObject(plant.object)
    end
end)

function createWeedStageAtCoords(pStage, pCoords)
    local model = PlantConfig.GrowthObjects[pStage].hash
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local plantObject = CreateObject(model, pCoords.x, pCoords.y, pCoords.z + PlantConfig.GrowthObjects[pStage].zOffset, 0, 0, 0)
    FreezeEntityPosition(plantObject, true)
    SetEntityHeading(plantObject, math.random(0, 360) + 0.0)
    return plantObject
end

function removeWeed(pPlantId)
    if ActivePlants[pPlantId] then
        DeleteObject(ActivePlants[pPlantId].object)
        ActivePlants[pPlantId] = nil
    end
end

function getStageFromPercent(pPercent)
    local growthObjects = #PlantConfig.GrowthObjects - 1
    local percentPerStage = 100 / growthObjects
    return math.floor((pPercent / percentPerStage) + 1.5)
end

function getPlantGrowthPercent(pPlant)
    local timeDiff = (GetCloudTimeAsInt() - pPlant.timestamp) / 60
    local genderFactor = (pPlant.gender == 1 and PlantConfig.MaleFactor or 1)
    local fertilizerFactor = pPlant.strain.n >= 0.9 and PlantConfig.FertilizerFactor or 1.0
    local growthFactors = (PlantConfig.GrowthTime * genderFactor * fertilizerFactor)
    return math.min((timeDiff / growthFactors) * 100, 100.0)
end

function getPlantByPos(pCoords)
    for plantId, plant in pairs(WeedPlants) do
        if #(pCoords.xy - plant.coords.xy) < 1.5 then
            return plant.id
        end
    end
end

function getPlantId(pEntity)
    for plantId,plant in pairs(ActivePlants) do
        if plant.object == pEntity then
            return plantId
        end
    end
end

function getPlantById(pPlantId)
    for _,plant in pairs(WeedPlants) do
        if plant.id == pPlantId then
            return plant
        end
    end
end

function playPourAnimation()
    RequestAnimDict("weapon@w_sp_jerrycan")
    while ( not HasAnimDictLoaded( "weapon@w_sp_jerrycan" ) ) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
end

function showPlantMenu(pPlantId)
    local plant = getPlantById(pPlantId)
    --Build context menu
    local growth = getPlantGrowthPercent(plant)
    local water = plant.strain.water * 100.0
    local myjob = exports["isPed"]:isPed("myjob")
    local context = {}

    context[#context+1] = {
        title = "Growth: " .. string.format("%.2f", growth) .. '%',
        description = "Gender: " .. (plant.gender == 1 and "Male" or "Female"),
    }

    --Only allow adding water/fertilzier before harvest time
    if growth < PlantConfig.HarvestPercent then
        context[#context+1] = {
            title = "Add Water",
            description = "Water: " .. string.format("%.2f", water) .. '%',
            args = { pPlantId },
            event = 'np-weed:addWater',
            disabled = not exports["np-inventory"]:hasEnoughOfItem("water", 1, false)
        }

        context[#context+1] = {
            title = "Add Fertilizer",
            event = 'np-weed:addFertilizerMenu',
            args = { pPlantId },
            disabled = not exports["np-inventory"]:hasEnoughOfItem("fertilizer", 1, false)
        }
    end

    --Only allow changing gender in the first 2~ stages
    if getStageFromPercent(growth) < 3 and plant.gender == 0 then
        context[#context+1] = {
            title = "Add Male Seed",
            args = { pPlantId },
            event = "np-weed:addMaleSeed",
            description = "Make the plant preggies",
            disabled = not exports["np-inventory"]:hasEnoughOfItem("maleseed", 1, false)
        }
    end

    if growth >= 95 or myjob == "police" or myjob == "judge" then
        context[#context+1] = {
            title = "Destroy Plant",
            args = { pPlantId },
            event = "np-weed:removePlant"
        }
    end

    TriggerEvent("nc-weed:createMenu", context)
end

RegisterNetEvent('np-weed:addFertilizerMenu')
AddEventHandler("np-weed:addFertilizerMenu", function (pPlantId)
    local context = {}

    context[#context+1] = {
        title = "Add Fertilizer (N)",
        args = { pPlantId, "n" },
        event = 'np-weed:addFertilizer',
    }

    context[#context+1] = {
        title = "Add Fertilizer (P)",
        args = { pPlantId, "p" },
        event = 'np-weed:addFertilizer',
    }

    context[#context+1] = {
        title = "Add Fertilizer (K)",
        args = { pPlantId, "k" },
        event = 'np-weed:addFertilizer',
    }

    TriggerEvent("nc-weed:createMenu", context)
end)
