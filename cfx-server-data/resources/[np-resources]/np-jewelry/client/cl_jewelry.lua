local thisisok = false
local notsmashed1 = true
local notsmashed2 = true
local notsmashed3 = true
local notsmashed4 = true
local notsmashed5 = true
local notsmashed6 = true
local notsmashed7 = true
local notsmashed8 = true
local notsmashed9 = true
local notsmashed10 = true
local notsmashed11 = true
local notsmashed12 = true
local notsmashed13 = true

local weaponTypes = {
    ["3337201093"] = { "SMG", ["slot"] = 3 },
    ["970310034"] = { "AssaultRifle", ["slot"] = 4 },
    ["-957766203"] = { "AssaultRifle", ["slot"] = 4 },
    ["1159398588"] = { "MG", ["slot"] = 4 },
    ["860033945"] = { "Shotgun", ["slot"] = 3 },
    ["3082541095"] = { "Sniper", ["slot"] = 3 },
    ["2725924767"] = { "Heavy", ["slot"] = 4 },
}
local _,wep = GetCurrentPedWeapon(playerPed)

RegisterNetEvent("dark-jewelry:jewelry:triggerItemUsed")
AddEventHandler("dark-jewelry:jewelry:triggerItemUsed", function(itemID,activePolice)
    print(itemID)
    attemptToRob(itemID,activePolice)
end)


Citizen.CreateThread(function()
    Dealer = AddBlipForCoord(-626.5326, -238.3758, 38.05)

    SetBlipSprite (Dealer, 617)
    SetBlipDisplay(Dealer, 4)
    SetBlipScale  (Dealer, 0.7)
    SetBlipAsShortRange(Dealer, true)
    SetBlipColour(Dealer, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Vangelico ")
    EndTextCommandSetBlipName(Dealer)
end)

function weaponTypeC()
	local w = GetSelectedPedWeapon(PlayerPedId())
	local wg = GetWeapontypeGroup(w)
	if weaponTypes[""..wg..""] then
		return weaponTypes[""..wg..""]["slot"]
	else
		return 0
	end
end

local uhavewapon = false

function uhavewapon2()
    local playerPos = GetEntityCoords(PlayerPedId(), true)
    if weaponTypeC() > 1 then
        uhavewapon = true
        PlaySoundFromCoord(-1, "Glass_Smash", playerPos.x, playerPos.y, playerPos.z, "", 0, 2.0, 0)
    else
        TriggerEvent("notification", "You don't have required power for breaking glass" , 2)
    end
end

function inventoryitem()
	local rnd = math.random()
	if rnd < 0.1 then
	  TriggerEvent("player:receiveItem", "goldbar", 1)
	  Wait(100)
	  TriggerEvent("player:receiveItem", "rolexwatch", math.random(5, 10))
	else
	  TriggerEvent("player:receiveItem", "rolexwatch", math.random(20, 30))
	end
	TriggerServerEvent("np-gallery:generateGem", "jewelry")
end

RegisterNetEvent("pacific:ptfxparticle")
AddEventHandler("pacific:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-596.38, -284.47, 50.30)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('dark-jewelry:jewelry:OpenMinigame')
AddEventHandler('dark-jewelry:jewelry:OpenMinigame', function()
local ped = PlayerPedId()
local playercoords = GetEntityCoords(ped)
local thermitepos = vector3(-596.14, -283.74, 50.3236)
local ped = PlayerPedId()
local playercoords = GetEntityCoords(ped)

if #(playercoords - thermitepos) < 2.0 then
	if thisisok == false then

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
	TaskGoStraightToCoord(PlayerPedId(), -596.96, -284.41, 50.30, 1.0, -1, 337.84, 0.0)
	Citizen.Wait(4500)
	    exports["np-memory"]:thermiteminigame(10, 3, 3, 10,
			function()
				print('well done')
				TriggerEvent("inventory:removeItem", "thermitecharge", 1)
				local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
				local bagscene = NetworkCreateSynchronisedScene(-596.14, -283.74, 50.3236, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
				local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -596.14, -283.74, 50.3236,  true,  true, false)
		
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
				TriggerServerEvent("pacific:particleserver", method)
				SetPtfxAssetNextCall("scr_ornate_heist")
				local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", -596.0, -282.80, 50.3236, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
				
				NetworkStopSynchronisedScene(bagscene)
				TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
				TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
				Citizen.Wait(10000)
				ClearPedTasks(ped)
				DeleteObject(bomba)
				StopParticleFxLooped(effect, 0)
				Citizen.Wait(500)
				thisisok = true
				TriggerEvent('dark-jewelry:jewelry:cooldown')
				TriggerServerEvent("np-doors:change-lock-state", 111)
				TriggerServerEvent("np-doors:change-lock-state", 112)
			end,
			function() -- failure
				print('FAILED')
				thisisok = false
				TriggerEvent("inventory:removeItem", "thermitecharge", 1)
			end)
		else
			TriggerEvent("notification", "Already opened!" , 2)
		end    
else
	print('notdistaance')
end
end)


RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions1')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions1', function(p1, p2, pContext)
	if notsmashed1  then

		local id = pContext.zones["jewelry_rob_spot1"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed1 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions2')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions2', function(p1, p2, pContext)
	if notsmashed2 then

		local id = pContext.zones["jewelry_rob_spot2"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed2 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions3')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions3', function(p1, p2, pContext)
	if notsmashed3 then

		local id = pContext.zones["jewelry_rob_spot3"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed3 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions4')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions4', function(p1, p2, pContext)
	if notsmashed4 then

		local id = pContext.zones["jewelry_rob_spot4"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed4 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions5')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions5', function(p1, p2, pContext)
	if notsmashed5 then

		local id = pContext.zones["jewelry_rob_spot5"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed5 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions6')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions6', function(p1, p2, pContext)
	if notsmashed6 then

		local id = pContext.zones["jewelry_rob_spot6"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed6 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions7')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions7', function(p1, p2, pContext)
	if notsmashed7 then

		local id = pContext.zones["jewelry_rob_spot7"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed7 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions8')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions8', function(p1, p2, pContext)
	if notsmashed8 then

		local id = pContext.zones["jewelry_rob_spot8"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed8 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions9')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions9', function(p1, p2, pContext)
	if notsmashed9 then

		local id = pContext.zones["jewelry_rob_spot9"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed9 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions10')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions10', function(p1, p2, pContext)
	if notsmashed10 then

		local id = pContext.zones["jewelry_rob_spot10"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed10 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions11')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions11', function(p1, p2, pContext)
	if notsmashed11 then

		local id = pContext.zones["jewelry_rob_spot11"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed11 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions12')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions12', function(p1, p2, pContext)
	if notsmashed12 then

		local id = pContext.zones["jewelry_rob_spot12"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed12 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)

RegisterNetEvent('dark-jewelry:jewelry:SmashFunctions13')
AddEventHandler('dark-jewelry:jewelry:SmashFunctions13', function(p1, p2, pContext)
	if notsmashed13 then

		local id = pContext.zones["jewelry_rob_spot13"].id
		SmashAnim()
		Wait(100)
		inventoryitem()
		notsmashed13 = false
	else
		TriggerEvent("notification", "Smashed Already" , 2)
	end
end)



function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
end

function SmashAnim()
loadAnimDict('missheist_jewel')
TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'robberyglassbreak', 0.5)
TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
Citizen.Wait(5000)
ClearPedTasks(PlayerPedId())
end

Citizen.CreateThread(function()
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot1", vector3(-625.78, -238.71, 38.06), 2.2, 1, {
	  heading=305,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = "1",
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot2", vector3(-626.55, -234.64, 38.06), 2.2, 0.6, {
	  heading=306,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = "2",
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot3", vector3(-627.18, -233.87, 38.06), 2.2, 0.6, {
	  heading=306,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = 3,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot4", vector3(-619.33, -234.53, 38.06), 2.2, 0.6, {
	  heading=306,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = 4,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot5", vector3(-617.42, -229.71, 38.06), 2.2, 0.6, {
	  heading=216,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = 5,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot6", vector3(-619.54, -226.82, 38.06), 2.2, 0.6, {
	  heading=216,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = 6,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot7", vector3(-624.72, -227.0, 38.06), 2.2, 0.6, {
	  heading=126,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.46,
	  data = {
		id = 7,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot8", vector3(-620.47, -232.97, 38.06), 1.4, 0.6, {
	  heading=126,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 8,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot9", vector3(-620.11, -230.74, 38.06), 1.4, 0.6, {
	  heading=36,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 9,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot10", vector3(-621.47, -229.05, 38.06), 1.4, 0.6, {
	  heading=36,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 10,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot11", vector3(-623.62, -228.63, 38.06), 1.4, 0.6, {
	  heading=306,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 11,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot12", vector3(-624.04, -230.82, 38.06), 1.4, 0.6, {
	  heading=216,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 12,
	  },
	})
	exports["np-polytarget"]:AddBoxZone("jewelry_rob_spot13", vector3(-622.53, -232.86, 38.06), 1.4, 0.6, {
	  heading=216,
	  -- debugPoly=true,
	  minZ=37.66,
	  maxZ=38.66,
	  data = {
		id = 13,
	  },
	})
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot1", {{
	  event = "dark-jewelry:jewelry:SmashFunctions1",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot2", {{
	  event = "dark-jewelry:jewelry:SmashFunctions2",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot3", {{
	  event = "dark-jewelry:jewelry:SmashFunctions3",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot4", {{
	  event = "dark-jewelry:jewelry:SmashFunctions4",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot5", {{
	  event = "dark-jewelry:jewelry:SmashFunctions5",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot6", {{
	  event = "dark-jewelry:jewelry:SmashFunctions6",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot7", {{
	  event = "dark-jewelry:jewelry:SmashFunctions7",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot8", {{
	  event = "dark-jewelry:jewelry:SmashFunctions8",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot9", {{
	  event = "dark-jewelry:jewelry:SmashFunctions9",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot10", {{
	  event = "dark-jewelry:jewelry:SmashFunctions10",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot11", {{
	  event = "dark-jewelry:jewelry:SmashFunctions11",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot12", {{
	  event = "dark-jewelry:jewelry:SmashFunctions12",
	  id = "jewelry_rob_spot",
	  icon = "",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	exports['np-interact']:AddPeekEntryByPolyTarget("jewelry_rob_spot13", {{
	  event = "dark-jewelry:jewelry:SmashFunctions13",
	  id = "jewelry_rob_spot",
	  icon = "	",
	  label = "",
	  parameters = {},
	}}, { distance = { radius = 1.3 } })
	
  end)

RegisterNetEvent('dark-jewelry:jewelry:cooldown')
AddEventHandler('dark-jewelry:jewelry:cooldown', function()
	TriggerEvent("notification", "In 15 minutes, doors will be closed!!" , 2)
	Wait(900000)
	TriggerServerEvent("dark-jewelry:doors:client:setState", 1)
	Wait(9900000)
	thisisok = false
	notsmashed1 = true
	notsmashed2 = true
	notsmashed3 = true
	notsmashed4 = true
	notsmashed5 = true
	notsmashed6 = true
	notsmashed7 = true
	notsmashed8 = true
	notsmashed9 = true
	notsmashed10 = true
	notsmashed11 = true
	notsmashed12 = true
	notsmashed13 = true
end)
