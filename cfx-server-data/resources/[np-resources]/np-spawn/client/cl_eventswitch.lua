function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("np-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("np-base:initialSpawnModelLoaded")
  -- Main events leave alone 

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent("fx:clear")
  TriggerEvent('np-bankrobbery:client:CreateTrollysEvent')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('np-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent("requestOffices")
  Wait(500)
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("server:currentpasses")
  TriggerEvent("np-hud:SetValues", exports['isPed']:isPed('cid'))
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent('np-scoreboard:AddPlayer')
  TriggerServerEvent("np-base:PolyZoneUpdate")

  -- TriggerServerEvent("weapon:general:check")
  -- Anything that might need to wait for the client to get information, do it here.
  TriggerServerEvent("login:get:keys")
  TriggerServerEvent("raid_clothes:retrieve_tats")
  TriggerServerEvent("np-weapons:getAmmo")
  Wait(4000)
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('np-hud:EnableHud', true)
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('np-base:sv:player_control')
  TriggerServerEvent('np-base:sv:player_settings')
  TriggerEvent("spawning", false)
  TriggerEvent("attachWeapons")
  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

  if Spawn.isNew then
      Wait(1000)
      TriggerServerEvent('np-spawn:create_bank_accounts', exports['isPed']:isPed('cid'))
      if not exports["np-inventory"]:hasEnoughOfItem("mobilephone", 1, false) then
          TriggerEvent("player:receiveItem", "mobilephone", 1)
      end
      if not exports["np-inventory"]:hasEnoughOfItem("idcard", 1, false) then
          TriggerEvent("player:receiveItem", "idcard", 1)
      end
      if not exports["np-inventory"]:hasEnoughOfItem("lockpick", 2, false) then
        TriggerEvent("player:receiveItem", "lockpick", 2)
      end
      if not exports["np-inventory"]:hasEnoughOfItem("sandwich", 3, false) then
        TriggerEvent("player:receiveItem", "sandwich", 3)
      end
      if not exports["np-inventory"]:hasEnoughOfItem("water", 3, false) then
        TriggerEvent("player:receiveItem", "water", 3)
      end
      if not exports["np-inventory"]:hasEnoughOfItem("repairkit", 1, false) then
        TriggerEvent("player:receiveItem", "repairkit", 1)
      end
      TriggerEvent('np-hud:ChangeThirst', 100)
      TriggerEvent('np-hud:ChangeHunger', 100)
      TriggerEvent('np-hud:SaveValues')

      -- commands to make sure player is alive and full food/water/health/no injuries
      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("status:needs:restore", src) 

      TriggerServerEvent("np-spawn:newPlayerFullySpawned")
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  --SetPlayerMaxArmour(PlayerId(), 100) -- This is setting players armor on relog??
  runGameplay() -- moved from np-base 
  Spawn.isNew = false
end
RegisterNetEvent("np-spawn:characterSpawned");
AddEventHandler("np-spawn:characterSpawned", Login.characterSpawned);
