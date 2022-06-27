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

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        local armor = GetPedArmour(PlayerPedId())
        if armor < 60 then
            armor = armor + 3
            if armor > 60 then
                armor = 60
            end
            SetPedArmour(PlayerPedId(),armor)
        end

          if math.random(500) < 3 then
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
        SetPedToRagdoll(PlayerPedId(),1000,1000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end)

RegisterNetEvent('hadcrack')
AddEventHandler('hadcrack', function(arg1,arg2,arg3)
    dstamina = 0
    Citizen.Wait(1000)

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

	SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

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

end)

RegisterNetEvent('food:IceCream')
AddEventHandler('food:IceCream', function()
	TriggerServerEvent("server:alterStress", false, 350)
end)

RegisterNetEvent('food:FishTaco')
AddEventHandler('food:FishTaco', function()
	dstamina = 0

	currentValues["hunger"] = currentValues["hunger"] + 80
	if currentValues["hunger"] < 0 then
		currentValues["hunger"] = 0
	end

	if currentValues["hunger"] > 100 then
		currentValues["hunger"] = 100
	end

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

	currentValues["hunger"] = currentValues["hunger"] + 40

	if currentValues["hunger"] < 0 then
		currentValues["hunger"] = 0
	end

	if currentValues["hunger"] > 100 then
		currentValues["hunger"] = 100
	end

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


RegisterNetEvent('hadenergy')
AddEventHandler('hadenergy', function(arg1,arg2,arg3)

    dstamina = 0
    Citizen.Wait(1000)

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.005)
    dstamina = 30

	SetRunSprintMultiplierForPlayer(PlayerId(), 1.0005)

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
end)


RegisterNetEvent('np-tacos')
AddEventHandler('np-tacos', function()
    TriggerEvent('np-hud:ChangeHunger', 50)
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
