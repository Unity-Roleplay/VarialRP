

local silahalindi = false
local silahalindiiki = false
local thirdcrate = false
local pediyuruttu = false

local bobcatsoyuldu = 1

local pedModels = {
    { model = "s_m_m_marine_01", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_m_marine_02", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_y_marine_01", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_y_marine_02", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_y_marine_03", components = { { 2, 3, 0, 0 } } },
    { model = "s_m_y_blackops_01", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_y_blackops_02", props = { { 0, 2, 0, 0 } } },
    { model = "s_m_y_blackops_03", props = { { 0, 2, 0, 0 } } },
  }
  

  local iplStates = {}
local bobcatSecurityDoorCoords = vector3(883.43, -2268.04, 30.5)
local npcBomberIdlePhase = true
local npcBomber = 0

local function updateIpls()
  -- RequestIpl("prologue06_int_np")
  local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
  for k, v in pairs(iplStates) do
    if v then
      ActivateInteriorEntitySet(interiorid, k)
    else
      DeactivateInteriorEntitySet(interiorid, k)
    end
  end
  RefreshInterior(interiorid)
end


function animasyon() -- ÖN KAPI ANİMASYON
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 170.52)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(882.1660, -2258.35, 30.700, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 882.1660, -2258.35, 32.461,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(2000)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("efe:particleserver", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
    TriggerEvent("efe:birincikapidoorlock")
end

function ikincianim() -- İÇERİDEKİ İLK KAPI ANİMASYON
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 170.52)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(880.4080, -2264.50, 30.700, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 880.4080, -2264.50, 32.441,  true,  true, false)

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
    TriggerServerEvent("efe:particleserversec", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(5000)
    ClearPedTasks(ped)
    DeleteObject(bomba)
    StopParticleFxLooped(effect, 0)
	TriggerEvent("efe:ikincikapidoorlock")
end

function ikinanim() -- İÇERİDEKİ İLK KAPI ANİMASYON
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, 170.52)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(883.26, -2294.81, 30.46, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), 883.26, -2294.81, 30.46,  true,  true, false)

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
	TriggerEvent("efe:ikinkapidoorlock")
end

RegisterNetEvent('efe:firstdoor') -- BİRİNCİ KAPI
AddEventHandler('efe:firstdoor', function()
    if bobcatsoyuldu == 1 then
        if exports["isPed"]:isPed("countpolice") >= 1 then
            exports["memorygame"]:thermiteminigame(8, 3, 3, 5,
            function() -- success
                TriggerEvent("efe:bobcatkapiac")
                AlertBobCat()
                TriggerEvent("inventory:removeItem","thermitecharge",1)
                TriggerEvent("efebobcat:incooldown")
                Citizen.Wait(100)
                TriggerEvent("efebobcat:cooldownfalse")
            end,
        
            function() -- failure
                AlertBobCat()
                TriggerEvent("inventory:removeItem","thermitecharge",1)
            end)
        else
            TriggerEvent("efe:robbed")
        end
    else
        TriggerEvent("DoLongHudText", "Not enough cops in the city!", 2)						
    end
end) 

function AlertBobCat()
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
      dispatchMessage = "Robbery At Bobcat Security",
      recipientList = {
        police = "police"
      },
      origin = {
        x = plyPos.x,
        y = plyPos.y,
        z = plyPos.z
      }
    })
  
    TriggerEvent('np-dispatch:dispatchBobcat')
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


RegisterCommand("efebir", function()
    TriggerEvent("efe:firstdoor")
end)

RegisterNetEvent("efe:robbed")
AddEventHandler("efe:robbed", function()
    TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'This bobcat robbed before. Come back in 30 minutes!'})
end)

RegisterNetEvent("efebobcat:incooldown")
AddEventHandler("efebobcat:incooldown", function()
    bobcatsoyuldu = 0 
end)

RegisterNetEvent("efebobcat:cooldownfalse")
AddEventHandler("efebobcat:cooldownfalse", function()
    Citizen.Wait(1800000)
    bobcatsoyuldu = 1 
end)


RegisterNetEvent('efe:secondoor') -- 2.Cİ KAPI
AddEventHandler('efe:secondoor', function()
    exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() 
        TriggerEvent("efe:bobcatikincikapi")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end,
    function() -- failure
        --TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Başaramadın.'})
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end)
end)

RegisterCommand("thirstdoor", function ()
    TriggerEvent("efe:thirstdoor")
end)

RegisterNetEvent('efe:thirdoor') -- 2.Cİ KAPI
AddEventHandler('efe:thirdoor', function()
    exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() 
        TriggerEvent("efe:bobcatikinkapi")
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end,
    function() -- failure
        --TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Başaramadın.'})
        TriggerEvent("inventory:removeItem","thermitecharge",1)
    end)
end)

RegisterCommand("thirstdoor", function ()
    TriggerEvent("efe:thirstdoor")
end)


RegisterNetEvent('efe:thirstdoor') -- BİRİNCİ KAPI
AddEventHandler('efe:thirstdoor', function()
    exports["memorygame"]:thermiteminigame(8, 3, 3, 10,
    function() -- success
        TriggerEvent("efe:bobcatucunkapi")
        TriggerEvent("inventory:removeItem","bobcatsecuritycard",1)
        pediyuruttu = true
    end,
    function() -- failure
        --TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Başaramadın.'})
        end)
end)    

RegisterNetEvent("efe:ptfxparticle")
AddEventHandler("efe:ptfxparticle", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(882.1320, -2257.34, 30.700)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("first particle synced!")
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("efe:ptfxparticlesec")
AddEventHandler("efe:ptfxparticlesec", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(880.43, -2263.65, 30.685)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("second particle synced!")
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent("efe:ptfxparticlethi")
AddEventHandler("efe:ptfxparticlethi", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
        ptfx = vector3(883.26, -2294.81, 30.46)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(4000)
    print("third particle synced!")
    StopParticleFxLooped(effect, 0)
end)

RegisterNetEvent('efe:bobcatikincikapi')
AddEventHandler('efe:bobcatikincikapi', function()
	ikincianim()
    TriggerEvent("efe:ikincikapidoorlock")
end)

RegisterNetEvent('efe:bobcatikinkapi')
AddEventHandler('efe:bobcatikinkapi', function()
	ikinanim()
    Citizen.Wait(3500)
    TriggerEvent("efe:ikinkapidoorlock")
end)


RegisterNetEvent("efe:bobcatucunkapi")
AddEventHandler("efe:bobcatucunkapi", function ()
    TriggerEvent("efe:ucuncukapidoorlock")
end)

RegisterNetEvent('efe:bobcatkapiac')
AddEventHandler('efe:bobcatkapiac', function()
	animasyon()
	Citizen.Wait(3500)
    TriggerEvent("efe:birincikapidoorlock")
end)

RegisterNetEvent('efe:createenemybot')
AddEventHandler('efe:createenemybot', function()
    RequestModel(-1275859404)
    RequestModel(2047212121)
    RequestModel(1349953339)

	AddRelationshipGroup('efe')

		bobcatped1 = CreatePed(30, -1275859404, 878.0915, -2297.23, 30.467, 30.568, 88.00, true, true)
        SetPedSuffersCriticalHits(bobcatped1, false)
        SetEntityMaxHealth(bobcatped1, 2000)
        SetEntityHealth(bobcatped1, 2000)
        SetPedArmour(bobcatped1, 1000)      
		SetPedAsEnemy(bobcatped1, true)
        SetCanAttackFriendly(bobcatped1, false, true)
        SetPedCombatMovement(bobcatped1, 3)
        SetPedCombatRange(bobcatped1, 2)
        SetPedCombatAttributes(bobcatped1, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped1, 'efe')
		GiveWeaponToPed(bobcatped1, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped1, false)
        SetPedRandomComponentVariation(bobcatped1, true)
        SetPedSeeingRange(bobcatped1, 150.0)
        SetPedHearingRange(bobcatped1, 150.0)
        SetPedAlertness(bobcatped1, 3)
        TaskCombatPed(bobcatped1, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped1, 100)
		SetPedDropsWeaponsWhenDead(bobcatped1, false)
		
		bobcatped2 = CreatePed(30, -1275859404, 873.6958, -2296.59, 30.467, 360.00, true, true)
        SetPedSuffersCriticalHits(bobcatped2, false)
        SetEntityMaxHealth(bobcatped2, 2000)
        SetEntityHealth(bobcatped2, 2000)
        SetPedArmour(bobcatped2, 1000)      
		SetPedAsEnemy(bobcatped2, true)
        SetCanAttackFriendly(bobcatped2, false, true)
        SetPedCombatMovement(bobcatped2, 3)
        SetPedCombatRange(bobcatped2, 2)
        SetPedCombatAttributes(bobcatped2, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped2, 'efe')
		GiveWeaponToPed(bobcatped2, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped2, false)
        SetPedRandomComponentVariation(bobcatped2, true)
        SetPedSeeingRange(bobcatped2, 150.0)
        SetPedHearingRange(bobcatped2, 150.0)
        SetPedAlertness(bobcatped2, 3)
		TaskCombatPed(bobcatped2, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped2, 100)
		SetPedDropsWeaponsWhenDead(bobcatped2, false)

		bobcatped3 = CreatePed(30, -1275859404, 873.0935, -2292.35, 30.467, 350.00, true, true)
        SetPedSuffersCriticalHits(bobcatped3, false)
        SetEntityMaxHealth(bobcatped3, 2000)
        SetEntityHealth(bobcatped3, 2000)
        SetPedArmour(bobcatped3, 1000)      
		SetPedAsEnemy(bobcatped3, true)
        SetCanAttackFriendly(bobcatped3, false, true)
        SetPedCombatMovement(bobcatped3, 3)
        SetPedCombatRange(bobcatped3, 2)
        SetPedCombatAttributes(bobcatped3, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped3, 'efe')
		GiveWeaponToPed(bobcatped3, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped3, false)
        SetPedRandomComponentVariation(bobcatped3, true)
        SetPedSeeingRange(bobcatped3, 150.0)
        SetPedHearingRange(bobcatped3, 150.0)
        SetPedAlertness(bobcatped3, 3)
		TaskCombatPed(bobcatped3, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped3, 100)
		SetPedDropsWeaponsWhenDead(bobcatped3, false)

		bobcatped4 = CreatePed(30, 2047212121, 878.4496, -2291.53, 30.474, 350.00, true, true)
        SetPedSuffersCriticalHits(bobcatped4, false)
        SetEntityMaxHealth(bobcatped4, 2000)
        SetEntityHealth(bobcatped4, 2000)
        SetPedArmour(bobcatped4, 1000)      
		SetPedAsEnemy(bobcatped4, true)
        SetCanAttackFriendly(bobcatped4, false, true)
        SetPedCombatMovement(bobcatped4, 3)
        SetPedCombatRange(bobcatped4, 2)
        SetPedCombatAttributes(bobcatped4, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped4, 'efe')
		GiveWeaponToPed(bobcatped4, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped4, false)
        SetPedRandomComponentVariation(bobcatped4, true)
        SetPedSeeingRange(bobcatped4, 150.0)
        SetPedHearingRange(bobcatped4, 150.0)
        SetPedAlertness(bobcatped4, 3)
		TaskCombatPed(bobcatped4, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped4, 100)
		SetPedDropsWeaponsWhenDead(bobcatped4, false)

		bobcatped5 = CreatePed(30, 2047212121, 883.3175, -2294.66, 30.467, 300.00, true, true)
        SetPedSuffersCriticalHits(bobcatped5, false)
        SetEntityMaxHealth(bobcatped5, 2000)
        SetEntityHealth(bobcatped5, 2000)
        SetPedArmour(bobcatped5, 1000)      
		SetPedAsEnemy(bobcatped5, true)
        SetCanAttackFriendly(bobcatped5, false, true)
        SetPedCombatMovement(bobcatped5, 3)
        SetPedCombatRange(bobcatped5, 2)
        SetPedCombatAttributes(bobcatped5, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped5, 'efe')
		GiveWeaponToPed(bobcatped5, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped5, false)
        SetPedRandomComponentVariation(bobcatped5, true)
        SetPedSeeingRange(bobcatped5, 150.0)
        SetPedHearingRange(bobcatped5, 150.0)
        SetPedAlertness(bobcatped5, 3)
		TaskCombatPed(bobcatped5, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped5, 100)
		SetPedDropsWeaponsWhenDead(bobcatped5, false)


		bobcatped6 = CreatePed(30, 2047212121, 888.6503, -2294.50, 30.467, 266.00, true, true)
        SetPedSuffersCriticalHits(bobcatped6, false)
        SetEntityMaxHealth(bobcatped6, 2000)
        SetEntityHealth(bobcatped6, 2000)
        SetPedArmour(bobcatped6, 1000)      
		SetPedAsEnemy(bobcatped6, true)
        SetCanAttackFriendly(bobcatped6, false, true)
        SetPedCombatMovement(bobcatped6, 3)
        SetPedCombatRange(bobcatped6, 2)
        SetPedCombatAttributes(bobcatped6, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped6, 'efe')
		GiveWeaponToPed(bobcatped6, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped6, false)
        SetPedRandomComponentVariation(bobcatped6, true)
        SetPedSeeingRange(bobcatped6, 150.0)
        SetPedHearingRange(bobcatped6, 150.0)
        SetPedAlertness(bobcatped6, 3)
		TaskCombatPed(bobcatped6, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped6, 100)
		SetPedDropsWeaponsWhenDead(bobcatped6, false)

		bobcatped7 = CreatePed(30, 1349953339, 893.6617, -2294.54, 30.467, 298.00, true, true)
        SetPedSuffersCriticalHits(bobcatped7, false)
        SetEntityMaxHealth(bobcatped7, 2000)
        SetEntityHealth(bobcatped7, 2000)
        SetPedArmour(bobcatped7, 1000)      
		SetPedAsEnemy(bobcatped7, true)
        SetCanAttackFriendly(bobcatped7, false, true)
        SetPedCombatMovement(bobcatped7, 3)
        SetPedCombatRange(bobcatped7, 2)
        SetPedCombatAttributes(bobcatped7, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped7, 'efe')
		GiveWeaponToPed(bobcatped7, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped7, false)
        SetPedRandomComponentVariation(bobcatped7, true)
        SetPedSeeingRange(bobcatped7, 150.0)
        SetPedHearingRange(bobcatped7, 150.0)
        SetPedAlertness(bobcatped7, 3)
		TaskCombatPed(bobcatped7, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped7, 100)
		SetPedDropsWeaponsWhenDead(bobcatped7, false)

		bobcatped8 = CreatePed(30, 1349953339, 879.1893, 894.2161, -2290.80, 30.467, true, true)
        SetPedSuffersCriticalHits(bobcatped8, false)
        SetEntityMaxHealth(bobcatped8, 2000)
        SetEntityHealth(bobcatped8, 2000)
        SetPedArmour(bobcatped8, 1000)      
		SetPedAsEnemy(bobcatped8, true)
        SetCanAttackFriendly(bobcatped8, false, true)
        SetPedCombatMovement(bobcatped8, 3)
        SetPedCombatRange(bobcatped8, 2)
        SetPedCombatAttributes(bobcatped8, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped8, 'efe')
		GiveWeaponToPed(bobcatped8, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped8, false)
        SetPedRandomComponentVariation(bobcatped8, true)
        SetPedSeeingRange(bobcatped8, 150.0)
        SetPedHearingRange(bobcatped8, 150.0)
        SetPedAlertness(bobcatped8, 3)
		TaskCombatPed(bobcatped8, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped8, 100)
		SetPedDropsWeaponsWhenDead(bobcatped8, false)
        
        bobcatped9 = CreatePed(30, 1349953339, 879.1893, 891.4326, -2287.57, 30.492, true, true)
        SetPedSuffersCriticalHits(bobcatped9, false)
        SetEntityMaxHealth(bobcatped9, 2000)
        SetEntityHealth(bobcatped9, 2000)
        SetPedArmour(bobcatped9, 1000)      
		SetPedAsEnemy(bobcatped9, true)
        SetCanAttackFriendly(bobcatped9, false, true)
        SetPedCombatMovement(bobcatped9, 3)
        SetPedCombatRange(bobcatped9, 2)
        SetPedCombatAttributes(bobcatped9, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped9, 'efe')
		GiveWeaponToPed(bobcatped9, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped9, false)
        SetPedRandomComponentVariation(bobcatped9, true)
        SetPedSeeingRange(bobcatped9, 150.0)
        SetPedHearingRange(bobcatped9, 150.0)
        SetPedAlertness(bobcatped9, 3)
		TaskCombatPed(bobcatped9, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped9, 100)
		SetPedDropsWeaponsWhenDead(bobcatped9, false)

        bobcatped10 = CreatePed(30, 1349953339, 893.5341, -2282.84, 30.508, 266.00, true, true)
        SetPedSuffersCriticalHits(bobcatped10, false)
        SetEntityMaxHealth(bobcatped10, 2000)
        SetEntityHealth(bobcatped10, 2000)
        SetPedArmour(bobcatped10, 1000)      
		SetPedAsEnemy(bobcatped10, true)
        SetCanAttackFriendly(bobcatped10, false, true)
        SetPedCombatMovement(bobcatped10, 3)
        SetPedCombatRange(bobcatped10, 2)
        SetPedCombatAttributes(bobcatped10, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped10, 'efe')
		GiveWeaponToPed(bobcatped10, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped10, false)
        SetPedRandomComponentVariation(bobcatped10, true)
        SetPedSeeingRange(bobcatped10, 150.0)
        SetPedHearingRange(bobcatped10, 150.0)
        SetPedAlertness(bobcatped10, 3)
		TaskCombatPed(bobcatped10, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped10, 100)
		SetPedDropsWeaponsWhenDead(bobcatped10, false)

        bobcatped11 = CreatePed(30, 1349953339, 868.940, -2287.952, 30.467, 231.747, true, true)
        SetPedSuffersCriticalHits(bobcatped11, false)
        SetEntityMaxHealth(bobcatped11, 2000)
        SetEntityHealth(bobcatped11, 2000)
        SetPedArmour(bobcatped11, 1000)      
		SetPedAsEnemy(bobcatped11, true)
        SetCanAttackFriendly(bobcatped11, false, true)
        SetPedCombatMovement(bobcatped11, 3)
        SetPedCombatRange(bobcatped11, 2)
        SetPedCombatAttributes(bobcatped11, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped11, 'efe')
		GiveWeaponToPed(bobcatped11, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped11, false)
        SetPedRandomComponentVariation(bobcatped11, true)
        SetPedSeeingRange(bobcatped11, 150.0)
        SetPedHearingRange(bobcatped11, 150.0)
        SetPedAlertness(bobcatped11, 3)
		TaskCombatPed(bobcatped11, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped11, 100)
		SetPedDropsWeaponsWhenDead(bobcatped11, false)

        bobcatped12 = CreatePed(30, 1349953339, 875.790, -2292.817, 30.467, true, true)
        SetPedSuffersCriticalHits(bobcatped12, false)
        SetEntityMaxHealth(bobcatped12, 2000)
        SetEntityHealth(bobcatped12, 2000)
        SetPedArmour(bobcatped12, 1000)      
		SetPedAsEnemy(bobcatped12, true)
        SetCanAttackFriendly(bobcatped12, false, true)
        SetPedCombatMovement(bobcatped12, 3)
        SetPedCombatRange(bobcatped12, 2)
        SetPedCombatAttributes(bobcatped12, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped12, 'efe')
		GiveWeaponToPed(bobcatped12, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped12, false)
        SetPedRandomComponentVariation(bobcatped12, true)
        SetPedSeeingRange(bobcatped12, 150.0)
        SetPedHearingRange(bobcatped12, 150.0)
        SetPedAlertness(bobcatped12, 3)
		TaskCombatPed(bobcatped12, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped12, 100)
		SetPedDropsWeaponsWhenDead(bobcatped12, false)

        bobcatped13 = CreatePed(30, 1349953339, 887.874, -2296.848, 30.467, true, true)
        SetPedSuffersCriticalHits(bobcatped13, false)
        SetEntityMaxHealth(bobcatped13, 2000)
        SetEntityHealth(bobcatped13, 2000)
        SetPedArmour(bobcatped13, 1000)      
		SetPedAsEnemy(bobcatped13, true)
        SetCanAttackFriendly(bobcatped13, false, true)
        SetPedCombatMovement(bobcatped13, 3)
        SetPedCombatRange(bobcatped13, 2)
        SetPedCombatAttributes(bobcatped13, 5000, 1)
		SetPedRelationshipGroupHash(bobcatped13, 'efe')
		GiveWeaponToPed(bobcatped13, GetHashKey('WEAPON_PISTOL'), 9999, false, true)
        SetPedDropsWeaponsWhenDead(bobcatped13, false)
        SetPedRandomComponentVariation(bobcatped13, true)
        SetPedSeeingRange(bobcatped13, 150.0)
        SetPedHearingRange(bobcatped13, 150.0)
        SetPedAlertness(bobcatped13, 3)
		TaskCombatPed(bobcatped13, PlayerPedId(), 0, 16)
		SetPedAccuracy(bobcatped13, 100)
		SetPedDropsWeaponsWhenDead(bobcatped13, false)
end)


RegisterCommand("lolcreatele", function ()
    TriggerEvent("efe:createenemybot")
end)

RegisterNetEvent('efe:pedicreatele') 
AddEventHandler('efe:pedicreatele', function()
    TriggerEvent("efe:createenemybot")
end)

RegisterNetEvent('efe-bobcat:boom')
AddEventHandler('efe-bobcat:boom', function()
    local interiorid = GetInteriorAtCoords(883.4142, -2282.372, 31.44168)
    ActivateInteriorEntitySet(interiorid, "np_prolog_broken")
    RemoveIpl(interiorid, "np_prolog_broken")
    DeactivateInteriorEntitySet(interiorid, "np_prolog_clean")
    RefreshInterior(interiorid)
    silahalindi = true
    Citizen.Wait(1000)
    silahalindiiki = true
    Citizen.Wait(1000)
    thirdcrate = true
end)

RegisterNetEvent('efe:silahver')
AddEventHandler('efe:silahver', function()
    if silahalindi == true then
    local myluck = math.random(2)
    if myluck == 1 then
        TriggerEvent("player:receiveItem", "-942620673", 1)
        TriggerEvent("player:receiveItem",  "-1716589765", 1)
        TriggerEvent("player:receiveItem",  "-2012211169", 1)
        TriggerEvent("player:receiveItem",  "148457251", 1)
        silahalindi = false
    elseif myluck == 2 then
        TriggerEvent( "player:receiveItem", "-942620673", 1 )
        TriggerEvent( "player:receiveItem", "584646201", 1 )
        TriggerEvent( "player:receiveItem", "-134995899", 1 )
        TriggerEvent( "player:receiveItem", "subammo", 5)
        TriggerEvent( "player:receiveItem", "rifleammo", 5)
    silahalindi = false
    else
        print("First weapon crate is robbed!")
        end
    end
end)

RegisterNetEvent('efe:silahveriki')
AddEventHandler('efe:silahveriki', function()
    if silahalindiiki == true then
    local myluck = math.random(2)
    if  myluck == 1 then    
    TriggerEvent( "player:receiveItem", "615608432", 1 )
    silahalindiiki = false
    elseif myluck == 2 then
    TriggerEvent( "player:receiveItem", "741814745", 1 )    
    silahalindiiki = false
    else
        print("Second weapon crate is robbed!")
        end
    end
end)


RegisterNetEvent('efe:thirdcrate')
AddEventHandler('efe:thirdcrate', function()
    if thirdcrate == true then
    local myluck = math.random(2)
    if  myluck == 1 then    
    TriggerEvent( "player:receiveItem", "-1074790547", 1 ) 
    thirdcrate = false
    elseif myluck == 2 then
    TriggerEvent( "player:receiveItem", "-1074790547", 1 ) 
    thirdcrate = false
    else
        print("third weapon crate is robbed!")
        end
    end
end)


-- OPEN DOORS EVENTS
RegisterNetEvent('efe:birincikapidoorlock') -- BİRİNCİ KAPI 1
AddEventHandler('efe:birincikapidoorlock', function()
    TriggerServerEvent('np-doors:change-lock-state', 273, false) -- 1.kapı sol 
    TriggerServerEvent('np-doors:change-lock-state', 274, false) -- 1. kapı sağ
end)

RegisterNetEvent('efe:ikincikapidoorlock') -- İKİNCİ KAPI 2
AddEventHandler('efe:ikincikapidoorlock', function()
	TriggerServerEvent('np-doors:change-lock-state', 275, false) -- 2.kapı
    TriggerEvent("efe:pedicreatele")
end)

RegisterNetEvent('efe:ikinkapidoorlock') -- İKİNCİ KAPI 2
AddEventHandler('efe:ikinkapidoorlock', function()
	TriggerServerEvent('np-doors:change-lock-state', 443, false) -- 5.kapı
end)

RegisterNetEvent('efe:ucuncukapidoorlock')
AddEventHandler('efe:ucuncukapidoorlock', function()
    TriggerServerEvent('np-doors:change-lock-state', 276, false) -- 3.kapı
    TriggerServerEvent('np-doors:change-lock-state', 277, false) -- 4.kapı
    TriggerEvent("efe:pedicreatele")
end)


-- CREATE PED
--[[Citizen.CreateThread(function()
    local hash = GetHashKey("mp_s_m_armoured_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end

rehineped = CreatePed("PED_TYPE_CIVFEMALE", "mp_s_m_armoured_01", 870.23962402344, -2288.8513183594, 35.169334411621, 173.41091918945, true, true)
SetBlockingOfNonTemporaryEvents(rehineped, true)
        SetPedDiesWhenInjured(rehineped, false)
        SetPedCanPlayAmbientAnims(rehineped, true)
        SetPedCanRagdollFromPlayerImpact(rehineped, false)
        SetEntityInvincible(rehineped, false)
    RequestAnimDict('random@arrests@busted', function()
    TaskPlayAnim(rehineped, 'random@arrests@busted', 'idle_a', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
end)
end)]]

--ped walk
RegisterNetEvent('efe:pediyurut') 
AddEventHandler('efe:pediyurut', function()
    if pediyuruttu == true then
    TriggerEvent("DoLongHudText", "Good Job, Lemme download this virus into there system, Standby", 1)
	--ClearPedTasks(rehineped)
	TaskGoStraightToCoord(869.2078, -2292.60, 32.441, 150.0, -1, 265.61, 0)
	Citizen.Wait(5000)
	TaskGoStraightToCoord(893.3309, -2294.90, 32.441, 150.0, -1, 350.61, 0)
	Citizen.Wait(13000)
	TriggerEvent("efe:pediyurutiki")
    pediyuruttu = false
    else
        print("Nice try asshole")
    end
end)

RegisterNetEvent('efe:pediyurutiki')
AddEventHandler('efe:pediyurutiki', function()
	TaskGoStraightToCoord(894.6337, -2284.97, 32.441, 150.0, -1, 82.56, 0)
	Citizen.Wait(7500)
	RequestAnimDict('weapons@projectile@grenade_str', function()
        TaskPlayAnim( 'weapons@projectile@grenade_str', 'throw_h_fb_backward', 8.0, 8.0, -1, 33, 0, 0, 0, 0)
    end)
	Citizen.Wait(1000)
	AddExplosion(890.7849, -2284.88, 32.441, 32, 150000.0, true, false, 4.0)
	AddExplosion(894.0084, -2284.90, 32.580, 32, 150000.0, true, false, 4.0)
    TriggerServerEvent('efe-bobcat:boom_efe', -1)
end)

RegisterCommand("bobcattest", function ()
    TriggerServerEvent('efe-bobcat:boom_efe', -1)
end)
	

function LoadAnimationDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
  
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
  end

  --[[Citizen.CreateThread(function()
    local pedModelKeyMap = {}
    for _, v in pairs(pedModels) do
      pedModelKeyMap[#pedModelKeyMap + 1] = GetHashKey(v.model)
    end
    exports['np-interact']:AddPeekEntryByModel(pedModelKeyMap, {
      {
        event = 'bobcat-rob:lootDeadGuard',
        id = 'bobcat-rob:lootDeadGuard',
        icon = 'circle',
        label = 'Grab Gear',
        parameters = {},
      },
    }, {
      distance = { radius = 2.0 },
      isEnabled = function(pEntity)
      --  if not inServerFarm then return false end
        if not IsPedDeadOrDying(pEntity) then return false end
        return true
      end,
    })
  end)

  local lootingDeadGuard = false
AddEventHandler("bobcat-rob:lootDeadGuard", function(p1, pEntity, p3)
  if lootingDeadGuard then return end
  lootingDeadGuard = true
  TriggerEvent("farm:weed")
  RPC.execute("bobcat-rob:lootDeadGuard")
  Wait(3000)
  Sync.DeleteEntity(pEntity)
  Wait(1000)
  lootingDeadGuard = false
end)]]




-- TARGET'S
Citizen.CreateThread(function()
  exports["np-polytarget"]:AddBoxZone("Loot_Box1", vector3(882.23, -2286.46, 30.47), 2.2, 2.0, {
    heading= 0
  })
  exports["np-polytarget"]:AddBoxZone("Loot_Box2", vector3(881.35, -2282.59, 30.47), 2.0, 1.8, {
    heading= 0
  })
  exports["np-polytarget"]:AddBoxZone("Loot_Box3", vector3(886.66, -2287.05, 30.59), 1.4, 2.0, {
    heading= 0
  })
  exports["np-polytarget"]:AddBoxZone("Bomb_Door", vector3(886.92, -2299.02, 30.47), 0.2, 0.6, {
    heading= 0
  })
  exports["np-polytarget"]:AddBoxZone("card_door", vector3(882.98, -2268.21, 30.47), 0.6, 0.4, {
    heading= 0
  })

end)