local firsttrolley = false
local sectrolley = false
local thirdtrolley = false
local randommoney = math.random(25,130)
local randomgold = math.random(3,20)

function SpawnTrolleys(data, name)
    RequestModel("ch_prop_ch_cash_trolly_01c")
    while not HasModelLoaded("ch_prop_ch_cash_trolly_01c") do
        Citizen.Wait(1)
    end
	RequestModel("ch_prop_gold_trolly_01c")
    while not HasModelLoaded("ch_prop_gold_trolly_01c") do
        Citizen.Wait(1)
    end
    Trolley1 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 259.52, 214.08, 100.683, 1, 1, 0)
    Trolley2 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 263.709, 215.525, 100.683, 1, 1, 0)
	Trolley3 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 262.944, 213.291, 100.683, 1, 1, 0)
    local h1 = GetEntityHeading(Trolley1)
    local h2 = GetEntityHeading(Trolley2)
    local h3 = GetEntityHeading(Trolley3)
    SetEntityHeading(Trolley1, 6.87)
	SetEntityHeading(Trolley2, 90.00)
	SetEntityHeading(Trolley3, 43.26)
    --local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
end

  --[[ for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            table.insert(missionplayers, GetPlayerServerId(players[i]))
        end
	end
    done = false
end]]

RegisterNetEvent("dark-vaultrob:upper:uppertrolleydelete")
AddEventHandler("dark-vaultrob:upper:uppertrolleydelete", function()
	DeleteObject(Trolley1)
	while DoesEntityExist(Trolley1) do
        Citizen.Wait(1)
        DeleteObject(Trolley1)
	end
	DeleteObject(Trolley2)
	while DoesEntityExist(Trolley2) do
        Citizen.Wait(1)
        DeleteObject(Trolley2)
	end
	DeleteObject(Trolley3)
	while DoesEntityExist(Trolley3) do
        Citizen.Wait(1)
        DeleteObject(Trolley3)
	end
	local obj1 = GetClosestObjectOfType(GetHashKey("ch_prop_ch_cash_trolly_01c"), 259.52, 214.08, 100.683, 1, 1, 0)
	local obj2 = GetClosestObjectOfType(GetHashKey("ch_prop_gold_trolly_01c"), 263.709, 215.525, 100.683, 1, 1, 0)
	local obj3 = GetClosestObjectOfType(GetHashKey("ch_prop_ch_cash_trolly_01c"), 262.944, 213.291, 100.683, 1, 1, 0)
	SetEntityAsMissionEntity(xd1, 1, 1)
	SetEntityAsMissionEntity(xd2, 1, 1)
	SetEntityAsMissionEntity(xd3, 1, 1)
    Citizen.Wait(0)
    DeleteObject(obj1)
	while DoesEntityExist(obj1) do
        Citizen.Wait(1)
        DeleteObject(obj1)
	end

	DeleteObject(obj2)
	while DoesEntityExist(obj2) do
        Citizen.Wait(1)
        DeleteObject(obj2)
	end

	DeleteObject(obj3)
	while DoesEntityExist(obj3) do
        Citizen.Wait(1)
        DeleteObject(obj3)
	end
end)

AddEventHandler("onResourceStop", function()
	DeleteObject(Trolley1)
	while DoesEntityExist(Trolley1) do
        Citizen.Wait(1)
        DeleteObject(Trolley1)
	end
	DeleteObject(Trolley2)
	while DoesEntityExist(Trolley2) do
        Citizen.Wait(1)
        DeleteObject(Trolley2)
	end
	DeleteObject(Trolley3)
	while DoesEntityExist(Trolley3) do
        Citizen.Wait(1)
        DeleteObject(Trolley3)
	end
	local obj1 = GetClosestObjectOfType(GetHashKey("ch_prop_ch_cash_trolly_01c"), 259.52, 214.08, 100.683, 1, 1, 0)
	local obj2 = GetClosestObjectOfType(GetHashKey("ch_prop_gold_trolly_01c"), 263.709, 215.525, 100.683, 1, 1, 0)
	local obj3 = GetClosestObjectOfType(GetHashKey("ch_prop_ch_cash_trolly_01c"), 262.944, 213.291, 100.683, 1, 1, 0)
	SetEntityAsMissionEntity(xd1, 1, 1)
	SetEntityAsMissionEntity(xd2, 1, 1)
	SetEntityAsMissionEntity(xd3, 1, 1)
    Citizen.Wait(0)
    DeleteObject(obj1)
	while DoesEntityExist(obj1) do
        Citizen.Wait(1)
        DeleteObject(obj1)
	end

	DeleteObject(obj2)
	while DoesEntityExist(obj2) do
        Citizen.Wait(1)
        DeleteObject(obj2)
	end

	DeleteObject(obj3)
	while DoesEntityExist(obj3) do
        Citizen.Wait(1)
        DeleteObject(obj3)
	end
end)

RegisterNetEvent("dark-vaultrob:upper:firsttrolley")
AddEventHandler("dark-vaultrob:upper:firsttrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local firsttrolleyvector = vector3(260.331, 214.040, 100.683) 
	if #(playercoords - firsttrolleyvector) < 5.0 then
		if not firsttrolley then
			firsttrolley = true
		Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.2, GetHashKey("ch_prop_ch_cash_trolly_01c"), false, false, false)
		local CashAppear = function()
			local pedCoords = GetEntityCoords(ped)
			local grabmodel = GetHashKey(model)

			RequestModel(grabmodel)
			while not HasModelLoaded(grabmodel) do
				Citizen.Wait(100)
			end
			local grabobj = CreateObject(grabmodel, pedCoords, true)

			FreezeEntityPosition(grabobj, true)
			SetEntityInvincible(grabobj, true)
			SetEntityNoCollisionEntity(grabobj, ped)
			SetEntityVisible(grabobj, false, false)
			AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
			local startedGrabbing = GetGameTimer()

			Citizen.CreateThread(function()
				while GetGameTimer() - startedGrabbing < 37000 do
					Citizen.Wait(1)
					DisableControlAction(0, 73, true)
					if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
						if not IsEntityVisible(grabobj) then
							SetEntityVisible(grabobj, true, false)
						end
					end
					if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
						if IsEntityVisible(grabobj) then
							SetEntityVisible(grabobj, false, false)
						end
					end
				end
				DeleteObject(grabobj)
			end)
		end
		local trollyobj = Trolley
		local emptyobj = GetHashKey("ch_prop_cash_low_trolly_01c")

		if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
			return
		end
		local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

		RequestAnimDict("anim@heists@ornate_bank@grab_cash")
		RequestModel(baghash)
		RequestModel(emptyobj)
		while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
			Citizen.Wait(100)
		end
		while not NetworkHasControlOfEntity(trollyobj) do
			Citizen.Wait(1)
			NetworkRequestControlOfEntity(trollyobj)
		end
		local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
		local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
		SetPedComponentVariation(ped, 5, 0, 0, 0)
		NetworkStartSynchronisedScene(scene1)
		Citizen.Wait(1500)
		CashAppear()
		local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
		NetworkStartSynchronisedScene(scene2)
		Citizen.Wait(37000)
		local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
		NetworkStartSynchronisedScene(scene3)
		NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
		--TriggerServerEvent("utk_fh:updateObj", name, NewTrolley, 2)
		SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
		while not NetworkHasControlOfEntity(trollyobj) do
			Citizen.Wait(1)
			NetworkRequestControlOfEntity(trollyobj)
		end
		DeleteObject(trollyobj)
		while DoesEntityExist(Trolley) do
            Citizen.Wait(1)
            DeleteObject(Trolley)
        end
		PlaceObjectOnGroundProperly(NewTrolley)
		Citizen.Wait(1800)
		DeleteObject(bag)
		SetPedComponentVariation(ped, 5, 45, 0, 0)
		RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
		SetModelAsNoLongerNeeded(emptyobj)
		SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
		disableinput = false
		firsttrolley = true
		local myluck = math.random(2)
		if myluck == 1 then
		TriggerEvent('player:receiveItem', 'markedbills', randommoney)
		elseif myluck == 2 then
		TriggerEvent('player:receiveItem', 'heistusb3', randommoney)
	else
		TriggerEvent("notification", "Already grabbed!", 2)
	end
	end
	end
end)

RegisterNetEvent("dark-vaultrob:upper:secondtrolley")
AddEventHandler("dark-vaultrob:upper:secondtrolley", function()
		disableinput = true
		local ped = PlayerPedId()
		local model = "hei_prop_heist_gold_bar"
		local playercoords = GetEntityCoords(ped)
		local secondtrolley = vector3(263.709, 215.525, 100.683) 
		if #(playercoords - secondtrolley) < 2.5 then
			if not sectrolley then
			Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.2, GetHashKey("ch_prop_gold_trolly_01c"), false, false, false)
			local CashAppear = function()
				local pedCoords = GetEntityCoords(ped)
				local grabmodel = GetHashKey(model)
	
				RequestModel(grabmodel)
				while not HasModelLoaded(grabmodel) do
					Citizen.Wait(100)
				end
				local grabobj = CreateObject(grabmodel, pedCoords, true)
	
				FreezeEntityPosition(grabobj, true)
				SetEntityInvincible(grabobj, true)
				SetEntityNoCollisionEntity(grabobj, ped)
				SetEntityVisible(grabobj, false, false)
				AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
				local startedGrabbing = GetGameTimer()
	
				Citizen.CreateThread(function()
					while GetGameTimer() - startedGrabbing < 37000 do
						Citizen.Wait(1)
						DisableControlAction(0, 73, true)
						if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
							if not IsEntityVisible(grabobj) then
								SetEntityVisible(grabobj, true, false)
							end
						end
						if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
							if IsEntityVisible(grabobj) then
								SetEntityVisible(grabobj, false, false)
							end
						end
					end
					DeleteObject(grabobj)
				end)
			end
			local trollyobj = Trolley
			local emptyobj = GetHashKey("ch_prop_cash_low_trolly_01c")
	
			if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
				return
			end
			local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")
	
			RequestAnimDict("anim@heists@ornate_bank@grab_cash")
			RequestModel(baghash)
			RequestModel(emptyobj)
			while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
				Citizen.Wait(100)
			end
			while not NetworkHasControlOfEntity(trollyobj) do
				Citizen.Wait(1)
				NetworkRequestControlOfEntity(trollyobj)
			end
			local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
			local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	
			NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
			SetPedComponentVariation(ped, 5, 0, 0, 0)
			NetworkStartSynchronisedScene(scene1)
			Citizen.Wait(1500)
			CashAppear()
			local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	
			NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
			NetworkStartSynchronisedScene(scene2)
			Citizen.Wait(37000)
			local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	
			NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
			NetworkStartSynchronisedScene(scene3)
			NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
			SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
			while not NetworkHasControlOfEntity(trollyobj) do
				Citizen.Wait(1)
				NetworkRequestControlOfEntity(trollyobj)
			end
			DeleteObject(trollyobj)
			while DoesEntityExist(Trolley) do
				Citizen.Wait(1)
				DeleteObject(Trolley)
			end
			PlaceObjectOnGroundProperly(NewTrolley)
			Citizen.Wait(1800)
			DeleteObject(bag)
			SetPedComponentVariation(ped, 5, 45, 0, 0)
			RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
			SetModelAsNoLongerNeeded(emptyobj)
			SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
			disableinput = false
			sectrolley = true
			TriggerEvent('player:receiveItem', 'goldbar', randomgold) 
		else 
			TriggerEvent("notification","Already grabbed!",2)
		end
	end
	end)

RegisterNetEvent("dark-vaultrob:upper:thirdtrolley")
AddEventHandler("dark-vaultrob:upper:thirdtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local thirdtrolleyvec = vector3(262.944, 213.291, 100.683) 
	if #(playercoords - thirdtrolleyvec) < 3.0 then
		if not thirdtrolley then
		Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.2, GetHashKey("ch_prop_ch_cash_trolly_01c"), false, false, false)
		local CashAppear = function()
			local pedCoords = GetEntityCoords(ped)
			local grabmodel = GetHashKey(model)

			RequestModel(grabmodel)
			while not HasModelLoaded(grabmodel) do
				Citizen.Wait(100)
			end
			local grabobj = CreateObject(grabmodel, pedCoords, true)

			FreezeEntityPosition(grabobj, true)
			SetEntityInvincible(grabobj, true)
			SetEntityNoCollisionEntity(grabobj, ped)
			SetEntityVisible(grabobj, false, false)
			AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
			local startedGrabbing = GetGameTimer()

			Citizen.CreateThread(function()
				while GetGameTimer() - startedGrabbing < 37000 do
					Citizen.Wait(1)
					DisableControlAction(0, 73, true)
					if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
						if not IsEntityVisible(grabobj) then
							SetEntityVisible(grabobj, true, false)
						end
					end
					if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
						if IsEntityVisible(grabobj) then
							SetEntityVisible(grabobj, false, false)
						end
					end
				end
				DeleteObject(grabobj)
			end)
		end
		local trollyobj = Trolley
		local emptyobj = GetHashKey("ch_prop_cash_low_trolly_01c")

		if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
			return
		end
		local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

		RequestAnimDict("anim@heists@ornate_bank@grab_cash")
		RequestModel(baghash)
		RequestModel(emptyobj)
		while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
			Citizen.Wait(100)
		end
		while not NetworkHasControlOfEntity(trollyobj) do
			Citizen.Wait(1)
			NetworkRequestControlOfEntity(trollyobj)
		end
		local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
		local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
		SetPedComponentVariation(ped, 5, 0, 0, 0)
		NetworkStartSynchronisedScene(scene1)
		Citizen.Wait(1500)
		CashAppear()
		local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
		NetworkStartSynchronisedScene(scene2)
		Citizen.Wait(37000)
		local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

		NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
		NetworkStartSynchronisedScene(scene3)
		NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
		SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
		while not NetworkHasControlOfEntity(trollyobj) do
			Citizen.Wait(1)
			NetworkRequestControlOfEntity(trollyobj)
		end
		while DoesEntityExist(Trolley) do
            Citizen.Wait(1)
            DeleteObject(Trolley)
        end
		DeleteObject(trollyobj)
		PlaceObjectOnGroundProperly(NewTrolley)
		Citizen.Wait(1800)
		DeleteObject(bag)
		SetPedComponentVariation(ped, 5, 45, 0, 0)
		RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
		SetModelAsNoLongerNeeded(emptyobj)
		SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
		disableinput = false
		thirdtrolley = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else 
		TriggerEvent("notification", "Already grabed!", 2)
	end
end
end)