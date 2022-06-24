local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local lastValues = {}
Fuel = 0
local currentValues = {
	["health"] = 100,
	["armor"] = 100,
	["hunger"] = 100,
	["thirst"] = 100,
	["oxy"] = 2,
	["stress"] = 100,
	["voice"] = 2,
	["devmode"] = false,
	["devdebug"] = false,
  ["hasregen"] = false,
	["is_talking"] = false
}

local compassEnabled = true
local isLoggedIn = false
local compassRoadNamesEnabled = true
local compassWaitTime = 16
local showCompassFromWatch = false
local showCompassFromCar = false
local minimapEnabled = true
local wasMinimapEnabled = true
local useDefaultMinimap = false
local appliedTextureChange = false
local round = false
local inVehicle = false
local inveh = false
local engineOn = false
local isDead = false
local pStress = 0
local drugEffectTime = 0
local bufftimeluck = 0
local bufftimeswimming = 0
local buffstrenthtime = 0
local bufftimeint = 0
local regentime = 0
local armortime = 0
local hungertime = 0
local stresstime = 0
local alerttime = 0
local buffthirsttime = 0
local minimapchoice = 0
local nitro = 0


RegisterNetEvent('np-hud:show_money')
AddEventHandler('np-hud:show_money', function()
  isLooting = 1
  SendNUIMessage({action = "money", money = isLooting})
Citizen.Wait(10800000)
isLooting = 0
end)

RegisterNetEvent('np-hud:show_alert')
AddEventHandler('np-hud:show_alert', function()
  alerttime = 1
  SendNUIMessage({action = "alert", alert = alerttime})
Citizen.Wait(10800000)
alerttime = 0
end)


-- icons start
RegisterNetEvent('healthregen')
AddEventHandler('healthregen', function()
  if regentime > 0 then return end
  SetPlayerHealthRechargeLimit(pId, 2.0)
  regentime = math.random(2699, 2700)

  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while regentime > 0 do
    loops = loops + 1
    if loops > 10 then
      SetEntityHealth(GetEntityHealth(PlayerPedId()) + 2)
    end
    Citizen.Wait(1000)
    regentime = regentime - 1.0
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  regentime = 0
  SetPlayerHealthRechargeLimit(pId, 1.0)
end)

RegisterNetEvent('armorbuff')
AddEventHandler('armorbuff', function()
  if armortime > 0 then return end
  SetPlayerMaxArmour(pId, 1.5)
  armortime = math.random(100, 1000)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while armortime > 0 do
    loops = loops + 1
    if loops > 10 then
      if not GetPedArmour(PlayerPedId()) == 60 then
        print('Armor: ' ..GetPedArmour(PlayerPedId()))
        SetPedArmour(PlayerPedId(), GetPedArmour(PlayerPedId()) + 0.5)
      end
    end
    Citizen.Wait(1000)
    armortime = armortime - 1.0
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  armortime = 0
  SetPlayerMaxArmour(pId, 1.0)
end)

RegisterNetEvent('hungerbuff')
AddEventHandler('hungerbuff', function()
  if hungertime > 0 then return end
  hungertime = math.random(2699, 2700)
  isHungerBuff = 1

  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while hungertime > 0 do
    loops = loops + 1
    if loops > 10 then
    end
    Citizen.Wait(1000)
    hungertime = hungertime - 1.0
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  isHungerBuff = 0
end)

RegisterNetEvent('thirstbuff')
AddEventHandler('thirstbuff', function()
  if buffthirsttime > 0 then return end
  buffthirsttime = math.random(2699, 2700)
  isThirstBuff = 1

  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while buffthirsttime > 0 do
    loops = loops + 1
    if loops > 10 then
    end
    Citizen.Wait(1000)
    buffthirsttime = buffthirsttime - 1.0
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  isThirstBuff = 0
end)

RegisterNetEvent('stressbuff')  -- done
AddEventHandler('stressbuff', function()
  if stresstime > 0 then return end
  stresstime = math.random(2699, 2700)
  isStressBuff = 1

  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while stresstime > 0 do
    loops = loops + 1
    if loops > 10 then
    end
    Citizen.Wait(1000)
    stresstime = stresstime - 1.0
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  stresstime = 0
  SetPlayerMaxArmour(pId, 1.0)
  isStressBuff = 0
end)

-- icons buff done

-- buffs start

RegisterNetEvent('luckevent') -- done 
AddEventHandler('luckevent', function()
  if bufftimeluck > 0 then return end
  bufftimeluck = math.random(10, 100)
  isLuckBuff = 1


  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0
  while bufftimeluck > 0 do
    if loops > 10 then
      SetSwimMultiplierForPlayer(pId, 1.1)
    end
    loops = loops + 1
    Citizen.Wait(1000)
    bufftimeluck = bufftimeluck - 0.2
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  bufftimeluck = 0
  isLuckBuff = 0
end)

RegisterNetEvent('swimbuffevent')
AddEventHandler('swimbuffevent', function()
  if bufftimeswimming > 0 then return end
  SetSwimMultiplierForPlayer(pId, 2.0)
  bufftimeswimming = math.random(10, 55)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while bufftimeswimming > 0 do
    loops = loops + 1
    if loops > 10 then
      SetSwimMultiplierForPlayer(pId, 1.025)
    end
    Citizen.Wait(1000)
    bufftimeswimming = bufftimeswimming - 0.2
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  bufftimeswimming = 0
  SetSwimMultiplierForPlayer(pId, 1.0)
end)

RegisterNetEvent('strongevent')
AddEventHandler('strongevent', function()
  if buffstrenthtime > 0 then return end
  SetPlayerMeleeWeaponDamageModifier(pId, 1.25)
  SetPlayerMeleeWeaponDefenseModifier(pId, 1.25)
  buffstrenthtime = math.random(10, 75)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while buffstrenthtime > 0 do
    loops = loops + 1
    if loops > 10 then
    SetPlayerMeleeWeaponDamageModifier(pId, 1.25)
    SetPlayerMeleeWeaponDefenseModifier(pId, 1.25)
    end
    Citizen.Wait(1000)
    buffstrenthtime = buffstrenthtime - 0.2
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  buffstrenthtime = 0
  SetPlayerMeleeWeaponDamageModifier(pId, 1.0)
  SetPlayerMeleeWeaponDefenseModifier(pId, 1.0)
  hasregen = true
end)

RegisterNetEvent('intelevent')
AddEventHandler('intelevent', function()
  if bufftimeint > 0 then return end
  bufftimeint = math.random(10, 75)
  isIntelBuff = 1
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while bufftimeint > 0 do
    loops = loops + 1
    if loops > 10 then
    end
    Citizen.Wait(1000)
    bufftimeint = bufftimeint - 0.2
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  bufftimeint = 0
  isIntelBuff = 0
end)







-- buffs end


RegisterNetEvent('specialring')
AddEventHandler('specialring', function()
  if buffstrenthtime > 0 then return end
  SetPlayerMeleeWeaponDamageModifier(pId, 1.25)
  SetPlayerMeleeWeaponDefenseModifier(pId, 1.25)
  buffstrenthtime = math.random(99, 100)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while buffstrenthtime > 0 do
    loops = loops + 1
    if loops > 10 then
    SetPlayerMeleeWeaponDamageModifier(pId, 1.25)
    SetPlayerMeleeWeaponDefenseModifier(pId, 1.25)
    end
    Citizen.Wait(1000)
    buffstrenthtime = buffstrenthtime - 0.03
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  buffstrenthtime = 0
  SetPlayerMeleeWeaponDamageModifier(pId, 1.0)
  SetPlayerMeleeWeaponDefenseModifier(pId, 1.0)
end)

RegisterNetEvent('luckeventring')     
AddEventHandler('luckeventring', function()
  if bufftimeluck > 0 then return end
  bufftimeluck = math.random(99, 100)
  isLuckBuff = 1
  TriggerEvent("client:newStress", false, math.random(10, 50))
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0
  while bufftimeluck > 0 do
    if loops > 10 then
      SetSwimMultiplierForPlayer(pId, 1.1)
    end
    loops = loops + 1
    Citizen.Wait(1000)
    bufftimeluck = bufftimeluck - 0.04
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  bufftimeluck = 0
  isLuckBuff = 0
end)

RegisterNetEvent('swimbuffring')
AddEventHandler('swimbuffring', function()
  if bufftimeswimming > 0 then return end
  SetSwimMultiplierForPlayer(pId, 2.0)
  bufftimeswimming = math.random(99, 100)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while bufftimeswimming > 0 do
    loops = loops + 1
    if loops > 10 then
     SetSwimMultiplierForPlayer(pId, 2.0)
    end
    Citizen.Wait(1000)
    bufftimeswimming = bufftimeswimming - 0.04
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  bufftimeswimming = 0
  SetSwimMultiplierForPlayer(pId, 1.0)
end)

-- Sugar effects
RegisterNetEvent('hadsugar')
AddEventHandler('hadsugar', function()
  if drugEffectTime > 0 then return end
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.05)
  SetSwimMultiplierForPlayer(pId, 1.05)
  drugEffectTime = 20
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  while drugEffectTime > 0 do
    loops = loops + 1
    if loops > 10 then
      SetRunSprintMultiplierForPlayer(pId, 1.025)
      SetSwimMultiplierForPlayer(pId, 1.025)
    end
    Citizen.Wait(1000)
    RestorePlayerStamina(pId, 1.0)
    drugEffectTime = drugEffectTime - 1
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  drugEffectTime = 0
  TriggerEvent('np-hud:hidedrugs')
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
  SetSwimMultiplierForPlayer(pId, 1.0)
end)

-- Cocaine Effects
RegisterNetEvent('hadcocaine')
AddEventHandler('hadcocaine', function()
  if drugEffectTime > 0 then return end
  drugEffectTime = 60

  TriggerEvent("client:newStress", true, math.random(10, 50))
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  SetRunSprintMultiplierForPlayer(pId, 1.25)
  SetSwimMultiplierForPlayer(pId, 1.15)

  while drugEffectTime > 0 do
    if loops > 10 then
      SetRunSprintMultiplierForPlayer(pId, 1.15)
      SetSwimMultiplierForPlayer(pId, 1.1)
    end
    loops = loops + 1
    Citizen.Wait(1000)
    RestorePlayerStamina(pId, 1.0)
    drugEffectTime = drugEffectTime - 1
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
    -- if loops < 20 then
    --   SetPedArmour(ped, math.floor(GetPedArmour(ped) + 2))
    -- end
  end
  drugEffectTime = 0
  SetRunSprintMultiplierForPlayer(pId, 1.0)
  SetSwimMultiplierForPlayer(pId, 1.0)
  TriggerEvent('np-hud:hidedrugs')
end)

RegisterNetEvent('hadmeth')
AddEventHandler('hadmeth', function(quality)
  -- TriggerEvent("addiction:drugTaken", "meth")
  if drugEffectTime > 0 then return end
  drugEffectTime = 0
  -- TriggerEvent("fx:run", "cocaine", 8, 0.0, false, false)
  local addictionFactor = 0.0
  local drugEffectApplyArmorMulti = 10
  local drugEffectQualityMulti = 1.0
  local sprintEffectFactor = 1.0
  drugEffectTime = drugEffectQualityMulti * 6
  if quality and quality < 40 then
    TriggerEvent("DoLongHudText", "This is some poor quality shit", 2)
  end
  TriggerEvent("client:newStress", false, math.random(19, 25))
  local loops = 0
  while drugEffectTime > 0 do
    loops = loops + 1
    if loops > 20 then
      SetRunSprintMultiplierForPlayer(PlayerId(), 1.15)
      SetSwimMultiplierForPlayer(PlayerId(), 1.15)
    end
    if loops < 20 then
      SetRunSprintMultiplierForPlayer(PlayerId(), 1.25)
      SetSwimMultiplierForPlayer(PlayerId(), 1.25)
      RestorePlayerStamina(PlayerId(), 1.25)
    end
    Citizen.Wait(1000)
    drugEffectTime = drugEffectTime - 1
    if IsPedRagdoll(PlayerPedId()) then
      SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
    end
    if drugEffectApplyArmorMulti > 0 then
      local armor = GetPedArmour(PlayerPedId())
      SetPedArmour(PlayerPedId(), math.floor(armor + drugEffectApplyArmorMulti))
    end
  end
  drugEffectTime = 0
  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
  SetSwimMultiplierForPlayer(PlayerId(), 1.0)
  TriggerEvent('np-hud:hidedrugs')
  -- exports["carandplayerhud"]:revertToStress()
end)

RegisterNetEvent('hadnitrous')
AddEventHandler('hadnitrous', function()
  if drugEffectTime > 0 then return end
  drugEffectTime = 0

  TriggerEvent("fx:run", "cocaine", 8, 0.0, false, false)

  SetRunSprintMultiplierForPlayer(PlayerId(), 1.01)

  drugEffectTime = 200

  -- TriggerEvent("client:newStress", false, math.random(250))

  while drugEffectTime > 0 do
    Citizen.Wait(1000)
    drugEffectTime = drugEffectTime - 1

    if IsPedRagdoll(PlayerPedId()) then
      SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end

  drugEffectTime = 0

  if IsPedRunning(PlayerPedId()) then
    SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
  end

  SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
  exports["carandplayerhud"]:revertToStress()
end)

-- Adrenaline (Swat) Effects
local adrenActive = false
RegisterNetEvent('inventory:adrenaline')
AddEventHandler('inventory:adrenaline', function()
  if adrenActive then return end
  adrenActive = true
  local ped = PlayerId()

  -- local armor = GetPedArmour(PlayerPedId())
  -- SetPedArmour(PlayerPedId(), math.floor(armor + 25.0))
  -- drugEffectTime = 18000
  SetRunSprintMultiplierForPlayer(ped, 1.25)
  SetSwimMultiplierForPlayer(ped, 1.25)
  SetPedArmour(PlayerPedId(), 60)


  Citizen.CreateThread(function()
    local innerLC = 0
    while innerLC < 6 do
      innerLC = innerLC + 1
      SetPedArmour(PlayerPedId(), 60)
      Wait(1000)
    end
  end)

  Wait(6000)

  SetRunSprintMultiplierForPlayer(ped, 1.0)
  SetSwimMultiplierForPlayer(ped, 1.0)
  TriggerEvent('np-hud:hidedrugs')

  local loopCount = 0
  while loopCount < 10 do
    loopCount = loopCount + 1
    SetPedArmour(PlayerPedId(), math.max(0, math.floor(GetPedArmour(PlayerPedId()) - 1)))
    Wait(500)
  end

  -- add this here so they can tell its "over"
  SetPedArmour(PlayerPedId(), 10)

  adrenActive = false

  -- while drugEffectTime > 0 do
  --   Citizen.Wait(0)
  --   if math.random(300) == 69 then
  --     local armor = GetPedArmour(PlayerPedId())
  --     SetPedArmour(PlayerPedId(), math.floor(armor + 5))
  --   end
  --   RestorePlayerStamina(ped, 1.0)
  --   drugEffectTime = drugEffectTime - 1
  -- end
  -- drugEffectTime = 0
end)

-- Special K (prison drug)
local ketaActive = false
RegisterNetEvent('inventory:ketamine')
AddEventHandler('inventory:ketamine', function(pPurity)
  if ketaActive then return end
  ketaActive = true
  local ped = PlayerId()

  local lastTaken = getLastTaken("ketamine")
  if not lastTaken then lastTaken = 0 end
  if GetCloudTimeAsInt() - lastTaken < 10 * 60 then return end
  TriggerEvent("addiction:drugTaken", "ketamine")

  TriggerEvent("fx:run", "cocaine", 10, 0.0, false, false)

  local armor = GetPedArmour(PlayerPedId())

  SetPedArmour(PlayerPedId(), math.floor(armor + (armorFactor * 10.0)))

  local drugRunning = true

  Citizen.SetTimeout(3 * 60 * 1000, function()
    drugRunning = false
  end)

  TriggerEvent("healed:useOxy", false)
  TriggerServerEvent("np-drugeffects:forceStress", 1, 3 * 60 * 1000)

  local purityRng = (200 - math.floor(pPurity)) * 2
  while drugRunning do
    Citizen.Wait(0)
    if math.random(purityRng) == 69 then
      -- fast armor regen
      local armor = GetPedArmour(PlayerPedId())
      SetPedArmour(PlayerPedId(), math.floor(armor + armorFactor))
      local health = GetEntityHealth(PlayerPedId())
      SetEntityHealth(PlayerPedId(), math.floor(health + armorFactor))
    end
  end
  ketaActive = false
  TriggerEvent("fx:run", "cocaine", 10, 0.0, false, false)
  TriggerServerEvent("np-drugeffects:forceStress", 5000, 10 * 60 * 1000)
end)

-- Crack Effects
RegisterNetEvent('hadcrack')
AddEventHandler('hadcrack', function()
  if drugEffectTime > 0 then return end
  drugEffectTime = 40

  TriggerEvent("client:newStress", true, 10)
  TriggerEvent("healed:useOxy", false, true)
  
  local ped = PlayerPedId()
  local pId = PlayerId()
  local loops = 0

  SetRunSprintMultiplierForPlayer(pId, 1.25)
  SetSwimMultiplierForPlayer(pId, 1.25)

  while drugEffectTime > 0 do
    if loops > 10 then
      SetRunSprintMultiplierForPlayer(pId, 1.1)
      SetSwimMultiplierForPlayer(pId, 1.1)
    end
    loops = loops + 1
    Citizen.Wait(1000)
    RestorePlayerStamina(pId, 1.0)
    drugEffectTime = drugEffectTime - 1
    if IsPedRagdoll(ped) then
      SetPedToRagdoll(ped, math.random(5), math.random(5), 3, 0, 0, 0)
    end
  end
  TriggerEvent("healed:useOxy", false, true)
  drugEffectTime = 0
  SetRunSprintMultiplierForPlayer(pId, 1.0)
  SetSwimMultiplierForPlayer(pId, 1.0)
end)

RegisterNetEvent("weed")
AddEventHandler("weed", function(alteredValue, scenario, multiply)
  local timeout = 500
  if not multiply then multiply = 1.0 end

  while not IsPedUsingScenario(PlayerPedId(), scenario) do
    Wait(0)

    timeout = timeout - 1

    if timeout == 0 then
      print("WEED ANIMATION TIMED OUT")
      return
    end
  end

  TriggerEvent("addiction:drugTaken", "weed")
  local removedStress = 0

  TriggerEvent("DoShortHudText", 'Stress is being relieved', 6)

  SetPlayerMaxArmour(PlayerId(), 60)

  local addictionFactor = getFactor("weed")

  -- Addiction will scale the amount of armor you get over time between 0 and 3 dependiong on how addicted you are
  local armorchange = map_range(addictionFactor, 0.0, 5.0, 3.0, 0.0)

  if armorchange < 0 then
    armorchange = 0
  end

  while removedStress <= alteredValue do
    removedStress = removedStress + 25

    local armor = GetPedArmour(PlayerPedId())
    SetPedArmour(PlayerPedId(), math.ceil(armor + (multiply * armorchange)))

    if scenario ~= "None" then
      if not IsPedUsingScenario(PlayerPedId(), scenario) then
        TriggerEvent("animation:cancel")
        break
      end
    end

    Citizen.Wait(1000)
  end

  TriggerServerEvent("server:alterStress", false, removedStress)
end)

function map_range(s, a1, a2, b1, b2)
  return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end

---------------------------------------------------- BIG BALLA DRUGS DONE DAWG -------------------------------------------------------------------------------





RegisterNetEvent("np-hud:EnableHud")
AddEventHandler("np-hud:EnableHud", function(status)
    isLoggedIn = status
end)

DecorRegister("GetVehicleCurrentFuel", 3)

function fRound( n )
    return math.floor( n + 0.5 )
end


function lerp(min, max, amt)
	return (1 - amt) * min + amt * max
end
function rangePercent(min, max, amt)
	return (((amt - min) * 100) / (max - min)) / 100
end

function HasPedLoaded()
    if PlayerPedId() == PlayerPedId() then return true else return false end
end
CreateThread(function()
    SetBlipAlpha(GetNorthRadarBlip(), 0)
end)

local lastDamageTrigger = 0
  
currentValues["oxy"] = 25

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
	if currentValues["oxy"] > 25.0 then
		currentValues["oxy"] = 25.0
        removeAttachedProp()
        removeAttachedProp2()
        print('[OXYGEN] Removed tank')
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
	currentValues["oxy"] = 100.0
	TriggerEvent('menu:hasOxygenTank', true)
end)

oxyOn = false

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if currentValues["oxy"] > 0 and IsPedSwimmingUnderWater(PlayerPedId()) then
			SetPedDiesInWater(PlayerPedId(), false)
			if currentValues["oxy"] > 25.0 then
				currentValues["oxy"] = currentValues["oxy"] - 0.0028125
			else
				currentValues["oxy"] = currentValues["oxy"] - 2.5
			end
		else
			if IsPedSwimmingUnderWater(PlayerPedId()) then
				currentValues["oxy"] = currentValues["oxy"] - 0.01
				SetPedDiesInWater(PlayerPedId(), true)
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 15)
			end
		end

		if not IsPedSwimmingUnderWater( PlayerPedId() ) and currentValues["oxy"] < 25.0 then
			if GetGameTimer() - lastDamageTrigger > 3000 then
				currentValues["oxy"] = currentValues["oxy"] + 6
				if currentValues["oxy"] > 25.0 then
					currentValues["oxy"] = 25.0
				end
			else
				if currentValues["oxy"] <= 0 then
                    local dead = exports['np-death']:GetDeathStatus()

					if dead then
						lastDamageTrigger = -7000
						currentValues["oxy"] = 25.0
					else
						SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 20)
					end
				end
			end
		end

		if currentValues["oxy"] > 25.0 and not oxyOn then
			oxyOn = true
			attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
			attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
		elseif oxyOn and currentValues["oxy"] <= 25.0 then
			oxyOn = false
			removeAttachedProp()
			removeAttachedProp2()
		end
		if not oxyOn then
			Wait(1000)
    end

	end
end)

function roundedRadar()
    if wasMinimapEnabled == false then
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false) 
        return
    end
    Citizen.CreateThread(function()
        if not appliedTextureChange and not useDefaultMinimap then
          RequestStreamedTextureDict("circlemap", false)
          while not HasStreamedTextureDictLoaded("circlemap") do
              Citizen.Wait(0)
          end
          AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasklg")
          AddReplaceTexture("platform:/textures/graphics", "radarmasklg", "circlemap", "radarmasklg")
          appliedTextureChange = true
        elseif appliedTextureChange and useDefaultMinimap then
          appliedTextureChange = false
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasksm")
          RemoveReplaceTexture("platform:/textures/graphics", "radarmasklg")
        end

        SetBlipAlpha(GetNorthRadarBlip(), 0.0)

        local screenX, screenY = GetScreenResolution()
        local modifier = screenY / screenX

        local baseXOffset = 0.0046875
        local baseYOffset = 0.74

        local baseSize    = 0.20 -- 20% of screen

        local baseXWidth  = 0.1313 -- baseSize * modifier -- %
        local baseYHeight = baseSize -- %

        local baseXNumber = screenX * baseSize  -- 256
        local baseYNumber = screenY * baseSize  -- 144

        local radiusX     = baseXNumber / 2     -- 128
        local radiusY     = baseYNumber / 2     -- 72

        local innerSquareSideSizeX = math.sqrt(radiusX * radiusX * 2) -- 181.0193
        local innerSquareSideSizeY = math.sqrt(radiusY * radiusY * 2) -- 101.8233

        local innerSizeX = ((innerSquareSideSizeX / screenX) - 0.01) * modifier
        local innerSizeY = innerSquareSideSizeY / screenY

        local innerOffsetX = (baseXWidth - innerSizeX) / 2
        local innerOffsetY = (baseYHeight - innerSizeY) / 2

        local innerMaskOffsetPercentX = (innerSquareSideSizeX / baseXNumber) * modifier

        local function setPos(type, posX, posY, sizeX, sizeY)
            SetMinimapComponentPosition(type, "I", "I", posX, posY, sizeX, sizeY)
        end
        if not useDefaultMinimap then
            SendNUIMessage({
                action = "displayUI"
            })
            round = true
          setPos("minimap",       baseXOffset - (0.025 * modifier), baseYOffset - 0.025, baseXWidth + (0.05 * modifier), baseYHeight + 0.05)
          setPos("minimap_blur",  baseXOffset, baseYOffset, baseXWidth + 0.001, baseYHeight)
          -- setPos("minimap_mask",  baseXOffset + innerOffsetX, baseYOffset + innerOffsetY, innerSizeX, innerSizeY)
          -- The next one is FUCKING WEIRD.
          -- posX is based off top left 0.0 coords of minimap - 0.00 -> 1.00
          -- posY seems to be based off of the top of the minimap, with 0.75 representing 0% and 1.75 representing 100%
          -- sizeX is based off the size of the minimap - 0.00 -> 0.10
          -- sizeY seems to be height based on minimap size, ranging from -0.25 to 0.25
          setPos("minimap_mask", 0.1, 0.95, 0.09, 0.15)
          -- setPos("minimap_mask", 0.0, 0.75, 1.0, 1.0)
          -- setPos("minimap_mask",  baseXOffset, baseYOffset, baseXWidth, baseYHeight)
        else
            round = false
          local function setPosLB(type, posX, posY, sizeX, sizeY)
              SetMinimapComponentPosition(type, "L", "B", posX, posY, sizeX, sizeY)
          end
          local offsetX = -0.018
          local offsetY = 0.025

          local defaultX = -0.0045
          local defaultY = 0.002

          local maskDiffX = 0.020 - defaultX
          local maskDiffY = 0.032 - defaultY
          local blurDiffX = -0.03 - defaultX
          local blurDiffY = 0.022 - defaultY

          local defaultMaskDiffX = 0.0245
          local defaultMaskDiffY = 0.03

          local defaultBlurDiffX = 0.0255
          local defaultBlurDiffY = 0.02

          setPosLB("minimap",       -0.0045,  -0.0245,  0.150, 0.18888)
          setPosLB("minimap_mask",  0.020,    0.022,  0.111, 0.159)
          setPosLB("minimap_blur",  -0.03,    0.002,  0.266, 0.237)
        end
        if not useDefaultMinimap then
          SetMinimapClipType(1)
        else
          SetMinimapClipType(0)
        end
        DisplayRadar(0)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(1)
    end)
end

Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        --
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        HideHudComponentThisFrame(15)
        HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)

        local selectedWeapon = GetSelectedPedWeapon(PlayerPedId())
		if `WEAPON_UNARMED` ~= selectedWeapon and 741814745 ~= selectedWeapon then
			DisplayAmmoThisFrame(true)
		end

        HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
        DisableControlAction(0, 37, true)
        
        HideMinimapInteriorMapThisFrame()
        SetRadarZoom(1000)

        Citizen.Wait(0)
    end
end)

-- No idle cams
Citizen.CreateThread(function()
    while true do
      InvalidateIdleCam()
      N_0x9e4cfff989258472() -- Disable the vehicle idle camera
      Wait(10000) --The idle camera activates after 30 second so we don't need to call this per frame
    end 
end)

--minimap stuff

local speed = 0.0
local cruiseOn = false
local toggle = false
local developer = false
local estashowroom = false
local setHealOnOff = true
local setArmorOnOff = true
local setFoodOnOff = true
local setWateronOff = true
local setOxyOnOff = true
local setStressOnOff = true
local setStaminaOnOff = true
local setLagOnOff = true
local developer = false
local debug = false
local bleedingPercentage = 0
local level = 100
local voz = 66.66
local nitro = 0
local tiempo = 0
local pursuitmode = 0
local ecompass = false
local hcompass = 100
local shoot = 0
local money = 0
local chipmode = 0

local seatbelt = false
RegisterNetEvent("seatbelt")
AddEventHandler("seatbelt", function(belt)
    seatbelt = belt
end)

local harness = false
RegisterNetEvent("harness")
AddEventHandler("harness", function(belt)
	harness = belt
end)

RegisterNetEvent('np-admin:currentDevmode')
AddEventHandler('np-admin:currentDevmode', function(test)
    developer = test
end)

RegisterNetEvent('np-admin:currentDebug')
AddEventHandler('np-admin:currentDebug', function(status)
    debug = status
end)

RegisterNetEvent('nitro:info')
AddEventHandler('nitro:info', function(test)
    nitro = test
end)

RegisterNetEvent('hud:casino')
AddEventHandler('hud:casino', function(test)
    tiempo = test
end)

RegisterNetEvent("np-hud:changeRange")
AddEventHandler("np-hud:changeRange", function(pRange)
    voice = pRange or 2
end)

AddEventHandler("hud:voice:transmitting", function (transmitting)
	SendNUIMessage({type = "transmittingStatus", is_transmitting = transmitting})
end)

RegisterNetEvent('estashowroom')
AddEventHandler('estashowroom', function(test)
    estashowroom = test
end)

RegisterNetEvent('hud:saveCurrentMeta')
AddEventHandler('hud:saveCurrentMeta', function()
	TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"],currentValues["armor"])
end)

Citizen.CreateThread(function()
    while true do
	    if exports['np-hud']:BuffHunger() and currentValues["hunger"] > 0 then
      currentValues["hunger"] = currentValues["hunger"] - math.random(2)
        else
        currentValues["hunger"] = currentValues["hunger"] - math.random(3)
end
	    if exports['np-hud']:BuffThirst() and currentValues["thirst"] > 0 then
      currentValues["thirst"] = currentValues["thirst"] - 2
        else
        currentValues["thirst"] = currentValues["thirst"] - 3
end
  TriggerServerEvent("police:update:hud",GetEntityHealth(PlayerPedId()),GetPedArmour(PlayerPedId()),currentValues["thirst"],currentValues["hunger"])
Citizen.Wait(300000)
		
		if currentValues["thirst"] < 20 or currentValues["hunger"] < 20 then
			local newhealth = GetEntityHealth(PlayerPedId()) - math.random(10)
			SetEntityHealth(PlayerPedId(), newhealth)
		end
	end
end)


blackBars = true
CinematicCamBool = true
hudoff = true


RegisterNUICallback('hud_on', function(data)
    hudoff = data.hud_on
end)

RegisterNUICallback('compassinput', function(data)
    TriggerEvent("change:full_oof", data.compassinput)
end)

RegisterNUICallback('compassTime', function(data)
    TriggerEvent("change:compass", data.compassTime)
end)

RegisterNUICallback('compassStreet', function(data)
    TriggerEvent("change:street", data.compassStreet)
end)

RegisterNUICallback('minimap_clip', function(data)
    useDefaultMinimap = data.d_minimap
    TriggerServerEvent('void:map1')
end)

RegisterNUICallback('minimap_clip2', function(data)
  useDefaultMinimap = data.d_minimap
  TriggerServerEvent('void:map0')
end)

local radioPush = false

RegisterNetEvent("police:setClientMeta")
AddEventHandler("police:setClientMeta",function(meta)
	if meta == nil then return end
	if meta.thirst == nil then currentValues["thirst"] = 100 else currentValues["thirst"] = meta.thirst end
	if meta.hunger == nil then currentValues["hunger"] = 100 else currentValues["hunger"] = meta.hunger end
	if meta.health == nil then
		return
	end

	if meta.health < 10.0 then
		SetEntityHealth(PlayerPedId(),10.0)
	else
		SetEntityHealth(PlayerPedId(),meta.health)
	end

	
	SetPlayerMaxArmour(PlayerPedId(), 60 )
	SetPedArmour(PlayerPedId(),meta.armour)
end)

Citizen.CreateThread(function ()
	while true do
		local isTalking = NetworkIsPlayerTalking(PlayerId())
        local pRadioActive = exports['np-voice']:pRadioActive()
        SendNUIMessage({
            action = "voiceupdate", 
            talking = NetworkIsPlayerTalking(PlayerId()) and not pRadioActive,
            radioPush = pRadioActive,
        })
		Citizen.Wait(250)
	end
end)

Citizen.CreateThread(function()
    voice = 2
    while true do 
        Citizen.Wait(500)
        if isLoggedIn then
            local playerPed = PlayerPedId()
            speed = GetEntitySpeed(GetVehiclePedIsIn(playerPed, false)) * 3.6
            local playerVeh = GetVehiclePedIsIn(playerPed, false)
            local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            local pRadio = exports['radio']:pChannel()

            local get_ped = PlayerPedId()
            currentValues["armor"] = GetPedArmour(get_ped)

            if pStress < 0 then 
                pStress = 0
            end

            if pStress > 100 then 
                pStress = 100
            end

            if currentValues["hunger"] < 0 then
                currentValues["hunger"] = 0
            end
            if currentValues["thirst"] < 0 then
                currentValues["thirst"] = 0
            end

            if currentValues["hunger"] > 100 then currentValues["hunger"] = 100 end

            if currentValues["health"] < 1 then currentValues["health"] = 100 end
            if currentValues["thirst"] > 100 then currentValues["thirst"] = 100 end
        
                
            if oxy < 0 then oxy = 0 end

            if IsPedInAnyVehicle(PlayerPedId(), true) and not IsPauseMenuActive() then 
                local vehhash = GetEntityModel(playerVeh)
                local maxspeed = GetVehicleModelMaxSpeed(vehhash) * 3.6
                SendNUIMessage({action = "ShowCarHud", showCarUi = true})
                SendNUIMessage({action = "ShowCarHud", belt = seatbelt})
                SendNUIMessage({action = "ShowCarHud", checkHarness = harness})
                SendNUIMessage({action = "ShowCarHud", speed = Mph, maxspeed = maxspeed, engine = engine, fuel = math.ceil(Fuel)})
            else
                SendNUIMessage({action = "ShowCarHud", checkHarness = false})
                SendNUIMessage({action = "ShowCarHud", showCarUi = false})
            end


            SendNUIMessage({
                action = "hudtick",
                show = hudoff == false,
                health = GetEntityHealth(playerPed),
                armor = lerp(0, 100, rangePercent(0, 60, currentValues["armor"])),--GetPedArmour(playerPed),
                hunger = currentValues["hunger"],
                thirst = currentValues["thirst"],
                oxygen = currentValues["oxy"],
                mic = voice,
                stress = pStress,
                cinturon = Harness,
                radio = pRadio,
                dev = developer,
                dev2 = debug,
                nitro = nitro,
                casino = tiempo,
                inVehicle = inveh,
                nitron = hasbottle,--exports["np-nitro"]:onNitro(),
                pursuitmode = SelectedPursuitMode,
                hcompass = hcompass,
                ecompass = ecompass,
                shoot = HasWeaponOut,
                money = isLooting,
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
                luck = bufftimeluck,
                swimbuff = bufftimeswimming,
                intelegence = bufftimeint,
                strong = buffstrenthtime,
                chipmode = chipmode,
                hasregen = regentime,
                hasregenarmor = armortime,
                hasregenstressed = stresstime,
                alert = alerttime,
			        	hasbuffthirst = buffthirsttime,
                hasregenfood = hungertime
                
            })
        else 
            SendNUIMessage({action = "ShowCarHud", showCarUi = false})
            SendNUIMessage({action = "hudtick", show = "none"})
        end
    end
end)

RegisterNetEvent('hud:dealertimerClock')
AddEventHandler('hud:dealertimerClock', function(timetable)
    casino = timetable
end)



RegisterNetEvent('noshud')
AddEventHandler('noshud', function(newlevel,noson,bottle)
	level = newlevel
	nitro = noson
	nitron = bottle
end)

RegisterNetEvent('np-hud:ChangeThirst')
AddEventHandler('np-hud:ChangeThirst', function(amount)
    if isLoggedIn == true then
		currentValues["thirst"] = currentValues["thirst"] + amount

		if currentValues["thirst"] < 0 then
			currentValues["thirst"] = 0
		end

		if currentValues["thirst"] > 100 then
			currentValues["thirst"] = 100
		end
	end
end)

RegisterNetEvent('np-hud:ChangeHunger')
AddEventHandler('np-hud:ChangeHunger', function(amount)
	if isLoggedIn == true then
		currentValues["hunger"] = currentValues["hunger"] + amount

		if currentValues["hunger"] < 0 then
			currentValues["hunger"] = 0
		end

		if currentValues["hunger"] > 100 then
			currentValues["hunger"] = 100
		end
	end
end)

function GetPed()
    return PlayerPedId()
end

local isPause = false
local uiHidden = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        if not useDefaultMinimap then
            if IsPauseMenuActive() or IsRadarHidden() then
                if not uiHidden then
                    SendNUIMessage({
                        action = "hideUI"
                    })
                    uiHidden = true
                end
            elseif uiHidden or IsPauseMenuActive() then
                Citizen.Wait(500)
                SendNUIMessage({
                    action = "displayUI"
                })
                uiHidden = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local veh = GetVehiclePedIsIn(GetPed(), false)
        local eon = IsVehicleEngineOn(veh)
        if eon and not engineOn then
            roundedRadar()
            engineOn = true
            inVehicle = true
            inveh = true
        elseif not eon and engineOn then
            inveh = false
            engineOn = false
            showCompassFromCar = false
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({
                action = "hideUI"
            })
        elseif IsPedOnFoot(GetPed()) then
            Citizen.Wait(32)
            DisplayRadar(0)
            SendNUIMessage({
                action = "hideUI"
            })
        elseif wasMinimapEnabled ~= minimapEnabled then
            wasMinimapEnabled = minimapEnabled
            roundedRadar()
        end
    end
end)

RegisterNUICallback('ayar-minimap', function(data)
    minimapEnabled = data.minimap
end)

currentValues["hunger"] = 100
currentValues["thirst"] = 100

hunger = "Full"
thirst = "Sustained"

AddEventHandler('playerSpawned', function()
    Citizen.Wait(8000)
    SendNUIMessage({action = "DisplayPursuitMode", pursuitmode = 0})
end)

RegisterCommand('hud', function()
    TriggerEvent('np-hud:open-hud')
end)

RegisterNetEvent('np-bruh:pay')
AddEventHandler('np-bruh:pay', function()
    local randomMoney = math.random(340, 500)
    user:addMoney(randomMoney)
end)

RegisterNetEvent('np-hud:open-hud')
AddEventHandler('np-hud:open-hud', function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'showMenu'})
end)

RegisterNUICallback('close-ayar-menu', function()
    SetNuiFocus(false, false)
end)

dstamina = 0

local stressDisabled = false
RegisterNetEvent("client:disableStress")
AddEventHandler("client:disableStress",function(stressNew)
	stressDisabled = stressNew
end)


RegisterNetEvent("stress:timed2")
AddEventHandler("stress:timed2",function(alteredValue,scenario)
	local removedStress = 0
	Wait(1000)

	TriggerEvent("DoShortHudText",'Stress is being relieved',6)
	SetPlayerMaxArmour(PlayerId(), 60)
	while true do
		removedStress = removedStress + 25
		if removedStress >= alteredValue then
			break
		end
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(),armor+3)
		if scenario ~= "None" then
			if not IsPedUsingScenario(PlayerPedId(),scenario) then
				TriggerEvent("animation:cancel")
				break
			end
		end
		Citizen.Wait(1000)
	end
	TriggerServerEvent("server:alterStress",false,removedStress)
end)


Citizen.CreateThread(function()

    while true do

        Citizen.Wait(500)
        local player = PlayerPedId()

        if (IsPedInAnyVehicle(player, false)) then

            local veh = GetVehiclePedIsIn(player,false)

            if GetPedInVehicleSeat(veh, -1) == player then

                if not DivingStatus then


                    if updateLatestVehicle ~= veh then
                        --if not DecorExistOn(veh, "GetVehicleCurrentFuel") then
                        --    Fuel = math.random(80,100)
                        --else
                            Fuel = exports["np-vehicles"]:CurrentFuel()
                        --end
                    else
                        Fuel = exports["np-vehicles"]:CurrentFuel()
                    end

                    DivingStatus = true
                    updateLatestVehicle = veh
                    setLastUpdate = 0

                    --if not DecorExistOn(veh, "GetVehicleCurrentFuel") then 
                    --    Fuel = math.random(80,100)
                    --    DecorSetInt(veh, "GetVehicleCurrentFuel", fRound(Fuel))
                    --end

                else

                    if Fuel > 105 then
                        Fuel = exports["np-vehicles"]:CurrentFuel()
                    end                     
                    if Fuel == 101 then
                        Fuel = exports["np-vehicles"]:CurrentFuel()
                    end

                end

                if ( setLastUpdate > 300) then
                  exports["np-vehicles"]:SetVehicleFuel(veh, fRound(Fuel))
                  lasteupdate = 0
                end

                setLastUpdate = setLastUpdate + 1

                if Fuel > 0 then
                    if IsVehicleEngineOn(veh) then
                        local fueltankhealth = GetVehiclePetrolTankHealth(veh)
                        if fueltankhealth == 1000.0 then
                            SetVehiclePetrolTankHealth(veh, 4000.0)
                        end
                        local fuelMath = GetEntitySpeed(GetVehiclePedIsIn(player, false)) * 3.6
                        if fuelMath > 30 then
                            fuelMath = fuelMath * 1.8
                        else
                            fuelMath = fuelMath / 2.0
                        end
                        fuelMath = fuelMath / 7500

                        if fuelMath == 0 then
                            fuelMath = 0.0001
                        end
                        if IsPedInAnyBoat(PlayerPedId()) then
                            fuelMath = 0.0090
                        end
                        local missingTankHealth = (4000 - fueltankhealth) / 1000

                        if missingTankHealth > 1 then
                            missingTankHealth = missingTankHealth * (missingTankHealth * missingTankHealth * 12)
                        end

                        local factorFuel = (fuelMath + 1 / 5000) * (missingTankHealth+1)
                        Fuel = Fuel - factorFuel
                    end
                end

                if Fuel <= 4 and Fuel > 0 then
                    if not IsThisModelABike(GetEntityModel(veh)) then
                        local decayChance = math.random(20,100)
                        if decayChance > 90 then
                            SetVehicleEngineOn(veh,0,0,1)
                            SetVehicleUndriveable(veh,true)
                            Citizen.Wait(100)
                            SetVehicleEngineOn(veh,1,0,1)
                            SetVehicleUndriveable(veh,false)
                        end
                    end
                end

                if Fuel < 15 then
                end

                if Fuel < 1 then
                    if Fuel ~= 0 then
                        Fuel = 0
                        exports["np-vehicles"]:SetVehicleFuel(veh, fRound(Fuel))
                      end

                    if IsVehicleEngineOn(veh) or IsThisModelAHeli(GetEntityModel(veh)) then
                        SetVehicleEngineOn(veh,0,0,1)
                        SetVehicleUndriveable(veh,false)
                    end
                end
            end
        else
            if DivingStatus then
                DivingStatus = false
                exports["np-vehicles"]:SetVehicleFuel(updateLatestVehicle, fRound(Fuel))
            end
            Citizen.Wait(1500)
        end
    end
end)
local showGasStations = false

local gasStations = {
    {49.41872, 2778.793, 58.04395,600},
    {263.8949, 2606.463, 44.98339,600},
    {1039.958, 2671.134, 39.55091,900},
    {1207.26, 2660.175, 37.89996,900},
    {2539.685, 2594.192, 37.94488,1500},
    {2679.858, 3263.946, 55.24057,1500},
    {2005.055, 3773.887, 32.40393,1200},
    {1687.156, 4929.392, 42.07809,900},
    {1701.314, 6416.028, 32.76395,1200},
    {179.8573, 6602.839, 31.86817,600},
    {-94.46199, 6419.594, 31.48952,600},
    {-2554.996, 2334.402, 33.07803,600},
    {-1800.375, 803.6619, 138.6512,600},
    {-1437.622, -276.7476, 46.20771,600},
    {-2096.243, -320.2867, 13.16857,600},
    {-724.6192, -935.1631, 19.21386,600},
    {-526.0198, -1211.003, 18.18483,600},
    {-70.21484, -1761.792, 29.53402,600},
    {265.6484,-1261.309, 29.29294,600},
    {819.6538,-1028.846, 26.40342,780},
    {1208.951,-1402.567, 35.22419,900},
    {1181.381,-330.8471, 69.31651,900},
    {620.8434, 269.1009, 103.0895,780},
    {2581.321, 362.0393, 108.4688,1500},
    {1785.363, 3330.372, 41.38188,1200},
    {-319.537, -1471.5116, 30.54118,600},
    {-66.58, -2532.56, 6.14, 400}
}


RegisterNetEvent('CarPlayerHud:ToggleGas')
AddEventHandler('CarPlayerHud:ToggleGas', function()
    showGasStations = not showGasStations
   for _, item in pairs(gasStations) do
        if not showGasStations then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[3])
            SetBlipSprite(item.blip, 361)
            SetBlipScale(item.blip, 0.7)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Gas")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

Citizen.CreateThread(function()
    showGasStations = true
    TriggerEvent('CarPlayerHud:ToggleGas')
end)

RegisterNetEvent('np-gas:checkpump')
AddEventHandler('np-gas:checkpump', function()
    local ped = PlayerPedId()
	local vehicle = GetPlayersLastVehicle()
	local vehicleCoords = GetEntityCoords(vehicle)
    local veh = getVehicleClosestToMe()

    TriggerEvent('customNotification', "Make sure you are facing the vehicle!") 
    TaskTurnPedToFaceEntity(ped, vehicle, 1000)
    Wait(1600)
    if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then
        vehicleCurrentFuel = exports["np-vehicles"]:CurrentFuel()
        costs = (100 - vehicleCurrentFuel)
        if costs < 0 then
            costs = 0
        end
        if vehicleCurrentFuel >= 100 then
            PlaySound(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0, 0, 1)
            TriggerEvent('customNotification', "You are already full!") 
        else
            costs = math.ceil(costs)
            TriggerServerEvent("carfill:checkmoney", costs)
        end
    end
end)

exports("setFuel", function(veh, amt)
  exports["np-vehicles"]:SetVehicleFuel(veh, amt)
end)

function getVehicleClosestToMe()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end

function getVehicleInDirection(coordFrom, coordTo)
	local offset = 0
	local rayHandle
	local vehicle

	for i = 0, 100 do
		rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)	
		a, b, c, d, vehicle = GetRaycastResult(rayHandle)
		
		offset = offset - 1

		if vehicle ~= 0 then break end
	end
	
	local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
	
	if distance > 3000 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent("RefuelCarServerReturn")
AddEventHandler("RefuelCarServerReturn",function()
    local timer = (100 - vehicleCurrentFuel) * 400
    refillVehicle()
    local finished = exports["np-taskbar"]:taskBar(timer,"Refueling")
    local veh = getVehicleClosestToMe()

    if finished == 100 then
        DecorSetInt(veh, "GetVehicleCurrentFuel", 100)
    else

        local vehicleCurrentFuel = DecorGetInt(veh, "GetVehicleCurrentFuel")
        local endFuel = (100 - vehicleCurrentFuel) 
        endFuel = math.ceil(endFuel * (finished / 100) + vehicleCurrentFuel)
        DecorSetInt(veh, "GetVehicleCurrentFuel", endFuel)

    end
    endanimation()
end)

function refillVehicle()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict( "weapon@w_sp_jerrycan" ) 
    TaskPlayAnim( PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
end

function endanimation()
    shiftheld = false
    ctrlheld = false
    tabheld = false
    ClearPedTasks(PlayerPedId())
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent('np-admin:maxstats')
AddEventHandler('np-admin:maxstats', function()
    currentValues["thirst"] = 100
	currentValues["hunger"] = 100 
    TriggerEvent("heal", PlayerPedId())
    TriggerEvent("Hospital:HealInjuries", PlayerPedId(),true) 
    TriggerServerEvent("np-death:reviveSV", source)
    TriggerServerEvent("reviveGranted", source)
    TriggerServerEvent("ems:healplayer", source)
    SetPlayerMaxArmour(PlayerPedId(), 100)
    SetPedArmour(PlayerPedId(), 60)
    TriggerEvent("hud:saveCurrentMeta")
end)

local isBlocked = false

RegisterNetEvent("client:updateStress")
AddEventHandler("client:updateStress",function(newStress)
    pStress = newStress
end)

RegisterNetEvent("client:blockShake")
AddEventHandler("client:blockShake",function(isBlockedInfo)
    isBlocked = isBlockedInfo
end)


RegisterNetEvent("np-admin:currentDevmode")
AddEventHandler("np-admin:currentDevmode", function(devmode)
    isBlocked = devmode
end)

RegisterNetEvent("np-hud:updateStress")
AddEventHandler("np-hud:updateStress", function(status, amount)
    if status == true then
        pStress = pStress + amount
        TriggerEvent("DoShortHudText",'Stress Gained',6)
        Wait(1000)
        TriggerServerEvent('np-hud:UpdateStress_SV', pStress)
    elseif status == false then
        pStress = pStress - amount
        Wait(1000)
        TriggerServerEvent('np-hud:UpdateStress_SV', pStress)
    end
end)

RegisterCommand('ui-r', function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'closeMenu'})
    TriggerEvent('np-hud:EnableHud', false)
    TriggerScreenblurFadeOut(100.0)
    TriggerEvent('closeInventoryGui')
    TriggerEvent('np-banking:ResetUI')
    TriggerEvent('np-radio:ResetUI')
    TriggerEvent('np-menu:ResetUI')
    TriggerEvent('np-interact:ResetUI')
    TriggerEvent('np-mdt:ResetUI')
    TriggerEvent('np-ui:restartUI')
    TriggerEvent('menu:menuexit')
    TriggerEvent('clothing:close')
    TriggerServerEvent('void:getmapprefrence')
    exports['np-textui']:showInteraction("Restarting UI .")
    Wait(1000)
    exports['np-textui']:showInteraction("Restarting UI ..")
    Wait(1000)
    exports['np-textui']:showInteraction("Restarting UI ...")
    Wait(1000)
    exports['np-textui']:showInteraction("UI Successfully Restarted")
    Wait(1000)
    exports['np-textui']:hideInteraction()
    TriggerEvent('np-hud:EnableHud', true)
	TriggerServerEvent("police:SetMeta")
end)

RegisterCommand("anim-r", function()
    exports["np-textui"]:showInteraction("Reseting Animations .")
    Wait(1000)
    exports["np-textui"]:showInteraction("Reseting Animations ..")
    Wait(1000)
    exports["np-textui"]:showInteraction("Reseting Animations ...")
    Wait(1000)
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedTasks(PlayerPedId())
    exports["np-textui"]:showInteraction("Animations Restarted !", "success")
    Wait(1000)
    exports["np-textui"]:hideInteraction()
    exports["np-textui"]:hideInteraction("success")
end)

Citizen.CreateThread( function()

	local resetcounter = 0
	local jumpDisabled = false
  	
  	while true do 
    Citizen.Wait(100)
		if jumpDisabled and resetcounter > 0 and IsPedJumping(PlayerPedId()) then
			
			SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)

			resetcounter = 0
		end

		if not jumpDisabled and IsPedJumping(PlayerPedId()) then

			jumpDisabled = true
			resetcounter = 10
			Citizen.Wait(1200)
		end

		if resetcounter > 0 then
			resetcounter = resetcounter - 1
		else
			if jumpDisabled then
				resetcounter = 0
				jumpDisabled = false
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPedArmed(PlayerPedId(), 6) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        else
            Citizen.Wait(1500)
        end
    end
end)


function removeAttachedProp2()
    DeleteEntity(attachedProp2)
    attachedProp2 = 0
  end
  function removeAttachedProp()
    DeleteEntity(attachedProp)
    attachedProp = 0
  end
  function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp2()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
      Citizen.Wait(100)
    end
    attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
  end
  function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
    removeAttachedProp()
    attachModel = GetHashKey(attachModelSent)
    boneNumber = boneNumberSent
    local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
      Citizen.Wait(100)
    end
    attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
    AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
    SetModelAsNoLongerNeeded(attachModel)
  end

  RegisterNetEvent("np-hud:jerry_can:refuel")
  AddEventHandler("np-hud:jerry_can:refuel",function()
      vehicleCurrentFuel = exports["np-vehicles"]:CurrentFuel(veh) --DecorGetInt(veh, "GetVehicleCurrentFuel")
      if exports['np-inventory']:hasEnoughOfItem('883325847', 1) then
        local timer = (100 - vehicleCurrentFuel) * 400
        refillVehicle()
        local finished = exports["np-taskbar"]:taskBar(timer,"Refueling")
        local veh = getVehicleClosestToMe()
    
        if finished == 100 then
            if exports['np-inventory']:hasEnoughOfItem('883325847', 1) then
                --DecorSetInt(veh, "GetVehicleCurrentFuel", 100)
                exports["np-vehicles"]:SetVehicleFuel(veh, 100)
                TriggerEvent('inventory:removeItem', '883325847', 1)
            else
                TriggerEvent('DoLongHudText', 'Try again!', 2)
            end
    
            local vehicleCurrentFuel = exports["np-vehicles"]:CurrentFuel(veh) --DecorGetInt(veh, "GetVehicleCurrentFuel")
            local endFuel = (100 - vehicleCurrentFuel) 
            endFuel = math.ceil(endFuel * (finished / 100) + vehicleCurrentFuel)
            --DecorSetInt(veh, "GetVehicleCurrentFuel", endFuel)
            exports["np-vehicles"]:SetVehicleFuel(veh, endFuel)
    
        end
        endanimation()
    else
        TriggerEvent('DoLongHudText', 'Unsure how you managed this?', 2)
    end
  end)

  -- Weapon Shit --

  RegisterNetEvent('np-hud:armed')
  AddEventHandler('np-hud:armed', function(pArmed)
    HasWeaponOut = pArmed
    SendNUIMessage({action = "shoot", shoot = HasWeaponOut})
  end)

  -- Ping Shit --

  RegisterNetEvent('np-hud:show_ping')
  AddEventHandler('np-hud:show_ping', function()
    ecompass = 100
    SendNUIMessage({action = "ecompass", ecompass = ecompass})
  end)

  RegisterNetEvent('np-hud:hide_ping')
  AddEventHandler('np-hud:hide_ping', function()
    ecompass = 0
    SendNUIMessage({action = "ecompass", ecompass = ecompass})
  end)

  RegisterNetEvent('np-hud:show_hackerman')
  AddEventHandler('np-hud:show_hackerman', function()
    chipmode = 100
    SendNUIMessage({action = "chipmode", chipmode = chipmode})
  end)

  RegisterNetEvent('np-hud:hide_hackerman')
  AddEventHandler('np-hud:hide_hackerman', function()
    chipmode = 0
    SendNUIMessage({action = "chipmode", chipmode = chipmode})
  end)


RegisterNetEvent('np-hud:showharness')
AddEventHandler('np-hud:showharness', function(pHarnessDur)
  Harness = pHarnessDur
  SendNUIMessage({action = "cinturon", cinturon = Harness})
end)

RegisterNetEvent('np-hud:hideharness')
AddEventHandler('np-hud:hideharness', function()
  Harness = 0
  SendNUIMessage({action = "cinturon", cinturon = Harness})
end)


RegisterNetEvent('np-hud:hideseatbelt')
AddEventHandler('np-hud:hideseatbelt', function()
  seatbelt = true
  SendNUIMessage({action = "belt", belt = seatbelt})
end)

RegisterNetEvent('np-hud:showseatbelt')
AddEventHandler('np-hud:showseatbelt', function()
  seatbelt = false
  SendNUIMessage({action = "belt", belt = seatbelt})
end)

RegisterNetEvent("client:newStress")
AddEventHandler("client:newStress", function(status, amount)
    local actualamount = amount/10

    if status == true then
        pStress = pStress + actualamount
        TriggerEvent("DoShortHudText",'Stress Gained',6)
        Wait(1000)
        TriggerServerEvent('np-hud:UpdateStress_SV', pStress)
    elseif status == false then
        pStress = pStress - actualamount
        Wait(1000)
        TriggerServerEvent('np-hud:UpdateStress_SV', pStress)
    end
end)

RegisterNetEvent('np-admin:remove_stress')
AddEventHandler('np-admin:remove_stress', function()
  pStress = 0
  TriggerServerEvent('np-hud:UpdateStress_SV', pStress)
end)


Citizen.CreateThread(function()
  while true do
	Wait(1000)
	if pStress <= 0 then
	 TriggerScreenblurFadeOut(1000.0)
	end
  end
end)

Citizen.CreateThread(function()
    while true do
        if not isBlocked then
            if pStress >= 100 then
                TriggerScreenblurFadeIn(1000.0)
                Wait(3000)
                TriggerScreenblurFadeOut(1000.0)
            elseif pStress <= 99 and pStress >=45 then
                TriggerScreenblurFadeIn(1000.0)
                Wait(100)
                TriggerScreenblurFadeOut(1000.0)
            end
        end 
        Citizen.Wait(2000)
    end
end)


local counter = 0
local Mph = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 2.236936
local uiopen = false



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(80)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            local veh = GetVehiclePedIsIn(player, false)
            if IsVehicleEngineOn(veh) then          

                if not uiopen then
                    uiopen = true
                    SendNUIMessage({
                    open = 1,
                    }) 
                end

                Mph = math.ceil(GetEntitySpeed(veh) * 2.236936)
                if Mph < 1.01 then
                    Mph = 0
                end
                local atl = false
                if IsPedInAnyPlane(player) or IsPedInAnyHeli(player) then
                    atl = string.format("%.1f", GetEntityHeightAboveGround(veh) * 3.28084)
                end
                local engine = false
                if GetVehicleEngineHealth(veh) < 400.0 then
                    engine = true
                end
                local GasTank = false
                if GetVehiclePetrolTankHealth(veh) < 3002.0 then
                    GasTank = true
                end
                SendNUIMessage({action = "ShowCarHud", speed = Mph, maxspeed = maxspeed, engine = engine, fuel = math.ceil(Fuel)})
            else
                if uiopen then
                    SendNUIMessage({
                    open = 3,
                    }) 

                    uiopen = false
                end
            end
        else
            if uiopen then
                SendNUIMessage({
                open = 3,
                }) 

                uiopen = false
            end
        end
    end
end)

function BuffIntel()
    if isIntelBuff == 1 then
        intelBuff = true
    elseif isIntelBuff == 0 then
        intelBuff = false
    end
    return intelBuff
end

function BuffStress()
  if isStressBuff == 1 then
    isStressBuff = true
  elseif isStressBuff == 0 then
    isStressBuff = false
  end
  return isStressBuff
end

function BuffLuck()
  if isLuckBuff == 1 then
    isLuckBuff = true
  elseif isLuckBuff == 0 then
    isLuckBuff = false
  end
  return isLuckBuff
end

function BuffHunger()
  if isHungerBuff == 1 then
    isHungerBuff = true
  elseif isHungerBuff == 0 then
    isHungerBuff = false
  end
  return isHungerBuff
end

function BuffAlert()
  if isAlertBuff == 1 then
    isAlertBuff = true
  elseif isAlertBuff == 0 then
    isAlertBuff = false
  end
  return isAlertBuff
end

function BuffThirst()
  if isThirstBuff == 1 then
    isThirstBuff = true
  elseif isThirstBuff == 0 then
    isThirstBuff = false
  end
  return isThirstBuff
end


RegisterNetEvent('minimapchecked')
AddEventHandler('minimapchecked', function()
  useDefaultMinimap = true
SendNUIMessage({
  action = "Minimap"
})
end)
 