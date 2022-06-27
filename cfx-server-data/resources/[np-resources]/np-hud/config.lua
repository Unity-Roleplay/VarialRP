Ghostt = {}
Ghostt.BPlusMode = 0.495000 --- quick
Ghostt.MultiplierS = 1.595000 --- quicker
Ghostt.MultiplierSPlus = 26.695000 --- quickest
Ghostt.MultiplierA = 0.395000 --- slowest

-- function stress() 
--     return exports['np-stress']:stress() 
-- end


------ COMMANDS -----

RegisterCommand("hud", function(source, args) 
    OpenMenu() 
end)

RegisterCommand("Ghosttbuff", function(source, args, raw) 
    dobuffthing(args[1], args[2]) 
end)

RegisterCommand("dev", function(source, args, raw) 
    dobuffthing("dev") 
end)

RegisterCommand("debug", function(source, args, raw) 
    dobuffthing("debug") 
end)
--- VOICE --

RegisterNetEvent("np-hud:voice")
AddEventHandler("np-hud:voice", function(talk, mod) 
    if mod == "Whisper" then sesduzey = 1 elseif mod == "Normal" then sesduzey = 2 elseif mod == "Shouting" then sesduzey = 3 end 
    SendNUIMessage({
        action = "voice",
        radio = radio,
        voice = sesduzey,
        talking = talk
    })
end)
