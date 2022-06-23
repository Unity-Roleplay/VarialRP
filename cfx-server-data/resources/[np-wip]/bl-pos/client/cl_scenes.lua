RegisterCommand("+getPosLoc", function()
    if sceneStarted then -- end
        sceneStarted = false
        TriggerServerEvent("bl-pos:printPos", activePos)
        print(json.encode(activePos))
        return
    end

    sceneStarted = true
    Citizen.CreateThread(function()
        while sceneStarted do
            local hit, pos, _, _ = RayCastGamePlayCamera(10.0)
            if hit then
                DrawSphere(pos, 0.2, 0, 255, 0, 255)
                activePos = pos
            end
            Wait(0)
        end
    end)
end, false)

RegisterCommand("-getPosLoc", function() end, false)

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "ZZ_Admin", "Get Pos", "+getPosLoc", "-getPosLoc")
    RequestStreamedTextureDict('commonmenu', true)
    Wait(5000)
end)