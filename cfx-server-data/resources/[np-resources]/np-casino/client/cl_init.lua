local casinoInteriorId = nil

function IsTable(T)
  return type(T) == 'table'
end
function SetIplPropState(interiorId, props, state, refresh)
  if refresh == nil then refresh = false end
  if IsTable(interiorId) then
      for key, value in pairs(interiorId) do
          SetIplPropState(value, props, state, refresh)
      end
  else
      if IsTable(props) then
          for key, value in pairs(props) do
              SetIplPropState(interiorId, value, state, refresh)
          end
      else
          if state then
              if not IsInteriorPropEnabled(interiorId, props) then EnableInteriorProp(interiorId, props) end
          else
              if IsInteriorPropEnabled(interiorId, props) then DisableInteriorProp(interiorId, props) end
          end
      end
      if refresh == true then RefreshInterior(interiorId) end
  end
end

Citizen.CreateThread(function()
  Wait(10000)
  -- RequestIpl('vw_casino_main')
  -- RequestIpl('vw_dlc_casino_door')
  -- RequestIpl('hei_dlc_casino_door')
  RequestIpl("hei_dlc_windows_casino")
  RequestIpl("vw_casino_penthouse")
  SetIplPropState(274689, "Set_Pent_Tint_Shell", true, true)
  SetInteriorEntitySetColor(274689, "Set_Pent_Tint_Shell", 3)
  -- RequestIpl("vw_casino_carpark")
  -- RequestIpl("vw_casino_garage")
  -- RequestIpl("hei_dlc_windows_casino_lod")
  -- RequestIpl("hei_dlc_casino_aircon")
  -- RequestIpl("hei_dlc_casino_aircon_lod")
  -- RequestIpl("hei_dlc_casino_door")
  -- RequestIpl("hei_dlc_casino_door_lod")
  -- RequestIpl("hei_dlc_vw_roofdoors_locked")
  -- RequestIpl("vw_ch3_additions")
  -- RequestIpl("vw_ch3_additions_long_0")
  -- RequestIpl("vw_ch3_additions_strm_0")
  -- RequestIpl("vw_dlc_casino_door")
  -- RequestIpl("vw_dlc_casino_door_lod")
  -- RequestIpl("vw_casino_billboard")
  -- RequestIpl("vw_casino_billboard_lod(1)")
  -- RequestIpl("vw_casino_billboard_lod")
  -- RequestIpl("vw_int_placement_vw")
  -- RequestIpl("vw_dlc_casino_apart")
  local interiorId = GetInteriorAtCoords(1032.22,40.71,69.87)
  casinoInteriorId = interiorId

  if IsValidInterior(interiorId) then
    RefreshInterior(interiorId)
  end

  -- exports["np-polyzone"]:AddBoxZone("casino_entrance", vector3(934.66, 46.54, 81.11), 4.4, 6.2, {
  --   heading=10,
  --   minZ=80.1,
  --   maxZ=82.9,
  --   data = {
  --     id = "1",
  --   },
  -- })
  -- exports["np-polyzone"]:AddBoxZone("casino_exit", vector3(1089.83, 206.84, -49.0), 4, 4, {
  --   heading=0,
  --   minZ=-50.2,
  --   maxZ=-47.2,
  --   data = {
  --     id = "1",
  --   },
  -- })
  exports["np-polyzone"]:AddBoxZone("casino_entrance", vector3(930.0, 43.48, 81.1), 12.2, 10, {
    heading=328,
    minZ=79.9,
    maxZ=83.9,
    data = {
      id = "1",
    },
  })
  exports["np-polyzone"]:AddBoxZone("casino_exit", vector3(921.06, 48.99, 81.1), 10.8, 10, {
    heading=328,
    minZ=79.7,
    maxZ=83.7,
    data = {
      id = "1",
    },
  })

  exports["np-polyzone"]:AddBoxZone("casino_post_gate", vector3(1122.36, 240.28, -50.44), 10.8, 5.0, {
    heading=42,
    minZ=-51.44,
    maxZ=-49.04,
    data = {
      id = "1",
    },
  })
  exports["np-polyzone"]:AddBoxZone("casino_betting_screen", vector3(1100.96, 256.81, -51.24), 20, 25.6, {
    heading=306,
    minZ=-52.04,
    maxZ=-48.04,
    data = {
      id = "1",
    },
  })
  -- exports["np-polytarget"]:AddBoxZone("wheel_of_fortune", vector3(988.26, 42.93, 73.265), 1.0, 1.0, {
  --   heading=199.95,
  --   minZ=72.265,
  --   maxZ=74.265,
  --   data = {
  --     id = 1,
  --     --ref = "spin",
  --   },
  -- })
  exports["np-polytarget"]:AddCircleZone("wheel_of_fortune", vector3(988.26, 42.93, 71.265), 2.0, { useZ=false })
  exports["np-polytarget"]:AddBoxZone("casino_reception", vector3(989.98, 31.6, 71.47), 2.6, 0.8, {
    heading=330,
    minZ=70.265,
    maxZ=72.265,
    data = {
      id = 1,
      --ref = "recep",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget("wheel_of_fortune", {{
    event = "np-casino:wheel:spinWheelTurbo",
    id = "wheelspinturbo",
    icon = "fas fa-play",
    label = "Turbo Spin!",
  }}, { distance = { radius = 2.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("wheel_of_fortune", {{
    event = "np-casino:wheel:spinWheel",
    id = "wheelspin",
    icon = "fas fa-play",
    label = "Spin!",
  }}, { distance = { radius = 2.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("casino_reception", {{
    event = "np-casino:purchaseMembership",
    id = "member",
    icon = "fas fa-dollar-sign",
    label = "Buy Membership Card",
  }}, { distance = { radius = 1.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("casino_reception", {{
    event = "np-casino:purchaseChips",
    id = "chips",
    icon = "fas fa-dollar-sign",
    label = "Casino Chips",
  }}, { distance = { radius = 1.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("casino_reception", {{
    event = "np-casino:purchaseVipMembership",
    id = "vipmember",
    icon = "fas fa-dollar-sign",
    label = "Buy VIP Membership Card",
  }}, { distance = { radius = 1.5 } })
end)

local interiorSetNames = {
  ["bets"] = "casino_rm_betting_standard",
  ["poker"] = "casino_rm_betting_poker",
}
RegisterNetEvent("np-casino:entitySetSwap")
AddEventHandler("np-casino:entitySetSwap", function(set)
  local cInteriorId = GetInteriorAtCoords(993.04, 80.07, 69.67)
  for _, v in pairs(interiorSetNames) do
    DeactivateInteriorEntitySet(cInteriorId, v)
  end
  ActivateInteriorEntitySet(cInteriorId, interiorSetNames[set])
  RefreshInterior(cInteriorId)
end)

AddEventHandler("np-casino:enterPenthouse", function()
  TriggerEvent("np-casino:elevatorExitCasino")
  local interiorId = GetInteriorAtCoords(968.58,46.92,116.17)
  ActivateInteriorEntitySet(interiorId, "set_pent_creampie")
  RefreshInterior(interiorId)
end)

AddEventHandler("np-casino:betting:interiorSwap", function(pArgs)
  local characterId = exports["isPed"]:isPed("cid")
  local jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = "casino" } })
  if not jobAccess then
    TriggerEvent("DoLongHudText", "Please talk to a member of floor staff", 2)
    return
  end
  TriggerServerEvent("np-casino:interiorSwap", pArgs[1])
end)

Config = Config or {}

Config.casinoPeds = {
    { x= 988.26, y= 42.93, z= 71.265, name = "ped", heading = 199.95, model = "S_F_Y_Casino_01" },
    { x= 990.80, y= 30.84, z= 71.466, name = "ped2", heading = 51.20, model = "S_F_Y_Casino_01" },
}

Citizen.CreateThread(function()
  for _,v in pairs(Config.casinoPeds) do
      loadmodel(v.model)
      casinoPeds =  CreatePed(1, v.model, v.x, v.y, v.z-1, v.heading, false, true)
      FreezeEntityPosition(casinoPeds, true)
      SetEntityInvincible(casinoPeds, true)
      SetBlockingOfNonTemporaryEvents(casinoPeds, true)
  end
end)

function loadmodel(model)
  while not HasModelLoaded(model) do
      RequestModel(model)
      Wait(10)
  end
end

