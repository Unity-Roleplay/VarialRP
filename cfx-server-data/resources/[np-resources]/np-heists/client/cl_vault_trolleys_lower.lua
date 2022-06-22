
    --  LowerTrolley1 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 309.44, 223.56, 96.73, 1, 1, 0)
    --  LowerTrolley2 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 306.14, 219.41, 96.73, 1, 1, 0)
 	--  LowerTrolley3 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 292.93, 218.6, 96.73, 1, 1, 0)
    --   LowerTrolley4 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 299.32, 217.47, 96.73, 1, 1, 0)
    --   LowerTrolley5 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 299.80, 228.1, 96.75, 1, 1, 0)
    --   LowerTrolley6 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 302.41, 209.97, 96.73, 1, 1, 0)


    local firsttrolleylower = false
local sectrolleylower = false
local thirddlowertrolley = false
local fourthtrolleylower = false
local fifthtrolleylower = false
local sixthtrolleylower = false
local trolleyleryerinemi = false
local sextrolley = false
local randommoney = math.random(75,250)
local randomgold = math.random(7,31)

function SpawnLwTrolleys(data, name)
	if not trolleyleryerinemi then
		trolleyleryerinemi = true
   RequestModel("ch_prop_ch_cash_trolly_01c")
   while not HasModelLoaded("ch_prop_ch_cash_trolly_01c") do
       Citizen.Wait(1)
   end
  RequestModel("ch_prop_gold_trolly_01c")
   while not HasModelLoaded("ch_prop_gold_trolly_01c") do
       Citizen.Wait(1)
   end
   Trolley1 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 309.44, 223.56, 96.73, 1, 1, 0)
   Trolley2 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 306.14, 219.41, 96.73, 1, 1, 0)
  Trolley3 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 292.93, 218.6, 96.73, 1, 1, 0)
  Trolley4 = CreateObject(GetHashKey("ch_prop_gold_trolly_01c"), 299.32, 217.47, 96.73, 1, 1, 0)
  Trolley5 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 299.80, 228.1, 96.70, 1, 1, 0)
  Trolley6 = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), 302.41, 209.97, 96.73, 1, 1, 0)
   local h1 = GetEntityHeading(Trolley1)
   local h2 = GetEntityHeading(Trolley2)
   local h3 = GetEntityHeading(Trolley3)
   local h4 = GetEntityHeading(Trolley4)
   local h5 = GetEntityHeading(Trolley5)
   local h6 = GetEntityHeading(Trolley6)
   SetEntityHeading(Trolley1, 43.26)
  SetEntityHeading(Trolley2, 90.00)
  SetEntityHeading(Trolley3, 281.3)
  SetEntityHeading(Trolley4, 181.46)
  SetEntityHeading(Trolley5, 265.14)
  SetEntityHeading(Trolley6, 220.34)
  --local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 20.0)
  local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
  local missionplayers = {}
  local ply = PlayerId()

 for i = 1, #closePlayers, 1 do
	if closePlayers[i] ~= ply then
		table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
       end
  end
   done = false
end
end

function GetClosestPlayers(targetVector,dist)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local plyCoords = targetVector
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
			if(distance < dist) then
				valueID = GetPlayerServerId(value)
				closestplayers[#closestplayers+1]= valueID
				closestdistance[#closestdistance+1]= distance
				closestcoords[#closestcoords+1]= {targetCoords["x"], targetCoords["y"], targetCoords["z"]}

			end
		end
	end
	return closestplayers, closestdistance, closestcoords
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+10]= i
        end
    end

    return players
end


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
	DeleteObject(Trolley4)
	while DoesEntityExist(Trolley4) do
        Citizen.Wait(1)
        DeleteObject(Trolley4)
	end

	DeleteObject(Trolley5)
	while DoesEntityExist(Trolley5) do
        Citizen.Wait(1)
        DeleteObject(Trolley5)
	end

	DeleteObject(Trolley6)
	while DoesEntityExist(Trolley6) do
        Citizen.Wait(1)
        DeleteObject(Trolley6)
	end
end)

RegisterNetEvent("dark-vaultrob:lower:firsttrolley")
AddEventHandler("dark-vaultrob:lower:firsttrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local firsttrolleylowervector = vector3(309.44, 223.56, 96.73) 
	if #(playercoords - firsttrolleylowervector) < 5.0 then
		if not firsttrolleylower then
			firsttrolleylower = true
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
		firsttrolleylower = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else
		TriggerEvent("notification","Already grabbed!",2)
	end
	end
end)

RegisterNetEvent("dark-vaultrob:lower:seclwtrolley")
AddEventHandler("dark-vaultrob:lower:seclwtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local sectrolleylowervector = vector3(299.80, 228.1, 96.75) 
	if #(playercoords - sectrolleylowervector) < 5.0 then
		if not sectrolleylower then
			sectrolleylower = true
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
		sectrolleylower = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else
		TriggerEvent("notification", "Already grabed!", 2)
	end
	end
end)

RegisterNetEvent("dark-vaultrob:lower:thirdlwtrolley")
AddEventHandler("dark-vaultrob:lower:thirdlwtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_gold_bar"
	local playercoords = GetEntityCoords(ped)
	local thirddlowertrolleyvec = vector3(306.14, 219.41, 96.73) 
	if #(playercoords - thirddlowertrolleyvec) < 2.0 then
   if not thirddlowertrolley then
      thirddlowertrolley = true
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
		thirddlowertrolley = true
		TriggerEvent('player:receiveItem', 'goldbar', randomgold) 
	else 
		TriggerEvent("notification","Already grabbed!",2)
	end
end
end)

RegisterNetEvent("dark-vaultrob:lower:sextrolley")
AddEventHandler("dark-vaultrob:lower:sextrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_gold_bar"
	local playercoords = GetEntityCoords(ped)
	local sextrolleyvec = vector3(299.32, 217.47, 96.73) 
	if #(playercoords - sextrolleyvec) < 2.0 then
   if not sextrolley then
      sextrolley = true
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
		sextrolley = true
		TriggerEvent('player:receiveItem', 'goldbar', randomgold) 
	else 
		TriggerEvent("notification","Already grabbed!",2)
	end
end
end)

RegisterNetEvent("dark-vaultrob:lower:fourthlwtrolley")
AddEventHandler("dark-vaultrob:lower:fourthlwtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local fourthlwtrolleyvector = vector3(292.93, 218.6, 96.73) 
	if #(playercoords - fourthlwtrolleyvector) < 5.0 then
		if not fourthlwtrolleylower then
			fourthlwtrolleylower = true
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
		fourthlwtrolleylower = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else
		TriggerEvent("notification","Already grabbed!",2)
	end
	end
end)

RegisterNetEvent("dark-vaultrob:lower:fifthlwtrolley")
AddEventHandler("dark-vaultrob:lower:fifthlwtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local fifthlwtrolleylowervector = vector3(299.80, 228.1, 96.70) 
	if #(playercoords - fifthlwtrolleylowervector) < 5.0 then
		if not fifthlwtrolleylower then
			fifthlwtrolleylower = true
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
		fifthlwtrolleylower = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else
		TriggerEvent("notification","Already grabbed!",2)
	end
	end
end)

RegisterNetEvent("dark-vaultrob:lower:sixthlwtrolley")
AddEventHandler("dark-vaultrob:lower:sixthlwtrolley", function()
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"
	local playercoords = GetEntityCoords(ped)
	local sixthlwtrolleylowervector = vector3(302.41, 209.97, 96.73) 
	if #(playercoords - sixthlwtrolleylowervector) < 5.0 then
		if not sixthlwtrolley then
			sixthlwtrolley = true
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
		sixthlwtrolley = true
		TriggerEvent('player:receiveItem', 'markedbills', randommoney) 
	else
		TriggerEvent("notification","Already grabbed!",2)
	end
	end
end)