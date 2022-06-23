RegisterNetEvent("lootcashbaycity")
AddEventHandler("lootcashbaycity", function(name)
    StartGrab69(name)
end) 

RegisterNetEvent('baycityvaultDoor')
AddEventHandler('baycityvaultDoor', function()
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-1304.7004150391, -816.88671875, 17.14842414856) - player)
    if distance < 1.5 then
-- -105.12893676758, 6471.46484375, 31.626705169678 Heading: 40.885322570801
            if exports["np-inventory"]:hasEnoughOfItem("thermite",1,false) then
                FreezeEntityPosition(PlayerPedId(),true)
                local FirstDoorBigBank = exports["np-taskbar"]:taskBar(9000,"Preparing For Hack")
                if FirstDoorBigBank == 100 then
                    FreezeEntityPosition(PlayerPedId(),false)
                    Wait(1000)
                    ClearPedTasksImmediately(ply)
                    Wait(0)
                    TaskGoStraightToCoord(ply, -1304.7004150391, -816.88671875, 17.14842414856 , 2.0, -1, 73.9)
    
                    local hackAnimDict = "anim@heists@ornate_bank@hack"
    
                    RequestAnimDict(hackAnimDict)
                    RequestModel("hei_prop_hst_laptop")
                    RequestModel("hei_p_m_bag_var22_arm_s")
                    RequestModel("hei_prop_heist_card_hack_02")
                    while not HasAnimDictLoaded(hackAnimDict)
                        or not HasModelLoaded("hei_prop_hst_laptop")
                        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
                        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
                        Wait(0)
                    end
                    Wait(0)
                    while GetIsTaskActive(ply, 35) do
                        Wait(0)
                    end
                    ClearPedTasksImmediately(ply)
                    Wait(0)
                    SetEntityHeading(ply, 305.37213134766)
                    Wait(0)
                    TaskPlayAnimAdvanced(ply, hackAnimDict, "hack_enter", -1304.7004150391, -815.88671875, 17.14842414856, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
                    Wait(0)
                    SetEntityHeading(ply, 305.37213134766)
                    while IsEntityPlayingAnim(ply, hackAnimDict, "hack_enter", 3) do
                        Wait(0)
                    end
                    local laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
                    Wait(0)
                    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
                    PlaceObjectOnGroundProperly(laptop)
                    Wait(0)
                    TaskPlayAnim(ply, hackAnimDict, "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)
                    
                    Wait(1000)
                    FreezeEntityPosition(PlayerPedId(),false)
                    Wait(1000)
                    exports["memorygame"]:thermiteminigame(1, 3, 4, 10,
                    function() -- Success
                        StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                        TriggerEvent('np-vaultDoor3', -1, method)
                        --TriggerEvent('np-ffs2:startheist')
                        --SpawnTrolleys2(data, name)
                        TriggerEvent("inventory:removeItem","thermite",1)
                        TriggerEvent('DoLongHudText', 'Well done dumbass please cry more!', 2)
                        SpawnTrolleys69(data, name)
                    end,
                    function() -- failure
                        StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                        TriggerEvent('DoLongHudText', 'You failed!', 2)
                        TriggerEvent("inventory:removeItem","thermite",1)
                    end)
                    -- exports["hacking"]:hacking(
                    --     function() -- success
                    --         StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                    --         TriggerEvent('np-vaultDoor2', -1, method)
                    --         TriggerEvent('np-ffs2:startheist')
                    --         TriggerEvent('BigBankLoot')
                    --         TriggerEvent("inventory:removeItem","thermite",1)
                    --         TriggerEvent('DoLongHudText', 'Well done dumbass please cry more!', 2)
                    --     end,
                    --     function() -- failur
                    --         StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                    --         TriggerEvent('DoLongHudText', 'You failed!', 2)
                    --         TriggerEvent("inventory:removeItem","thermite",1)
                    --     end)
                end
            end
        --end
    end
end)

RegisterNetEvent('BayCitySecondDoor')
AddEventHandler('BayCitySecondDoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-1307.9698486328, -814.58245849609, 17.148427963257) - player)
    if distance < 1.5 then
        if exports["np-inventory"]:hasEnoughOfItem("thermite",1,false) then
            FreezeEntityPosition(PlayerPedId(),true)
            local FirstDoorBigBank = exports["np-taskbar"]:taskBar(9000,"Preparing For Hack")
            if FirstDoorBigBank == 100 then
                FreezeEntityPosition(PlayerPedId(),false)
                Wait(1000)
                exports["memorygame"]:thermiteminigame(1, 3, 4, 10,
                function() -- Success
                    TriggerEvent("np-BayCityTriggerSecondDoor")
                    TriggerEvent("inventory:removeItem","thermite",1)
                    TriggerEvent('DoLongHudText', 'Well done dumbass please cry more!', 2)
                end,
                function() -- failure
                    TriggerEvent('DoLongHudText', 'You failed!', 2)
                    TriggerEvent("inventory:removeItem","thermite",1)
                end)
            end
        end
    end
end)

RegisterNetEvent('np-BayCityTriggerSecondDoor')
AddEventHandler('np-BayCityTriggerSecondDoor', function()
	anim66()
	Citizen.Wait(3500)
end)

RegisterNetEvent('np-Seconddoorsbaycity') 
AddEventHandler('np-Seconddoorsbaycity', function()
    TriggerServerEvent("np-doors:change-lock-state", 524, false)
end)

RegisterNetEvent('BayCityFirstDoor')
AddEventHandler('BayCityFirstDoor', function()
    local player = GetEntityCoords(PlayerPedId())
    local distance = #(vector3(-1305.3227539063, -820.21166992188, 17.148414611816) - player)
    if distance < 1.5 then
        if exports["np-inventory"]:hasEnoughOfItem("thermite",1,false) then
            FreezeEntityPosition(PlayerPedId(),true)
            local FirstDoorBigBank = exports["np-taskbar"]:taskBar(9000,"Preparing For Hack")
            if FirstDoorBigBank == 100 then
                FreezeEntityPosition(PlayerPedId(),false)
                Wait(1000)
                exports["memorygame"]:thermiteminigame(1, 3, 4, 10,
                function() -- Success
                    TriggerEvent("np-BayCityTriggerFirstDoor")
                    TriggerEvent("inventory:removeItem","thermite",1)
                    TriggerEvent('DoLongHudText', 'Well done dumbass please cry more!', 2)
                    
                end,
                function() -- failure
                    TriggerEvent('DoLongHudText', 'You failed!', 2)
                    TriggerEvent("inventory:removeItem","thermite",1)
                end)
            end
        end
    end
end)

RegisterNetEvent('np-BayCityTriggerFirstDoor')
AddEventHandler('np-BayCityTriggerFirstDoor', function()
	anim69()
	Citizen.Wait(3500)
end)

RegisterNetEvent('np-firstdoorsbaycity') 
AddEventHandler('np-firstdoorsbaycity', function()
    TriggerServerEvent("np-doors:change-lock-state", 525, false)
end)






RegisterNetEvent('np-vaultDoor3')
AddEventHandler('np-vaultDoor3', function(method)
    local obj = GetClosestObjectOfType(-1306.7009277344, -815.44757080078, 17.308031082153, 2.0, 961976194, false, false, false)
    local count = 0

    -- print'Method')

    if (method == 1) then
        repeat
            local rot = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, rot)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    else
        repeat
            local rot = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, rot)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    end
    FreezeEntityPosition(obj, true)
end)



-- -1309.0720214844, -810.15460205078, 17.14838218689 Heading: 344.43566894531

function StartGrab69(name)
    --TriggerEvent("client:newStress", true, 500)
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("ch_prop_ch_cash_trolly_01c"), false, false, false)

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
    local emptyobj = GetHashKey("ch_prop_gold_trolly_01c_empty")

	if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(0)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(0)
		NetworkRequestControlOfEntity(trollyobj)
	end
	local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    --SetPedComponentVariation(ped, 5, 0, 0, 0)
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

    DeleteObject(trollyobj)
	while DoesEntityExist(trollyobj) do
		Citizen.Wait(0)
		NetworkRequestControlOfEntity(trollyobj)
	end

    PlaceObjectOnGroundProperly(NewTrolley)
    SetEntityAsMissionEntity(NewTrolley, 1, 1)
    Citizen.SetTimeout(5000, function()
        DeleteObject(NewTrolley)
        while DoesEntityExist(NewTrolley) do
            Citizen.Wait(0)
            DeleteEntity(NewTrolley)
        end
    end)        

    Citizen.Wait(1800)
    if DoesEntityExist(bag) then
        DeleteEntity(bag)
    end

    --SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    disableinput = false
    TriggerEvent("player:receiveItem", "markedbills", 150)
end


function SpawnTrolleys69(data, name)
    RequestModel("ch_prop_ch_cash_trolly_01c")
    while not HasModelLoaded("ch_prop_ch_cash_trolly_01c") do
        Citizen.Wait(1)
    end
    RequestModel("ch_prop_gold_trolly_01c")
    while not HasModelLoaded("ch_prop_gold_trolly_01c") do
        Citizen.Wait(1)
    end

    
    Trolley = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), -1309.0720214844, -810.15460205078, 16.14838218689, 1, 1, 0)
    local hand = GetEntityHeading(Trolley)


-- 
-- -1309.3168945313, -810.91320800781, 17.148416519165 Heading: 169.753326416021
    SetEntityHeading(Trolley, hand + 169.753326416021)
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


































local baycityDoorState = false

RegisterNetEvent("np-baycity:getDoorCheckCL")
AddEventHandler("np-baycity:getDoorCheckCL", function(result)
    baycityDoorState = result
end)

Citizen.CreateThread(function()
    local isNear = false
    while true do 
        Wait(2000)
        local dist = #(vector3(-1306.7009277344, -815.44757080078, 17.308031082153) - GetEntityCoords(PlayerPedId()))
        if dist < 30 then isNear = true end
        if isNear then
            TriggerServerEvent('np-baycity:getGetDoorStateSV')
            local VaultDoor = GetClosestObjectOfType(-1306.7009277344, -815.44757080078, 17.308031082153, 25.0, `v_ilev_bk_vaultdoor`, 0, 0, 0)
            if baycityDoorState == false then
                SetEntityHeading(VaultDoor,35.062076568604)
                FreezeEntityPosition(VaultDoor,true)
            end    
        else
            Wait(2000)
        end
    end
end)

RegisterNetEvent("np-ptfxparticlebaycity")
AddEventHandler("np-ptfxparticlebaycity", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-1308.2517089844, -813.01928710938, 17.148412704468)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("seks")
    StopParticleFxLooped(effect, 0)
end)

function anim66() -- Animation
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
-- 252.99769592285, 220.96379089355, 101.68360137939 Heading: 166.93214416504
    SetEntityHeading(ped, 39.135593414307)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-1308.2529296875, -814.00305175781, 17.24838218689 , rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -1307.9698486328, -814.58245849609, 17.148427963257,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("np-particleserverbaycity", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("np-Seconddoorsbaycity")
end

RegisterNetEvent("np-ptfxparticlebaycity1")
AddEventHandler("np-ptfxparticlebaycity1", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(-1305.458984375, -818.65441894531, 17.148386001587)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("seks")
    StopParticleFxLooped(effect, 0)
end)

function anim69() -- Animation
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()
-- 252.99769592285, 220.96379089355, 101.68360137939 Heading: 166.93214416504
    SetEntityHeading(ped, 39.135593414307)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-1305.5396728516, -819.85516357422, 17.148384094238 , rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -1305.3227539063, -820.21166992188, 17.148414611816,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("np-particleserverbaycity1", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("np-firstdoorsbaycity")
end