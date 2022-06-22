Freeze2 = {P1 = 0}
Check2 = {P1 = false}
LootCheck2 = {
    P1 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false}
}
local disableinput = false
local initiator = false
local startdstcheck = false
local currentname = nil
local done = true
local paletoBanks = {}
local paletoBanksTimes = 0
local paletoTimesHit = 0
local paletoDoorState = false
local paletoStateAlready = false

RegisterNetEvent("np-paleto:getBanks")
AddEventHandler("np-paleto:getBanks", function(result)
    paletoBanks = result
end)

RegisterNetEvent("np-paleto:getHit")
AddEventHandler("np-paleto:getHit", function(result)
    paletoBanksTimes = result
end)

RegisterNetEvent("np-paleto:getDoorCheckCL")
AddEventHandler("np-paleto:getDoorCheckCL", function(result)
    paletoDoorState = result
end)

RegisterNetEvent("np-paleto:GetTimeCL")
AddEventHandler("np-paleto:GetTimeCL", function(result)
    paletoTimesHit = result
end)

RegisterNetEvent("np-paleto:GetTime2CL")
AddEventHandler("np-paleto:GetTime2CL", function(result)
    paletoTimesHit2 = result
end)


RegisterNetEvent("np-paleto:GetDoorAccessCL")
AddEventHandler("np-paleto:GetDoorAccessCL", function(result)
    paletoStateAlready = result
end)

Citizen.CreateThread(function() 
    while true do 
        local enabled = false 
        Citizen.Wait(1) 
        if disableinput then 
            enabled = true 
            DisableControl() 
        end 
        if not enabled then 
            Citizen.Wait(500) 
        end 
    end 
end)

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

RegisterNetEvent("np-paleto:resetDoorState")
AddEventHandler("np-paleto:resetDoorState", function(name)
    Freeze2[name] = 0
end)

RegisterNetEvent("np-paleto:lootup_c")
AddEventHandler("np-paleto:lootup_c", function(var, var2)
    LootCheck2[var][var2] = true
end)

RegisterNetEvent("np-paleto:outcome")
AddEventHandler("np-paleto:outcome", function(oc, arg)
    for i = 1, #Check, 1 do
        Check[i] = false
    end
    for i = 1, #LootCheck2, 1 do
        for j = 1, #LootCheck2[i] do
            LootCheck2[i][j] = false
        end
    end
    if oc then
        Check2[arg] = true
        TriggerEvent("np-paleto:startheist", paleto.Banks[arg], arg)
    elseif not oc then
        exports['np-notification']:Alert({style = 'error', duration = 3000, message = arg})
    end
end)

RegisterNetEvent("np-paleto:OpenPaletoDoor")
AddEventHandler("np-paleto:OpenPaletoDoor", function()
    TriggerServerEvent('np-paleto:getGetDoorStateSVSV', true)
    local count = 0
    local VaultDoor = GetClosestObjectOfType(-104.8747253418,6472.1274414062,31.621948242188, 25.0, `v_ilev_cbankvauldoor01`, 0, 0, 0)
    repeat
        local heading = GetEntityHeading(VaultDoor) + 0.10

        SetEntityHeading(VaultDoor, heading)
        count = count + 1
        Citizen.Wait(10)
    until count == 900
end)

RegisterNetEvent("np-paleto:ClosePaletoDoor")
AddEventHandler("np-paleto:ClosePaletoDoor", function()
    local count = 0
    local VaultDoor = GetClosestObjectOfType(-104.8747253418,6472.1274414062,31.621948242188, 25.0, `v_ilev_cbankvauldoor01`, 0, 0, 0)
    repeat
        local heading = GetEntityHeading(VaultDoor) - 0.10

        SetEntityHeading(VaultDoor, heading)
        count = count + 1
        Citizen.Wait(10)
    until count == 900
    TriggerServerEvent('np-paleto:getGetDoorStateSVSV', false)
end)

Citizen.CreateThread(function()
    local isNear = false
    while true do 
        Wait(2000)
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
            Wait(2000)
        end
    end
end)

RegisterNetEvent('plootCash1')
AddEventHandler('plootCash1',function()
    TriggerServerEvent("np-paleto:lootup", "P1", "Loot1")
    StartGrab2(name)
end)

RegisterNetEvent('plootCash2')
AddEventHandler('plootCash2',function()
    TriggerServerEvent("np-paleto:lootup", "P1", "Loot2")
    StartGrab2(name)
end)

RegisterNetEvent('plootCash3')
AddEventHandler('plootCash3',function()
    TriggerServerEvent("np-paleto:lootup", "P1", "Loot3")
    StartGrab2(name)
end)

RegisterNetEvent("np-paleto:startLoot_c")
AddEventHandler("np-paleto:startLoot_c", function(data, name)
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    if not LootCheck2[name].Stop then
        Citizen.CreateThread(function()

            exports["np-target"]:AddBoxZone("pCash1", vector3(-107.39, 6473.98, 31.63), 0.6, 1, {
            name="pCash1",
            heading=312,
            minZ=27.78,
            maxZ=31.78
            }, {
                options = {
                    {
                        event = "plootCash1",
                        icon = "fas fa-hand-holding",
                        label = "Grab it!",
                    },
                },
                job = {"all"},
                distance = 1.0
            }) 
            exports["np-target"]:AddBoxZone("pCash2", vector3(-102.78, 6476.79, 31.65), 0.6, 1, {
            name="pCash2",
            heading=318,
            minZ=27.75,
            maxZ=31.75
            }, {
                options = {
                    {
                        event = "plootCash2",
                        icon = "fas fa-hand-holding",
                        label = "Grab it!",
                    },
                },
                job = {"all"},
                distance = 1.0
            }) 

            exports["np-target"]:AddBoxZone("pCash3", vector3(-104.7, 6478.54, 31.63), 0.6, 1, {
            name="pCash3",
            heading=316,
            minZ=27.73,
            maxZ=31.73
            }, {
                options = {
                    {
                        event = "plootCash3",
                        icon = "fas fa-hand-holding",
                        label = "Grab it!",
                    },
                },
                job = {"all"},
                distance = 1.0
            }) 

            while true do
                local pedcoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)
                local plyId = PlayerPedId()
                local plyCoords = GetEntityCoords(plyId)

                if dst < 40 then
                    if LootCheck2[name].Stop or (LootCheck2[name].Loot1 and LootCheck2[name].Loot2 and LootCheck2[name].Loot3) then
                        LootCheck2[name].Stop = false
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
    LootCheck2[name].Stop = true
end)

function GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    local zone = GetLabelText(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
    local street = street1 .. ", " .. zone
    return street
end

RegisterNetEvent("np-paleto:reset")
AddEventHandler("np-paleto:reset", function(name, data)
    for i = 1, #LootCheck2[name], 1 do
        LootCheck2[name][i] = false
    end
    Check2[name] = false
    exports['np-notification']:Alert({style = 'error', duration = 3000, message = 'VAULT DOOR WILL CLOSE IN 2 MINUTES!'})
    Citizen.Wait(120000)
    exports['np-notification']:Alert({style = 'error', duration = 3000, message = 'VAULT DOOR CLOSING'})
    TriggerEvent("np-paleto:cleanUp", data, name)
    TriggerServerEvent("np-paleto:closeDoor")
end)

RegisterNetEvent("np-paleto:startheist")
AddEventHandler("np-paleto:startheist", function(data, name)
    currentname = name
    initiator = true

    exports['np-notification']:Alert({style = 'info', duration = 5000, message = 'Nice! You bypassed the captcha. Give me a few minutes to open the door!'})

    Citizen.Wait(300000)

    TriggerServerEvent('np-paleto:openDoor')
    startdstcheck = true
    currentname = name
    SpawnTrolleys2(data, name)
end)

AddEventHandler("np-paleto:cleanUp", function(data, name)
    TriggerServerEvent("np-paleto:setCooldown", name)
    Citizen.Wait(30000)
    for i = 1, 3, 1 do -- full trolley clean
        local obj = GetClosestObjectOfType(data.objects[i].x, data.objects[i].y, data.objects[i].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    for j = 1, 3, 1 do -- empty trolley clean
        local obj = GetClosestObjectOfType(data.objects[j].x, data.objects[j].y, data.objects[j].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_03"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    if DoesEntityExist(IdProp) then
        DeleteEntity(IdProp)
    end
    if DoesEntityExist(IdProp2) then
        DeleteEntity(IdProp2)
    end
    paletoBanks = {}
    initiator = false
end)

function SpawnTrolleys2(data, name)
    RequestModel("hei_prop_hei_cash_trolly_01")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(1)
    end
    Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley1.x, data.trolley1.y, data.trolley1.z, 1, 1, 0)
    Trolley2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley2.x, data.trolley2.y, data.trolley2.z, 1, 1, 0)
    Trolley3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley3.x, data.trolley3.y, data.trolley3.z, 1, 1, 0)
    local h1 = GetEntityHeading(Trolley1)
    local h2 = GetEntityHeading(Trolley2)
    local h3 = GetEntityHeading(Trolley3)

    SetEntityHeading(Trolley1, h1 + paleto.Banks[name].trolley1.h)
    SetEntityHeading(Trolley2, h2 + paleto.Banks[name].trolley2.h)
    SetEntityHeading(Trolley3, h3 + paleto.Banks[name].trolley3.h)
    TriggerServerEvent("np-paleto:startLoot", data, name)
    done = false
end

function StartGrab2(name)
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)
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
                        TriggerServerEvent("np-paleto:rewardCash")
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
	local trollyobj = Trolley
    local emptyobj = GetHashKey("hei_prop_hei_cash_trolly_03")

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
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	DeleteObject(trollyobj)
    exports['np-textui']:hideInteraction()
	Citizen.Wait(1800)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    disableinput = false
end

Citizen.CreateThread(function()
    while true do
        if startdstcheck then
            if initiator then
                local playercoord = GetEntityCoords(PlayerPedId())
                local currentcoords = vector3(-104.8747253418,6472.1274414062,31.621948242188)

                if (GetDistanceBetweenCoords(playercoord, currentcoords, true)) > 20 then
                    LootCheck2[currentname].Stop = true
                    startdstcheck = false
                    TriggerServerEvent("np-paleto:stopHeist", currentname)
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local resettimer = paleto.timer

    while true do
        if startdstcheck then
            if initiator then
                if paleto.timer > 0 then
                    Citizen.Wait(1000)
                    paleto.timer = paleto.timer - 1
                elseif paleto.timer == 0 then
                    startdstcheck = false
                    TriggerServerEvent("np-paleto:stopHeist", currentname)
                    paleto.timer = resettimer
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if paletoBanksTimes < 1 then
            Citizen.Wait(600000)
            TriggerServerEvent('np-paleto:getHitSVSV', 3)
        end
        Citizen.Wait(5)
    end
end)

local hackAnimDict = "anim@heists@ornate_bank@hack"
local function loadDicts()
    RequestAnimDict(hackAnimDict)
    RequestModel("hei_prop_hst_tablet")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(hackAnimDict)
        or not HasModelLoaded("hei_prop_hst_tablet")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(0)
    end
end

RegisterNetEvent("np-paleto:hackinganim")
AddEventHandler("np-paleto:hackinganim", function(toggle)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local plyHeading = GetEntityHeading(ply)
    if toggle == true then
        ClearPedTasksImmediately(ply)
        Wait(0)
        loadDicts()
        Wait(0)
        ClearPedTasksImmediately(ply)
        Wait(0)
        SetEntityHeading(ply, plyHeading)
        Wait(0)
        TaskPlayAnimAdvanced(ply, hackAnimDict, "hack_enter", plyCoords, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
        Wait(0)
        SetEntityHeading(ply, plyHeading)
        while IsEntityPlayingAnim(ply, hackAnimDict, "hack_enter", 3) do
            Wait(0)
        end
        Wait(0)
        TaskPlayAnim(ply, hackAnimDict, "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)
    elseif toggle == false then
        ClearPedTasksImmediately(ply)
    end
end)

RegisterNetEvent("np-paleto:removePlease")
AddEventHandler("np-paleto:removePlease", function()
    if not paletoStateAlready == true then
        TriggerServerEvent('np-paleto:getHitSVSV', paletoBanksTimes - 1)
        TriggerEvent('np-robberies:hackinganim', false)
        FreezeEntityPosition(PlayerPedId(), false)
        ClearPedTasks(PlayerPedId())
        ClearPedTasksImmediately(PlayerPedId())
    end
end)

RegisterNetEvent("np-paleto:addPlease")
AddEventHandler("np-paleto:addPlease", function()
    for k, v in pairs(paletoBanks) do
        local coords = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(coords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)
        if not v.onaction then
            if dst <= 5 and not Check[k] then
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                ClearPedTasksImmediately(PlayerPedId())
                TriggerEvent('np-robberies:hackinganim', false)
                TriggerServerEvent("np-paleto:startcheck", k)
                return
            end
        end
    end
end)

RegisterNetEvent("np-paleto:policenotify")
AddEventHandler("np-paleto:policenotify", function(name)
    local street1 = GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    local gender = IsPedMale(PlayerPedId())
  
    TriggerServerEvent('dispatch:svNotify', {
        dispatchCode = "10-90B",
        firstStreet = street1,
        gender = gender,
        isImportant = true,
		priority = 1,
        dispatchMessage = "Paleto Bank Robbery",
        recipientList = {
          police = "police"
        },
        origin = {
          x = plyPos.x,
          y = plyPos.y,
          z = plyPos.z
        }
    })

    TriggerEvent('np-dispatch:bankrobbery')
end)

RegisterNetEvent("np-paleto:startPaletoHeist")
AddEventHandler("np-paleto:startPaletoHeist", function()
    TriggerServerEvent('np-paleto:getBanksSV')
    TriggerServerEvent('np-paleto:getHitSV')
    TriggerServerEvent('np-paleto:getTimeSV')
    TriggerServerEvent('np-paleto:getTime2SV')
    TriggerServerEvent('np-paleto:getDoorAccessSV')
    Citizen.Wait(1000)
    local countpolice = exports["isPed"]:isPed("countpolice")
    if countpolice >= 0 then
        if not paletoStateAlready == true then
            if paletoTimesHit2 > paletoTimesHit then
                if paletoBanksTimes >= 1 then
                    if exports['np-inventory']:hasEnoughOfItem('electronickit', 1, false) then
                        TriggerEvent('np-paleto:policenotify')
                        TriggerEvent('np-robberies:hackinganim', true)
                        Citizen.Wait(7000)
						exports["hacking"]:hacking(
						function() -- success
						TriggerEvent("inventory:removeItem","electronickit", 1)
						
					end,
					function() --failure
						end)
                    else
                        TriggerEvent('DoLongHudText', 'You do not have the proper hacking equipment!', 2)
                        return
                    end
                else
                    TriggerEvent('DoLongHudText', 'Tablet is overloaded!', 2)
                    return
                end
            else
                TriggerServerEvent('np-paleto:TimePoggers')
            end
        else
            TriggerServerEvent('np-paleto:DoorAccessPoggers')
        end
    else
        TriggerEvent('DoLongHudText', 'Not enough cops on duty!', 2)
        return
    end
end)