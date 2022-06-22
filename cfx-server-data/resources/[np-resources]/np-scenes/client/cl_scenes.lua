local keyboardActive = false
local sceneStarted = false
local scenesEnabled = true
local activePos = nil
local activeScenes = {}
local drawnScenes = {}
local lastUpdate = GetGameTimer()
local playerCoords = nil
local disableLargeSceneText = false
local isPeekActive = false

RegisterNetEvent("np-scenes:updateScenes", function(scenes)
    activeScenes = scenes
end)

RegisterNetEvent("np-scenes:deleteScene")
AddEventHandler("np-scenes:deleteScene", function(removeId)
    if removeId then
        drawnScenes[removeId] = nil
    end
end)

local fontSizing = {
    ["0"] = {1.0, 0.85},
    ["1"] = {1.5, 0.75},
    ["2"] = {1.75, 0.75},
    ["3"] = {1.0, 1.0},
    ["4"] = {1.0, 0.75},
    ["5"] = {1.0, 1.0},
    ["6"] = {1.4, 0.4},
    ["7"] = {1.3, 0.9},
    ["8"] = {1.5, 1.0},
    ["9"] = {1.5, 1.0},
    ["10"] = {1.5, 1.0},
    ["11"] = {1.5, 1.0},
    ["12"] = {1.5, 1.0},
}

function calculateScenesToDraw()
    playerCoords = GetEntityCoords(PlayerPedId())

    isPeekActive = exports['np-interact']:IsPeeking()
    if (activeScenes) then
        for _, scene in pairs(activeScenes) do
            -- print("isPeekActive: " .. json.encode(isPeekActive) .. " - scene.peek: " .. json.encode(scene.peek))

            if ((scene.peek and isPeekActive) or not scene.peek) and #(scene.pos - playerCoords) < scene.distance then
                if not scene.processed then
                    local sText = scene.text
                    if disableLargeSceneText then
                        local _, _, foundText = sText:find('<font size=.[0-9]*.>(.*)')
                        if foundText then
                            local _, _, foundEnd = foundText:find('(.*)</font>')
                            if foundEnd then
                                sText = foundEnd
                            else
                                sText = foundText
                            end
                        end
                    end
                    --calculate line count
                    local lineCount = 0
                    local s1 = string.sub(sText, 0, 99)
                    local s2 = string.sub(sText, 100, 199)
                    local s3 = string.sub(sText, 200, 255)
                    --Get inital line count from length of string
                    if s1:len() > 0 then lineCount = lineCount + 1 end
                    if s2:len() > 0 then lineCount = lineCount + 1 end
                    if s3:len() > 0 then lineCount = lineCount + 1 end

                    local longestLine = ""
                    for _,s in ipairs(Split(s1, "~n~")) do
                        if s:len() > longestLine:len() then
                            longestLine = s
                        end
                    end
                    for _,s in ipairs(Split(s2, "~n~")) do
                        if s:len() > longestLine:len() then
                            longestLine = s
                        end
                    end
                    for _,s in ipairs(Split(s3, "~n~")) do
                        if s:len() > longestLine:len() then
                            longestLine = s
                        end
                    end

                    --Get additional line count from newlines in string
                    local _, count = sText:gsub('\n', '\n')
                    lineCount = count + lineCount
                    local _, count2 = sText:gsub('~n~', '~n~')
                    lineCount = count2 + lineCount

                    --calculate width
                    SetTextScale(0.0, 1.0)
                    SetTextFont(scene.font and scene.font or 4)
                    SetTextCentre(true)
                    local swidth = 0
                    for c in longestLine:gmatch"." do
                        BeginTextCommandGetWidth("STRING")
                        AddTextComponentSubstringPlayerName(c)
                        local cwidth = EndTextCommandGetWidth(false)
                        swidth = swidth + cwidth
                    end

                    local font = scene.font and scene.font or 4
                    local cwidth = map_range(longestLine:len(), 0, 99, fontSizing[tostring(font)][1], fontSizing[tostring(font)][2])
                    local width = swidth * cwidth

                    scene.pText = {
                        text = sText,
                        string1 = s1,
                        string2 = s2,
                        string3 = s3,
                        maxOneLineLength = longestLine:len(),
                        lineCount = lineCount,
                        width = width,
                    }
                    scene.fade = { type = "in", fade = 0 }
                    scene.processed = true
                    Wait(100)
                    end
                drawnScenes[scene.id] = scene
            end
        end
    end
end

local updateTimer = 0
local processing = false
Citizen.CreateThread(function()
    while true do

        if scenesEnabled then

            local currentTime = GetGameTimer()
            -- every 200 ticks lets recalculate what we want to draw
            if currentTime - updateTimer > 500 and not processing then
                Citizen.CreateThread(function()
                    processing = true
                    calculateScenesToDraw()
                    processing = false
                end)
                updateTimer = currentTime
            end

            local plyCoords = GetFinalRenderedCamCoord()
            for _, scene in pairs(drawnScenes) do
                local dist = #(scene.pos - plyCoords)
                if (dist < scene.distance) then
                    if ((scene.peek and isPeekActive) or not scene.peek) then
                        DrawText3D(scene.pos.x, scene.pos.y, scene.pos.z, dist, scene.pText, scene.colour, scene.background, scene.font)
                    end
                end
            end
            lastUpdate = currentTime
        end
        Wait(0)
    end
end)

RegisterCommand("+startScene", function()
    if sceneStarted then -- end
        sceneStarted = false

        OpenKeyboard()

        return
    end

    sceneStarted = true
    Citizen.CreateThread(function()
        while sceneStarted do
            local hit, pos, _, _ = RayCastGamePlayCamera(10.0)
            if hit then
                DrawSphere(pos, 0.2, 255, 0, 0, 255)
                activePos = pos
            end
            Wait(0)
        end
    end)
end, false)

RegisterCommand("-startScene", function() end, false)

RegisterCommand("+enableScene", function() 
    scenesEnabled = not scenesEnabled
    TriggerEvent('DoLongHudText', not scenesEnabled and 'Scenes Disabled' or 'Scenes Enabled')
end, false)
RegisterCommand("-enableScene", function() end, false)

RegisterCommand("+deleteScene", function()
    RPC.execute("np-scenes:deleteScene", GetEntityCoords(PlayerPedId()))
end, false)
RegisterCommand("-deleteScene", function() end, false)

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Scenes", "Start / Place Scene", "+startScene", "-startScene")
    exports["np-keybinds"]:registerKeyMapping("", "Scenes", "Enable / Disable", "+enableScene", "-enableScene")
    exports["np-keybinds"]:registerKeyMapping("", "Scenes", "Delete Closest Scene", "+deleteScene", "-deleteScene")
    RequestStreamedTextureDict('commonmenu', true)
    Wait(5000)
    activeScenes = RPC.execute("np-scenes:getScenes")
end)

AddEventHandler("np-preferences:setPreferences", function(data)
    disableLargeSceneText = data["scenes.disableLargeText"]
    for _, scene in pairs(activeScenes) do
        scene.processed = false
    end
end)

OpenKeyboard = function()
    keyboardActive = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN"
    })
end

CloseKeyboard = function()
    if (keyboardActive) then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "CLOSE",
        })
        keyboardActive = false
    end
end

RegisterNUICallback("closeDialog", function(data, cb)
    CloseKeyboard()
end)

RegisterNUICallback("newScene", function(data, cb)
    CloseKeyboard()
    -- print("newScene data.data[1]: " .. json.encode(data.data[1]))

    local text = data.data[1].text
    local colour = data.data[1].colour or 'white'
    local distance = tonumber(data.data[1].distance) or 10
    local font = data.data[1].font or 0
    local peekOnly = data.data[1].peekOnly or false
    distance = distance + 0.0
    if distance < 0.1 or distance > 10 then
        distance = 10.0
    end

    if not text then
        TriggerEvent("DoLongHudText", "No text entered for scene.")
        return
    end

    RPC.execute("np-scenes:addScene", {
        pos = activePos,
        text = text,
        colour = colour,
        distance = distance,
        peekOnly = peekOnly,
        font = tonumber(font)
    })
    cb("ok")
end)