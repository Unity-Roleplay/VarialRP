-- TODO: Get actual exhaust positions and rotations. This is based on bone
-- positions, but custom exhausts can have different positions or rotations.
particles = {}
local scales = {
  ["purge"] = {
    [1] = 0.30,
    [2] = 0.34,
    [3] = 0.38,
    [4] = 0.42,
    [5] = 0.46,
    [6] = 0.50,
    [7] = 0.54,
    [8] = 0.58,
    [9] = 0.62,
    [10] = 0.66,
  },
  ["boost"] = {
    [1] = 0.30,
    [2] = 0.40,
    [3] = 0.50,
    [4] = 0.60,
    [5] = 0.70,
    [6] = 0.80,
    [7] = 0.90,
    [8] = 1.00,
    [9] = 1.10,
    [10] = 1.20,
  }
}
function CreateVehicleExhaustBackfire(vehicle, scale)
  RequestNamedPtfxAsset("veh_xs_vehicle_mods")
  while not HasNamedPtfxAssetLoaded("veh_xs_vehicle_mods") do
      Citizen.Wait(0)
      print("NOT LOADED LOL")
  end

  local exhaustNames = {
    "exhaust",    "exhaust_2",  "exhaust_3",  "exhaust_4",
    "exhaust_5",  "exhaust_6",  "exhaust_7",  "exhaust_8",
    "exhaust_9",  "exhaust_10", "exhaust_11", "exhaust_12",
    "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16"
  }

  for _, exhaustName in ipairs(exhaustNames) do
    local boneIndex = GetEntityBoneIndexByName(vehicle, exhaustName)

    if boneIndex ~= -1 then
      local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
      local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
      UseParticleFxAsset("veh_xs_vehicle_mods")
      -- StartParticleFxNonLoopedOnEntity('veh_nitrous', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scale * NITRO_VEHICLES[vehicle].flowRate * 0.5, false, false, false)
   --   print(scales["boost"][NITRO_VEHICLES[vehicle].flowRate])
      particles[#particles+1] = StartParticleFxLoopedOnEntity('veh_nitrous', vehicle, off.x, off.y, off.z, 0.0, 0.0, 0.0, scales["boost"][NITRO_VEHICLES[vehicle].flowRate] , false, false, false)
    end
  end
end


function removeParticles()
  Citizen.CreateThread(function()
      for i,v in pairs(particles) do
          RemoveParticleFx(v)
      end
      Citizen.Wait(2000)
      for i,v in pairs(particles) do
          RemoveParticleFx(v)
          particles[i] = nil
      end
  end)
end

function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
  UseParticleFxAsset('core')
  return StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scales["purge"][NITRO_VEHICLES[vehicle].flowRate], false, false, false)
end

function CreateVehicleLightTrail(vehicle, bone, scale)
  UseParticleFxAsset('core')
  local ptfx = StartParticleFxLoopedOnEntityBone('veh_light_red_trail', vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone, scale, false, false, false)
  SetParticleFxLoopedEvolution(ptfx, "speed", 1.0, false)
  return ptfx
end

function StopVehicleLightTrail(ptfx, duration)
  Citizen.CreateThread(function()
    local startTime = GetGameTimer()
    local endTime = GetGameTimer() + duration
    while GetGameTimer() < endTime do 
      Citizen.Wait(0)
      local now = GetGameTimer()
      local scale = (endTime - now) / duration
      SetParticleFxLoopedScale(ptfx, scale)
      SetParticleFxLoopedAlpha(ptfx, scale)
    end
    StopParticleFxLooped(ptfx)
  end)
end

-- function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, density, r, g, b)
--   local boneIndex = GetEntityBoneIndexByName(vehicle, 'bonnet')
--   local pos = GetWorldPositionOfEntityBone(vehicle, boneIndex)
--   local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
--
--   local xOffset = (xOffset or 0) + off.x
--   local yOffset = (yOffset or 0) + off.y
--   local zOffset = (zOffset or 0) + off.z
--
--   local xRot = xRot or 0
--   local yRot = yRot or 0
--   local zRot = zRot or 0
--
--   local scale = scale or 0.5
--   local density = density or 3
--
--   local r = (r or 255) / 255
--   local g = (g or 255) / 255
--   local b = (b or 255) / 255
--
--   local particles = {}
--
--   for i = 0, density do
--     UseParticleFxAsset('core')
--     local fx1 = StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, off.x - 0.5, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.5, false, false, false)
--     SetParticleFxLoopedColour(fx1, r, g, b)
--
--     UseParticleFxAsset('core')
--     local fx2 = StartParticleFxLoopedOnEntity('ent_sht_steam', vehicle, off.x + 0.5, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.5, false, false, false)
--     SetParticleFxLoopedColour(fx2, r, g, b)
--   end
-- end