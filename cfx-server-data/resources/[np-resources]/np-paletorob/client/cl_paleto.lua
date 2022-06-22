Freeze = {P1 = 0}
Check = {P1 = false}
SearchChecks = {P1 = false}
LootCheck = {
    P1 = {Stop = false, Loot = false},
}
Doors = {}
local disableinput = false
local initiator = false
local startdstcheck = false
local currentname = nil
local currentcoords = nil
local done = true
local dooruse = false
local helpTextShowing2 = false
local paletoDoorState = false
local randommoney = math.random(40,150)
local randombands = math.random(2,10)

Citizen.CreateThread(function() while true do local enabled = false Citizen.Wait(1) if disableinput then enabled = true  end if not enabled then Citizen.Wait(500) end end end)

Citizen.CreateThread(function()
    local isNear = false
    while true do 
        Wait(10000)
        local dist = #(vector3(-104.8747253418,6472.1274414062,31.621948242188) - GetEntityCoords(PlayerPedId()))
        if dist < 30 then isNear = true end
        if isNear then
            TriggerServerEvent('np-paleto:getGetDoorStateSV')
            local VaultDoor = GetClosestObjectOfType(-104.8747253418,6472.1274414062,31.621948242188, 25.0, `v_ilev_cbankvauldoor01`, 0, 0, 0)
            if paletoDoorState == false then
                SetEntityHeading(VaultDoor,47.188972473145)
                FreezeEntityPosition(VaultDoor,true)
            end    
        else
            Wait(10000)
        end
    end
end)

RegisterNetEvent("np-paleto:getDoorCheckCL")
AddEventHandler("np-paleto:getDoorCheckCL", function(result)
    paletoDoorState = result
end)

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

RegisterNetEvent("np-paleto:resetDoorState")
AddEventHandler("np-paleto:resetDoorState", function(name)
    Freeze[name] = 0
end)

RegisterNetEvent("np-paleto:lootup_c")
AddEventHandler("np-paleto:lootup_c", function(var, var2)
    LootCheck[var][var2] = true
end)

RegisterNetEvent("np-paleto:outcome")
AddEventHandler("np-paleto:outcome", function(oc, arg)
    for i = 1, #Check, 1 do
        Check[i] = false
    end
    for i = 1, #LootCheck, 1 do
        for j = 1, #LootCheck[i] do
            LootCheck[i][j] = false
        end
    end
    if oc then
        Check[arg] = true
        TriggerEvent("np-paleto:startheist", Paleto.Banks[arg], arg)
    elseif not oc then
        TriggerEvent("DoLongHudText", arg, 2)
    end
end)

RegisterNetEvent("np-paleto:startLoot_c")
AddEventHandler("np-paleto:startLoot_c", function(data, name)
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    if not LootCheck[name].Stop then
        Citizen.CreateThread(function()
            while true do
                local pedcoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)

                if dst < 40 then
                    if not LootCheck[name].Loot then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley.x, data.trolley.y, data.trolley.z + 1, true)

                        if dst1 < 2 then
                            if not helpTextShowing2 then
                                exports["np-ui"]:showInteraction('[E] Grab It !')
                                helpTextShowing2 = true
                            elseif dst1 < 0.75 and IsControlJustReleased(0, 38) then
                                exports["np-ui"]:hideInteraction()
                                TriggerServerEvent("np-paleto:lootup", name, "Loot")
                                StartGrab(name)
                            end
                        else   
                            if helpTextShowing2 then
                                exports["np-ui"]:hideInteraction()
                                helpTextShowing2 = false
                            end
                        end
                    end

                    if LootCheck[name].Stop or (LootCheck[name].Loot) then
                        LootCheck[name].Stop = false
                        if initiator then
                            TriggerEvent("np-paleto:reset", name, data)
                            return
                        end
                        return
                    end
                    Citizen.Wait(1)
                else
                    Citizen.Wait(1000)
                end
            end
        end)
    end
end)

RegisterNetEvent("np-paleto:stopHeist_c")
AddEventHandler("np-paleto:stopHeist_c", function(name)
    LootCheck[name].Stop = true
end)

-- MAIN DOOR UPDATE --

AddEventHandler("np-paleto:freezeDoors", function()
    Citizen.CreateThread(function()
        doVaultStuff = function()
            while true do
                local pcoords = GetEntityCoords(PlayerPedId())

                for k, v in pairs(Doors) do
                    if GetDistanceBetweenCoords(v[1].loc, pcoords, true) <= 20.0 then
                        if v[1].state ~= nil then
                            local obj
                            if k ~= "F4" then
                                obj = GetClosestObjectOfType(v[1].loc, 1.5, GetHashKey("v_ilev_cbankvauldoor01"), false, false, false)
                            else
                                obj = GetClosestObjectOfType(v[1].loc, 1.5, 4231427725, false, false, false)
                            end
                            SetEntityHeading(obj, v[1].state)
                            Citizen.Wait(1000)
                            return doVaultStuff()
                        end
                    else
                        Citizen.Wait(1000)
                    end
                end
                Citizen.Wait(1)
            end
        end
        doVaultStuff()
    end)
end)

RegisterNetEvent("np-paleto:ClosePaletoDoor")
AddEventHandler("np-paleto:ClosePaletoDoor", function()
    local count = 0
    local VaultDoor = GetClosestObjectOfType(-104.8747253418,6472.1274414062,31.621948242188, 25.0, `v_ilev_cbankvauldoor01`, 0, 0, 0)
    repeat
        local heading = GetEntityHeading(VaultDoor) - 0.10

        SetEntityHeading(VaultDoor, heading)
        count = count + 1
        Citizen.Wait(10000)
    until count == 900
    TriggerServerEvent('np-paleto:getGetDoorStateSVSV', false)
end)


-- RegisterNetEvent("np-paleto:toggleVault")
-- AddEventHandler("np-paleto:toggleVault", function(key, state)
--     dooruse = true
--     if Paleto.Banks[key].hash == nil then
--         if not state then
--             local obj = GetClosestObjectOfType(Paleto.Banks[key].doors.startloc.x, Paleto.Banks[key].doors.startloc.y, Paleto.Banks[key].doors.startloc.z, 2.0, GetHashKey(Paleto.vaultdoor), false, false, false)
--             local count = 0

--             repeat
--                 local heading = GetEntityHeading(obj) - 0.017

--                 SetEntityHeading(obj, heading)
--                 count = count + 1
--                 Citizen.Wait(10)
--             until count == 900
--             Doors[key][1].locked = state
--             TriggerServerEvent("np-paleto:updateVaultState", key, Doors[key][1].state)
--         elseif state then
--             local obj = GetClosestObjectOfType(Paleto.Banks[key].doors.startloc.x, Paleto.Banks[key].doors.startloc.y, Paleto.Banks[key].doors.startloc.z, 2.0, GetHashKey(Paleto.vaultdoor), false, false, false)
--             local count = 0

--             repeat
--                 local heading = GetEntityHeading(obj) + 0.017

--                 SetEntityHeading(obj, heading)
--                 count = count + 1
--                 Citizen.Wait(10)
--             until count == 900
--             Doors[key][1].locked = state
--             TriggerServerEvent("np-paleto:updateVaultState", key, Doors[key][1].state)
--         end
--     else
--         if not state then
--             local obj = GetClosestObjectOfType(Paleto.Banks.F4.doors.startloc.x, Paleto.Banks.F4.doors.startloc.y, Paleto.Banks.F4.doors.startloc.z, 2.0, Paleto.Banks.F4.hash, false, false, false)
--             local count = 0
--             repeat
--                 local heading = GetEntityHeading(obj) - 0.10

--                 SetEntityHeading(obj, heading)
--                 count = count + 1
--                 Citizen.Wait(10)
--             until count == 900
--             Doors[key][1].locked = state
--             TriggerServerEvent("np-paleto:updateVaultState", key, Doors[key][1].state)
--         elseif state then
--             local obj = GetClosestObjectOfType(Paleto.Banks.F4.doors.startloc.x, Paleto.Banks.F4.doors.startloc.y, Paleto.Banks.F4.doors.startloc.z, 2.0, Paleto.Banks.F4.hash, false, false, false)
--             local count = 0

--             repeat
--                 local heading = GetEntityHeading(obj) + 0.10

--                 SetEntityHeading(obj, heading)
--                 count = count + 1
--                 Citizen.Wait(10)
--             until count == 900
--             Doors[key][1].locked = state
--             Doors[key][1].state = GetEntityHeading(obj)
--             TriggerServerEvent("np-paleto:updateVaultState", key, Doors[key][1].state)
--         end
--     end
--     dooruse = false
-- end)

RegisterNetEvent("np-paleto:OpenPaletoDoor")
AddEventHandler("np-paleto:OpenPaletoDoor", function()
    TriggerServerEvent('np-paleto:getGetDoorStateSVSV', true)
    local count = 0
    local VaultDoor = GetClosestObjectOfType(-104.8747253418, 6472.1274414062, 31.621948242188, 25.0, `v_ilev_cbankvauldoor01`, 0, 0, 0)
    repeat
        local heading = GetEntityHeading(VaultDoor) + 0.099

        SetEntityHeading(VaultDoor, heading)
        count = count + 1
        Citizen.Wait(10)
    until count == 900
end)

AddEventHandler("np-paleto:reset", function(name, data)
    for i = 1, #LootCheck[name], 1 do
        LootCheck[name][i] = false
    end
    Check[name] = false
    TriggerEvent("DoLongHudText", "VAULT DOOR WILL CLOSE IN 30 MINUTES!", 2)
    Citizen.Wait(100000)
    TriggerEvent("DoLongHudText", "VAULT DOOR CLOSING", 2)
    TriggerServerEvent("np-paleto:closeDoor")
    -- TriggerServerEvent("np-paleto:toggleVault", name, true)
    TriggerEvent("np-paleto:cleanUp", data, name)
end)


AddEventHandler("np-paleto:startheist", function(data, name)
    disableinput = true
    currentname = name
  --  currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    initiator = true
    disableinput = false
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    TriggerServerEvent('np-paleto:openDoor')
    TriggerServerEvent("np-paleto:setCooldown", name)
    --TriggerServerEvent("np-paleto:toggleVault", name, false)
    startdstcheck = true
    currentname = name
    SpawnTrolleys(data, name)
end)

-- AddEventHandler("np-paleto:cleanUp", function(data, name)
--     Citizen.Wait(10000)
--     for i = 1, 1, 1 do -- full trolley clean
--         local obj = GetClosestObjectOfType(data.objects[i].x, data.objects[i].y, data.objects[i].z, 0.75, GetHashKey("ch_prop_ch_cash_trolly_01c"), false, false, false)

--         if DoesEntityExist(obj) then
--             DeleteEntity(obj)
--         end
--     end
--     for j = 1, 1, 1 do -- empty trolley clean
--         local obj = GetClosestObjectOfType(data.objects[j].x, data.objects[j].y, data.objects[j].z, 0.75, GetHashKey("ch_prop_gold_trolly_01c_empty"), false, false, false)

--         if DoesEntityExist(obj) then
--             DeleteEntity(obj)
--         end
--     end
--     if DoesEntityExist(IdProp) then
--         DeleteEntity(IdProp)
--     end
--     if DoesEntityExist(IdProp2) then
--         DeleteEntity(IdProp2)
--     end
--     TriggerServerEvent("np-paleto:setCooldown", name)
--     initiator = false
-- end)

function SpawnTrolleys(data, name)
    RequestModel("ch_prop_ch_cash_trolly_01c")
    while not HasModelLoaded("ch_prop_ch_cash_trolly_01c") do
        Citizen.Wait(1)
    end
    Trolley = CreateObject(GetHashKey("ch_prop_ch_cash_trolly_01c"), data.trolley.x, data.trolley.y, data.trolley.z, 1, 1, 0)
    local hand = GetEntityHeading(Trolley)

    SetEntityHeading(Trolley, hand + Paleto.Banks[name].trolley.h)
    local closePlayers = GetClosestPlayers(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    local ply = PlayerId()

    for i = 1, #closePlayers, 1 do
        if closePlayers[i] ~= ply then
            table.insert(missionplayers, GetPlayerServerId(closePlayers[i]))
        end
    end
    TriggerServerEvent("np-paleto:startLoot", data, name, missionplayers)
    done = false
end

function StartGrab(name)
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
    local myluck = math.random(2)
    if myluck == 1 then
    TriggerEvent("player:receiveItem", "markedbills", randommoney)
    TriggerEvent("player:receiveItem", "band", randombands)
    elseif myluck == 2 then
    TriggerEvent("player:receiveItem", "markedbills", randommoney)
    TriggerEvent("player:receiveItem", "heistusb2", 1)
else
    print("Paleto Compeleted!")
    end
end

Citizen.CreateThread(function()
    while true do
        if startdstcheck then
            if initiator then
                local playercoord = GetEntityCoords(PlayerPedId())

                if (GetDistanceBetweenCoords(playercoord, currentcoords, true)) > 20 then
                    LootCheck[currentname].Stop = true
                    startdstcheck = false
                    TriggerServerEvent("np-paleto:stopHeist", currentname)
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(1)
    end
end)

RegisterNetEvent('np-paleto:darkmail')
AddEventHandler('np-paleto:darkmail', function()
    Citizen.Wait(1000)
    TriggerEvent('phone:notification', {
        sender = "Paleto",
        subject = "Dark Mail",
        message = "Good Job: <br><br> Hi, </b><br><br> You Bypassed the hack wait around 1-5 minutes, im getting this vault door open.",
    })
end)

RegisterNetEvent('np-paleto:UseBlueLapTop')
AddEventHandler('np-paleto:UseBlueLapTop', function(item)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local p = promise:new()

    Paleto.Banks, doors = RPC.execute("np-paleto:getBanks")
	TriggerEvent("np-paleto:freezeDoors")

    for k, v in pairs(Paleto.Banks) do
        if not v.onaction then
	        local dist = GetDistanceBetweenCoords(plyCoords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)
            if dist < 1.0 then
                if exports["isPed"]:isPed("countpolice") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("heistlaptop2", 1) then
                    -- if HasItem then
                    ClearPedTasksImmediately(ply)
                    Wait(0)
                    TaskGoStraightToCoord(ply, v.doors.startloc.animcoords.x, v.doors.startloc.animcoords.y, v.doors.startloc.animcoords.z, 2.0, -1, v.doors.startloc.animcoords.h)
    
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
                    SetEntityHeading(ply, v.doors.startloc.animcoords.h)
                    Wait(0)
                    TaskPlayAnimAdvanced(ply, hackAnimDict, "hack_enter", v.doors.startloc.animcoords.x, v.doors.startloc.animcoords.y, v.doors.startloc.animcoords.z, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
                    Wait(0)
                    SetEntityHeading(ply, v.doors.startloc.animcoords.h)
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


                    exports['hacking']:OpenHackingGame(function(Success)
                        if Success then
                            print('well done')
                            TriggerEvent("DoLongHudText", "Good Job, You Bypassed the hack wait around 1-5 minutes, im getting this vault door open", 1)						
                            StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                            DeleteObject(laptop)
                            ClearPedTasksImmediately(ply)
                            local timeout = math.random(60,300)    
                            Citizen.SetTimeout(timeout, function()
                                TriggerServerEvent("np-paleto:startcheck", k)
                            end)
    
                        else
                            StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                            DeleteObject(laptop)
                            ClearPedTasksImmediately(ply)    
                            TriggerEvent("inventory:DegenItemType",0.25,"heistlaptop3")
                            TriggerEvent("client:newStress",true,100)
                            TriggerEvent('DoLongHudText', 'Breaching faild - stress more now :)', 2)
                        end
                    end)
                    
                end 

            end

            end 
        end      		
    end  
end)


function Thermitegatep() -- Paleto Thermitecharge
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 37.54)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-105.19, 6473.028, 31.62, rotx, roty, rotz + 1.1, 2, false, false, 1622278560, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -105.06, 6472.70, 31.62,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    --SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    --SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("efe:particleserverthi", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("paletogate:doorburn")
end

function Thermitegatep2() -- Paleto Thermitecharge
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 324.49)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(-106.29, 6475.26, 31.62, rotx, roty, rotz + 1.1, 2, false, false, 1622278560, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), -106.29, 6475.26, 31.62,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    --SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.4,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    --SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("efe:particleserverthi", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("paletogate2:doorburn")
end

RegisterNetEvent('paletogate:door') -- Thermite door trigger
AddEventHandler('paletogate:door', function()
            if bobcatsoyuldu == 1 then
                exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() -- success
        TriggerEvent("paleto:thermiteburn")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
        Citizen.Wait(100)
    end,
    
    function() -- failure
        TriggerEvent("inventory:removeItem","thermitecharge",1)
        end)
    else
        TriggerEvent("efe:robbed")
            end
end) 

RegisterNetEvent('paleto:thermiteburn')
AddEventHandler('paleto:thermiteburn', function()
	Thermitegatep()
    Citizen.Wait(3500)
    TriggerEvent("paletogate:doorburn")
end)

RegisterNetEvent('paleto:thermiteburn2')
AddEventHandler('paleto:thermiteburn2', function()
	Thermitegatep2()
    Citizen.Wait(3500)
    TriggerEvent("paletogate2:doorburn")
end)


RegisterNetEvent('paletogate:doorburn') -- Doorlock
AddEventHandler('paletogate:doorburn', function()
	TriggerServerEvent('np-doors:change-lock-state', 498, false)
end)

RegisterNetEvent('paletogate2:doorburn') -- Doorlock
AddEventHandler('paletogate2:doorburn', function()
	TriggerServerEvent('np-doors:change-lock-state', 517, false)
end)

RegisterNetEvent('paleto:door') -- 2.Trigger Door
AddEventHandler('paleto:door', function()
    exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() 
        TriggerEvent("paleto:thermiteburn")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end,
    function() -- failure
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end)
end)

RegisterNetEvent('paleto:door2') -- 2.Trigger Door
AddEventHandler('paleto:door2', function()
    exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() 
        TriggerEvent("paleto:thermiteburn2")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end,
    function() -- failure
        TriggerEvent("DoLongHudText", "Failed")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end)
end)



