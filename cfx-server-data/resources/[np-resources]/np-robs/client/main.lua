local IsHacking = false
local location = nil
AddEventHandler('open:minigame', function(callback)
    Callbackk = callback
    openHack()
end)

function OpenHackingGame(callback)
    Callbackk = callback
    openHack()
end

RegisterNUICallback('callback', function(data, cb)
    closeHack()
    print("SUCCESS?",data.success,location)
    if location == "fleeca"then
        if data.success == true then 
            TriggerEvent('np-fleeca:addPlease')
        elseif data.success == false then
            TriggerEvent('np-fleeca:removePlease')
        end
    elseif location == "paleto" then
        if data.success == true then 
            --TriggerEvent('np-fleeca:addPlease')
        elseif data.success == false then
            --TriggerEvent('np-fleeca:removePlease')
        end
    end
    cb('ok')
end)

function openHack()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        time = 10,
        amount = 2,
    })
    IsHacking = true
end

function StartHacking(data)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        time = data.time,
        amount = data.amount,
        correct = data.correct
    })
    location = data.bankName
    IsHacking = true
    
end
function closeHack()
    SetNuiFocus(false, false)
    IsHacking = false
end

function GetHackingStatus()
    return IsHacking
end

exports("StartHacking", StartHacking)


----- GRAPPLE GUN BELOW


    local grappleGunModelHash = 100416529
    local grappleGunTintIndex = 2
    local grappleGunSuppressor = `COMPONENT_AT_AR_SUPP_02`
    local theGrappleGunIsEquiped = false
    local shownGrappleButton = false


    
    RegisterNetEvent('Ghost:UseGrappleGun') 
    AddEventHandler('Ghost:UseGrappleGun' , function(item)
        theGrappleGunIsEquiped = not theGrappleGunIsEquiped
        if theGrappleGunIsEquiped then
        Citizen.Trace('[Grapple] : Executing')
        theGrappleGunIsEquiped = true
        GiveWeaponToPed(PlayerPedId(), grappleGunModelHash, 0, 0, 1)
        GiveWeaponComponentToPed(PlayerPedId(), grappleGunModelHash, grappleGunSuppressor)
        SetPedWeaponTintIndex(PlayerPedId(), grappleGunModelHash, item ~= "grapplegun" and 5 or 2)
        SetPedAmmo(PlayerPedId(), grappleGunModelHash, 0)
        SetAmmoInClip(PlayerPedId(), grappleGunModelHash, 0)
    else
        RemoveWeaponFromPed(PlayerPedId(), grappleGunModelHash)
      end
    
      local ply = PlayerId()
      Citizen.CreateThread(function()
        print(theGrappleGunIsEquiped)
        while theGrappleGunIsEquiped do
          Wait(500)
          local veh = GetVehiclePedIsIn(PlayerPedId(), false)
          if (veh and veh ~= 0) or GetSelectedPedWeapon(PlayerPedId()) ~= grappleGunModelHash then
            theGrappleGunIsEquiped = false
            RemoveWeaponFromPed(PlayerPedId(), grappleGunModelHash)
          end
        end
      end)
      Citizen.CreateThread(function ()
        while theGrappleGunIsEquiped do
          local isFreeAiming = IsPlayerFreeAiming(ply)
          local hit, pos, _, _ = GrappleCurrentAimPoint(30)
          if not shownGrappleButton and isFreeAiming and hit == 1 then
            shownGrappleButton = true
            exports["np-textui"]:showInteraction("[E] Grapple!")
            print('[Ghost Grapple] :'..pos)
          elseif shownGrappleButton and (not isFreeAiming or hit ~= 1) then
            shownGrappleButton = false
            exports["np-textui"]:hideInteraction("[E] Grapple!")
          end
          Wait(250)
        end
      end)
      Citizen.CreateThread(function()
        while theGrappleGunIsEquiped do
          local isFreeAiming = IsPlayerFreeAiming(ply)

          if IsControlJustReleased(0, 51) and isFreeAiming and theGrappleGunIsEquiped then
            local hit, pos, _, _ = GrappleCurrentAimPoint(30)
            if hit == 1 then
              theGrappleGunIsEquiped = false

              local grapple = Grapple.new(pos, { waitTime = 1.5 })
              grapple.activate()

              Citizen.Wait(1000)
              RemoveWeaponFromPed(PlayerPedId(), grappleGunModelHash)

            --   TriggerEvent("inventory:DegenLastUsedItem", 25)  -- Remove lateer init 
              shownGrappleButton = false
              exports["np-textui"]:hideInteraction("[E] Grapple!")
              print('[Ghost Grapple] : Moving player :' ..ply)
            end
          end
          Citizen.Wait(0)
        end
      end)
    end)
    
    
    
    
    
    
    
    
    --[[ Grapple Gun main Functions ]]
    
    
    
    local sin, cos, atan2, abs, rad, deg = math.sin, math.cos, math.atan2, math.abs, math.rad, math.deg
    local EARLY_STOP_MULTIPLIER = 0.5
    local DEFAULT_GTA_FALL_DISTANCE = 8.3
    local DEFAULT_OPTIONS = {waitTime=0.5, grappleSpeed=20.0}
    
    Grapple = {}
    
    local function DirectionToRotation(dir, roll)
      local x, y, z
      z = -deg(atan2(dir.x, dir.y))
      local rotpos = vector3(dir.z, #vector2(dir.x, dir.y), 0.0)
      x = deg(atan2(rotpos.x, rotpos.y))
      y = roll
      return vector3(x, y, z)
    end
    
    local function RotationToDirection(rot)
      local rotZ = rad(rot.z)
      local rotX = rad(rot.x)
      local cosOfRotX = abs(cos(rotX))
      return vector3(-sin(rotZ) * cosOfRotX, cos(rotZ) * cosOfRotX, sin(rotX))
    end
    
    local function RayCastGamePlayCamera(dist)
      local camRot = GetGameplayCamRot()
      local camPos = GetGameplayCamCoord()
      local dir = RotationToDirection(camRot)
      local dest = camPos + (dir * dist)
      local ray = StartShapeTestRay(camPos, dest, 17, -1, 0)
      local _, hit, endPos, surfaceNormal, entityHit = GetShapeTestResult(ray)
      if hit == 0 then endPos = dest end
      return hit, endPos, entityHit, surfaceNormal
    end
    
    function GrappleCurrentAimPoint(dist)
      return RayCastGamePlayCamera(dist)
    end
    

    local function DrawSphere(pos, radius, r, g, b, a)
      DrawMarker(28, pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, r, g, b, a, false, false, 2, nil, nil, false)
    end
    

    local function _ensureOptions(options)
      for k, v in pairs(DEFAULT_OPTIONS) do
        if options[k] == nil then options[k] = v end
      end
    end
    
    local function _waitForFall(pid, ped, stopDistance)
      SetPlayerFallDistance(pid, 10.0)
      while GetEntityHeightAboveGround(ped) > stopDistance do
        SetPedCanRagdoll(ped, false)
        Wait(0)
      end
      SetPlayerFallDistance(pid, DEFAULT_GTA_FALL_DISTANCE)
    end
    
    local function PinRope(rope, ped, boneId, dest)
      PinRopeVertex(rope, 0, dest)
      PinRopeVertex(rope, GetRopeVertexCount(rope) - 1, GetPedBoneCoords(ped, boneId, 0.0, 0.0, 0.0))
    end
    
    
    function Grapple.new(dest, options)
      local self = {}
      options = options or {}
      _ensureOptions(options)
      local grappleId = math.random((-2^32)+1, 2^32-1)
      if options.grappleId then
        grappleId = options.grappleId
      end
      local pid = PlayerId()
      if options.plyServerId then
        pid = GetPlayerFromServerId(options.plyServerId)
      end
      local ped = GetPlayerPed(pid)
      local start = GetEntityCoords(ped)
      local notMyPed = options.plyServerId and options.plyServerId ~= GetPlayerServerId(PlayerId())
      local fromStartToDest = dest - start
      local dir = fromStartToDest / #fromStartToDest
      local length = #fromStartToDest
      local finished = false
      local rope
      if pid ~= -1 then
        rope = AddRope(dest, 0.0, 0.0, 0.0, 0.0, 5, 0.0, 0.0, 1.0, false, false, false, 5.0, false)
        if notMyPed then
          local headingToSet = GetEntityHeading(ped)
          ped = ClonePed(ped, 0, 0, 0)
          SetEntityHeading(ped, headingToSet)
          NetworkConcealPlayer(pid, true, false)
        end
      end
    
      local function _setupDestroyEventHandler()
        local event = nil
        local eventName = 'ghost-grapple:ropeDestroyed:' .. tostring(grappleId)
        RegisterNetEvent(eventName)
        event = AddEventHandler(eventName, function()
          self.destroy(false)
          RemoveEventHandler(event)
        end)
      end
    
      function self._handleRope(rope, ped, boneIndex, dest)
        Citizen.CreateThread(function ()
          while not finished do
            PinRope(rope, ped, boneIndex, dest)
            Wait(0)
          end
          DeleteChildRope(rope)
          DeleteRope(rope)
        end)
      end
    
      function self.activateSync()
        if pid == -1 then return end
        local distTraveled = 0.0
        local currentPos = start
        local lastPos = currentPos
        local rotationMultiplier = notMyPed == true and -1 or 1
        local rot = DirectionToRotation(-dir * rotationMultiplier, 0.0)
        local lastRot = rot

        rot = rot + vector3(90.0 * rotationMultiplier, 0.0, 0.0)
        Wait(options.waitTime * 1000)
        while not finished and distTraveled < length do
          local fwdPerFrame = dir * options.grappleSpeed * GetFrameTime()
          distTraveled = distTraveled + #fwdPerFrame
          if distTraveled > length then
            distTraveled = length
            currentPos = dest
          else
            currentPos = currentPos + fwdPerFrame
          end
          SetEntityCoords(ped, currentPos)
          SetEntityRotation(ped, rot)
          if distTraveled > 3 and HasEntityCollidedWithAnything(ped) == 1 then
            SetEntityCoords(ped, lastPos - (dir * EARLY_STOP_MULTIPLIER))
            SetEntityRotation(ped, lastRot)
            break
          end
          lastPos = currentPos
          lastRot = rot
          Wait(0)
        end
        self.destroy()
        _waitForFall(pid, ped, 3.0)
      end
    
      function self.activate()
        CreateThread(self.activateSync)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'grapple-shot', 0.4)
      end
    
      function self.destroy(shouldTriggerDestroyEvent)
        finished = true
        if pid ~= -1 and notMyPed then
          DeleteEntity(ped)
          NetworkConcealPlayer(pid, false, false)
        end
        if shouldTriggerDestroyEvent or shouldTriggerDestroyEvent == nil then
          -- Should trigger if shouldTriggerDestroyEvent is true or nil (not passed)

        end
      end
    
      if pid ~= -1 then
        self._handleRope(rope, ped, 0x49D9, dest)
        if notMyPed then
          self.activate()
        end
      end
      if options.plyServerId == nil then

      else
        _setupDestroyEventHandler()
      end
      return self
    end
    