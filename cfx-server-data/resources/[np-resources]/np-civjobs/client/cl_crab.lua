crabcatch = false


Citizen.CreateThread(function()
	exports["np-polyzone"]:AddBoxZone("crab_catch1", vector3(2258.89, 4574.31, 32.04), 80, 6, {
		name="crab_catch1",
		heading=100,
        minZ=27.64,
        maxZ=31.64
	})
    exports["np-polyzone"]:AddBoxZone("crab_catch2", vector3(2218.81, 4580.45, 31.02), 20, 8, {
		name="crab_catch2",
		heading=10,
        minZ=28.42,
        maxZ=31.42
	})
	  
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "crab_catch1" or name == "crab_catch2" then
        crabcatch = true
        crabbypatty()
        exports["np-ui"]:showInteraction("[E] Catch Crabs")
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "crab_catch1" or name == "crab_catch2" then
        crabcatch = false
    end
    exports["np-ui"]:hideInteraction()
end)


function crabbypatty()
    Citizen.CreateThread(function()
        while crabcatch do
            Citizen.Wait(5)
            if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
                local hasCage = exports["np-inventory"]:hasEnoughOfItem("crabcage",1,false) 
                if hasCage then
                    FreezeEntityPosition(GetPlayerPed(-1),true)
                    TriggerEvent("animation:PlayAnimation","gardening")
                    local finished = exports["np-taskbar"]:taskBar(15000,"Searching for crabs")
                    if (finished == 100) then
                        local chance = math.random(1,100)
                        print(chance)
                        if chance <= 30 then
                            TriggerEvent("player:receiveItem","crab", math.random(1,3))	
                            TriggerEvent("animation:PlayAnimation","c")
                            FreezeEntityPosition(GetPlayerPed(-1),false)
                        elseif chance >= 31 and chance <= 37 then
                            TriggerEvent("player:receiveItem","crab3", 1)	
                            TriggerEvent("animation:PlayAnimation","c")
                            FreezeEntityPosition(GetPlayerPed(-1),false)
                        elseif chance == 69 then    
                            TriggerEvent("player:receiveItem","crab2", 1)	
                            TriggerEvent("animation:PlayAnimation","c")
                            FreezeEntityPosition(GetPlayerPed(-1),false)
                        else
                            TriggerEvent('DoLongHudText', 'You didnt find any crabs', 1 )
                            FreezeEntityPosition(GetPlayerPed(-1),false)
                        end
                    else
                       -- TriggerEvent('DoLongHudText', 'cancelled', 2 )
                       TriggerEvent("animation:PlayAnimation","c")
                        FreezeEntityPosition(GetPlayerPed(-1),false)
                    end
                else
                    TriggerEvent('DoLongHudText', 'You dont have a crab cage head over to mega mall to buy one', 2)
                end
            end
        end
    end)
end

local crabsell = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("crab_sell", vector3(903.15, -1723.39, 32.16), 3, 3, {
        name="crab_sell",
        heading=0,
        minZ=29.36,
        maxZ=33.36
    })  
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "crab_sell" then
        crabsell = true
        sellcrabs()
        exports["np-ui"]:showInteraction("[E] Sell Crabs")
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "crab_sell" then
        crabsell = false
    end
    exports["np-ui"]:hideInteraction()
end)

RegisterNetEvent('np-jobs:crabsell:menu', function()
    TriggerEvent('np-context:sendMenu', {
        {
            id = 0,
            header = "Crab Sales",
            txt = "",
            params = {
                event = "",
            },
        },
        {
            id = 1,
            header = "Crab",
            txt = "Sell your Crab",
            params = {
                event = "sell:crab",
            },
        },
        {
            id = 2,
            header = "King Crab",
            txt = "Sell your King Crab",
            params = {
            event = "sell:crab3",
            },
        },  
        {
            id = 3,
            header = "Blue Crab",
            txt = "Sell your Blue Crab",
            params = {
            event = "sell:crab2",
            },
        },  
    })
end)

function sellcrabs()
    Citizen.CreateThread(function()
        while crabsell do
            Citizen.Wait(5)
			if IsControlJustPressed(1, 38) and IsPedInAnyVehicle(GetPlayerPed(-1), false) ~= 1 then
                if not IsControlPressed(1, 19) then
                    TriggerEvent("np-jobs:crabsell:menu")
                else
                    TriggerServerEvent('np-civjobs:errorlog', 0x66)
                end
            end
        end
    end)
end

RegisterNetEvent('sell:crab')
AddEventHandler('sell:crab', function()
    if exports['np-inventory']:hasEnoughOfItem('crab', 1) then
        TriggerEvent('inventory:removeItem', 'crab', 1)
        RPC.execute("np-civjobs:sell-crab", "crab")
    else
        TriggerEvent('DoLongHudText', 'You do not have any Crab to sell', 2)
    end
end)

RegisterNetEvent('sell:crab3')
AddEventHandler('sell:crab3', function()
    if exports['np-inventory']:hasEnoughOfItem('crab3', 1) then
        TriggerEvent('inventory:removeItem', 'crab3', 1)
        RPC.execute("np-civjobs:sell-crab", "crab3")
    else
        TriggerEvent('DoLongHudText', 'You do not have any King Crab to sell', 2)
    end
end)

RegisterNetEvent('sell:crab2')
AddEventHandler('sell:crab2', function()
    if exports['np-inventory']:hasEnoughOfItem('crab2', 1) then
        TriggerEvent('inventory:removeItem', 'crab2', 1)
        RPC.execute("np-civjobs:sell-crab", "crab2")
    else
        TriggerEvent('DoLongHudText', 'You wish you had a Blue Crab to sell', 2)
    end
end)