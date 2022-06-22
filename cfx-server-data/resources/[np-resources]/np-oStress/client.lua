local stresslevel = 0
local isBlocked = false
local Blurtime = 1100

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
    stresslevel = newStress
    print(stresslevel)
end)

RegisterNetEvent("client:blockShake")
AddEventHandler("client:blockShake",function(isBlockedInfo)
    isBlocked = isBlockedInfo
end)


RegisterNetEvent("np-adminmenu:currentDevmode")
AddEventHandler("np-adminmenu:currentDevmode", function(devmode)
    isBlocked = devmode
end)


Citizen.CreateThread(function()
    while true do
        if stresslevel == 0 then

        else
            Citizen.Wait(500000)
        end
        Citizen.Wait(100)
    end
end)
Citizen.CreateThread(function()
    while true do
		local waitTime = 60000
        if not isBlocked then

            if stresslevel > 7500 then
                waitTime = 10000
                Blurtime = 5000
            elseif stresslevel > 4500 then
                waitTime = 20000
                Blurtime = 3000
            elseif stresslevel > 2000 then
                waitTime = 40000
                Blurtime = 2000
            end
            if stresslevel > 1000 then
                TriggerScreenblurFadeIn(1000.0)
                Wait(Blurtime)
                TriggerScreenblurFadeOut(1000.0)
            end
            Citizen.Wait(waitTime)
        end
    end
end)


