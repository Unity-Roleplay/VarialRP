RegisterNetEvent("police:impoundVehicle")
AddEventHandler("police:impoundVehicle", function(pArgs, pEntity, pContext)
  TriggerServerEvent("police:impoundVehicle", VehToNet(pEntity))
end)




ControlForPursuitMode = 172	

local defaultHash, defaultHash2, defaultHash3, defaultHash4, defaultHash5 = "npolchal","npolvette","npolstang","polchar","npolvic"

local pursuitEnabled = false

local InPursuitModeAPlus = false

local InPursuitModeB = false



	 -- [START]   Events for different modes


	RegisterNetEvent("police:Ghost:Pursuit:Mode:A")
	AddEventHandler("police:Ghost:Pursuit:Mode:A",function()
		local ped = PlayerPedId()
		if (IsPedInAnyVehicle(PlayerPedId(), true)) then
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			local Driver = GetPedInVehicleSeat(veh, -1)
			local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
			local First = 'A +'
		   if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)
		   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
					SetVehicleModKit(veh, 0)
					SetVehicleMod(veh, 46, 4, true)
					SetVehicleMod(veh, 11, 4, true)
					SetVehicleMod(veh, 12, 4, false)
					SetVehicleMod(veh, 13, 4, false)  
					ToggleVehicleMod(veh,  18, false)          
                    print('Ghost : Display Icon')
                    TriggerEvent('PursuitModeIcon:Enable:A+') 
					TriggerEvent('DoLongHudText', 'New Mode : ' ..First)
					PursuitEnabled = true
					SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.3970000)
					SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                    SelectedPursuitMode = 35
                    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
				else
                    print(First)
					TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
				end
		end
		end)



RegisterNetEvent("police:Ghost:Pursuit:B:Plus") -- Second Pursuit Mode
AddEventHandler("police:Ghost:Pursuit:B:Plus",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode1 = 'B +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)
				SetVehicleMod(veh, 13, 4, true)  
                ToggleVehicleMod(veh,  18, true)          
                TriggerEvent('PursuitModeIcon:Enable:B+') 
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode1)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4270000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                SelectedPursuitMode = 50
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                print(mode1)
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)

	
RegisterNetEvent("police:Ghost:Pursuit:SPlusMode")  
AddEventHandler("police:Ghost:Pursuit:SPlusMode",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode2 = 'S +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)
				SetVehicleMod(veh, 13, 4, true)  
                ToggleVehicleMod(veh,  18, true)          
                TriggerEvent('PursuitModeIcon:Enable:S+') 
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode2)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4970000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.100000)

                SelectedPursuitMode = 100
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                print(mode2)
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)




	

RegisterNetEvent("police:pursuitmodeOff")
AddEventHandler("police:pursuitmodeOff",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
            print('Pursuit Disabled?')
               TriggerEvent('PursuitModeIcon:Disable')
               SetVehicleModKit(veh, 0)
               SetVehicleMod(veh, 46, 4, false)
			   SetVehicleMod(veh, 13, 4, false)
			   SetVehicleMod(veh, 12, 4, false)
			   SetVehicleMod(veh, 11, 4, false)
               ToggleVehicleMod(veh,  18, false)

				TriggerEvent("DoLongHudText","Pursuit Mode Disabled",2 )                
				InPursuitModeAPlus = false
                pursuitEnabled = false
                InPursuitModeB = false
				SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.305000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 0.850000)
                SelectedPursuitMode = 0
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
        end
        end)


	 -- [END]   Events for different modes



	 Citizen.CreateThread( function()
		while true do 
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
				if (IsDisabledControlJustPressed(0, ControlForPursuitMode)) and InPursuitModeAPlus == false then 
					if (not IsPauseMenuActive()) then 
						if exports["isPed"]:isPed("myjob") == "police" then
						if pursuitEnabled == false then
							pursuitEnabled = true
							TriggerEvent('police:Ghost:Pursuit:Mode:A')
							print(json.encode('Key pressed actiavte A+ Mode'))
	
	
							while pursuitEnabled == true do
								Citizen.Wait(15)
								if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									print(json.encode('Already In A+ Mode New mode :   B +'))
									InPursuitModeAPlus = true
                                    pursuitEnabled = false
									TriggerEvent('police:Ghost:Pursuit:B:Plus') 
	
								while InPursuitModeAPlus == true do 
									Citizen.Wait(15)
									if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									InPursuitModeB = true
                                    InPursuitModeAPlus = false
									print(json.encode('Already In B Plus Mode New mode :   S +'))
									TriggerEvent('police:Ghost:Pursuit:SPlusMode') 
	
									
									while InPursuitModeB == true do 
										Citizen.Wait(15)
										if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
										 print(json.encode('Key pressed : Resetting back to default car handling'))
                                         InPursuitModeAPlus = false
                                         TriggerEvent('police:pursuitmodeOff')
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	end
	end
	end)


	local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		disableSeatShuffle(false)
		Citizen.Wait(5000)
		disableSeatShuffle(true)
	else
		CancelEvent()
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end 
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
            local model = GetEntityModel(veh)
            -- If it's not a boat, plane or helicopter, and the vehilce is off the ground with ALL wheels, then block steering/leaning left/right/up/down.
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityUpsidedown(veh) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end 
        end
    end
end)


RegisterCommand("shuff", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false) --False, allow everyone to run it

	RegisterNetEvent('car:engine')
	AddEventHandler('car:engine', function()
		local targetVehicle = GetVehiclePedIsUsing(PlayerPedId())
		TriggerEvent("keys:hasKeys", 'engine', targetVehicle)
	end)

	local waitKeys = false
RegisterNetEvent('car:engineHasKeys')
AddEventHandler('car:engineHasKeys', function(targetVehicle, allow)
    if IsVehicleEngineOn(targetVehicle) then
        if not waitKeys then
            waitKeys = true
            SetVehicleEngineOn(targetVehicle,0,1,1)
            SetVehicleUndriveable(targetVehicle,true)
            TriggerEvent("DoShortHudText", "Engine Halted",1)
            Citizen.Wait(300)
            waitKeys = false
        end
    else
        if not waitKeys then
            waitKeys = true
            TriggerEvent("keys:startvehicle")
            TriggerEvent("DoShortHudText", "Engine Started",1)
            Citizen.Wait(300)
            waitKeys = false
        end
    end
end)