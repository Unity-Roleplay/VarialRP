--[[ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)]]

local firstdoorshmm = false
local secdoorshmm = false
local thirddoor = false
local fourthdoor = false

RegisterNetEvent("dark-vaultrob:upper:ptfxparticle")
AddEventHandler("dark-vaultrob:upper:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(257.511, 221.30, 106.284)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("dark-vaultrob:upper:ptfxparticlesec")
AddEventHandler("dark-vaultrob:upper:ptfxparticlesec", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(253.000, 221.653, 101.683)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("dark-vaultrob:upper:vault")
AddEventHandler("dark-vaultrob:upper:vault", function(method)
	local PlayerPos = GetEntityCoords(PlayerPedId())
	local obj = GetClosestObjectOfType(PlayerPos.x, PlayerPos.y, PlayerPos.z, 10.0, GetHashKey("v_ilev_bk_vaultdoor"), false, false, false)
    local count = 0

    if method == 1 then
        repeat
	        local rotation = GetEntityHeading(obj) - 0.05

            SetEntityHeading(obj, rotation)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    else
        repeat
	        local rotation = GetEntityHeading(obj) + 0.05

            SetEntityHeading(obj, rotation)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    end
    FreezeEntityPosition(obj, true)
end)

RegisterNetEvent("dark-vaultrob:upper:vaultsound")
AddEventHandler("dark-vaultrob:upper:vaultsound", function()
    local plyCoords = GetEntityCoords(PlayerPedId())
    local x,y,z = 253.581, 225.167, 101.876
    local count = 0
    if GetDistanceBetweenCoords(plyCoords.x,plyCoords.y,plyCoords.z,x,y,z ,false) <= 10 then
        repeat
            PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" , 1)
            Citizen.Wait(900)
            count = count + 1
        until count == 17
    end
end)
	
RegisterNetEvent("dark-vaultrob:upper:openvault_c")
AddEventHandler("dark-vaultrob:upper:openvault_c", function(method)
    TriggerEvent("dark-vaultrob:upper:vault", method)
    TriggerEvent("dark-vaultrob:upper:vaultsound")
end)

function animcancel1()
	local animDict = "anim@heists@ornate_bank@hack"
	RequestAnimDict(animDict)
	RequestModel("hei_prop_hst_laptop")
	RequestModel("hei_p_m_bag_var22_arm_s")
	RequestModel("hei_prop_heist_card_hack_02")
	while not HasAnimDictLoaded(animDict)
		or not HasModelLoaded("hei_prop_hst_laptop")
		or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
		or not HasModelLoaded("hei_prop_heist_card_hack_02") do
		Citizen.Wait(100)
	end
	local ped = PlayerPedId()
	local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
	local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 262.875, 222.976, 105.980, 262.875, 222.976, 105.980, 0, 2)
	local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)
	--SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(netScene3)
	Citizen.Wait(4600)
	NetworkStopSynchronisedScene(netScene3)
	DeleteObject(laptop)
	--FreezeEntityPosition(ped, false)
	--SetPedComponentVariation(ped, 5, 45, 0, 0)
end

local disableinput = false

function DisableControl()
DisableControlAction(0, 73, false) 
DisableControlAction(0, 24, true) 
DisableControlAction(0, 257, true) 
DisableControlAction(0, 25, true)
DisableControlAction(0, 263, true) 
DisableControlAction(0, 32, true) 
DisableControlAction(0, 34, true) 
DisableControlAction(0, 31, true) 
DisableControlAction(0, 30, true) 
DisableControlAction(0, 45, true) 
DisableControlAction(0, 22, true) 
DisableControlAction(0, 44, true) 
DisableControlAction(0, 37, true) 
DisableControlAction(0, 23, true) 
DisableControlAction(0, 288, true)
DisableControlAction(0, 289, true) 
DisableControlAction(0, 170, true) 
DisableControlAction(0, 167, true) 
DisableControlAction(0, 73, true) 
DisableControlAction(2, 199, true) 
DisableControlAction(0, 47, true) 
DisableControlAction(0, 264, true) 
DisableControlAction(0, 257, true)
DisableControlAction(0, 140, true) 
DisableControlAction(0, 141, true) 
DisableControlAction(0, 142, true) 
DisableControlAction(0, 143, true) 
end

Citizen.CreateThread(function()
	if disableinput then
		DisableControl()
	else
		Citizen.Wait(500)
	end
end)

RegisterNetEvent('dark-vaultrob:upper:heistlaptop4')
AddEventHandler('dark-vaultrob:upper:heistlaptop4', function()
	local ped = PlayerPedId()
    local playercoords = GetEntityCoords(ped)
	local seconddoorlocs = vector3(261.943, 223.131, 106.284)
	local thirddoorvector = vector3(253.257, 228.383, 101.683)
	if #(playercoords - seconddoorlocs) < 4.0 then
	if not secdoorshmm then
		if firstdoorshmm then
		if exports["np-inventory"]:hasEnoughOfItem("heistlaptop4", 1) and exports["np-inventory"]:hasEnoughOfItem("heistusb2", 1)  then
		TaskGoStraightToCoord(PlayerPedId(), 261.609, 223.283, 106.284, 1.0, -1, 248.95, 0.0)
		Citizen.Wait(2500)
		local ped = PlayerPedId()
		SetEntityHeading(ped, -90.00)
	
		local animDict = "anim@heists@ornate_bank@hack"
		RequestAnimDict(animDict)
		RequestModel("hei_prop_hst_laptop")
		RequestModel("hei_p_m_bag_var22_arm_s")
		RequestModel("hei_prop_heist_card_hack_02")
		while not HasAnimDictLoaded(animDict)
			or not HasModelLoaded("hei_prop_hst_laptop")
			or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
			or not HasModelLoaded("hei_prop_heist_card_hack_02") do
			Citizen.Wait(100)
		end
		local ped = PlayerPedId()
		local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
	
		local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", 262.875, 222.976, 105.980, 262.875, 222.976, 105.980, 0, 2)
		local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", 262.875, 222.976, 105.980, 262.875, 222.976, 105.980, 0, 2)
		local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 262.875, 222.976, 105.980, 262.875, 222.976, 105.980, 0, 2)
	
		--FreezeEntityPosition(ped, true)
		local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
		-- SetEntityCoords(ped, 262.011, 223.212, 106.284, 1, 0, 0, 1)
		-- local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
		NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
	
		local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
		NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
		NetworkAddEntityToSynchronisedScene(netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)
		Citizen.Wait(200)
		NetworkStartSynchronisedScene(netScene)
		Citizen.Wait(6300)
		NetworkStartSynchronisedScene(netScene2)
		Citizen.Wait(2000)
		exports['hacking']:OpenHackingGame(function(Success)
            if Success then
				VaultPDNoti()
				animcancel1()
				TriggerServerEvent("np-doors:change-lock-state", 48)
				secdoorshmm = true
				local deleternd = math.random(1,100)
				if deleternd <= 100 and deleternd > 20 then
					TriggerEvent('inventory:removeItem', 'heistusb2', 1)
				end
			else
				animcancel1()
				secdoorshmm = false
				local deleternd = math.random(1,100)
				if deleternd <= 100 and deleternd > 20 then
					TriggerEvent('inventory:removeItem', 'heistusb2', 1)
				end
			end 
		end)
 	else
 		TriggerEvent("notification", "Something is missing!", 2)
 	end
end
else
	TriggerEvent("notification", "Already opened!", 2)
end
elseif #(playercoords - thirddoorvector) < 3.0 then
	if not thirddoor then
		if secdoorshmm then
	TaskGoStraightToCoord(PlayerPedId(), 253.447, 228.289, 101.683, 1.0, -1, 69.15, 0.0)
	Citizen.Wait(5000)
	local ped = PlayerPedId()
	-- SetEntityCoords(ped, 253.123, 228.336, 101.683, 1, 0, 0, 1)
	-- SetEntityHeading(ped, -90.00)
	
	local animDict = "anim@heists@ornate_bank@hack"
	RequestAnimDict(animDict)
	RequestModel("hei_prop_hst_laptop")
	RequestModel("hei_p_m_bag_var22_arm_s")
	RequestModel("hei_prop_heist_card_hack_02")
	while not HasAnimDictLoaded(animDict)
		or not HasModelLoaded("hei_prop_hst_laptop")
		or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
		or not HasModelLoaded("hei_prop_heist_card_hack_02") do
		Citizen.Wait(100)
	end
	local ped = PlayerPedId()
	local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))

	local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", 253.300, 228.336, 101.450, 253.300, 228.336, 101.450, 0, 2)
	local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", 253.300, 228.336, 101.450, 253.300, 228.336, 101.450, 0, 2)
	local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 253.300, 228.336, 101.450, 253.300, 228.336, 101.450, 0, 2)

	--FreezeEntityPosition(ped, true)
	local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
	-- SetEntityCoords(ped, 262.011, 223.212, 106.284, 1, 0, 0, 1)
	-- local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
	NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

	local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)
	Citizen.Wait(200)
	NetworkStartSynchronisedScene(netScene)
	Citizen.Wait(6300)
	NetworkStartSynchronisedScene(netScene2)
	Citizen.Wait(2000)
	-- SetEntityCoords(PlayerPedId(), 253.257, 228.383, 101.683)
	exports['hacking']:OpenHackingGame(function(Success)
		if Success then
			local ped = PlayerPedId()
			TriggerEvent('inventory:removeItem', 'heistlaptop4', 1)
			-- SetEntityCoords(ped, 253.123, 228.336, 101.683, 1, 0, 0, 1)
			-- SetEntityHeading(ped, -90.00)
			
			local animDict = "anim@heists@ornate_bank@hack"
			RequestAnimDict(animDict)
			RequestModel("hei_prop_hst_laptop")
			RequestModel("hei_p_m_bag_var22_arm_s")
			RequestModel("hei_prop_heist_card_hack_02")
			while not HasAnimDictLoaded(animDict)
				or not HasModelLoaded("hei_prop_hst_laptop")
				or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
				or not HasModelLoaded("hei_prop_heist_card_hack_02") do
				Citizen.Wait(100)
			end
			local ped = PlayerPedId()
			local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
		
			local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 253.300, 228.336, 101.450, 253.300, 228.336, 101.450, 0, 2)
		
			local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)
		--	SetPedComponentVariation(ped, 5, 0, 0, 0)
			NetworkStartSynchronisedScene(netScene3)
			Citizen.Wait(4600)
			NetworkStopSynchronisedScene(netScene3)
			DeleteObject(laptop)
		--	SetPedComponentVariation(ped, 5, 45, 0, 0)
			TriggerServerEvent("dark-vaultrob:upper:openvault", 1)
			VaultPDNoti()
			SpawnTrolleys()
			thirddoor = true
		else
			local ped = PlayerPedId()
			-- SetEntityCoords(ped, 253.123, 228.336, 101.683, 1, 0, 0, 1)
			-- SetEntityHeading(ped, -90.00)
			
			local animDict = "anim@heists@ornate_bank@hack"
			RequestAnimDict(animDict)
			RequestModel("hei_prop_hst_laptop")
			RequestModel("hei_p_m_bag_var22_arm_s")
			RequestModel("hei_prop_heist_card_hack_02")
			while not HasAnimDictLoaded(animDict)
				or not HasModelLoaded("hei_prop_hst_laptop")
				or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
				or not HasModelLoaded("hei_prop_heist_card_hack_02") do
				Citizen.Wait(100)
			end
			local ped = PlayerPedId()
			local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
		
			local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 253.300, 228.336, 101.450, 253.300, 228.336, 101.450, 0, 2)
		
			local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)
		--	SetPedComponentVariation(ped, 5, 0, 0, 0)
			NetworkStartSynchronisedScene(netScene3)
			Citizen.Wait(4600)
			NetworkStopSynchronisedScene(netScene3)
			DeleteObject(laptop)
	--		SetPedComponentVariation(ped, 5, 45, 0, 0)
			thirddoor = false
			TriggerServerEvent("np-doors:change-lock-state", 51)
		end
	end)
else
	TriggerServerEvent("notification","Something is missing!", 2)
end
else
	TriggerServerEvent("notification","Are you blind the door is already open!", 2)
end
end
end)

local fifthdoor = false
RegisterNetEvent('dark-vaultrob:upper:thermitedoors')
AddEventHandler('dark-vaultrob:upper:thermitedoors', function()
	local ped = PlayerPedId()
    local playercoords = GetEntityCoords(ped)
	local playercoords2 = GetEntityCoords(ped)
	local playercoords3 = GetEntityCoords(ped)
	local firstdoorvector = vector3(257.258, 220.184, 106.284)
	local fourthdoorvector = vector3(252.963, 221.078, 101.683)
	local fifthdoorvector = vector3(261.408, 215.673, 101.683)
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
	RequestModel("hei_p_m_bag_var22_arm_s")
	RequestNamedPtfxAsset("scr_ornate_heist")
	while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
		Citizen.Wait(50)
	end
	if not HasNamedPtfxAssetLoaded("scr_ornate_heist") then
		RequestNamedPtfxAsset("scr_ornate_heist")
		while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
			Wait(1)
		end
	end
    
	if not fifthdoor and #(playercoords - fifthdoorvector) < 3.0  then
		TaskGoStraightToCoord(PlayerPedId(), 261.176, 215.768, 101.683, 1.0, -1, 247.98, 0.0)
		Citizen.Wait(4000)
		exports["np-memory"]:thermiteminigame(8, 3, 3, 10,
		function() -- success
			
			local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
			local bagscene = NetworkCreateSynchronisedScene(261.600, 215.590, 101.683, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
			local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 261.600, 215.590, 101.683,  true,  true, false)
	
			SetEntityCollision(bag, false, true)
			NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
		--	SetPedComponentVariation(ped, 5, 0, 0, 0)
			NetworkStartSynchronisedScene(bagscene)
			Citizen.Wait(1500)
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)
	
			SetEntityCollision(bomba, false, true)
			AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
			Citizen.Wait(2000)
			DeleteObject(bag)
		--	SetPedComponentVariation(ped, 5, 45, 0, 0)
			DetachEntity(bomba, 1, 1)
			FreezeEntityPosition(bomba, true)
			TriggerServerEvent("dark-vaultrob:upper:particleserverthird", method)
			SetPtfxAssetNextCall("scr_ornate_heist")
			local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", 261.748, 216.500, 101.683, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
			
			NetworkStopSynchronisedScene(bagscene)
			TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
			TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
			Citizen.Wait(10000)
			ClearPedTasks(ped)
			DeleteObject(bomba)
			DeleteObject(bag)
			StopParticleFxLooped(effect, 0)
			Citizen.Wait(2000)
			TriggerServerEvent("np-doors:change-lock-state", 50)
			fifthdoor = true
			local deleternd = math.random(1,100)
			if deleternd <= 100 and deleternd > 20 then
				TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
			end
		end,
		function() -- failure
			fifthdoor = false
		end)
    elseif #(playercoords2 - firstdoorvector) < 3.0 then
		if not firstdoorshmm then
		if exports["isPed"]:isPed("countpolice") >= 1 then
		if exports["np-inventory"]:hasEnoughOfItem("thermitecharge", 1) then
		TaskGoStraightToCoord(PlayerPedId(), 257.156, 219.600, 106.286, 1.0, -1, 337.84, 0.0)
		Citizen.Wait(4500)
		exports["np-memory"]:thermiteminigame(8, 3, 3, 10,
		function() -- success
			-- SetEntityHeading(ped, 180.52)
			local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
			local bagscene = NetworkCreateSynchronisedScene(257.515, 220.164, 106.284, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
			local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 257.515, 220.164, 106.284,  true,  true, false)
	
			SetEntityCollision(bag, false, true)
			NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
	--		SetPedComponentVariation(ped, 5, 0, 0, 0)
			NetworkStartSynchronisedScene(bagscene)
			Citizen.Wait(1500)
			local x, y, z = table.unpack(GetEntityCoords(ped))
			local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)
	
			SetEntityCollision(bomba, false, true)
			AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
			Citizen.Wait(2000)
			DeleteObject(bag)
		--	SetPedComponentVariation(ped, 5, 45, 0, 0)
			DetachEntity(bomba, 1, 1)
			FreezeEntityPosition(bomba, true)
			TriggerServerEvent("dark-vaultrob:upper:particleserver", method)
			SetPtfxAssetNextCall("scr_ornate_heist")
			local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", 257.511, 221.387, 106.284, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
			
			NetworkStopSynchronisedScene(bagscene)
			TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
			TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
			Citizen.Wait(10000)
			ClearPedTasks(ped)
			DeleteObject(bomba)
			StopParticleFxLooped(effect, 0)
			Citizen.Wait(2000)
			TriggerServerEvent("np-doors:change-lock-state", 46)
			firstdoorshmm = true
			local deleternd = math.random(1,100)
			if deleternd <= 100 and deleternd > 20 then
				TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
			end
			Wait(12000000)
			TriggerEvent("dark:VAULTDOOR_REFRESH_GUY")
		end,
		function() -- failure
			firstdoorshmm = false
			local deleternd = math.random(1,100)
			if deleternd <= 100 and deleternd > 20 then
				TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
			end
		end)
	else
		TriggerEvent("notification","Something is missing!",2)
	end
else
	TriggerEvent("notification", "Already Opened!", 2)
	end
end
elseif  not fourthdoor and #(playercoords3 - fourthdoorvector) < 3.0  then
	TaskGoStraightToCoord(PlayerPedId(), 252.963, 221.078, 101.683, 1.0, -1, 161.91, 0.0)
	Citizen.Wait(4000)
	exports["np-memory"]:thermiteminigame(8, 3, 3, 10,
	function() -- success
		
		-- SetEntityCoords(PlayerPedId(), 253.050, 221.086, 101.683)
		SetEntityHeading(ped, 180.00)
		local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
		local bagscene = NetworkCreateSynchronisedScene(252.970, 220.700, 101.683, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
		local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 252.970, 220.700, 101.683,  true,  true, false)

		SetEntityCollision(bag, false, true)
		NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
		NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
	--	SetPedComponentVariation(ped, 5, 0, 0, 0)
		NetworkStartSynchronisedScene(bagscene)
		Citizen.Wait(1500)
		local x, y, z = table.unpack(GetEntityCoords(ped))
		local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

		SetEntityCollision(bomba, false, true)
		AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
		Citizen.Wait(2000)
		DeleteObject(bag)
	--	SetPedComponentVariation(ped, 5, 45, 0, 0)
		DetachEntity(bomba, 1, 1)
		FreezeEntityPosition(bomba, true)
		TriggerServerEvent("dark-vaultrob:upper:particleserversec", method)
		SetPtfxAssetNextCall("scr_ornate_heist")
		local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", 253.000, 221.653, 101.683, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		
		NetworkStopSynchronisedScene(bagscene)
		TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
		TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
		Citizen.Wait(10000)
		ClearPedTasks(ped)
		DeleteObject(bomba)
		StopParticleFxLooped(effect, 0)
		Citizen.Wait(2000)
		TriggerServerEvent("np-doors:change-lock-state", 49)
		thirddoor = true
		local deleternd = math.random(1,100)
		if deleternd <= 100 and deleternd > 20 then
			TriggerEvent('inventory:removeItem', 'thermitecharge', 1)
		end
	end,
	function() -- failure
		thirddoor = false
	end)
end
end)

RegisterNetEvent("dark-vaultrob:upper:ptfxparticlethird")
AddEventHandler("dark-vaultrob:upper:ptfxparticlethird", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(261.748, 216.586, 101.683)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("dark:VAULTDOOR_REFRESH_GUY")
AddEventHandler("dark:VAULTDOOR_REFRESH_GUY", function(method)
if firstdoorshmm then
	firstdoorshmm = false
	TriggerServerEvent("np-doors:change-lock-state", 46)
end
if secdoorshmm then
	secdoorshmm = false
	TriggerServerEvent("np-doors:change-lock-state", 48)
	TriggerServerEvent("dark-vaultrob:upper:openvault", 0)
end
if thirddoor then
	thirddoor = false
	TriggerServerEvent("np-doors:change-lock-state", 51)
	TriggerEvent("dark-vaultrob:upper:uppertrolleydelete")
	local firsttrolley = false
    local sectrolley = false
    local thirdtrolley = false
end
if fourthdoor then
	fourthdoor = false
	TriggerServerEvent("np-doors:change-lock-state", 49)
end
if fifthdoor then
	fifthdoor = false
	TriggerServerEvent("np-doors:change-lock-state", 50)
end
end)

RegisterCommand('vaultsecure', function()
	TriggerEvent("dark:VAULTDOOR_REFRESH_GUY")
	TriggerEvent("dark-sikis:LOWERVAULT_REFRESH")
end)


exports["np-polyzone"]:AddBoxZone("reset_vault", vector3(259.57, 218.14, 106.29), 1, 1, {
	heading=0
})

function VaultPDNoti()
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)

  
    local dispatchCode = "10-90A"

  
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = dispatchCode,
      firstStreet = street1,
      gender = gender,

      isImportant = true,
          priority = 3,
      dispatchMessage = "Robbery In Progress At The Vault",
      recipientList = {
        police = "police"
      },
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
  
    TriggerEvent('np-dispatch:DispatchVaultAlert')
--        Wait(math.random(5000,15000))

  end



function GetStreetAndZone()
local plyPos = GetEntityCoords(PlayerPedId(),  true)
local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
local playerStreetsLocation = GetLabelText(zone)
local street = street1 .. ", " .. playerStreetsLocation
return street
end

function LVaultNotfi()
    local street1 = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local plyPos = GetEntityCoords(PlayerPedId(), true)

  
    local dispatchCode = "10-90A"

  
    TriggerServerEvent('dispatch:svNotify', {
      dispatchCode = dispatchCode,
      firstStreet = street1,
      gender = gender,

      isImportant = true,
          priority = 3,
      dispatchMessage = "Robbery In Progress Lower Vault",
      recipientList = {
        police = "police"
      },
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
  
    TriggerEvent('np-dispatch:DispatchVaultAlert')
--        Wait(math.random(5000,15000))

  end



function GetStreetAndZone()
local plyPos = GetEntityCoords(PlayerPedId(),  true)
local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
local street1 = GetStreetNameFromHashKey(s1)
local street2 = GetStreetNameFromHashKey(s2)
zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
local playerStreetsLocation = GetLabelText(zone)
local street = street1 .. ", " .. playerStreetsLocation
return street
end
