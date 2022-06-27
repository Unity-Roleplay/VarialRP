
Citizen.CreateThread(function()

  exports["np-polyzone"]:AddCircleZone("townhalwl:gavel", vector3(-519.26, -175.61, 38.55), 1.25, { useZ=true }, {debugpoly=true})

  exports['np-interact']:AddPeekEntryByPolyTarget("townhalwl:gavel", {{
    event = "Courthouse:Gavel",
    id = "gavel",
    icon = "fas fa-gavel",
    label = "Hit Gavel!",
  }}, { distance = { radius = 2.5 } })


  exports["np-polyzone"]:AddCircleZone("townhall:gavel", vector3(-518.4946, -175.3768, 38.5612), 0.8, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("gallery:ceo:stash", vector3(-468.766, 45.866, 46.231), 0.6, { useZ=true })
  exports["np-polyzone"]:AddCircleZone("gallery:car:stash", vector3(-483.346, 63.082, 52.414), 0.6, { useZ=true })


  exports["np-polyzone"]:AddCircleZone("redline:stash", vector3(930.665, -983.314, 39.499), 0.6, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("harmony:stash", vector3(1180.803, 2636.042, 37.753), 0.6, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("lost:stash", vector3(2517.545, 4106.320, 35.585), 0.5, { useZ=true })

  --exports["np-polyzone"]:AddCircleZone("ugr:stash", vector3(2522.435, 2632.970, 37.958), 0.5, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("ugr:usb", vector3(2518.951, 2632.353, 37.970), 0.5, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("ugr:craft", vector3(2519.217, 2629.117, 37.959), 0.5, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("ems:stash", vector3(311.909, -597.473, 43.284), 1.0, { useZ=true })
  exports["np-polyzone"]:AddCircleZone("ems:stash2", vector3(-813.638, -1240.340, 7.337), 1.0, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("ms13:stash", vector3(1445.368, -1488.453, 66.619), 0.5, { useZ=true })

  --exports["np-polyzone"]:AddCircleZone("lost:bar:tray", vector3(2513.208, 4098.278, 38.584), 1.2, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("lost:bar:fridge", vector3(2512.273, 4100.731, 38.584), 0.8, { useZ=true })


  --exports["np-polyzone"]:AddCircleZone("gallery:drinkmixing", vector3(-490.246, 41.454, 52.414), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("gallery:fridge", vector3(-491.175, 37.658, 52.414), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("gallery:tray", vector3(-488.906, 39.313, 52.414), 1.3, { useZ=true })

  --exports["np-polyzone"]:AddCircleZone("bakery:tray", vector3(-1262.565, -290.703, 37.450), 1.0, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:fridge", vector3(-1262.588, -287.895, 37.384), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:cupcakes", vector3(-1260.753, -289.748, 37.384), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:boxup", vector3(-1258.831, -288.855, 37.384), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:drinks", vector3(-1267.030, -284.061, 37.391), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:pies", vector3(-1264.769, -283.955, 37.389), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:ingredients", vector3(-1261.370, -285.841, 37.451), 0.8, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:food", vector3(-1265.165, -280.153, 37.387), 0.8, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:boxes", vector3(-1258.969, -281.953, 37.385), 0.8, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("bakery:gumballs", vector3(-1264.223, -294.086, 37.390), 0.5, { useZ=true })

  --exports["np-polyzone"]:AddCircleZone("winery:base", vector3(1005.783, -3201.034, -38.519), 0.8, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:redwine", vector3(1010.965, -3197.133, -38.993), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:whitewine", vector3(1010.525, -3199.850, -38.993), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:grapejuice", vector3(1002.859, -3200.042, -38.993), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:boxup", vector3(1012.818, -3194.990, -38.993), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:ingredients", vector3(1016.910, -3198.461, -38.993), 0.6, { useZ=true })
  --exports["np-polyzone"]:AddCircleZone("winery:moly", vector3(-1870.506, 2061.885, 135.434), 0.6, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("yakuza:stash", vector3(-1089.458, -1667.248, 8.413), 0.6, { useZ=true })

  exports["np-polyzone"]:AddCircleZone("mandem:stash", vector3(-1567.097, -232.746, 49.469), 0.6, { useZ=true }) 

  -- exports["np-polyzone"]:AddCircleZone("pd:raid", vector3(459.156, -973.860, 25.699), 0.5, { useZ=true })

end)

local listening = 0
local function listenForKeypress(listenCounter, pEvent)
    Citizen.CreateThread(function()
        while listening == listenCounter do
            if IsControlJustReleased(0, 38) then
              if pEvent == "gallery:ceo:stash" and exports["isPed"]:GroupRank("gallery") > 2 then
                TriggerEvent("server-inventory-open", "1", "storage-gallery_ceo")
              elseif pEvent == "gallery:ceo:stash" and exports["isPed"]:GroupRank("gallery") < 3 then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "gallery:car:stash" and exports["isPed"]:GroupRank("gallery") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-gallery_car")
              elseif pEvent == "gallery:car:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "redline:stash" and exports["isPed"]:GroupRank("tuner_carshop") > 2 then
                TriggerEvent("server-inventory-open", "1", "storage-tuner_carshop")
              elseif pEvent == "redline:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "harmony:stash" and exports["isPed"]:GroupRank("repairs_harmony") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-repairs_harmony")
              elseif pEvent == "harmony:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "lost:stash" and exports["isPed"]:GroupRank("lost_mc") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-lost_mc_2")
              elseif pEvent == "lost:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "ugr:stash" and exports["isPed"]:GroupRank("ug_racing") > 0 then
                --TriggerEvent("server-inventory-open", "1", "storage-ug_racing")
              --elseif pEvent == "ugr:stash" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "ugr:usb" and exports["isPed"]:GroupRank("ug_racing") > 0 then
                --TriggerEvent("animation:PlayAnimation","type3")
                --local finished = exports["np-taskbar"]:taskBar(25000,"Acquiring Data...",false,false,playerVeh)
                --if finished == 100 then
                  --TriggerEvent("animation:PlayAnimation","c")
                  --TriggerEvent( "player:receiveItem", "racingusb1", 1 )
                  --TriggerEvent("DoLongHudText","A new USB has been created for the Underground, welcome user.", 1)
                --end
              --elseif pEvent == "ugr:usb" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "ugr:craft" and exports["isPed"]:GroupRank("ug_racing") > 0 then
                --TriggerEvent("server-inventory-open", "888", "Craft");
              --elseif pEvent == "ugr:craft" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "ebk:stash" and exports["isPed"]:GroupRank("everybody_k") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-everybody_k")
              elseif pEvent == "ebk:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              -- elseif pEvent == "pd:raid" then
              --   TriggerEvent("server-inventory-open", "1", "motel-1-?")
              elseif pEvent == "ems:stash" and exports["isPed"]:GroupRank("lsm") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-ems")
              elseif pEvent == "ems:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "ems:stash2" and exports["isPed"]:GroupRank("lsm") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-ems2")
              elseif pEvent == "ems:stash2" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "ms13:stash" and exports["isPed"]:GroupRank("ms13") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-ms_13")
              elseif pEvent == "ms13:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "lost:bar:tray" then
                --TriggerEvent("server-inventory-open", "1", "tray-lost_mc")
              --elseif pEvent == "lost:bar:fridge" and exports["isPed"]:GroupRank("lost_mc") > 0 then
                --TriggerEvent("server-inventory-open", "1", "fridge-lost_mc")
              --elseif pEvent == "lost:bar:fridge" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "gallery:drinkmixing" and exports["isPed"]:GroupRank("gallery") > 0 then
                --TriggerEvent("server-inventory-open", "446", "Craft");
              --elseif pEvent == "gallery:drinkmixing" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "gallery:fridge" and exports["isPed"]:GroupRank("gallery") > 0 then
                --TriggerEvent("server-inventory-open", "1", "fridge-gallery")
              --elseif pEvent == "gallery:fridge" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "gallery:tray" then
                --TriggerEvent("server-inventory-open", "1", "tray-gallery")
              --elseif pEvent == "bakery:tray" then
                --TriggerEvent("server-inventory-open", "1", "tray-buns_n_roses")
              --elseif pEvent == "bakery:fridge" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "1", "fridge-buns_n_roses")
              --elseif pEvent == "bakery:fridge" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:cupcakes" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473476", "Craft");
              --elseif pEvent == "bakery:cupcakes" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:boxup" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473475", "Craft");
              --elseif pEvent == "bakery:boxup" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:drinks" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473473", "Craft");
              --elseif pEvent == "bakery:drinks" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:pies" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473477", "Craft");
              --elseif pEvent == "bakery:pies" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:ingredients" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "1", "storage-buns_n_roses_ingredients")
              --elseif pEvent == "bakery:ingredients" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:food" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473472", "Craft");
              --elseif pEvent == "bakery:food" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "bakery:boxes" and exports["isPed"]:GroupRank("buns_n_roses") > 0 then
                --TriggerEvent("server-inventory-open", "13473474", "Craft");
              --elseif pEvent == "bakery:boxes" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:base" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "7101", "Craft");
              --elseif pEvent == "winery:base" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:redwine" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "7102", "Craft");
              --elseif pEvent == "winery:redwine" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:whitewine" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "7103", "Craft");
              --elseif pEvent == "winery:whitewine" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:grapejuice" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "7104", "Craft");
              --elseif pEvent == "winery:grapejuice" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:boxup" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "7106", "Craft");
              --elseif pEvent == "winery:boxup" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:ingredients" and exports["isPed"]:GroupRank("winery_factory") > 0 then
                --TriggerEvent("server-inventory-open", "1", "storage-marlowe_valley_estates")
              --elseif pEvent == "winery:ingredients" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              --elseif pEvent == "winery:moly" and exports["isPed"]:GroupRank("winery_factory") > 4 then
                --TriggerEvent("server-inventory-open", "7105", "Craft");
              --elseif pEvent == "winery:moly" then
                --TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "yakuza:stash" and exports["isPed"]:GroupRank("yakuza") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-bondiboys")
              elseif pEvent == "yakuza:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              elseif pEvent == "mandem:stash" and exports["isPed"]:GroupRank("mandem") > 0 then
                TriggerEvent("server-inventory-open", "1", "storage-mandem")
              elseif pEvent == "mandem:stash" then
                TriggerEvent("DoLongHudText","Not allowed.", 2)
              end
              exports["np-ui"]:hideInteraction()
            end
            Wait(0)
        end
    end)
end

AddEventHandler("np-polyzone:enter", function(zone)
  if zone == "gallery:ceo:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "gallery:car:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "redline:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "harmony:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "lost:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  -- elseif zone == "pd:raid" then
  --   exports["np-ui"]:showInteraction("[E] Perform Raid")
  --   listenForKeypress(listening, zone)
  --elseif zone == "ugr:stash" then
    --exports["np-ui"]:showInteraction("[E] Stash")
    --listenForKeypress(listening, zone)
  --elseif zone == "ugr:usb" then
    --exports["np-ui"]:showInteraction("[E] Create a new USB")
    --listenForKeypress(listening, zone)
  --elseif zone == "ugr:craft" then
    --exports["np-ui"]:showInteraction("[E] Craft")
    --listenForKeypress(listening, zone)
  elseif zone == "ebk:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "ems:stash" then
    exports["np-ui"]:showInteraction("[E] Storage")
    listenForKeypress(listening, zone)
  elseif zone == "ems:stash2" then
    exports["np-ui"]:showInteraction("[E] Storage")
    listenForKeypress(listening, zone)
  elseif zone == "ms13:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  --elseif zone == "lost:bar:tray" then
    --exports["np-ui"]:showInteraction("[E] Tray")
    --listenForKeypress(listening, zone)
  --elseif zone == "lost:bar:fridge" then
    --exports["np-ui"]:showInteraction("[E] Fridge")
    --listenForKeypress(listening, zone)
  --elseif zone == "gallery:drinkmixing" then
    --exports["np-ui"]:showInteraction("[E] Mix Drinks")
    --listenForKeypress(listening, zone)
  --elseif zone == "gallery:fridge" then
    --exports["np-ui"]:showInteraction("[E] Fridge")
    --listenForKeypress(listening, zone)
  --elseif zone == "gallery:tray" then
    --exports["np-ui"]:showInteraction("[E] Tray")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:tray" then
    --exports["np-ui"]:showInteraction("[E] Tray")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:fridge" then
    --exports["np-ui"]:showInteraction("[E] Fridge")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:cupcakes" then
    --exports["np-ui"]:showInteraction("[E] Decorate Cupcakes")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:boxup" then
    --exports["np-ui"]:showInteraction("[E] Box up Food")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:drinks" then
    --exports["np-ui"]:showInteraction("[E] Make Drinks")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:pies" then
    --exports["np-ui"]:showInteraction("[E] Decorate Pies")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:ingredients" then
    --exports["np-ui"]:showInteraction("[E] Ingredients Shelf")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:food" then
    --exports["np-ui"]:showInteraction("[E] Make Food")
    --listenForKeypress(listening, zone)
  --elseif zone == "bakery:boxes" then
    --exports["np-ui"]:showInteraction("[E] Make Boxes")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:base" then
    --exports["np-ui"]:showInteraction("[E] Alcohol Base")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:redwine" then
    --exports["np-ui"]:showInteraction("[E] Make Red Wine")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:whitewine" then
    --exports["np-ui"]:showInteraction("[E] Make White Wine")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:grapejuice" then
    --exports["np-ui"]:showInteraction("[E] Make Grape Juice")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:boxup" then
    --exports["np-ui"]:showInteraction("[E] Box up Drinks")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:ingredients" then
    --exports["np-ui"]:showInteraction("[E] Storage Shelf")
    --listenForKeypress(listening, zone)
  --elseif zone == "winery:moly" then
    --exports["np-ui"]:showInteraction("[E] Compact a Moly")
    --listenForKeypress(listening, zone)
  elseif zone == "yakuza:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  elseif zone == "mandem:stash" then
    exports["np-ui"]:showInteraction("[E] Stash")
    listenForKeypress(listening, zone)
  end 
end)

AddEventHandler("np-polyzone:exit", function(zone)
  if zone == "townhall:gavel" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "gallery:ceo:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "gallery:car:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "redline:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "harmony:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "lost:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  -- elseif zone == "pd:raid" then
  --   exports["np-ui"]:hideInteraction()
  --   listening = listening + 1
  --elseif zone == "ugr:stash" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "ugr:usb" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "ugr:craft" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  elseif zone == "ebk:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "ems:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "ems:stash2" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "ms13:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  --elseif zone == "lost:bar:tray" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "lost:bar:fridge" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "gallery:drinkmixing" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "gallery:fridge" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "gallery:tray" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:tray" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:fridge" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:cupcakes" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:boxup" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:drinks" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:pies" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:ingredients" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:food" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "bakery:boxes" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:base" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:redwine" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:whitewine" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:grapejuice" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:boxup" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:ingredients" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  --elseif zone == "winery:moly" then
    --exports["np-ui"]:hideInteraction()
    --listening = listening + 1
  elseif zone == "yakuza:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  elseif zone == "mandem:stash" then
    exports["np-ui"]:hideInteraction()
    listening = listening + 1
  end
end)


function DrawText3DTest(x,y,z, text)
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

AddEventHandler('Courthouse:Gavel', function() 
  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 20.0, 'gavel_3hit_mixdown', 0.4)
end)