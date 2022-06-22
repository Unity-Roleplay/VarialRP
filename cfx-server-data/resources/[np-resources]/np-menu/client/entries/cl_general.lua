local GeneralEntries = MenuEntries['general']
local bennyLocation = vector3(-34.24, -1053.31, 28.4)
local bennyLocationBridge = vector3(727.74, -1088.95, 22.17)
local billyLocationPaleto = vector3(110.8, 6626.46, 31.89)
local bennyLocationMRPD = vector3(450.01, -976.04, 25.03)

--local tunerLocation = vector3(124.60910797119, -3022.5561523438, 6.4606328010559)

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles",
    title = "Vehicle",
    icon = "#vehicle-options-vehicle",
    event = "veh:options"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicles-keysgive",
    title = "Give Keys",
    icon = "#general-keys-give",
    event = "keys:give"
},
isEnabled = function(pEntity, pContext)
    return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports['np-keys']:hasKey(GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()))) 
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "peds-escort",
    title = "Escort",
    icon = "#general-escort",
    event = "escortPlayer"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled()
  end
}

-- -- change to keybind?
-- -- GeneralEntries[#GeneralEntries+1] = {
-- --     data = {
-- --         id = "vehicles-doorKeyFob",
-- --         title = "Door KeyFob",
-- --         icon = "#general-door-keyFob",
-- --         event = "np-doors:doorKeyFob"
-- --     },
-- --     isEnabled = function(pEntity, pContext)
-- --         return not IsDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["np-inventory"]:hasEnoughOfItem("keyfob", 1, false)
-- --     end
-- -- }


-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "poledance:toggle",
--     title = "Poledance",
--     icon = "#poledance-toggle",
--     event = "poledance:toggle"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["np-flags"]:HasPedFlag(PlayerPedId(), 'isPoledancing')
--   end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "poledance:toggle",
--     title = "Stop poledancing",
--     icon = "#poledance-toggle",
--     event = "poledance:toggle"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not IsDisabled() and polyChecks.vanillaUnicorn.isInside and exports["np-flags"]:HasPedFlag(PlayerPedId(), 'isPoledancing')
--   end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "oxygentank",
    title = "Remove Oxygen Tank",
    icon = "#oxygen-mask",
    event = "RemoveOxyTank"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and hasOxygenTankOn
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "policeDeadA",
    title = "10-13A",
    icon = "#police-dead",
    event = "police:tenThirteenA",
  },
  isEnabled = function(pEntity, pContext)
      return isDead and (isPolice or isDoc)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "policeDeadB",
    title = "10-13B",
    icon = "#police-dead",
    event = "police:tenThirteenB",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and (isPolice or isDoc)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "emsDeadA",
    title = "10-14A",
    icon = "#ems-dead",
    event = "police:tenForteenA",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and isMedic
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "emsDeadB",
    title = "10-14B",
    icon = "#ems-dead",
    event = "police:tenForteenB",
  },
  isEnabled = function(pEntity, pContext)
    return isDead and isMedic
  end
}


--[[GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-vehicleList",
    title = "Shared Vehicles",
    icon = "#vehicle-vehicleList",
    event = "np-garages:open"
},
isEnabled = function()
    return isAtHouseGarage and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}]]

--[[GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-parkvehicle",
    title = "Park Vehicle",
    icon = "#vehicle-parkvehicle",
    event = "np-garages:store"
},
isEnabled = function()
  return isAtHouseGarage and exports["np-garages"]:NearVehicle("Distance") and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}]]


 GeneralEntries[#GeneralEntries+1] = {
   data = {
     id = "unseat",
     title = "Get up",
     icon = "#obj-chair",
     event = "np-emotes:sitOnChair"
   },
   isEnabled = function(pEntity, pContext)
     return not isDead and exports["np-flags"]:HasPedFlag(PlayerPedId(), 'isSittingOnChair')
   end
 }

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "property-enter",
    title = "Enter Property",
    icon = "#property-enter",
    event = "housing:enter"
  },
  isEnabled = function(pEntity, pContext)
    return not isDead and exports["np-housing"]:isNearProperty()
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "property-lock",
    title = "Unlock/Lock Property",
    icon = "#property-lock",
    event = "np-housing:unlock&lockProperty"
  },
  isEnabled = function(pEntity, pContext)
    return not isDead and exports["np-housing"]:isNearProperty(true)
  end
}

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "vehicle-vehicleList",
--       title = "Vehicle List",
--       icon = "#vehicle-vehicleList",
--       event = "vehicle:garageVehicleList",
--       parameters = { nearby = true, radius = 4.0 }
--   },
--   isEnabled = function(pEntity, pContext)
--     return not IsDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags['isVehicleSpawner'] or not pEntity and exports['np-vehicles']:IsOnParkingSpot(PlayerPedId(), true, 4.0))
--   end
-- }

-- local canDropGoods = false
-- local canDropGoodsTimer = nil
-- AddEventHandler("np-jobs:247delivery:takeGoods", function()
--   canDropGoods = true
--   canDropGoodsTimer = GetGameTimer()
-- end)
-- AddEventHandler("np-jobs:247delivery:dropGoods", function()
--   canDropGoods = false
--   canDropGoodsTimer = nil
-- end)

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--     id = "job-drop-goods",
--     title = "Drop Goods",
--     icon = "#property-lock",
--     event = "np-jobs:247delivery:dropGoods"
--   },
--   isEnabled = function(pEntity, pContext)
--     return canDropGoods and canDropGoodsTimer + 15000 < GetGameTimer()
--   end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "dispatch:openDispatch",
--       title = "Dispatch",
--       icon = "#general-check-over-target",
--       event = "np-dispatch:openFull"
--   },
--   isEnabled = function()
--       return (isPolice or isMedic) and not isDead
--   end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "emotes:openmenu",
      title = "Emotes",
      icon = "#general-emotes",
      event = "emotes:OpenMenu"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead
  end
}

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "drivingInstructor:testToggle",
--       title = "Driving Test",
--       icon = "#drivinginstructor-drivingtest",
--       event = "drivingInstructor:testToggle"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not isDead and isInstructorMode
--   end
-- }

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "drivingInstructor:submitTest",
--       title = "Submit Test",
--       icon = "#drivinginstructor-submittest",
--       event = "drivingInstructor:submitTest"
--   },
--   isEnabled = function(pEntity, pContext)
--       return not isDead and isInstructorMode
--   end
-- }

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "general:checkoverself",
      title = "Examine Self",
      icon = "#general-check-over-self",
      event = "Evidence:CurrentDamageList"
  },
  isEnabled = function(pEntity, pContext)
      return not isDead
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "bennys:enter"
  },
  isEnabled = function(pEntity, pContext)
      return not IsDisabled() and polyChecks.bennys.isInside and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter2",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "bennys:enter"
  },
  isEnabled = function(pEntity, pContext)
    return (isInBennyPDZone and isPolice and not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - bennyLocationMRPD) <= 10)
  end
}

--[[GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter3",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:benny:paleto"
  },
  isEnabled = function(pEntity, pContext)
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - billyLocationPaleto) <= 10)
  end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "bennys:enter4",
      title = "Enter Bennys",
      icon = "#general-check-vehicle",
      event = "enter:tuner"
  },
  isEnabled = function(pEntity, pContext)
    return (not isDead and IsPedInAnyVehicle(PlayerPedId()) and #(GetEntityCoords(PlayerPedId()) - tunerLocation) <= 10)
  end
}]]

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "toggle-anchor",
    title = "Toggle Anchor",
    icon = "#vehicle-anchor",
    event = "sanyo-anchor:toggleAnchor"
  },
  isEnabled = function(pEntity, pContext)
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local boatModel = GetEntityModel(currentVehicle)
    return not IsDisabled() and currentVehicle ~= 0 and (IsThisModelABoat(boatModel) or IsThisModelAJetski(boatModel) or IsThisModelAnAmphibiousCar(boatModel) or IsThisModelAnAmphibiousQuadbike(boatModel))
  end
}

--[[GeneralEntries[#GeneralEntries+1] = {
   data = {
     id = "mdw",
     title = "MDW",
     icon = "#mdt",
     event = 'np-mdt:open'
   },
   isEnabled = function()
     return (
    myJob == "police"  or  isPolice) and not isDead
   end
 }]]

-- GeneralEntries[#GeneralEntries+1] = {
--   data = {
--       id = "prepare-boat-mount",
--       title = "Mount on Trailer",
--       icon = "#vehicle-plate-remove",
--       event = "vehicle:mountBoatOnTrailer"
--   },
--   isEnabled = function()
--     local ped = PlayerPedId()
--     local veh = GetVehiclePedIsIn(ped)
--     if veh == 0 then
--       return false
--     end
--     local seat = GetPedInVehicleSeat(veh, -1)
--     if seat ~= ped then
--       return false
--     end
--     local model = GetEntityModel(veh)
--     if IsDisabled() or not (IsThisModelABoat(model) or IsThisModelAJetski(model) or IsThisModelAnAmphibiousCar(model)) then
--       return false
--     end
--     local left, right = GetModelDimensions(model)
--     return #(vector3(0, left.y, 0) - vector3(0, right.y, 0)) < 15
--   end
-- }

-- -- GeneralEntries[#GeneralEntries+1] = {
-- --   data = {
-- --       id = "prepare-boat-mount1",
-- --       title = "Mount on Trailer",
-- --       icon = "#vehicle-plate-remove",
-- --       event = "vehicle:mountCarOnTrailer"
-- --   },
-- --   isEnabled = function(pEntity)

-- --     return pEntity ~= 0
-- --   end
-- -- }

-- -- AddEventHandler("vehicle:mountCarOnTrailer", function(a, pEntity)
-- --   if GetVehicleDoorAngleRatio(pEntity, 5) == 0 then
-- --     SetVehicleDoorOpen(pEntity, 5, 0, 0)
-- --   else
-- --     SetVehicleDoorShut(pEntity, 5, 0)
-- --   end
-- --   -- SetCarBootOpen(pEntity)
-- --   SetVehicleOnGroundProperly(pEntity)
-- --   -- SetEntityCoords(pEntity, GetEntityCoords(pEntity).x, GetEntityCoords(pEntity).y, GetEntityCoords(pEntity).z + 0.05, 0, 0, 0, 1)
-- -- end)

 local currentJob = nil
 local policeModels = {
   [`npolvic`] = true,
   [`npolchar`] = true,
   [`npolexp`] = true,
   [`npolchal`] = true,
   [`npolvette`] = true,
   [`npolstang`] = true,
   [`npolmm`] = true,
 }
 RegisterNetEvent("np-jobmanager:playerBecameJob")
 AddEventHandler("np-jobmanager:playerBecameJob", function(job, name, notify)
     currentJob = job
 end)
 GeneralEntries[#GeneralEntries+1] = {
   data = {
       id = "open-rifle-rack",
       title = "Rifle Rack",
       icon = "#vehicle-plate-remove",
       event = "vehicle:openRifleRack"
   },
   isEnabled = function(pEntity)
     if currentJob ~= "police" then return false end
    local veh = GetVehiclePedIsIn(PlayerPedId())
     if veh == 0 then return false end
    local model = GetEntityModel(veh)
    if policeModels[model] == nil then return false end
     return true
   end
 }
 AddEventHandler("vehicle:openRifleRack", function()
   local finished = exports["np-taskbar"]:taskBar(2500, "Unlocking...")
   if finished ~= 100 then return end
  local veh = GetVehiclePedIsIn(PlayerPedId())
   if veh == 0 then return end
  local vehId = exports['np-oVehicleMod']:GetVehicleIdentifier(veh)
   TriggerEvent("server-inventory-open", "1", "rifle-rack-" .. vehId)
 end)

local dashCamAttached = {}
AddEventHandler("np-menu:dashCamAttached", function(pVehicleNetId, pEnabled)
  dashCamAttached[pVehicleNetId] = pEnabled
end)

GeneralEntries[#GeneralEntries+1] = {
  data = {
      id = "remove-dashcam-from-vehicle",
      title = "Remove Dashcam",
      icon = "#news-job-news-camera",
      event = "np-gopro:removeDashCam",
  },
  isEnabled = function()
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local netId = NetworkGetNetworkIdFromEntity(veh)
    return not IsDisabled() and dashCamAttached[netId]
  end
}



GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-vehicleList",
    title = "Vehicle List",
    icon = "#vehicle-vehicleList",
    event = "np-garages:open"
},
isEnabled = function()
    return isAtGarage and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-sharedvehicleList",
    title = "Shared Vehicle List",
    icon = "#vehicle-vehicleList",
    event = "np-garages:open2"
},
isEnabled = function()
    return isAtHouseGarage and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-parkvehicle",
    title = "Park Vehicle",
    icon = "#vehicle-parkvehicle",
    event = "np-garages:store"
},
isEnabled = function()
  return isAtGarage and exports["np-garages"]:NearVehicle("Distance") and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}

GeneralEntries[#GeneralEntries+1] = {
  data = {
    id = "vehicle-parkvehicle",
    title = "Park Vehicle",
    icon = "#vehicle-parkvehicle",
    event = "np-garages:store"
},
isEnabled = function()
  return isAtHouseGarage and exports["np-garages"]:NearVehicle("Distance") and not IsPedInAnyVehicle(PlayerPedId(), false) and not isDead
end
}

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "Benny" then
		isInBennyZone = true
        return isInBennyZone
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "Benny" then
		isInBennyZone = false
        return isInBennyZone
    end
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "BennyPD" then
		isInBennyPDZone = true
        return isInBennyPDZone
    end
end)


RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "BennyPD" then
		isInBennyPDZone = false
        return isInBennyPDZone
    end
end)
