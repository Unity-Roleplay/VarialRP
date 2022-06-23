Citizen.CreateThread(function()
        
        exports["np-polytarget"]:AddBoxZone("pdlocker", vector3(481.67, -994.9, 30.69), 0.8, 3.4, {
            heading = 358,
            -- debugPoly = true,
            minZ = 27.69,
            maxZ = 31.69
        })
		
		        
        exports["np-polytarget"]:AddBoxZone("weed_shopx", vector3( 1175.49, -437.54, 65.9), 0.8, 3.4, {
            heading = 358,
            -- debugPoly = true,
            minZ = 27.69,
            maxZ = 31.69
        })
		
		    exports['np-interact']:AddPeekEntryByPolyTarget('weed_shopx', {{
            event = "np-kart:spawnKart",
            id = "weed_shopx",
            icon = "fas fa-shopping-basket",
            label = "Purchase Weed",
            parameters = {}
        }}, {distance = {radius = 1.5}})
        
        exports['np-interact']:AddPeekEntryByPolyTarget('pdlocker', {{
            event = "police:general",
            id = "pdlocker",
            icon = "fas fa-shopping-basket",
            label = "Armory",
            parameters = {trayId = 1}
        }}, {distance = {radius = 3.5}})
        
        exports["np-polytarget"]:AddBoxZone("pdlocker2", vector3(-437.33, 5987.87, 31.72), 2.0, 0.6, {
            heading = 315,
            --debugPoly=true,
            minZ = 28.42,
            maxZ = 32.42
        })
        
        exports['np-interact']:AddPeekEntryByPolyTarget('pdlocker2', {{
            event = "np-inventory:pdlocker",
            id = "pdlocker2",
            icon = "fas fa-shopping-basket",
            label = "Armory",
            parameters = {trayId = 1}
        }}, {distance = {radius = 3.5}, isEnabled = function() return LocalPlayer.state.job == "cop" end})
        
        
        exports["np-polytarget"]:AddBoxZone("pdlocker3", vector3(1840.92, 3690.26, 34.26), 0.4, 2.8, {
            heading = 300,
            --debugPoly=true,
            minZ = 32.26,
            maxZ = 36.26
        })
        
        exports['np-interact']:AddPeekEntryByPolyTarget('pdlocker3', {{
            event = "np-inventory:pdlocker",
            id = "pdlocker2",
            icon = "fas fa-shopping-basket",
            label = "Armory",
            parameters = {trayId = 1}
        }}, {distance = {radius = 3.5}, isEnabled = function() return LocalPlayer.state.job == "cop" end})
        
        
        exports["np-polytarget"]:AddBoxZone("pillbox", vector3(306.54, -602.44, 43.28), 0.8, 2.0, {
            heading = 340,
            -- debugPoly = true,
            minZ = 40.68,
            maxZ = 44.68
        })
        
        exports['np-interact']:AddPeekEntryByPolyTarget('pillbox', {{
            event = "np-inventory:emslocker",
            id = "pillbox",
            icon = "fas fa-shopping-basket",
            label = "shop",
            parameters = {trayId = 1}
        }}, {distance = {radius = 3.5}, isEnabled = function() return LocalPlayer.state.job == "ems" end})
        
        
        
        exports["np-polytarget"]:AddBoxZone("tequilala", vector3(-560.89, 286.96, 82.18), 5.6, 1.0, {
            heading = 354,
            -- debugPoly=true,
            minZ = 82.18,
            maxZ = 82.78
        })
        
        exports['np-interact']:AddPeekEntryByPolyTarget('tequilala', {{
            event = "np-inventory:bar",
            id = "tequilala",
            icon = "fas fa-shopping-basket",
            label = "Bar",
            parameters = {trayId = 1}
        }}, {distance = {radius = 3.5}})
        
        
        exports["np-polytarget"]:AddBoxZone("kartplace", vector3(-170.89, -2144.78, 16.84), 2.2, 2.2, {
            heading = 19,
            -- debugPoly=true,
            minZ = 14.34,
            maxZ = 17.74
        })
        
        exports['np-interact']:AddPeekEntryByPolyTarget('kartplace', {{
            event = "np-kart:spawnKart",
            id = "kartplace",
            icon = "fas fa-shopping-basket",
            label = "Rent Kart ($150)",
            parameters = {}
        }}, {distance = {radius = 1.5}})
        
        exports["np-polyzone"]:AddBoxZone("mall_store", vector3(45.24, -1730.8, 29.3), 32.6, 27.2, {
            name = "mall_store",
            heading = 320,
            --debugPoly=true,
            minZ = 28.3,
            maxZ = 32.3
        })
        
        exports["np-polyzone"]:AddBoxZone("youtool_store", vector3(2738.22, 3477.59, 55.66), 36.6, 29.8, {
            name = "youtool_store",
            heading = 338,
            --debugPoly=true,
            minZ = 54.66,
            maxZ = 58.66
        })
        
        
        exports["np-polyzone"]:AddBoxZone("general_store1", vector3(-712.94, -914.88, 19.01), 23.6, 17.2, {
            name = "general_store1",
            heading = 0,
            --debugPoly=true,
            minZ = 15.49,
            maxZ = 22.49
        })
        exports["np-polyzone"]:AddBoxZone("general_store2", vector3(29.62, -1349.03, 29.22), 20.6, 12.6, {
            name = "general_store2",
            heading = 0,
            --debugPoly=true,
            minZ = 28.22,
            maxZ = 32.22
        })
        exports["np-polyzone"]:AddBoxZone("general_store3", vector3(-51.74, -1754.78, 28.96), 23.0, 15.4, {
            name = "general_store3",
            heading = 320,
            --debugPoly=true,
            minZ = 27.96,
            maxZ = 31.96
        })
        exports["np-polyzone"]:AddBoxZone("general_store4", vector3(376.95, 326.01, 103.44), 18.0, 15.4, {
            name = "general_store4",
            heading = 348,
            --debugPoly=true,
            minZ = 102.44,
            maxZ = 106.44
        })
        exports["np-polyzone"]:AddBoxZone("general_store5", vector3(-1487.94, -380.65, 39.87), 7.8, 22.0, {
            name = "general_store5",
            heading = 225,
            --debugPoly=true,
            minZ = 38.87,
            maxZ = 42.87
        })
        exports["np-polyzone"]:AddBoxZone("general_store6", vector3(-2969.43, 390.54, 15.02), 8.0, 24.6, {
            name = "general_store6",
            heading = 356,
            -- debugPoly=true,
            minZ = 13.87,
            maxZ = 17.87
        })
        exports["np-polyzone"]:AddBoxZone("general_store7", vector3(-3241.8, 1004.64, 12.28), 12.2, 19.0, {
            name = "general_store7",
            heading = 358,
            --debugPoly=true
            minZ = 10.87,
            maxZ = 15.87
        })
        exports["np-polyzone"]:AddBoxZone("general_store8", vector3(-3041.0, 588.74, 7.81), 12.2, 19.0, {
            name = "general_store8",
            heading = 21,
            --debugPoly=true
            minZ = 5.87,
            maxZ = 10.87
        })
        exports["np-polyzone"]:AddBoxZone("general_store9", vector3(1964.27, 3742.36, 32.22), 12.2, 19.0, {
            name = "general_store9",
            heading = 300,
            --debugPoly=true,
            minZ = 31.22,
            maxZ = 35.22
        })
        exports["np-polyzone"]:AddBoxZone("general_store10", vector3(1393.58, 3603.15, 34.93), 14.4, 21.4, {
            name = "general_store10",
            heading = 290,
            --debugPoly=true,
            minZ = 33.93,
            maxZ = 37.93
        })
        exports["np-polyzone"]:AddBoxZone("general_store11", vector3(1166.6, 2709.24, 37.8), 7.4, 21.4, {
            name = "general_store11",
            heading = 271,
            --debugPoly=true,
            minZ = 36.8,
            maxZ = 40.8
        })
        exports["np-polyzone"]:AddBoxZone("general_store12", vector3(1701.39, 4927.48, 42.08), 13.8, 21.4, {
            name = "general_store12",
            heading = 143,
            --debugPoly=true,
            minZ = 41.08,
            maxZ = 45.08
        })
        exports["np-polyzone"]:AddBoxZone("general_store13", vector3(1732.38, 6414.38, 35.0), 11.4, 17.2, {
            name = "general_store13",
            heading = 63,
            --debugPoly=true,
            minZ = 34.0,
            maxZ = 38.0
        })
        exports["np-polyzone"]:AddBoxZone("general_store14", vector3(2680.1, 3283.4, 55.24), 11.4, 17.2, {
            name = "general_store14",
            heading = 328,
            --debugPoly=true,
            minZ = 54.24,
            maxZ = 58.24
        })
        exports["np-polyzone"]:AddBoxZone("general_store15", vector3(2556.84, 385.31, 108.46), 11.4, 17.2, {
            name = "general_store15",
            heading = 356,
            --debugPoly=true,
            minZ = 107.46,
            maxZ = 111.46
        })
        exports["np-polyzone"]:AddBoxZone("general_store16", vector3(1136.3, -981.7, 46.22), 7.8, 20.4, {
            name = "general_store16",
            heading = 4,
            --debugPoly=true,
            minZ = 45.22,
            maxZ = 49.22
        })
        exports["np-polyzone"]:AddBoxZone("general_store17", vector3(1159.41, -323.95, 68.8), 13.8, 22.0, {
            name = "general_store17",
            heading = 279,
            --debugPoly=true,
            minZ = 67.8,
            maxZ = 71.8
        })
        exports["np-polyzone"]:AddBoxZone("general_store18", vector3(-1223.2, -907.11, 12.11), 8.0, 20.8, {
            name = "general_store18",
            heading = 305,
            --debugPoly=true,
            minZ = 11.11,
            maxZ = 15.11
        })
        exports["np-polyzone"]:AddBoxZone("general_store19", vector3(-1824.6, 790.84, 137.87), 14.2, 20.8, {
            name = "general_store19",
            heading = 311,
            --debugPoly=true,
            minZ = 136.87,
            maxZ = 140.87
        })
        exports["np-polyzone"]:AddBoxZone("general_store20", vector3(544.27, 2670.1, 42.22), 11.8, 17.0, {
            name = "general_store20",
            heading = 276,
            --debugPoly=true,
            minZ = 41.22,
            maxZ = 45.22
        })
        exports["np-polyzone"]:AddBoxZone("general_store21", vector3(-2543.85, 2312.56, 33.06), 11.8, 17.0, {
            name = "general_store21",
            heading = 276,
            --debugPoly=true,
            minZ = 32.06,
            maxZ = 36.06
        })
        exports["np-polyzone"]:AddBoxZone("general_store22", vector3(164.46, 6638.8, 31.69), 11.8, 17.0, {
            name = "general_store22",
            heading = 226,
            --debugPoly=true,
            minZ = 30.69,
            maxZ = 34.69
        })
        
        exports["np-polyzone"]:AddBoxZone("gun_store1", vector3(-326.9, 6079.38, 31.29), 17.6, 8.8, {
            name = "gun_store1",
            heading = 45,
            --debugPoly=true,
            minZ = 30.29,
            maxZ = 34.29
        })
        exports["np-polyzone"]:AddBoxZone("gun_store2", vector3(1696.9, 3755.36, 34.05), 17.6, 8.8, {
            name = "gun_store2",
            heading = 45,
            --debugPoly=true,
            minZ = 33.05,
            maxZ = 37.05
        })
        exports["np-polyzone"]:AddBoxZone("gun_store3", vector3(-1114.65, 2694.24, 18.77), 17.6, 8.8, {
            name = "gun_store3",
            heading = 45,
            --debugPoly=true,
            minZ = 17.77,
            maxZ = 21.77
        })
        exports["np-polyzone"]:AddBoxZone("gun_store4", vector3(-3167.13, 1085.12, 20.7), 17.6, 8.8, {
            name = "gun_store4",
            heading = 66,
            --debugPoly=true,
            minZ = 19.7,
            maxZ = 23.7
        })
        exports["np-polyzone"]:AddBoxZone("gun_store5", vector3(247.03, -47.44, 69.71), 17.6, 8.8, {
            name = "gun_store5",
            heading = 70,
            --debugPoly=true,
            minZ = 68.71,
            maxZ = 72.71
        })
        exports["np-polyzone"]:AddBoxZone("gun_store6", vector3(-1311.02, -392.64, 36.46), 17.6, 8.8, {
            name = "gun_store6",
            heading = 76,
            --debugPoly=true,
            minZ = 35.46,
            maxZ = 39.46
        })
        exports["np-polyzone"]:AddBoxZone("gun_store7", vector3(2568.65, 299.85, 108.61), 17.6, 8.8, {
            name = "gun_store7",
            heading = 0,
            --debugPoly=true,
            minZ = 107.61,
            maxZ = 111.61
        })
        exports["np-polyzone"]:AddBoxZone("gun_store8", vector3(-662.97, -940.79, 21.53), 17.6, 8.8, {
            name = "gun_store8",
            heading = 359,
            --debugPoly=true,
            minZ = 20.53,
            maxZ = 24.53
        })
        exports["np-polyzone"]:AddBoxZone("gun_store9", vector3(817.63, -2152.76, 29.62), 23.6, 21.6, {
            name = "gun_store9",
            heading = 359,
            --debugPoly=true,
            minZ = 28.02,
            maxZ = 32.02
        })
        exports["np-polyzone"]:AddBoxZone("gun_store10", vector3(14.1, -1106.84, 29.8), 18.6, 21.6, {
            name = "gun_store10",
            heading = 339,
            --debugPoly=true,
            minZ = 28.2,
            maxZ = 32.2
        })
        exports["np-polyzone"]:AddBoxZone("gun_store11", vector3(843.29, -1027.59, 27.95), 8.6, 18.6, {
            name = "gun_store11",
            heading = 268,
            --debugPoly=true,
            minZ = 26.35,
            maxZ = 30.35
        })
        
        exports["np-polyzone"]:AddBoxZone("recycle_store", vector3(-352.48, -1558.22, 25.19), 18.8, 18.2, {
            name = "recycle_store",
            heading = 0,
            -- debugPoly=true,
            minZ = 24.19,
            maxZ = 30.39
        })
        
        exports["np-polyzone"]:AddBoxZone("hunting_store", vector3(-772.53, 5595.49, 33.49), 18.2, 11.8, {
            name = "hunting_store",
            heading = 348,
            minZ = 32.49,
            maxZ = 36.49
        })
        
        exports["np-polyzone"]:AddBoxZone("gokart_store", vector3(-170.41, -2148.29, 16.71), 10.0, 8.0, {
            name = "gokart_store",
            heading = 19,
        --debugPoly=true
        })
        
        exports["np-polyzone"]:AddBoxZone("payslip_store", vector3(243.18, 226.62, 106.29), 11.6, 10.8, {
            name = "payslip_store",
            heading = 340,
            --debugPoly=true,
            minZ = 104.49,
            maxZ = 108.89
        })
        
        exports["np-polyzone"]:AddBoxZone("planebuy_store", vector3(-1670.84, -3155.74, 13.99), 10.4, 10.2, {
            name = "planeBuy",
            heading = 21,
            --debugPoly=true,
            minZ = 13.39,
            maxZ = 17.39
        })
        
        exports["np-polyzone"]:AddBoxZone("boatbuy_store", vector3(-772.92, -1371.81, 1.6), 5.6, 6.6, {
            name = "boatbuy_store",
            heading = 322,
            --debugPoly=true,
            minZ = -0.2,
            maxZ = 3.8
        
        })
        
        exports["np-polyzone"]:AddBoxZone("pawnshop_store", vector3(-1597.38, -1008.98, 7.5), 13.4, 75.800000000001, {
            name = "pawnshop_store",
            heading = 320,
            --debugPoly=true,
            minZ = 6.3,
            maxZ = 10.1
        })
        
end)
