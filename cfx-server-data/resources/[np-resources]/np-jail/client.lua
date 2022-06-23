local inmate = 0

relogging = false
cellcoords = { 
    [1] = { ['x'] = 1767.7978515625, ['y'] = 2500.5495605469, ['z'] = 45.725219726562, ['h'] = 209.76377868652, ['info'] = ' cell1' },
    [2] = { ['x'] = 1764.6988525391, ['y'] = 2498.8220214844, ['z'] = 45.725219726562, ['h'] = 209.76377868652, ['info'] = ' cell2' },
    [3] = { ['x'] = 1761.3231201172, ['y'] = 2497.1604003906, ['z'] = 45.725219726562, ['h'] = 206.92913818359, ['info'] = ' cell3' },
    [4] = { ['x'] = 1755.5208740234, ['y'] = 2493.3889160156, ['z'] = 45.725219726562, ['h'] = 206.92913818359, ['info'] = ' cell4' },
    [5] = { ['x'] = 1751.6571044922, ['y'] = 2492.2153320312, ['z'] = 45.725219726562, ['h'] = 209.76377868652, ['info'] = ' cell5' },
    [6] = { ['x'] = 1748.8879394531, ['y'] = 2489.3273925781, ['z'] = 45.725219726562, ['h'] = 209.76377868652, ['info'] = ' cell6' },
    [7] =  { ['x'] = 1767.4154052734, ['y'] = 2500.9714355469, ['z'] = 49.684936523438, ['h'] = 218.2677154541, ['info'] = ' cell7' },
    [8] =  { ['x'] = 1764.6329345703, ['y'] = 2498.9802246094, ['z'] = 49.684936523438, ['h'] = 206.92913818359, ['info'] = ' cell8' },
    [9] =  { ['x'] = 1761.5340576172, ['y'] = 2497.3317871094, ['z'] = 49.684936523438, ['h'] = 204.09449768066, ['info'] = ' cell9' },
    [10] = { ['x'] = 1758.2241210938, ['y'] = 2495.4196777344, ['z'] = 49.684936523438, ['h'] = 206.92913818359, ['info'] = ' cell10' },
    [11] = { ['x'] = 1755.0461425781, ['y'] = 2493.4943847656, ['z'] = 49.684936523438, ['h'] = 206.92913818359, ['info'] = ' cell11' },
    [12] = { ['x'] = 1774.2857666016, ['y'] = 2481.1779785156, ['z'] = 49.684936523438, ['h'] = 25.511810302734, ['info'] = ' cell12' },
    [13] = { ['x'] = 1777.3450927734, ['y'] = 2483.4990234375, ['z'] = 49.684936523438, ['h'] = 28.346454620361,['info'] = ' cell13' },
    [14] = { ['x'] = 1776.9099121094, ['y'] = 2483.841796875, ['z'] = 45.725219726562, ['h'] = 31.181098937988, ['info'] = ' cell14' },
    [15] = { ['x'] = 1773.9956054688, ['y'] = 2481.5209960938, ['z'] = 45.725219726562, ['h'] = 28.346454620361, ['info'] = ' cell15' },
    [16] = { ['x'] = 1770.7780761719, ['y'] = 2479.8989257812, ['z'] = 45.725219726562, ['h'] = 31.181098937988, ['info'] = ' cell16' },
    [17] = { ['x'] = 1767.82421875, ['y'] = 2477.6176757812, ['z'] = 45.725219726562, ['h'] = 31.181098937988, ['info'] = ' cell17' },
    [18] = { ['x'] = 1764.3033447266, ['y'] = 2476.6286621094, ['z'] = 45.725219726562, ['h'] = 34.015747070312, ['info'] = ' cell18' },
    [19] = { ['x'] = 1761.7054443359, ['y'] = 2474.5187988281, ['z'] = 45.725219726562, ['h'] = 51.023620605469, ['info'] = ' cell19' },
    [20] = { ['x'] = 1758.2769775391, ['y'] = 2472.8967285156, ['z'] = 45.725219726562, ['h'] = 31.181098937988, ['info'] = ' cell20' },
}


local mycell = 1




imjailed = false
curTaskType = "None"
jobProcess = false
lockdown = false

secondOfDay = 19801
RegisterNetEvent('kTimeSync')
AddEventHandler("kTimeSync", function( data )
    secondOfDay = data
end)

RegisterNetEvent('jailbreak:reclaimitems')
AddEventHandler('jailbreak:reclaimitems', function(table)
    local sexcid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("server-jail-item", 'ply-'..sexcid, false)
    TriggerEvent("DoLongHudText", "You have re-claimed your possessions.")
end)

Citizen.CreateThread(function()
    while true do
        playerCoords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(1000)
    end
end)


function drink()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "mp_player_intdrink" ) 

    TaskPlayAnim( PlayerPedId(), "mp_player_intdrink", "loop_bottle", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(5000)

    endanimation()
end

function endanimation()
    ClearPedSecondaryTask(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end



function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


Controlkey = {["generalUse"] = {38,"E"},["generalUseThird"] = {47,"G"} ,["housingMain"] = {74,"H"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalUse"] = table["generalUse"]
    Controlkey["generalUseThird"] = table["generalUseThird"]
    Controlkey["housingMain"] = table["housingMain"]
end)

RegisterNetEvent('beginJail2')
AddEventHandler('beginJail2', function(time,skipintake)
    TriggerEvent("beginJail",skipintake,tonumber(time))
end)

function JailIntro(name,years,cid,date)
    if tonumber(years) > 40 then
        local cid = exports["isPed"]:isPed("cid")
        TriggerServerEvent("shops:jail:remove",cid)
    end
    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'handcuff', 1.0)

    
    TriggerEvent("police:remmaskAccepted")
    TriggerServerEvent("request:vinewooddel")
    Citizen.Wait(1000)

    local timer = 0
    while timer ~= -1 do
        timer = timer + 1
        Citizen.Wait(1)

        SetEntityCoords(PlayerPedId(),472.7355, -1011.272, 25.27331)
        if IsInteriorReady(GetInteriorAtCoords(472.7355, -1011.272, 25.27331)) or timer > 1000 then
            timer = -1
        end
    end



    SetEntityCoords(PlayerPedId(),472.7355, -1011.272, 25.27331)
    SetEntityHeading(PlayerPedId(),178.9855)
    Citizen.Wait(1500) 
    DoScreenFadeIn(500)
    TriggerEvent("attachItemCONLOL","con1",name,years,cid,date)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)     
    SetEntityHeading(PlayerPedId(),269.3963) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)  
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)         
    SetEntityHeading(PlayerPedId(),89.3215) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
     TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)       

    SetEntityHeading(PlayerPedId(),178.9855)

    Citizen.Wait(2000)
    DoScreenFadeOut(1100)   
    Citizen.Wait(2000)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'jaildoor', 1.0)

end
DoScreenFadeIn(1500)
SwappingCharacters = false
outofrange = false
minutes = 0
function GroupRank(groupid)
  local rank = 0
  local mypasses = exports["isPed"]:isPed("passes")
  for i=1, #mypasses do
    if mypasses[i]["pass_type"] == groupid then
      rank = mypasses[i]["rank"]
    end 
  end
  return rank
end

function RoleplayStats()

    local totalroleplay = 0

    if exports["np-inventory"]:hasEnoughOfItem("shitlockpick",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if exports["np-inventory"]:hasEnoughOfItem("jailfood",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if exports["np-inventory"]:hasEnoughOfItem("methbag",1,false) then
        totalroleplay = totalroleplay + 15
    end

    if exports["np-inventory"]:hasEnoughOfItem("assphone",1,false) then
        totalroleplay = totalroleplay + 15
        if math.random(10) < 3 then
             TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'pager', 0.4)
        end
    end

    if exports["np-inventory"]:hasEnoughOfItem("slushy",1,false) then
        totalroleplay = totalroleplay + 10
    end

    if math.random(70) < totalroleplay then
        TriggerEvent("DoLongHudText","All that roleplay adds up!")
        Wait(1000)
        TriggerServerEvent("jail:cuttime")
    end

end

function InmateHasAll()
    if exports["np-inventory"]:hasEnoughOfItem("slushy",1,false)
        and
        exports["np-inventory"]:hasEnoughOfItem("-1810795771",1,false)
        and
        exports["np-inventory"]:hasEnoughOfItem("methbag",1,false)
        and
        exports["np-inventory"]:hasEnoughOfItem("assphone",1,false)
        and
        exports["np-inventory"]:hasEnoughOfItem("slushy",1,false)
    then
        return true
    else
        return false
    end
end

function InmateAnim()
    if ( DoesEntityExist( inmate ) and not IsEntityDead( inmate ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( inmate, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function InmateDelete()
    if DoesEntityExist(inmate) then 
        SetPedAsNoLongerNeeded(inmate)
        DeletePed(inmate)
    end
end
function InmateCreate()
    local hashKey = -1313105063
    local pedType = 5
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
    inmate = CreatePed(pedType, hashKey, 1642.08, 2522.16, 45.57, 43.62, false, false)
    DecorSetBool(inmate, 'ScriptedPed', true)
end

function InmatePedSettings()
    DecorSetBool(inmate, 'ScriptedPed', true)
    SetEntityInvincible(inmate,true)
    ClearPedTasks(inmate)
    ClearPedSecondaryTask(inmate)
    TaskSetBlockingOfNonTemporaryEvents(inmate, true)
    SetPedFleeAttributes(inmate, 0, 0)
    SetPedCombatAttributes(inmate, 17, 1)
    SetPedSeeingRange(inmate, 0.0)
    SetPedHearingRange(inmate, 0.0)
    SetPedAlertness(inmate, 0)
    SetPedKeepTask(inmate, true)
end

RegisterNetEvent('beginJail')
AddEventHandler('beginJail', function(skipintake,time,name,cid,date)

    TriggerServerEvent("TacoShop:reputationChange",-20)

    imjailed = false
    local playerPed = PlayerPedId()
    local mycid = exports["isPed"]:isPed("cid")

    local gang = exports["isPed"]:isPed("gang")
    if gang == 4 then
        TriggerServerEvent("wipeweed")
    end    

    TriggerEvent("DensityModifierEnable",false)
    mycell = math.random(1,20)
    minutes = tonumber(time)


    if not skipintake then
        JailIntro(name,time,cid,date)
    end
    FreezeEntityPosition(playerPed, false)
    
    
    TriggerEvent("shop:createMeth")

    minCalc = 15000

    DoScreenFadeOut(1)
    TriggerServerEvent('server-jail-item', 'ply-'..mycid, true)
    if mycell == nil then
        mycell = 1
    end
    
    SetEntityCoords(playerPed, cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z ) 

    TriggerServerEvent("updateJailTime",minutes)
 
    InmateDelete()
    InmateCreate()
    InmatePedSettings()
    InmateAnim()
    local jailluck = math.random(100)
    if minutes > 60 then
        jailluck = jailluck - math.ceil(minutes/10)
    end


    Citizen.Wait(500)
    TriggerEvent("doors:resetTimer")
    FreezeEntityPosition(playerPed, false)
    DoScreenFadeIn(1500)
    TriggerEvent("falseCuffs")  

    
    imjailed = true
    RemoveAllPedWeapons(playerPed)
    TriggerEvent("attachWeapons")
    TriggerEvent("DoLongHudText", "You have been jailed. You can pick up your shit when you leave.")
    TriggerEvent("inhotel",false)
    while imjailed do
        Citizen.Wait(1)

        if minCalc == 0 then
            playerPed = PlayerPedId()
            minCalc = 15000
            RoleplayStats()
            TriggerServerEvent("checkJailTime",false)
        end


        if (#(GetEntityCoords(playerPed, 0) - vector3(1642.08, 2522.16, 45.57)) < 1.0) then
            drawTxt(0.90, 1.40, 1.0,1.0,0.25, "Inmates looking like he wants something..?", 255, 255, 255, 255)
            if IsControlJustPressed(1, Controlkey["generalUse"][1]) then
                TriggerEvent("server-inventory-open", "997", "Craft");                   
                Citizen.Wait(5000)
            end
        end


        if (#(GetEntityCoords(playerPed) - vector3(cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z)) > 340) then
            SetEntityCoords(playerPed, cellcoords[mycell].x,cellcoords[mycell].y,cellcoords[mycell].z) 
        end

        minCalc = minCalc - 1
    end
    if relogging then
        return
    end
    
    RemoveBlip(Blip)
    TriggerEvent("DensityModifierEnable",true)
end)

RegisterNetEvent('np-jail:checkTime')
AddEventHandler('np-jail:checkTime', function()
    TriggerServerEvent("checkJailTime",true)
end)

RegisterNetEvent('swappingCharsLoop')
AddEventHandler('swappingCharsLoop', function()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    TriggerEvent("np-base:clearStates")
    exports["np-base"]:getModule("SpawnManager"):Initialize()
    relogging = true
    imjailed = false
    -- trigger character swap
    Wait(4000)
    relogging = false
end)

RegisterNetEvent('TimeRemaining')
AddEventHandler('TimeRemaining', function(TimeRemaining, release)

    local playerPed = GetPlayerPed(-1)

    local TimeR = TimeRemaining

    if TimeR <= 0 and release then 
       imjailed = false
        TriggerEvent("DoLongHudText", "You are free!.",1)
        TriggerEvent("givePhone")
        SetEntityCoords(playerPed, 1837.1076660156,2589.7319335938,46.01171875)
        SetEntityHeading(playerPed, 204.09449768066)
       
    else

    local minutes = TimeR
    TriggerEvent("chatMessage", "DOC | " , 2, "You have " .. minutes .. " month(s) remaining")
    end
end)

RegisterNetEvent('endJailTime')
AddEventHandler('endJailTime', function()
    imjailed = false
    TriggerEvent("DoLongHudText", "You are free!.",1)
    --TriggerServerEvent("server:currentpasses")
    SetEntityCoords(GetPlayerPed(-1), 1837.36, 2588.35, 46.01)
end)


RegisterNetEvent('beginJail3')
AddEventHandler('beginJail3', function(time)
    TriggerEvent("beginJailMobster",tonumber(time))
end)

RegisterNetEvent('beginJailMobster')
AddEventHandler('beginJailMobster', function(time)
    imjailedmobster = true
    minutes = tonumber(time)
    TriggerEvent("DensityModifierEnable",false)
    minutes = tonumber(minutes) >= 120 and 120 or tonumber(minutes)
    TriggerEvent("DoLongHudText", "You were dumped here.. weird.",1)
    minCalc = 60
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), 143.79208374023,-2201.6572265625,4.6880202293396) 
    TriggerServerEvent("updateJailTimeMobster",minutes)
    TriggerEvent("falseCuffs")  


        while imjailedmobster do
            Citizen.Wait(1000)
            RemoveAllPedWeapons(PlayerPedId())
            TriggerEvent("attachWeapons")
            if minCalc < 1 then
                
                minCalc = 60
                minutes = minutes - 1
                TriggerEvent("DoLongHudText", "You have " .. minutes .. " minutes remaining",1)
                TriggerServerEvent("updateJailTimeMobster",minutes)
            end

            if (#(GetEntityCoords(PlayerPedId(), 0) - vector3(143.79208374023,-2201.6572265625,4.6880202293396)) > 5) then
                SetEntityCoords(PlayerPedId(), 143.79208374023,-2201.6572265625,4.6880202293396) 
            end

            if minutes < 2 then
                imjailedmobster = false
            end

            minCalc = minCalc - 1
        end

        TriggerServerEvent("updateJailTimeMobster",0)
        TriggerEvent("DoLongHudText", "You were dumped here.. weird.",1)
        SetEntityCoords(PlayerPedId(), 164.2027130127,-1721.9739990234,29.291980743408)

        TriggerEvent("DensityModifierEnable",true)
end)

lifeCellCoords = {
    {-3.5171592235565,-670.67626953125,16.130613327026}, 
    {-5.1028943061829,-676.06817626953,16.130613327026}, 
    {0.22147338092327,-659.54638671875,16.130613327026}, 
    {11.018131256104,-662.85894775391,16.130613327026}, 
    {4.3471856117249,-679.97094726563,16.130613327026}, 
}

selectedCell = 0

RegisterNetEvent('beginJail4')
AddEventHandler('beginJail4', function(imjailedLife)
    TriggerEvent("beginJailLife",imjailedLife)
end)

RegisterNetEvent('beginJailLife')
AddEventHandler('beginJailLife', function(imjailedLife)
    local rnd = math.random(1,5)
    selectedCell = rnd
    TriggerEvent("DensityModifierEnable",false)
    TriggerEvent("DoLongHudText", "You are on Life Sentence.",1)
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(),lifeCellCoords[selectedCell][1],lifeCellCoords[selectedCell][2],lifeCellCoords[selectedCell][3]) 
    TriggerEvent("falseCuffs")  
    DoScreenFadeIn(1500)
    if imjailedLife then
        while imjailedLife do
            Citizen.Wait(1000)
            RemoveAllPedWeapons(PlayerPedId())
            TriggerEvent("attachWeapons")

            if #(GetEntityCoords(PlayerPedId()) - vector3(1.8283240795135,-672.43591308594,16.130613327026)) > 100 then
                SetEntityCoords(PlayerPedId(), lifeCellCoords[selectedCell][1],lifeCellCoords[selectedCell][2],lifeCellCoords[selectedCell][3]) 
            end

            if selectedCell == 0 then break end
        end
    else
        selectedCell = 0
    end

    TriggerEvent("DoLongHudText", "You were removed from High Sec.",1)
    SetEntityCoords(PlayerPedId(), -1.1144685745239,-679.89410400391,16.130630493164)

    TriggerEvent("DensityModifierEnable",true)
end)

function DrawText3D(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

-- Electrical Job Jail --
local CleaningJobInProgress = false
local ElectricalJobInProgress = false
local ElectricalJob1 = false
local ElectricalJob2 = false
local ElectricalJob3 = false
local ElectricalJob4 = false
local ElectricalJob5 = false
local ElectricalJob6 = false
local ElectricalJob7 = false
local ElectricalJob8 = false
local CleaningJob1 = false
local CleaningJob2 = false
local CleaningJob3 = false
local CleaningJob4 = false

-- Job 


    
 
exports["np-polytarget"]:AddBoxZone("np_cleaning_job_1", vector3(1782.2202148438, 2550.9536132813, 45.6731300354), 1, 1.8, {
    heading=270,
    minZ=41.77,
    maxZ=45.77
})

exports["np-interact"]:AddPeekEntryByPolyTarget("np_cleaning_job_1", {
{
    event = "np-jail:work-clean-1",
    id = "np_cleaning_job_1",
    icon = "circle",
    label = "Clean Table",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return CleaningJob1
    end,
});

RegisterNetEvent('np-jail:work-clean-1')
AddEventHandler('np-jail:work-clean-1', function()
    TriggerEvent("animation:PlayAnimation","cleanfront")
    FreezeEntityPosition(PlayerPedId(), true)
    CleaningJob1 = false
    local finished = exports['np-taskbar']:taskBar(7500, 'Cleaning Dirty Table')
    if finished == 100 then
        CleaningJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('np-jail:remove-time-electrical')
        RemoveBlip(CleaningJobBlip1)
        TriggerServerEvent("checkJailTime",true)
    end
end)


exports["np-polytarget"]:AddBoxZone("np_cleaning_job_2", vector3(1753.0953369141, 2479.9479980469, 45.814468383789), 2, 3.4, {
    heading=0,
    minZ=42.96,
    maxZ=46.96
})

exports["np-interact"]:AddPeekEntryByPolyTarget("np_cleaning_job_2", {
{
    event = "np-jail:work-clean-2",
    id = "np_cleaning_job_2",
    icon = "circle",
    label = "Clean Table",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return CleaningJob2
    end,
});

RegisterNetEvent('np-jail:work-clean-2')
AddEventHandler('np-jail:work-clean-2', function()
    TriggerEvent("animation:PlayAnimation","cleanfront")
    FreezeEntityPosition(PlayerPedId(), true)
    CleaningJob2 = false
    local finished = exports['np-taskbar']:taskBar(7500, 'Cleaning Dirty Table')
    if finished == 100 then
        CleaningJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('np-jail:remove-time-electrical')
        RemoveBlip(CleaningJobBlip2)
        TriggerServerEvent("checkJailTime",true)
    end
end)

exports["np-polytarget"]:AddBoxZone("np_cleaning_job_3", vector3(1691.5657958984, 2454.7487792969, 45.842662811279), 2, 3.8, {
    heading=0,
    minZ=43.16,
    maxZ=47.16
})

exports["np-interact"]:AddPeekEntryByPolyTarget("np_cleaning_job_3", {
{
    event = "np-jail:work-clean-3",
    id = "np_cleaning_job_3",
    icon = "circle",
    label = "Clean Table",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return CleaningJob3
    end,
});

RegisterNetEvent('np-jail:work-clean-3')
AddEventHandler('np-jail:work-clean-3', function()
    TriggerEvent("animation:PlayAnimation","cleanfront")
    FreezeEntityPosition(PlayerPedId(), true)
    CleaningJob3 = false
    local finished = exports['np-taskbar']:taskBar(7500, 'Cleaning Dirty Table')
    if finished == 100 then
        CleaningJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('np-jail:remove-time-electrical')
        RemoveBlip(CleaningJobBlip3)
        TriggerServerEvent("checkJailTime",true)
    end
end)


exports["np-polytarget"]:AddBoxZone("np_cleaning_job_4", vector3(1742.0379638672, 2540.8752441406, 45.552787780762), 2, 2.2, {
    heading=270,
    minZ=43.36,
    maxZ=47.36
})

exports["np-interact"]:AddPeekEntryByPolyTarget("np_cleaning_job_4", {
{
    event = "np-jail:work-clean-4",
    id = "np_cleaning_job_4",
    icon = "circle",
    label = "Clean Table",
    parameters = {},
}
}, {
    distance = { radius = 1.5 },
    isEnabled = function()
        return CleaningJob4
    end,
});

RegisterNetEvent('np-jail:work-clean-4')
AddEventHandler('np-jail:work-clean-4', function()
    TriggerEvent("animation:PlayAnimation","cleanfront")
    FreezeEntityPosition(PlayerPedId(), true)
    CleaningJob4 = false
    local finished = exports['np-taskbar']:taskBar(7500, 'Cleaning Dirty Table')
    if finished == 100 then
        CleaningJobInProgress = false
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerServerEvent('np-jail:remove-time-electrical')
        RemoveBlip(CleaningJobBlip4)
        TriggerServerEvent("checkJailTime",true)
    end
end)




    -- Electrical Job 1 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_1", vector3(1690.0740966797, 2565.6911621094, 45.552783966064), 1, 1.8, {
        heading=270,
        minZ=41.77,
        maxZ=45.77
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_1", {
    {
        event = "np-jail:work-box-1",
        id = "np_electrical_job_1",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob1
        end,
    });

    RegisterNetEvent('np-jail:work-box-1')
    AddEventHandler('np-jail:work-box-1', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob1 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip1)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 2 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_2", vector3(1652.4403076172, 2564.0366210938, 45.55286026001), 2, 3.4, {
        heading=0,
        minZ=42.96,
        maxZ=46.96
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_2", {
    {
        event = "np-jail:work-box-2",
        id = "np_electrical_job_2",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob2
        end,
    });

    RegisterNetEvent('np-jail:work-box-2')
    AddEventHandler('np-jail:work-box-2', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob2 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip2)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 3 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_3", vector3(1629.8048095703, 2563.9721679688, 45.55277633667), 2, 3.8, {
        heading=0,
        minZ=43.16,
        maxZ=47.16
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_3", {
    {
        event = "np-jail:work-box-3",
        id = "np_electrical_job_3",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob3
        end,
    });

    RegisterNetEvent('np-jail:work-box-3')
    AddEventHandler('np-jail:work-box-3', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob3 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip3)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 4 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_4", vector3(1618.9591064453, 2521.3957519531, 45.552787780762), 2, 2.2, {
        heading=270,
        minZ=43.36,
        maxZ=47.36
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_4", {
    {
        event = "np-jail:work-box-4",
        id = "np_electrical_job_4",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob4
        end,
    });

    RegisterNetEvent('np-jail:work-box-4')
    AddEventHandler('np-jail:work-box-4', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob4 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip4)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 5 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_5", vector3(1667.9653320313, 2488.6357421875, 45.552783966064), 1, 1, {
        heading=315,
        minZ=42.77,
        maxZ=46.77
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_5", {
    {
        event = "np-jail:work-box-5",
        id = "np_electrical_job_5",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob5
        end,
    });

    RegisterNetEvent('np-jail:work-box-5')
    AddEventHandler('np-jail:work-box-5', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob5 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip5)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 6 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_6", vector3(1718.9182128906, 2488.7609863281, 45.546569824219), 1, 1, {
        heading=315,
        minZ=42.77,
        maxZ=46.77
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_6", {
    {
        event = "np-jail:work-box-6",
        id = "np_electrical_job_6",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob6
        end,
    });

    RegisterNetEvent('np-jail:work-box-6')
    AddEventHandler('np-jail:work-box-6', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob6 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip6)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 7 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_7", vector3(1627.1922607422, 2489.9975585938, 45.625026702881), 1, 1, {
        heading=315,
        minZ=42.76,
        maxZ=46.76
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_7", {
    {
        event = "np-jail:work-box-7",
        id = "np_electrical_job_7",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob7
        end,
    });

    RegisterNetEvent('np-jail:work-box-7')
    AddEventHandler('np-jail:work-box-7', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob7 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip7)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    -- Electrical Job 8 
    exports["np-polytarget"]:AddBoxZone("np_electrical_job_8", vector3(1686.8961181641, 2533.5595703125, 45.552780151367), 2, 2.2, {
        heading=275,
        minZ=43.36,
        maxZ=47.36
    })

    exports["np-interact"]:AddPeekEntryByPolyTarget("np_electrical_job_8", {
    {
        event = "np-jail:work-box-8",
        id = "np_electrical_job_8",
        icon = "circle",
        label = "Fix Electrical",
        parameters = {},
    }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function()
            return ElectricalJob8
        end,
    });

    RegisterNetEvent('np-jail:work-box-8')
    AddEventHandler('np-jail:work-box-8', function()
        TriggerEvent("animation:PlayAnimation","welding")
        FreezeEntityPosition(PlayerPedId(), true)
        ElectricalJob8 = false
        local finished = exports['np-taskbar']:taskBar(7500, 'Repairing Electrical Box')
        if finished == 100 then
            ElectricalJobInProgress = false
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerServerEvent('np-jail:remove-time-electrical')
            RemoveBlip(ElectricalJobBlip8)
            TriggerServerEvent("checkJailTime",true)
        end
    end)

    ----------------------------------------------------------------------------------------

    RegisterNetEvent('np-jail:electrical-get-job')
    AddEventHandler('np-jail:electrical-get-job', function()
        local roll = math.random(1, 8)
        if roll == 1 and not ElectricalJobInProgress then
            print('1')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob1 = true
            ElectricalJobBlip1 = AddBlipForCoord(1690.0740966797, 2565.6911621094, 45.552783966064)
            SetBlipSprite(ElectricalJobBlip1, 1)
            SetBlipSprite(ElectricalJobBlip1, 466)
            SetBlipScale(ElectricalJobBlip1, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip1)
        elseif roll == 2 and not ElectricalJobInProgress then
            print('2')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob2 = true
            ElectricalJobBlip2 = AddBlipForCoord(1652.62, 2565.13, 45.56)
            SetBlipSprite(ElectricalJobBlip2, 1)
            SetBlipSprite(ElectricalJobBlip2, 466)
            SetBlipScale(ElectricalJobBlip2, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip2)
        elseif roll == 3 and not ElectricalJobInProgress then
            print('3')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob3 = true
            ElectricalJobBlip3 = AddBlipForCoord(1630.0, 2565.25, 45.56)
            SetBlipSprite(ElectricalJobBlip3, 1)
            SetBlipSprite(ElectricalJobBlip3, 466)
            SetBlipScale(ElectricalJobBlip3, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip3)
        elseif roll == 4 and not ElectricalJobInProgress then
            print('4')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob4 = true
            ElectricalJobBlip4 = AddBlipForCoord(1618.9591064453, 2521.3957519531, 45.552787780762)
            SetBlipSprite(ElectricalJobBlip4, 1)
            SetBlipSprite(ElectricalJobBlip4, 466)
            SetBlipScale(ElectricalJobBlip4, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip4)
        elseif roll == 5 and not ElectricalJobInProgress then
            print('5')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob5 = true
            ElectricalJobBlip5 = AddBlipForCoord(1667.9653320313, 2488.6357421875, 45.552783966064)
            SetBlipSprite(ElectricalJobBlip5, 1)
            SetBlipSprite(ElectricalJobBlip5, 466)
            SetBlipScale(ElectricalJobBlip5, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip5)
        elseif roll == 6 and not ElectricalJobInProgress then
            print('6')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob6 = true
            ElectricalJobBlip6 = AddBlipForCoord(1718.9182128906, 2488.7609863281, 45.546569824219)
            SetBlipSprite(ElectricalJobBlip6, 1)
            SetBlipSprite(ElectricalJobBlip6, 466)
            SetBlipScale(ElectricalJobBlip6, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip6)
        elseif roll == 7 and not ElectricalJobInProgress then
            print('7')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob7 = true
            ElectricalJobBlip7 = AddBlipForCoord(1627.1922607422, 2489.9975585938, 45.625026702881)
            SetBlipSprite(ElectricalJobBlip7, 1)
            SetBlipSprite(ElectricalJobBlip7, 466)
            SetBlipScale(ElectricalJobBlip7, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip7)
        elseif roll == 8 and not ElectricalJobInProgress then
            print('8')
            ElectricalJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            ElectricalJob8 = true
            ElectricalJobBlip8 = AddBlipForCoord(1686.8961181641, 2533.5595703125, 45.552780151367)
            SetBlipSprite(ElectricalJobBlip8, 1)
            SetBlipSprite(ElectricalJobBlip8, 466)
            SetBlipScale(ElectricalJobBlip8, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Electrical Job")
            EndTextCommandSetBlipName(ElectricalJobBlip8)
        end
    end)


    RegisterNetEvent('np-jail:clean-get-job')
    AddEventHandler('np-jail:clean-get-job', function()
        print("start")
        local roll = math.random(1, 4)
        if roll == 1 and not CleaningJobInProgress then
            print('1')
            CleaningJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            CleaningJob1 = true
            CleanJobBlip1 = AddBlipForCoord(1782.2202148438, 2550.9536132813, 45.6731300354) 
            SetBlipSprite(CleanJobBlip1, 1)
            SetBlipSprite(CleanJobBlip1, 466)
            SetBlipScale(CleanJobBlip1, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cleaning Job")
            EndTextCommandSetBlipName(CleanJobBlip1)
        elseif roll == 2 and not CleaningJobInProgress then
            print('2')
            CleaningJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            CleaningJob2 = true
            CleanJobBlip2 = AddBlipForCoord(1753.0953369141, 2479.9479980469, 45.814468383789) 
            SetBlipSprite(CleanJobBlip2, 1)
            SetBlipSprite(CleanJobBlip2, 466)
            SetBlipScale(CleanJobBlip2, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cleaning Job")
            EndTextCommandSetBlipName(CleanJobBlip2)
        elseif roll == 3 and not CleaningJobInProgress then
            print('3')
            CleaningJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            CleaningJob3 = true
            CleanJobBlip3 = AddBlipForCoord(1691.5657958984, 2454.7487792969, 45.842662811279) 
            SetBlipSprite(CleanJobBlip3, 1)
            SetBlipSprite(CleanJobBlip3, 466)
            SetBlipScale(CleanJobBlip3, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cleaning Job")
            EndTextCommandSetBlipName(CleanJobBlip3)
        elseif roll == 4 and not CleaningJobInProgress then
            print('4')
            CleaningJobInProgress = true
            TriggerEvent('DoLongHudText', 'Jail Job On GPS', 1)
            CleaningJob4 = true
            CleanJobBlip4 = AddBlipForCoord(1742.0379638672, 2540.8752441406, 45.552787780762)
            SetBlipSprite(CleanJobBlip4, 1)
            SetBlipSprite(CleanJobBlip4, 466)
            SetBlipScale(CleanJobBlip4, 1.2)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cleaning Job")
            EndTextCommandSetBlipName(CleanJobBlip4)
      
        end
    end)
    
    

    -- Jail jobs context menu

    RegisterNetEvent('np-jobs:jail-jobs:menu', function()
        TriggerEvent('np-context:sendMenu', {           
                {
                    id = 1,
                    header = "Electrical",
                    txt = "Start Electrical Job",
                    params = {
                    event = "np-jail:electrical-get-job",
                }
            },
            {
                    id = 2,
                    header = "Clean up your cellmates mess",
                    txt = "Start Cleaning Job",
                    params = {
                    event = "np-jail:clean-get-job",
                }
            },
        })
    end)

    Citizen.CreateThread(function()
        exports["np-polytarget"]:AddBoxZone("select_job", vector3(1758.14, 2497.91, 45.82), 0.4, 4.8, {
            useZ = true
        })
        
        exports["np-polytarget"]:AddBoxZone("slushy_make", vector3(1777.58, 2559.82, 45.67), 1, 0.6, {
            useZ = true
        })
        exports["np-polytarget"]:AddBoxZone("jail_food", vector3(1783.43, 2559.92, 45.67), 1.0, 1.2, {
            name="jail_food",
            heading=0,
            --debugPoly=true,
            minZ=41.67,
            maxZ=46.07
        })
    end)       
