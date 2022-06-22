local stageLasers = {}
local lasersActive = false

local laserStartPoints = {
  vector3(-837.101, -717.194, 29.87), vector3(-837.373, -718.705, 29.885), vector3(-838.132, -720.017, 29.889), vector3(-839.292, -720.998, 29.892), vector3(-840.698, -721.493, 29.904), vector3(-842.464, -718.813, 29.914), vector3(-841.685, -717.493, 29.896), vector3(-840.545, -716.519, 29.898), vector3(-838.317, -716.619, 30.56), vector3(-841.83, -720.161, 30.56), vector3(-839.613, -718.692, 30.56)
}
local laserGridPoints = {
  vector3(-841.727, -721.388, 27.285), vector3(-840.012, -720.993, 27.285), vector3(-838.837, -720.22, 27.285), vector3(-837.966, -718.903, 27.285), vector3(-837.759, -717.651, 27.285), vector3(-841.939, -719.116, 27.285), vector3(-841.53, -717.168, 27.285), vector3(-839.534, -716.783, 27.285), vector3(-839.81, -719.167, 27.285), vector3(-840.648, -719.859, 27.285), vector3(-839.037, -717.671, 27.285)
}

Citizen.CreateThread(function()
  for k, coords in pairs(laserStartPoints) do
      local cLaser = Laser.new(coords, laserGridPoints, {
          travelTimeBetweenTargets = {1.0, 1.0},
          waitTimeAtTargets = {0.0, 0.0},
          randomTargetSelection = true,
          name = "laser_wc_" .. tostring(k),
          color = {0, 255, 100, 200},
          extensionEnabled = false,
      })
      stageLasers[#stageLasers + 1] = cLaser
  end
  
  -- register
  exports["np-polytarget"]:AddBoxZone("wuchang_register", vector3(-830.53, -730.13, 28.06), 0.6, 0.6, {
    heading = 0,
    minZ = 27.66,
    maxZ = 28.46,
    data = {
      id = "wuchang_register",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget("wuchang_register", {{
      event = "np-foodchain:wuchangRegister",
      id = "wuchangRegister",
      icon = "dollar-sign",
      label = "Charge Customer",
      parameters = { stationId = k },
  }}, { distance = { radius = 3.5 }  })
  -- drinks place
  exports["np-polytarget"]:AddBoxZone("wuchang_drinks", vector3(-831.28, -730.19, 28.06), 0.6, 0.6, {
    heading = 0,
    minZ = 27.26,
    maxZ = 29.06,
    data = {
      id = "wuchang_drinks",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget("wuchang_drinks", {{
      event = "np-stripclub:peekAction",
      id = "wuchangDrinks",
      icon = "circle",
      label = "Open",
      parameters = { action = "openFridge" },
  }}, { distance = { radius = 3.5 }  })
  -- music maker (wc)
  exports["np-polytarget"]:AddBoxZone("wuchang_music_maker", vector3(-818.17, -719.02, 32.34), 3.0, 0.6, {
    heading = 0,
    minZ = 32.14,
    maxZ = 32.74,
    data = {
      id = "wuchang_music_maker",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget("wuchang_music_maker", {{
      event = "np-music:addMusicEntry",
      id = "wuchangMusicEntry",
      icon = "music",
      label = "Add Music Entry",
      parameters = { business = "wuchang" },
  }}, { distance = { radius = 3.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("wuchang_music_maker", {{
      event = "np-music:createMusicTapes",
      id = "wuchangMusicTapes",
      icon = "play-circle",
      label = "Create Tapes",
      parameters = { business = "wuchang" },
  }}, { distance = { radius = 3.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("wuchang_music_maker", {{
      event = "np-music:createMerchandise",
      id = "wuchangMerchandise",
      icon = "dollar-sign",
      label = "Create Merchandise",
      parameters = { business = "wuchang" },
  }}, { distance = { radius = 3.5 } })
  -- music maker (cc)
  exports["np-polytarget"]:AddBoxZone("cc_music_maker", vector3(975.07, 48.05, 116.17), 0.6, 1.0, {
    heading = 58,
    minZ = 116.17,
    maxZ = 116.57,
    data = {
      id = "cc_music_maker",
    },
  })
  exports['np-interact']:AddPeekEntryByPolyTarget("cc_music_maker", {{
      event = "np-music:addMusicEntry",
      id = "ccMusicEntry",
      icon = "music",
      label = "Add Music Entry",
      parameters = { business = "creampie" },
  }}, { distance = { radius = 3.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("cc_music_maker", {{
      event = "np-music:createMusicTapes",
      id = "ccMusicTapes",
      icon = "play-circle",
      label = "Create Tapes",
      parameters = { business = "creampie" },
  }}, { distance = { radius = 3.5 } })
  exports['np-interact']:AddPeekEntryByPolyTarget("cc_music_maker", {{
      event = "np-music:createMerchandise",
      id = "ccMerchandise",
      icon = "dollar-sign",
      label = "Create Merchandise",
      parameters = { business = "creampie" },
  }}, { distance = { radius = 3.5 } })
end)

RegisterUICallback("np-ui:wuchang:charge", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = '' } })
  exports['np-ui']:closeApplication('textbox')
  local id = tonumber(data.values.state_id)
  local cost = tonumber(data.values.cost)
  local comment = data.values.comment
  data.state_id = id
  data.amount = cost
  data.comment = comment
  data.business = {
    code = "wuchang",
  }
  RPC.execute("ChargeExternal", data)
end)

AddEventHandler("np-foodchain:wuchangRegister", function()
  exports['np-ui']:openApplication('textbox', {
      callbackUrl = 'np-ui:wuchang:charge',
      key = "wuchang_register",
      items = {
        {
          icon = "user",
          label = "State ID",
          name = "state_id",
        },
        {
          icon = "dollar-sign",
          label = "Cost",
          name = "cost",
        },
        {
          icon = "pencil-alt",
          label = "Comment",
          name = "comment",
        },
      },
      show = true,
  })
end)

local function activateLasers(doActivate)
  if doActivate and #(GetEntityCoords(PlayerPedId()) - vector3(-837.101, -717.194, 29.87)) > 100 then return end
  if doActivate and lasersActive then return end
  lasersActive = doActivate
  if not lasersActive then
    for _, v in pairs(stageLasers) do
      v.setActive(false)
    end
    return
  end
  Citizen.CreateThread(function()
    while lasersActive do
      for _, v in pairs(stageLasers) do
        v.setActive(true)
      end
      if math.random() < 0.1 then
        local lc = 0
        local wasActive = true
        while lc < 6 do
          lc = lc + 1
          wasActive = not wasActive
          for _, v in pairs(stageLasers) do
            v.setActive(wasActive)
          end
          Citizen.Wait(125)
        end
        for _, v in pairs(stageLasers) do
          v.setActive(true)
        end
      end
      Citizen.Wait(2500)
    end
    for _, v in pairs(stageLasers) do
      v.setActive(false)
    end
  end)
end
RegisterNetEvent("np-wuchang:activateLasers")
AddEventHandler("np-wuchang:activateLasers", function(doActivate)
  activateLasers(doActivate)
end)
