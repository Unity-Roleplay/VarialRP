local firstlowerdoor = false
local firstpindoor = false
local secpindoor = false
local thirdpindoor = false
local fourthpindoor = false
local vaultdoor = false
local laptoppin = false


--[[RegisterNetEvent('dark-sikis:closevaultlower')
AddEventHandler('dark-sikis:closevaultlower', function()
    RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vaultmilo")

    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)

    EnableInteriorProp(interiorid, "np_vault_clean")
   -- DisableInteriorProp(interiorid, "np_vault_broken")
   -- DisableInteriorProp(interiorid, "np_vault_blocked")

    RefreshInterior(interiorid)
end)

RegisterNetEvent('dark-sikis:blockedvaultlower')
AddEventHandler('dark-sikis:blockedvaultlower', function()
    RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vaultmilo")

    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)

    EnableInteriorProp(interiorid, "np_vault_clean")
   -- DisableInteriorProp(interiorid, "np_vault_broken")
  --  EnableInteriorProp(interiorid, "np_vault_blocked")

    RefreshInterior(interiorid)
end)]]

RegisterNetEvent('dark-sikis:openvaultlower')
AddEventHandler('dark-sikis:openvaultlower', function()
    RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vaultmilo")

    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)

    DisableInteriorProp(interiorid, "np_vault_clean")
    EnableInteriorProp(interiorid, "np_vault_broken")
    DisableInteriorProp(interiorid, "np_vault_blocked")

    RefreshInterior(interiorid)
end)

Citizen.CreateThread(function()
    RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vaultmilo")

    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)

    EnableInteriorProp(interiorid, "np_vault_clean")
    DisableInteriorProp(interiorid, "np_vault_broken")
    DisableInteriorProp(interiorid, "np_vault_blocked")

    RefreshInterior(interiorid)
end)

function refreshVaultDoor()
    RequestIpl("np_int_placement_ch_interior_6_dlc_casino_vaultmilo")
    local interiorid = GetInteriorAtCoords(259.2812, 203.5071, 96.77954)
    for k, s in pairs(bicBoiVaultDoorStates) do
        DisableInteriorProp(interiorid, k)
    end
    for k, s in pairs(bicBoiVaultDoorStates) do
        if s then
            EnableInteriorProp(interiorid, k)
        end
    end
    RefreshInterior(interiorid)

    RequestIpl("hei_hw1_02_interior_2_heist_ornate_bankmilo")
    interiorid = GetInteriorAtCoords(247.913, 218.042, 105.283)
    for k, s in pairs(upperVaultEntityState) do
      DisableInteriorProp(interiorid, k)
    end
    for k, s in pairs(upperVaultEntityState) do
      if s then
        EnableInteriorProp(interiorid, k)
      end
    end
    RefreshInterior(interiorid)
end

function openanim()
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

    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", 272.50, 231.1, 97.36, 272.50, 231.1, 97.36, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", 272.50, 231.1, 97.36, 272.50, 231.1, 97.36, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 272.50, 231.1, 97.36, 272.50, 231.1, 97.36, 0, 2)

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
    Citizen.Wait(1500)
end

function cancelanim()
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
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", 272.50, 231.1, 97.36, 272.50, 231.1, 97.36, 0, 2)
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

RegisterNetEvent('dark-vaultrob:lower:firstdoor')
AddEventHandler('dark-vaultrob:lower:firstdoor', function()
	local ped = PlayerPedId()
    local playercoords = GetEntityCoords(ped)
	local firstdoorlowerlocation = vector3(271.99, 230.84, 97.36)
    local deleternd = math.random(1,100)
    -- if secdoorshmm then
        if exports["isPed"]:isPed("countpolice") >= 1 then
        if exports["np-inventory"]:hasEnoughOfItem("heistlaptop1", 1) then
            if not firstlowerdoor then
                if #(playercoords - firstdoorlowerlocation) < 3.0 then
                    TaskGoStraightToCoord(PlayerPedId(), 271.99, 230.84, 97.36, 1.0, -1, 337.34, 0.0)
                    Wait(5000)
                    openanim()
                    exports['hacking']:OpenHackingGame(function(Success)
                        if Success then
                            if deleternd <= 100 and deleternd > 20 then
                                TriggerEvent('inventory:removeItem', 'heistlaptop1', 1)
                            end
                            firstlowerdoor = true
                            TriggerServerEvent("np-doors:change-lock-state", 278)
                            print("firstlowerdoor")
                            TriggerServerEvent("np-doors:change-lock-state", 279)
                            cancelanim()
                            LVaultNotfi()
                        else
                            if deleternd <= 100 and deleternd > 20 then
                                TriggerEvent('inventory:removeItem', 'heistlaptop1', 1)
                            end
                            firstlowerdoor = false
                            cancelanim()
                        end 
                    end)
                end
            else
                TriggerEvent("notification", "Already opened", 2)
            end
        else
            TriggerEvent("notification", "Something is missing", 2)
        end
        end
    -- end
end)

RegisterNetEvent('dark-sikis:openvaultdoor_ITSLOWER')
AddEventHandler('dark-sikis:openvaultdoor_ITSLOWER', function()
    TriggerEvent('dark-sikis:openvaultlower')
end)

RegisterCommand('`trolley`', function()
    SpawnLwTrolleys()
end)

RegisterNetEvent('dark-vaultrob:lower:vaultdoor')
AddEventHandler('dark-vaultrob:lower:vaultdoor', function(s, args)
    local ped = PlayerPedId()
    local PLAYER_COORDS = GetEntityCoords(ped)
    local vaultdoorlowerlocation = vector3(284.13, 223.26, 98.24)
    if #(PLAYER_COORDS - vaultdoorlowerlocation) < 20.0 and not vaultdoor then
        vaultdoor = true
        AddExplosion(284.13, 223.26, 98.24, 37, 150000.0, true, false, 4.0)
        TriggerEvent('dark-sikis:openvaultdoor_ITSLOWER')
        ExecuteCommand('`trolley`')
        Wait(1800000)
        TriggerEvent("dark-sikis:LOWERVAULT_REFRESH")
    end
end)

RegisterNetEvent("dark-sikis:LOWERVAULT_REFRESH")
AddEventHandler("sikis:LOWERVAULT_REFRESH", function()
    laptoppin = false
    firsttrolleylower = false
    sectrolleylower = false
    thirddlowertrolley = false
    fourthtrolleylower = false
    fifthtrolleylower = false
    sixthtrolleylower = false
    trolleyleryerinemi = false
    sextrolley = false

    if firstlowerdoor then
        TriggerServerEvent("np-doors:change-lock-state", 278)
        TriggerServerEvent("np-doors:change-lock-state", 279)
    end

    if vaultdoor then
        vaultdoor = false
        TriggerEvent('dark-sikis:blockedvaultlower')
        Citizen.Wait(900000)
        TriggerEvent('dark-sikis:closevaultlower')
    end

    if firstpindoor and secpindoor and thirdpindoor and fourthpindoor then
        TriggerServerEvent("np-doors:change-lock-state", 280)
    end
    Wait(2000)
    vaultdoor = false
    firstlowerdoor = false
    firstpindoor = false
    secpindoor = false
    thirdpindoor = false
    fourthpindoor = false  
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

RegisterNetEvent("dark-vaultrob:lower:fourpincontrol")
AddEventHandler("dark-vaultrob:lower:fourpincontrol", function()
    if laptoppin then
    TriggerServerEvent("np-doors:change-lock-state", 325)
    print('all completed')
    end
end)

RegisterNetEvent('dark-vaultrob:lower:laptoppin')
AddEventHandler('dark-vaultrob:lower:laptoppin', function()
    local deleternd = math.random(1,100)
    if exports["np-inventory"]:hasEnoughOfItem("vcomputerusb", 1) and exports ["np-inventory"]:hasEnoughOfItem("lvaccesscodes", 1)  then
        if not laptoppin  then
            if deleternd <= 100 and deleternd > 20 then
                TriggerEvent('inventory:removeItem', 'vcomputerusb', 1)
            end
            exports['vaultpasswordmg']:OpenHackingGame(10, function(success)
                if success then
                    laptoppin = true
                    TriggerEvent('inventory:removeItem', 'lvaccesscodes', 1) 
                    TriggerEvent('inventory:removeItem', 'vcomputerusb', 1)
                    TriggerEvent("dark-vaultrob:lower:fourpincontrol")
                else
                    laptoppin = false
                end
            end)
        else 
            TriggerEvent("notification", "Already hacked!",2)
        end
    else 
        TriggerEvent("notification","Something is missing!", 2)
    end
end)





--[[RegisterNetEvent('dark-vaultrob:lower:firstpindoor')
AddEventHandler('dark-vaultrob:lower:firstpindoor', function()
    if not firstpindoor  then
        exports['vaultpasswordmg']:OpenHackingGame(6, function(success)
            if success then
                firstpindoor = true
                TriggerEvent("dark-vaultrob:lower:fourpincontrol")
            else
                firstpindoor = false
            end
        end)
    else 
        print('Already hacked!')
    end
end)

RegisterNetEvent('dark-vaultrob:lower:secpindoor')
AddEventHandler('dark-vaultrob:lower:secpindoor', function()
    if not secpindoor then
        exports['vaultpasswordmg']:OpenHackingGame(6, function(success)
            if success then
                secpindoor = true
               -- TriggerEvent("dark-vaultrob:lower:fourpincontrol")
            else
                secpindoor = false
            end
        end)
    else 
        print('Already hacked!')
    end
end)

RegisterNetEvent('dark-vaultrob:lower:thirdpindoor')
AddEventHandler('dark-vaultrob:lower:thirdpindoor', function()
    if not thirdpindoor then
        exports['vaultpasswordmg']:OpenHackingGame(6, function(success)
            if success then
                thirdpindoor = true
               -- TriggerEvent("dark-vaultrob:lower:fourpincontrol")
            else
                thirdpindoor = false
            end
        end)
    else 
        print('Already hacked!')
    end
end)

RegisterNetEvent('dark-vaultrob:lower:fourthpindoor')
AddEventHandler('dark-vaultrob:lower:fourthpindoor', function()
    if not fourthpindoor then
        exports['vaultpasswordmg']:OpenHackingGame(6, function(success)
            if success then
                fourthpindoor = true
                TriggerEvent("dark-vaultrob:lower:fourpincontrol")
            else
                fourthpindoor = false
            end
        end)
    else 
        print('Already hacked!')
    end
end)]]
