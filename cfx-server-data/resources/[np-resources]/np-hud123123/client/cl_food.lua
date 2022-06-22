local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["hunger"] = 100,
	["thirst"] = 100,
	["oxy"] = 2,
	["stress"] = 100,
	["voice"] = 2,
	["devmode"] = false,
	["devdebug"] = false,
	["is_talking"] = false
}

function Drugs1()
	StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")

end

function Drugs3()
	StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)

	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")

	StopScreenEffect("DrugsMichaelAliensFightOut")

end


function Drugs2()
	StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

RegisterNetEvent("OxyMenu")
AddEventHandler("OxyMenu",function()
	if currentValues["oxy"] > 25.0 then
		--RemoveOxyTank
		TriggerEvent('sendToGui','Remove Oxy Tank','RemoveOxyTank')
	end
end)


dstamina = 0
sitting = false

RegisterNetEvent('hadcocaine')
AddEventHandler('hadcocaine', function(arg1,arg2,arg3)
    dstamina = 0

	-- if math.random(100) > 50 then
	-- 	Drugs1()
	-- else
		Drugs3()
	-- end

    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
	    dstamina = 200
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.18)
	    dstamina = 200
	end

	TriggerEvent("client:newStress",true,math.random(250))

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+2)

	  	if math.random(500) < 3 then
	  		-- if math.random(100) > 50 then
	  		-- 	Drugs1()
	  		-- else
	  			Drugs3()
	  		-- end
		  	Citizen.Wait(math.random(30000))
		end

        -- if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
        --     SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        -- end
        
    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),1000,1000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()

end)

function RevertToStressMultiplier()

    local factor = (stresslevel / 2) / 10000
    local factor = 1.0 - factor
    
    
    if factor > 0.1 then
    
      SetSwimMultiplierForPlayer(PlayerId(), factor)
      SetRunSprintMultiplierForPlayer(PlayerId(), factor)
    else
      SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    end
    
end

RegisterNetEvent('hadcrack')
AddEventHandler('hadcrack', function(arg1,arg2,arg3)
    dstamina = 0
    Citizen.Wait(1000)

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
	    dstamina = 30
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
	    dstamina = 30
	end

	TriggerEvent("client:newStress",true,math.ceil(250))

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+1)

	  	if math.random(500) < 100 then
	  		if math.random(100) > 50 then
	  			Drugs1()
	  		else
	  			Drugs2()
	  		end
		  	Citizen.Wait(math.random(30000))
		end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
        
    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()

end)

RegisterNetEvent('hadcrack2')
AddEventHandler('hadcrack2', function(arg1,arg2,arg3)
    dstamina = 0
    Citizen.Wait(1000)

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
	    dstamina = 30
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)
	    dstamina = 30
	end

	TriggerEvent("client:newStress",true,math.ceil(350))

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+2)

	  	if math.random(500) < 100 then
	  		if math.random(100) > 50 then
	  			Drugs1()
	  		else
	  			Drugs2()
	  		end
		  	Citizen.Wait(math.random(30000))
		end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
        
    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()

end)

RegisterNetEvent('hadcrack3')
AddEventHandler('hadcrack3', function(arg1,arg2,arg3)
    dstamina = 0
    Citizen.Wait(1000)

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
	    dstamina = 30
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)
	    dstamina = 30
	end

	TriggerEvent("client:newStress",false,math.ceil(350))

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+2)

	  	if math.random(500) < 100 then
	  		if math.random(100) > 50 then
	  			Drugs1()
	  		else
	  			Drugs2()
	  		end
		  	Citizen.Wait(math.random(30000))
		end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
        
    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()

end)

RegisterNetEvent('food:IceCream')
AddEventHandler('food:IceCream', function()
	TriggerServerEvent("server:alterStress", false, 350)
end)


RegisterNetEvent('admin:IceCream')
AddEventHandler('admin:IceCream', function()
	TriggerServerEvent("server:alterStress", false, 10000)
end)

RegisterNetEvent('coffee:drink')
AddEventHandler('coffee:drink', function()
	
	-- currentValues["thirst"] = currentValues["thirst"] + 45

	-- if currentValues["thirst"] < 0 then
	-- 	currentValues["thirst"] = 0
	-- end

	-- if currentValues["thirst"] > 100 then
	-- 	currentValues["thirst"] = 100
	-- end

    TriggerEvent("np-hud:ChangeThirst", 45)
    TriggerEvent("np-hud:ChangeHunger", 15)
	
end)

RegisterNetEvent('hadenergy')
AddEventHandler('hadenergy', function(arg1,arg2,arg3)

    dstamina = 0
    Citizen.Wait(1000)

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.005)
    dstamina = 30

    if stresslevel > 1500 then
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0005)
	    dstamina = 115
	elseif stresslevel > 5000 then
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	    dstamina = 60
	end

	TriggerEvent("client:newStress",true,math.ceil(40))

    TriggerEvent("np-hud:ChangeThirst", 45)

    while dstamina > 0 do
        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1
        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(55), math.random(55), 3, 0, 0, 0)
        end
        if math.random(100) > 85 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(4000), math.random(4000), 3, 0, 0, 0)
        end
    end
    dstamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end
    RevertToStressMultiplier()
end)

RegisterNetEvent('food:FishTaco')
AddEventHandler('food:FishTaco', function()
	dstamina = 0

	TriggerEvent("np-hud:ChangeHunger", 70)

	SetSwimMultiplierForPlayer(PlayerId(), 1.15)

	while dstamina > 0 do
		if (IsPedSwimmingUnderWater(PlayerPedId()) or IsPedSwimming(PlayerPedId())) then
			RestorePlayerStamina(PlayerId(), 1.0)
		end
        Citizen.Wait(1000)
        dstamina = dstamina - 1
    end

    dstamina = 0


    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
end)

RegisterNetEvent('food:Taco')
AddEventHandler('food:Taco', function()
	currentValues["hunger"] = 100
	TriggerEvent("healed:minors")
end)

RegisterNetEvent('food:Condiment')
AddEventHandler('food:Condiment', function()
	dstamina = 0
	Citizen.Wait(1000)

	TriggerEvent("np-hud:ChangeHunger", 50)

	SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end

    end

    dstamina = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end)



local function ReturnShi()
    local PlayerPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(PlayerPed, false)
    local IsDriver = GetPedInVehicleSeat(plyVeh, -1) == PlayerPed
    local returnValue = plyVeh ~= 0 and plyVeh ~= nil and IsDriver
    return returnValue, plyVeh
end

Citizen.CreateThread(function()
    while true do
        local Driver, plyVeh = ReturnShi()
        if Driver then
            if GetVehicleCurrentGear(plyVeh) < 3 and GetVehicleCurrentRpm(plyVeh) == 1.0 and math.ceil(GetEntitySpeed(plyVeh) * 2.236936) > 50 then
              while GetVehicleCurrentRpm(plyVeh) > 0.6 do
                  SetVehicleCurrentRpm(plyVeh, 0.3)
                  Citizen.Wait(1)
              end
              Citizen.Wait(800)
            end
        end
        Citizen.Wait(500)
    end
end)

local function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(10)
	end
end

local function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(10)
	end
end

RegisterNetEvent('bong:animation')
AddEventHandler('bong:animation', function()
    
	    LoadModel('prop_bong_01')
	    LoadModel("p_cs_lighter_01")
	    local bong = CreateObject(GetHashKey('prop_bong_01'), GetEntityCoords(PlayerPedId()), true)
	    local lighter = CreateObject(GetHashKey('p_cs_lighter_01'), GetEntityCoords(PlayerPedId()), true)
	    LoadAnim("anim@safehouse@bong")
	    local pedCoords = GetEntityCoords(PlayerPedId())
	    local objectBong = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_bong_01"), false)
	    local objectLighter = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("p_cs_lighter_01"), false)
	    AttachEntityToEntity(objectBong,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 18905),0.10,-0.25,0.0,95.0,190.0,180.0,1,1,0,1,0,1)
	    AttachEntityToEntity(objectLighter, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),28422),  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
	    TaskPlayAnim(PlayerPedId(), 'anim@safehouse@bong', 'bong_stage1', 8.0, 8.0, -1, 69, 1, false, false, false)
	    Wait(8000)
	    DetachEntity(objectBong, true, true)
	    DeleteObject(objectBong)
	    DeleteObject(objectLighter)
        ClearPedTasks(GetPlayerPed(-1))
        Citizen.Wait(1000)
end)
