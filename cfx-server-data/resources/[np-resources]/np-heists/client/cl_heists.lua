local grappleGunHash = -1654528753
local grappleGunTintIndex = 2
local grappleGunSuppressor = `COMPONENT_AT_AR_SUPP_02`
local grappleGunEquipped = false
local shownGrappleButton = false
local grappleGunItems = {
  ["grapplegun"] = true,
  ["grapplegunpd"] = true,
}
CAN_GRAPPLE_HERE = true
AddEventHandler("np-inventory:itemUsed", function(item)
  if not grappleGunItems[item] then return end
  if item == "grapplegun" and myJob == "police" then return end
  grappleGunEquipped = not grappleGunEquipped
  if grappleGunEquipped then
    GiveWeaponToPed(PlayerPedId(), grappleGunHash, 0, 0, 1)
    GiveWeaponComponentToPed(PlayerPedId(), grappleGunHash, grappleGunSuppressor)
    SetPedWeaponTintIndex(PlayerPedId(), grappleGunHash, item ~= "grapplegun" and 5 or 2)
    SetPedAmmo(PlayerPedId(), grappleGunHash, 0)
    SetAmmoInClip(PlayerPedId(), grappleGunHash, 0)
  else
    RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
  end
  local ply = PlayerId()
  Citizen.CreateThread(function()
    while grappleGunEquipped do
      Wait(500)
      local veh = GetVehiclePedIsIn(PlayerPedId(), false)
      if (veh and veh ~= 0) or GetSelectedPedWeapon(PlayerPedId()) ~= grappleGunHash then
        grappleGunEquipped = false
        RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
      end
    end
  end)
  Citizen.CreateThread(function ()
    while grappleGunEquipped do
      local freeAiming = IsPlayerFreeAiming(ply)
      local hit, pos, _, _ = GrappleCurrentAimPoint(40)
      if not shownGrappleButton and freeAiming and hit == 1 and CAN_GRAPPLE_HERE then
        shownGrappleButton = true
        exports["np-ui"]:showInteraction("[E] Grapple!")
      elseif shownGrappleButton and ((not freeAiming) or hit ~= 1 or (not CAN_GRAPPLE_HERE)) then
        shownGrappleButton = false
        exports["np-ui"]:hideInteraction("[E] Grapple!")
      end
      Wait(250)
    end
  end)
  Citizen.CreateThread(function()
    while grappleGunEquipped do
      local freeAiming = IsPlayerFreeAiming(ply)
      if IsControlJustReleased(0, 51) and freeAiming and grappleGunEquipped and CAN_GRAPPLE_HERE then
        local hit, pos, _, _ = GrappleCurrentAimPoint(40)
        if hit == 1 then
          grappleGunEquipped = false
          -- local area = {
          --   radius = 10.0,
          --   target = GetEntityCoords(PlayerPedId()),
          --   type = 1,
          -- }
          -- local event = {
          --   server = false,
          --   inEvent = "InteractSound_CL:PlayOnOne",
          --   outEvent = "InteractSound_CL:StopLooped",
          -- }
          -- TriggerServerEvent("infinity:playSound", event, area, "grapple-shot", 0.75)
          -- Citizen.Wait(1000)
          local grapple = Grapple.new(pos)
          grapple.activate()
          Citizen.Wait(1000)
          RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
          TriggerEvent("inventory:DegenLastUsedItem", 25)
          shownGrappleButton = false
          exports["np-ui"]:hideInteraction("[E] Grapple!")
        end
      end
      Citizen.Wait(0)
    end
  end)
end)