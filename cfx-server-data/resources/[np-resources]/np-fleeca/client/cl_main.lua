local banks = {
    [1] = {x = 146.88589477539, y = -1046.0769042969, z = 29.368082046509, h = 244.70774841309, robbing = false, rob = {}},
    [2] = {x = -1210.7919921875, y = -336.4977722168, z = 37.781051635742, h = 296.38696289062, robbing = false, rob = {}},
    [3] = {x = -2956.5356445312, y = 481.47354125977, z = 15.69708442688, h = 358.35528564453, robbing = false, rob = {}},
    [4] = {x = 311.11526489258, y = -284.50228881836, z = 54.164810180664, h = 248.95367431641, robbing = false, rob = {}},
    [5] = {x = -353.90893554688, y = -55.3796043396, z = 49.036602020264, h = 251.66346740723, robbing = false, rob = {}},
    [6] = {x = 1176.0682373047, y = 2712.8735351562, z = 38.088050842285, h = 87.942642211914, robbing = false, rob = {}}
}
local OpenedABank = false
local rAllowed = true
local oDoors = {}

RegisterNetEvent('np-robbery:restartSoon')
AddEventHandler('np-robbery:restartSoon', function()
    rAllowed = false
end)

RegisterNetEvent('np-robbery:openSmallBankDoor')
AddEventHandler('np-robbery:openSmallBankDoor', function(vType)
    local pCoords = GetEntityCoords(PlayerPedId())
    local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 15.0, vType, 0, 0, 0)

    if vDoor == 0 then return end
    local oFactor = 50

    FreezeEntityPosition(vDoor, false)
    local vDoorHeading = GetEntityHeading(vDoor)

    if oDoors[vDoor] == nil then
        if vType == -131754413 then
            oFactor = 90
            --CreateTrollys()
        else
            --CreateTrollys()

        end
        oDoors[vDoor] = true

        for i = 1, 78 do
            SetEntityHeading(vDoor, vDoorHeading - i)
            Citizen.Wait(12)
        end
    elseif oDoors[vDoor] ~= nil then
        if vType == -131754413 and not drawingBoxes then
            --CreateTrollys()
        else
            if vType ~= -131754413 and not drawingBoxesV then
                --CreateTrollys()
            end
        end
    end

    FreezeEntityPosition(vDoor, true)

end)

local drawingBoxes = false
local drawingBoxesV = false




local vaultCard = false

RegisterNetEvent('np-robbery:sBankLoot')
AddEventHandler('np-robbery:sBankLoot', function()

    
    if math.random(100) > 95 then
        if vaultCard then 
            --print('penis')
        else
            TriggerEvent('np-banned:getID', 'Gruppe6Card22', 1)
            vaultCard = true
        end
    else
        local LocalPlayer = exports["np-base"]:getModule("LocalPlayer")
        local Player = LocalPlayer:getCurrentCharacter()
        LocalPlayer:addCash(Player.id, math.random(1500, 4500))
    end

    if math.random(100) > 45 then
        local pick = math.random(4)
        if pick == 1 then
            TriggerEvent("np-banned:getID", "goldbar", math.random(10, 50))
        elseif pick == 2 then
            TriggerEvent("np-banned:getID", "gemstonesapphire", math.random(1, 3))
        elseif pick == 3 then
            TriggerEvent("np-banned:getID", "rolexwatch", math.random(100, 200))
        elseif pick == 4 then
            TriggerEvent("np-banned:getID", "gemstoneaqua", math.random(3, 7))
        end
    end
end)

RegisterNetEvent('np-fleeca:UseGreenLapTop')
AddEventHandler('np-fleeca:UseGreenLapTop', function()
    if exports["isPed"]:isPed("countpolice") >= 0 then

        TriggerEvent('np-dispatch:bankrobbery')
        local bId = GetBankId()

        if not bId then return end
        if not rAllowed then
            TriggerEvent('DoLongHudText', 'It\'s too late to rob this bank.', 2)
            return
        end


        if banks[bId] == nil then return end


        if banks[bId]['robbing'] then
            TriggerEvent('DoLongHudText', 'This bank is already robbed.', 2)
            return
        end
        local ply = PlayerPedId()
        local pCoords = GetEntityCoords(PlayerPedId())
        local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 3.0, 2121050683, 0, 0, 0)
        if vDoor ~= 0 then
            if exports['np-inventory']:hasEnoughOfItem('heistlaptop3', 1) then
                for k, v in pairs(Config.Trollys) do
                    local dist = GetDistanceBetweenCoords(pCoords, v['TaskCoords']['X'], v['TaskCoords']['Y'], v['TaskCoords']['Z'], true)
                    if dist < 3.0 then
                        ClearPedTasksImmediately(ply)
                        Wait(0)
                        TaskGoStraightToCoord(ply, v['TaskCoords']['X'], v['TaskCoords']['Y'], v['TaskCoords']['Z'], 2.0, -1, v['TaskCoords']['H'])

                        local hackAnimDict = "anim@heists@ornate_bank@hack"

                        RequestAnimDict(hackAnimDict)
                        RequestModel("hei_prop_hst_laptop")
                        RequestModel("hei_p_m_bag_var22_arm_s")
                        RequestModel("hei_prop_heist_card_hack_02")
                        while not HasAnimDictLoaded(hackAnimDict) or not HasModelLoaded("hei_prop_hst_laptop") or not HasModelLoaded("hei_p_m_bag_var22_arm_s") or not HasModelLoaded("hei_prop_heist_card_hack_02") do
                            Wait(0)
                        end
                        Wait(0)
                        while GetIsTaskActive(ply, 35) do
                            Wait(0)
                        end
                        ClearPedTasksImmediately(ply)
                        Wait(0)
                        SetEntityHeading(ply, v['TaskCoords']['H'])
                        Wait(0)
                        TaskPlayAnimAdvanced(ply, hackAnimDict, "hack_enter", v['TaskCoords']['X'], v['TaskCoords']['Y'], v['TaskCoords']['Z'], 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
                        Wait(0)
                        SetEntityHeading(ply, v['TaskCoords']['H'])
                        while IsEntityPlayingAnim(ply, hackAnimDict, "hack_enter", 3) do
                            Wait(0)
                        end
                        local laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
                        Wait(5)
                        SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
                        PlaceObjectOnGroundProperly(laptop)
                        Wait(5)
                        TaskPlayAnim(ply, hackAnimDict, "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)
                        
                        Wait(1000)
                    end
                end


                exports['hacking']:OpenHackingGame(function(Success)
                    if Success then
                        OpenedABank = true
                        TriggerEvent("inventory:DegenItemType",10,"heistlaptop3")
                        TriggerEvent("DoLongHudText", "Good Job, You Bypassed the hack wait around 3-5 minutes", 1)						
                        StopAnimTask(PlayerPedId(), hackAnimDict, "hack_loop", 1.0)
                        DeleteObject(laptop)
                        ClearPedTasksImmediately(ply)
                        TriggerServerEvent('np-robbery:PoliceNotifyFleeeee')
                        local timeout = math.random(180000,300000)
                        Citizen.SetTimeout(timeout, function()
                            TriggerServerEvent('np-robbery:smallBankAttempt', bId)
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
            else
                TriggerEvent('DoLongHudText', 'You\'re missing an item!', 2)
            end
        end

        local vDoor = GetClosestObjectOfType(pCoords["x"], pCoords["y"], pCoords["z"], 3.0, -63539571, 0, 0, 0)
        if vDoor ~= 0 then
            exports['hacking']:OpenHackingGame(function(Success)
                if Success then
                    TriggerEvent("inventory:removeItem","heistlaptop3", 1)
                    TriggerServerEvent('np-robbery:smallBankAttempt', bId)
                    TriggerEvent('DoLongHudText', 'System Breached , head inside , QUICK')
                else

                    TriggerEvent("client:newStress",true,100)
                    TriggerEvent('DoLongHudText', 'Breaching faild , better luck next time', 2)
                end
            end)
        end
    else
        TriggerEvent('DoLongHudText', 'Not enough cops around', 2)
    end

end)

RegisterNetEvent('np-robbery:updateBankData')
AddEventHandler('np-robbery:updateBankData', function(bData)
    if bData ~= nil or bData ~= {} then
        banks = bData
        --print(json.encode(banks))
        OpenVaultDoor(true)
    end
end)

function OpenVaultDoor(vType)
    if vType then
        TriggerEvent('np-robbery:openSmallBankDoor', 2121050683)
        TriggerEvent('np-robbery:openSmallBankDoor', -63539571)
    else
        TriggerEvent('np-robbery:openSmallBankDoor', -131754413)
    end
end

function GetBankId()
    local dMin = 999.0

    for i = 1, #banks do
        local dst = #(GetEntityCoords(PlayerPedId()) - vector3(banks[i]['x'], banks[i]['y'], banks[i]['z']))
        if dst < dMin then
            dMin = dst
            bankId = i
        end
    end

    if dMin < 10.0 then
        return bankId
    else
        return false
    end
end


---------------------------------------------------


for k,v in pairs(Config.Trollys) do
    exports["np-polytarget"]:AddBoxZone("RobFleecaasTrolly", vector3(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z']), 1.05, 1, {
        heading= 0
    })
end

local done = false

RegisterNetEvent('np-bankrobbery:client:trolly')
AddEventHandler('np-bankrobbery:client:trolly', function()
    if OpenedABank and not done then
        for Troll, Trolly in pairs(Config.Trollys) do
            local Distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Trolly['Coords']['X'], Trolly['Coords']['Y'], Trolly['Coords']['Z'], true)
            if Distance < 3 then
                if not Trolly['Open-State'] then
                    done = true
                    local amount = math.random(125,250)
                    GetMoneyFromTrolly(Troll)
                    OpenedABank = false
                    Trolly['Open-State'] = true
                    TriggerEvent('player:receiveItem', 'markedbills', amount)
                end

            end
        end
    else
        TriggerEvent('DoLongHudText', 'What the flip are you doing in here.', 2)
    end
end)

function GetMoneyFromTrolly(TrollyNumber)
    local CurrentTrolly = GetClosestObjectOfType(Config.Trollys[TrollyNumber]['Coords']['X'], Config.Trollys[TrollyNumber]['Coords']['Y'], Config.Trollys[TrollyNumber]['Coords']['Z'], 1.0, 269934519, false, false, false)
    local MoneyObject = CreateObject(MoneyModel, GetEntityCoords(GetPlayerPed(-1)), true)
    SetEntityVisible(MoneyObject, false, false)
	AttachEntityToEntity(MoneyObject, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	local GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local GrabOne = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(GetPlayerPed(-1), GrabOne, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabOne, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(GetPlayerPed(-1), 5, 0, 0, 0)
    NetworkStartSynchronisedScene(GrabOne)
    Citizen.Wait(1500)
    GrabbingMoney = true
    SetEntityVisible(MoneyObject, true, true)
    local GrabTwo = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(GetPlayerPed(-1), GrabTwo, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabTwo, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(CurrentTrolly, GrabTwo, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabTwo)
    Citizen.Wait(37000)
    SetEntityVisible(MoneyObject, false, false)
    local GrabThree = NetworkCreateSynchronisedScene(GetEntityCoords(CurrentTrolly), GetEntityRotation(CurrentTrolly), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(GetPlayerPed(-1), GrabThree, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, GrabThree, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(GrabThree)
    NewTrolley = CreateObject(769923921, GetEntityCoords(CurrentTrolly) + vector3(0.0, 0.0, - 0.985), true, false, false)
    SetEntityRotation(NewTrolley, GetEntityRotation(CurrentTrolly))
    GrabbingMoney = false
    TriggerServerEvent('np-bankrobbery:server:set:trolly:state', TrollyNumber, true)
    while not NetworkHasControlOfEntity(CurrentTrolly) do
        Citizen.Wait(1)
        NetworkRequestControlOfEntity(CurrentTrolly)
    end
    DeleteObject(CurrentTrolly)
    while DoesEntityExist(CurrentTrolly) do
        Citizen.Wait(1)
        DeleteObject(CurrentTrolly)
    end
    PlaceObjectOnGroundProperly(NewTrolley)
    Citizen.Wait(1800)
    DeleteEntity(GrabBag)
    DeleteObject(MoneyObject)
    DeleteTrollys()
end

function CreateTrollys()
    RequestModel("hei_prop_hei_cash_trolly_01")
    for k,v in pairs(Config.Trollys) do
        Trolley = CreateObject(269934519, v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'] - 1, 1, 0, 0)
        SetEntityHeading(Trolley, v['Coords']['H'])
	    FreezeEntityPosition(Trolley, true)
	    SetEntityInvincible(Trolley, true)
        PlaceObjectOnGroundProperly(Trolley)
    end
end


function DeleteTrollys()
    for k,v in pairs(Config.Trollys) do
        local obj = GetClosestObjectOfType(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], 0.75, 269934519, false, false, false)
        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
        local obj = GetClosestObjectOfType(v['Coords']['X'], v['Coords']['Y'], v['Coords']['Z'], 0.75, 769923921, false, false, false)
        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
        if DoesEntityExist(CurrentTrolly) then
            DeleteEntity(CurrentTrolly)
        end
        if DoesEntityExist(NewTrolley) then
            DeleteEntity(NewTrolley)
        end
    end
end



RegisterNetEvent('np-bankrobbery:client:set:trolly:state')
AddEventHandler('np-bankrobbery:client:set:trolly:state', function(TrollyNumber, bool)
    Config.Trollys[TrollyNumber]['Open-State'] = bool
end)


RegisterNetEvent('np-bankrobbery:client:CreateTrollysEvent')
AddEventHandler('np-bankrobbery:client:CreateTrollysEvent', function()
    CreateTrollys()
end)
---------------------------------------------------
AddEventHandler('onResourceStop', function (resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    DeleteTrollys()
    Wait(1000)
    return
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    DeleteTrollys()
    -- Only for test
    --CreateTrollys()
    return
end)


