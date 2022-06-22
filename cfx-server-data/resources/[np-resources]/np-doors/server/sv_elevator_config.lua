--Example : 
    --{
    --     id = 1,
    --     floors = {
    --         name = "test",
    --         description = "test",
    --         teleport = {
    --             coords = typedata vector3,
    --             heading = 0,
    --             onArriveEvent = "",
    --             onLeaveEvent = "",
    --         },
    --         locked = false,
    --         forceUnlocked = false,
    --         zone = {
    --             center =  ,
    --             width = ,
    --             length = ,
    --             options = {
    --                 data =
    --             },
    --             target = true / false
    --         }
    --     },
    -- }

ELEVATOR_CONFIG = {
    {
        id = 1,
        info = "casino elevator",
        dec = "caino",
        active = true,
        access = {
            job = {},
            business = {},
        },
        floors = {
            {
                name = "Hotel",
                description = "Rooms for Rent",
                teleport = {
                    coords = vector3(910.50, -52.85, 21.01),
                    heading = 151.5,
                    onArriveEvent = "np-casino:enterHotel",
                },
                zone = {
                    center = vector3(910.12, -52.07, 21.0),
                    width = 0.4,
                    length = 0.6,
                    target = true,
                    options = { headling = 311.0, minZ = 21.0, maxZ = 21.6 }
                },
                locked = false,
            },
            {
                name = "Penthouse",
                description = "ERP Arena",
                teleport = {
                    coords = vector3(982.44, 55.46, 116.17),
                    heading = 51.58,
                    onArriveEvent = "np-casino:enterPenthouse",
                },
                zone = {
                    center = vector3(982.43, 57.07, 116.16),
                    width = 0.4,
                    length = 0.6,
                    target = true,
                    options = { headling = 328.0, minZ = 116.16, maxZ = 116.76 }
                },
                locked = false,
            },
            {
                name = "Roof",
                description = "Rooftop pleasures",
                teleport = {
                    coords = vector3(964.49, 58.83, 112.56),
                    heading = 49.08,
                    onArriveEvent = "np-casino:elevatorExitCasino",
                },
                zone = {
                    center = vector3(964.39, 57.66, 112.55),
                    width = 0.4,
                    length = 0.4,
                    target = true,
                    options = { headling = 60.0, minZ = 112.35, maxZ = 112.95 }
                },
                locked = false,
            },
            {
                name = "Office",
                description = "Management",
                teleport = {
                    coords = vector3(994.02, 56.06, 75.06),
                    heading = 244.09,
                    onArriveEvent = "np-casino:elevatorEnterCasino",
                },
                zone = {
                    center = vector3(993.42, 55.50, 75.06),
                    width = 0.4,
                    length = 0.4,
                    target = true,
                    options = { headling = 329.0, minZ = 75.01, maxZ = 75.61 }
                },
                locked = false,
            },
            {
                name = "Casino",
                description = "Casino Main Floor",
                teleport = {
                    coords = vector3(960.55, 43.24, 71.71),
                    heading = 285.08,
                    onArriveEvent = "np-casino:elevatorEnterCasino",
                },
                zone = {
                    center = vector3(960.22, 42.32, 71.71),
                    width = 0.4,
                    length = 0.4,
                    target = true,
                    options = { headling = 13, minZ = 71.9, maxZ = 72.3 }
                },
                locked = false,
            },
        },
    }, 
    {
        id = 2,
        info = "stadium",
        dec = "stadium",
        active = true,
        access = {
            job = {
                ["PD"] = true
            },
            --business = {
                --["npa"] = true
            --},
        },
        floors = {
            {
                name = "Stadium Entrance",
                description = "",
                teleport = {
                    coords = vector3(-282.4, -2031.43, 30.15),
                    heading = 292.15,
                    onArriveEvent = "np-paintball:leaveStadium", -- leave
                    onLeaveEvent = "np-paintball:enterStadium", -- enter
                },
                zone = {
                    center = vector3(-282.78, -2031.66, 30.15),
                    width = 0.4,
                    length = 1.2,
                    target = true,
                    options = { headling = 290.0, minZ = 29.95, maxZ = 30.75 },
                },
                locked = false,
            },
            {
                name = "VIP Lounge",
                description = "",
                teleport = {
                    coords = vector3(5518.24, 5963.74, 634.84),
                    heading = 179.45,
                },
                zone = {
                    center = vector3(5518.08, 5965.40, 635.84),
                    width = 0.4,
                    length = 1.2,
                    target = true,
                    options = { headling = 0.0, minZ = 635.64, maxZ = 636.44 },
                },
                locked = false,
            },
            {
                name = "Arena",
                description = "",
                teleport = {
                    coords = vector3(5503.43, 5980.24, 590.01),
                    heading = 14.4,
                    onArriveEvent = "np-paintball:enterArena",
                    onLeaveEvent = "np-paintball:leaveArena",
                },
                zone = {
                    center = vector3(5504.97, 5979.59, 590.0),
                    width = 0.4,
                    length = 1.2,
                    target = true,
                    options = { headling = 0.0, minZ = 589.80, maxZ = 590.60 },
                },
                locked = false,
            },
        },
    },
    {
        id = 3,
        floors = {
            {
                teleport = {
                    coords = vector3(345.9100036621094, -582.6099853515625, 27.79999923706054),
                    heading = 260
                },
                description = "Hospital Lower Lobby",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 346.0400085449219,
                        y = -581,
                        z = 28.79999923706054
                    },
                    target = true,
                    options = {
                        minZ = 28.8,
                        heading = 340,
                        maxZ = 29.4
                    }
                },
                locked = false,
                name = "First Floor"
            },
            {
                teleport = {
                    coords = vector3(331.989990234375, -595.5900268554688, 42.29000091552734),
                    heading = 80
                },
                description = "Hospital Upper Lobby",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 331.9599914550781,
                        y = -597.22998046875,
                        z = 43.27999877929687
                    },
                    target = true,
                    options = {
                        minZ = 43.28,
                        heading = 340,
                        maxZ = 43.88
                    }
                },
                locked = false,
                name = "Second Floor"
            }
        },
        info = "pillbox elevator 1",
        access = {
            business = {},
            job = {
                ["DR"] = true,
                ["PD"] = true
            }
        },
        dec = "hospital",
        active = true
    },
    {
        id = 4,
        floors = {
            {
                teleport = {
                    coords = {
                        x = 344.6000061035156,
                        y = -586.3300170898438,
                        z = 27.79999923706054
                    },
                    heading = 260
                },
                description = "Hospital Lower Lobby",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 344.739990234375,
                        y = -584.7100219726562,
                        z = 28.79999923706054
                    },
                    target = true,
                    options = {
                        minZ = 28.8,
                        heading = 340,
                        maxZ = 29.4
                    }
                },
                locked = false,
                name = "First Floor"
            },
            {
                teleport = {
                    coords = {
                        x = 329.8900146484375,
                        y = -600.9600219726562,
                        z = 42.29000091552734
                    },
                    heading = 80
                },
                description = "Hospital Upper Lobby",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 329.92999267578125,
                        y = -602.6799926757812,
                        z = 43.27999877929687
                    },
                    target = true,
                    options = {
                        minZ = 43.28,
                        heading = 340,
                        maxZ = 43.88
                    }
                },
                locked = false,
                name = "Second Floor"
            }
        },
        info = "pillbox elevator 2",
        access = {
            business = {},
            job = {
                ["DR"] = true,
                ["PD"] = true
            }
        },
        dec = "hospital",
        active = true
    },
    {
        id = 5,
        floors = {
            {
                teleport = {
                    coords = {
                        x = -304.9684753,
                        y = -721.1376953,
                        z = 28.0286083
                    },
                    heading = 163.0506439
                },
                description = "Admin Tower",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = -306.382873,
                        y = -721.932434,
                        z = 28.284427
                    },
                    target = true,
                    options = {
                        minZ = 27.9,
                        heading = 340,
                        maxZ = 28.6
                    }
                },
                locked = false,
                name = "Parkade"
            },
            {
                teleport = {
                    coords = {
                        x = -288.45602,
                        y = -722.46246,
                        z = 125.47322
                    },
                    heading = 244.61993
                },
                description = "Admin Tower",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = -287.3238830,
                        y = -723.9221191,
                        z = 125.8647079
                    },
                    target = true,
                    options = {
                        minZ = 125.56,
                        heading = 340,
                        maxZ = 126.16
                    }
                },
                locked = false,
                name = "Top Floor"
            }
        },
        info = "Admin Elevator",
        access = {
            business = {},
            job = {}
            
        },
        dec = "admin",
        active = true
    }   ,
    {
        id = 6,
        floors = {
            {
                teleport = {
                    coords = {
                        x = 339.6000061035156,
                        y = -584.5399780273438,
                        z = 27.79999923706054
                    },
                    heading = 80
                },
                description = "Hospital Garage",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 339.7200012207031,
                        y = -586.239990234375,
                        z = 28.79999923706054
                    },
                    target = true,
                    options = {
                        minZ = 28.8,
                        heading = 340,
                        maxZ = 29.4
                    }
                },
                locked = false,
                name = "First Floor"
            },
            {
                teleport = {
                    coords = {
                        x = 327.2200012207031,
                        y = -603.5800170898438,
                        z = 42.29000091552734
                    },
                    heading = 340
                },
                description = "Hospital Upper Lobby",
                zone = {
                    width = 0.4,
                    length = 0.4,
                    center = {
                        x = 325.6199951171875,
                        y = -603.4199829101562,
                        z = 43.27999877929687
                    },
                    target = true,
                    options = {
                        minZ = 43.28,
                        heading = 340,
                        maxZ = 43.88
                    }
                },
                locked = false,
                name = "Second Floor"
            },
            {
                teleport = {
                    coords = {
                        x = 339.0299987792969,
                        y = -584.010009765625,
                        z = 73.16999816894531
                    },
                    heading = 260
                },
                description = "Hospital Rooftop",
                zone = {
                    width = 3,
                    length = 1.6,
                    center = {
                        x = 338.9100036621094,
                        y = -583.969970703125,
                        z = 74.16000366210938
                    },
                    target = false,
                    options = {
                        minZ = 72.8,
                        heading = 340,
                        maxZ = 76.8
                    }
                },
                locked = false,
                name = "Third Floor"
            }
        },
        info = "pillbox elevator 3",
        access = {
            business = {},
            job = {
                ["DR"] = true,
                ["PD"] = true
            }
        },
        dec = "hospital",
        active = true
    }   
}