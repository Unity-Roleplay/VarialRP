local traysList = {
    {
        id = "trays_burgershot1",
        displayName = "Table Tray #1",
        coords = vector3(-1190.12, -896.14, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot2",
        displayName = "Table Tray #2", -- 2 Table
        coords = vector3(-1186.83, -894.54, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot3",
        displayName = "Table Tray #3", -- 2 Table
        coords = vector3(-1184.47, -892.97, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot4",
        displayName = "Table Tray #4",
        coords = vector3(-1181.97, -890.69, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot5",
        displayName = "Table Tray #5", -- 2 Table
        coords = vector3(-1183.11, -888.11, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 34,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot6",
        displayName = "Table Tray #6",
        coords = vector3(-1188.46, -891.41, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot7",
        displayName = "Table Tray #7", -- 2 Table
        coords = vector3(-1187.0, -882.39, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 34,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot8",
        displayName = "Table Tray #8",
        coords = vector3(-1188.87, -880.49, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot9",
        displayName = "Table Tray #9", --2 Table
        coords = vector3(-1191.98, -881.78, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot10",
        displayName = "Table Tray #10", --2 Table
        coords = vector3(-1194.34, -883.37, 13.98),
        length = 1.2,
        width = 2.2,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot11",
        displayName = "Table Tray #11",
        coords = vector3(-1192.0, -886.22, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot12",
        displayName = "Table Tray #12",
        coords = vector3(-1193.43, -888.18, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot13",
        displayName = "Table Tray #13",
        coords = vector3(-1190.87, -892.04, 13.98),
        length = 1.2,
        width = 1.25,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.20,
        },
    },
    {
        id = "trays_burgershot14",
        displayName = "Pickup Order #1",
        coords = vector3(-1193.85, -894.38, 13.98),
        length = 1.0,
        width = 0.85,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.35,
        },
    },
    {
        id = "trays_burgershot15",
        displayName = "Pickup Order #2",
        coords = vector3(-1194.90, -892.85, 13.98),
        length = 1.0,
        width = 0.85,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.35,
        }
    },
    {
        id = "trays_burgershot16",
        displayName = "Pickup Order #3",
        coords = vector3(-1195.92, -891.34, 13.98),
        length = 1.0,
        width = 0.85,
        options = {
            heading = 304,
            minZ = 13.75,
            maxZ = 14.35,
        }
    },

    {
        id = "trays_roosterest1",
        displayName = "Pickup Order #1",
        coords = vector3(-170.95, 302.43, 98.52),
        length = 1.6,
        width = 1.0,
        options = {
            heading = 0,
            minZ = 98.52,
            maxZ = 98.92
        }
    },
    {
        id = "trays_roosterest2",
        displayName = "Pickup Order #2",
        coords = vector3(-171.36, 291.72, 99.2),
        length = 3.4,
        width = 1.0,
        options = {
            heading = 0,
            minZ = 99.00,
            maxZ = 99.60
        }
    },
}

local serverCode = "wl"

Citizen.CreateThread(function()
    for pID, pData in pairs(traysList) do
        exports["np-polytarget"]:AddBoxZone(pData.id .. pID, pData.coords, pData.length, pData.width, {
            heading = pData.options.heading,
            minZ = pData.options.minZ,
            maxZ = pData.options.maxZ,
            debugPoly = false,
            data = {
                id = pData.id
            }
        })
        exports['np-interact']:AddPeekEntryByPolyTarget(pData.id .. pID, {{
            event = "np-trays:client:pickupPrompt",
            id = pData.id .. pID,
            icon = "hand-holding",
            label = "Open",
            parameters = {
                id = pData.id,
                displayName = pData.displayName,
            },
        }}, { distance = { radius = 3.5 }  })
    end
end)

AddEventHandler('np-trays:client:pickupPrompt', function(pParameters, pEntity, pContext)
    serverCode = "wl"
    TriggerEvent("server-inventory-open", "1", pParameters.id .. "-" .. pParameters.displayName .. "-" .. serverCode)
end)