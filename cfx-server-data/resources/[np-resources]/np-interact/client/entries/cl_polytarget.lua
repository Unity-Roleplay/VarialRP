local Entries = {}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:grabDrink' },
    data = {
        {
            id = "bar:grabDrink",
            label = "Grab Drink",
            icon = "circle",
            event = "np-stripclub:peekAction",
            parameters = { action = "grabDrink" }
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'harm_storage' },
    data = {
        {
            id = "harm_storage",
            label = "Storage",
            icon = "circle",
            event = "harmony:stash",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mdm_craft' },
    data = {
        {
            id = "mdm_craft",
            label = "What's this?",
            icon = "circle",
            event = "mdm:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mango_stash' },
    data = {
        {
            id = "mango_stash",
            label = "Open Storage",
            icon = "circle",
            event = "mango:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mango_craft' },
    data = {
        {
            id = "mango_craft",
            label = "Inspect",
            icon = "circle",
            event = "mango:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mat_refine' },
    data = {
        {
            id = "mat_refine",
            label = "Refine Materials",
            icon = "hammer",
            event = "kosta:refine",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'guerro_stash' },
    data = {
        {
            id = "guerro_stash",
            label = "Open Storage",
            icon = "circle",
            event = "guerro:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'guerro_craft' },
    data = {
        {
            id = "guerro_craft",
            label = "Inspect",
            icon = "circle",
            event = "guerro:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'strokers_stash' },
    data = {
        {
            id = "strokers_stash",
            label = "Open Storage",
            icon = "circle",
            event = "strokers:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'strokers_craft' },
    data = {
        {
            id = "strokers_craft",
            label = "Inspect",
            icon = "circle",
            event = "strokers:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang_stash' },
    data = {
        {
            id = "gang_stash",
            label = "Open Storage",
            icon = "circle",
            event = "gang:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang_craft' },
    data = {
        {
            id = "gang_craft",
            label = "Inspect",
            icon = "circle",
            event = "gang:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang2_stash' },
    data = {
        {
            id = "gang2_stash",
            label = "Open Storage",
            icon = "circle",
            event = "gang2:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang2_craft' },
    data = {
        {
            id = "gang2_craft",
            label = "Inspect",
            icon = "circle",
            event = "gang2:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:openFridge' },
    data = {
        {
            id = "bar:openFridge",
            label = "Open Fridge",
            icon = "circle",
            event = "np-stripclub:peekAction",
            parameters = { action = "openFridge" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:chargeCustomer' },
  data = {
      {
          id = "tbar:chargeCustomer",
          label = "Charge Customer",
          icon = "dollar-sign",
          event = "np-tavern:peekAction",
          parameters = { action = "chargeCustomer" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:getBag' },
  data = {
      {
          id = "tbar:getBag",
          label = "Grab Bag",
          icon = "circle",
          event = "np-tavern:peekAction",
          parameters = { action = "getBag" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:craftToxicMenu' },
  data = {
      {
          id = "tbar:craftToxicMenu",
          label = "Be Toxic",
          icon = "circle",
          event = "np-tavern:peekAction",
          parameters = { action = "craftToxicMenu" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

-- Entries[#Entries + 1] = {
--     type = 'polytarget',
--     group = { 'townhall:gavel' },
--     data = {
--         {
--             id = "townhall:gavel",
--             label = "Use Gavel",
--             icon = "circle",
--             event = "np-gov:gavel",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 1.5 }
--     }
-- }


--[[Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'officer_sign_in' },
    data = {
        {
            id = "officer_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = 'np-duty:PoliceMenu',
            parameters = { name = "police" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}]]

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'officer_sign_in' },
    data = {
        {
            id = "officer_sign_in",
            label = _L("interact-duty-action", "Duty Action"),
            icon = "circle",
            event = "np-signin:peekAction",
            parameters = { name = "officer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ems_sign_in' },
    data = {
        {
            id = "ems_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "np-signin:peekAction",
            parameters = { name = "ems" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'Laptop_hack' },
    data = {
        {
            id = 'Laptop_hack',
            label = "Start Hack",
            icon = "circle",
            event = "dark-vaultrob:lower:laptoppin",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'meth_start' },
    data = {
        {
            id = "meth_start",
            label = "Start Cooking",
            icon = "circle",
            event = "meth:start",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'meth_packing' },
    data = {
        {
            id = "meth_packing",
            label = "Start Packing",
            icon = "circle",
            event = "meth:packing",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'meth_finish' },
    data = {
        {
            id = "meth_finish",
            label = "Start Bagging",
            icon = "circle",
            event = "meth:finish",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'crack_start' },
    data = {
        {
            id = "crack_start",
            label = "Start Mixing",
            icon = "circle",
            event = "crack:start",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'start_fryers' },
    data = {
        {
            id = "start_fryers",
            label = "Fry Fries",
            icon = "circle",
            event = "np-burgershot:startfryer",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_craft' },
    data = {
        {
            id = "burger_craft",
            label = "Make Juicy Burger",
            icon = "circle",
            event = "burgershot:craft",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_cook' },
    data = {
        {
            id = "burger_cook",
            label = "Cook Patty",
            icon = "circle",
            event = "np-burgershot:startprocess3",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_drink' },
    data = {
        {
            id = "burger_drink",
            label = "Make Shakes",
            icon = "circle",
            event = "np-burgershot:makeshake",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_cola' },
    data = {
        {
            id = "burger_cola",
            label = "Make Cola's",
            icon = "circle",
            event = "np-burgershot:getcola",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_shelf' },
    data = {
        {
            id = "burger_shelf",
            label = "Open Rack",
            icon = "circle",
            event = "open:storage",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 3.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_fridge' },
    data = {
        {
            id = "burger_fridge",
            label = "Open Fridge",
            icon = "circle",
            event = "open:storage",
            parameters = { name = "burger_shot"}
        }
    },
    job = {"burger_shot"},
    options = {
        distance = { radius = 3.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'burger_register' },
    data = {
        {
            id = "burger_register",
            label = "Charge Customer",
            icon = "circle",
            event = "burgershot:register",
            parameters = {"1"}
		},
		{
            id = "burger_receipt",
            label = "Make Payment",
            icon = "circle",
            event = "burgershot:get:receipt",
            parameters = {"1"}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'casino_enter' },
    data = {
        {
            id = "casino_enter",
            label = "Enter Casino",
            icon = "circle",
            event = "casino:enter",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'spin_wheel' },
    data = {
        {
            id = "spin_wheel",
            label = "Spin The Wheel",
            icon = "circle",
            event = "attempt:spin-in",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'drift_garage' },
    data = {
        {
            id = "drift_garage",
            label = "Grab a Car",
            icon = "circle",
            event = "drift:garage",
            parameters = { name = "drift_instructor"}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

--[[Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'garbage_start' },
    data = {
        {
            id = "garbage_start",
            label = "Clock In",
            icon = "circle",
            event = "np-jobs:garbagestart:menu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}]]

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'comic_store' },
    data = {
        {
            id = "comic_store",
            label = "Become a Nerd",
            icon = "circle",
            event = "pokemon:buy",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'court_house' },
    data = {
        {
            id = "court_house",
            label = "Enter CourtHouse",
            icon = "circle",
            event = "courthouse:enter",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'court_houseexit' },
    data = {
        {
            id = "court_houseexit",
            label = "Exit CourtHouse",
            icon = "circle",
            event = "courthouse:exit",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'meth_sell' },
    data = {
        {
            id = "meth_sell",
            label = "Sell that shit",
            icon = "circle",
            event = "meth:sell",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'crack_sell' },
    data = {
        {
            id = "crack_sell",
            label = "Sell that shit",
            icon = "circle",
            event = "crack:sell",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'weed_store' },
    data = {
        {
            id = "weed_store",
            label = "Weed Store",
            icon = "circle",
            event = "bestbuds:shop",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}




Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'slushy_make' },
    data = {
        {
            id = "slushy_make",
            label = "Make God Slushy",
            icon = "circle",
            event = "slushy:general",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ap_search' },
    data = {
        {
            id = "ap_search",
            label = "What the fuck??",
            icon = "circle",
            event = "prisonap:general",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jail_food' },
    data = {
        {
            id = "jail_food",
            label = "Grab some Grub",
            icon = "circle",
            event = "pfood:general",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'arcade_music' },
    data = {
        {
            id = "arcade_music",
            label = "Slap Music",
            icon = "circle",
            event = "arcade:request:song",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'arcade_volume' },
    data = {
        {
            id = "arcade_volume",
            label = "Volume Control",
            icon = "circle",
            event = "arcade:change:volume",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mine_1' },
    data = {
        {
            id = "mine_1",
            label = "Start Mining",
            icon = "circle",
            event = "miningmenu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mine_2' },
    data = {
        {
            id = "mine_2",
            label = "Start Mining",
            icon = "circle",
            event = "miningmenu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

--[[Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mine_sell' },
    data = {
        {
            id = "mine_sell",
            label = "Sell your Hardwork",
            icon = "circle",
            event = "mining-sell:items",
            parameters = {"goldbar"}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}]]

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'hunting_sell' },
    data = {
        {
            id = "hunting_sell",
            label = "Sell Carcasses",
            icon = "circle",
            event = "hunting:sell",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mech_storage' },
    data = {
        {
            id = "mech_storage",
            label = "Open Storage",
            icon = "circle",
            event = "open:storage3",
            parameters = { name = "auto_exotics"}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mech_craft' },
    data = {
        {
            id = "mech_craft",
            label = "Mech Craft",
            icon = "circle",
            event = "mech:craft",
            parameters = { name = "auto_exotics"}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mech_craft2' },
    data = {
        {
            id = "mech_craft2",
            label = "Mech Craft",
            icon = "circle",
            event = "mech:craft",
            parameters = { name = "harmony_autos"}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mech_storage2' },
    data = {
        {
            id = "mech_storage2",
            label = "Open Storage",
            icon = "circle",
            event = "open:storage2",
            parameters = { name = "harmony_autos"}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'mech_internal' },
    data = {
        {
            id = "mech_internal",
            label = "Check Supply",
            icon = "circle",
            event = "mech:check:internal:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'roof_up' },
    data = {
        {
            id = "roof_up",
            label = "Take Elevator Up",
            icon = "circle",
            event = "hospital:roof",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'roof_exit' },
    data = {
        {
            id = "roof_exit",
            label = "Take Elevator Down",
            icon = "circle",
            event = "hospital:roofexit",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'hos_lower' },
    data = {
        {
            id = "hos_lower",
            label = "Enter the Elevator to the Bottom Floor",
            icon = "circle",
            event = "hospital:lower",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'hos_upper' },
    data = {
        {
            id = "hos_upper",
            label = "Take Elevator Up",
            icon = "circle",
            event = "hospital:elevatorup",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robbery_seller' },
    data = {
        {
            id = "robbery_seller",
            label = "Time to be poor",
            icon = "credit-card",
            event = "speaktowean",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'serial_search' },
    data = {
        {
            id = "serial_search",
            label = "Lookup Serial Number",
            icon = "circle",
            event = "serial:search",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'prison_services' },
    data = {
        {
            id = "prison_services",
            label = "Prison Services",
            icon = "circle",
            event = "np-jailbreak:services",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'checkin' },
    data = {
        {
            id = "checkin",
            label = "Check In",
            icon = "circle",
            event = "attempt:check-in",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'casino_clock_in' },
    data = {
        {
            id = "casino_clock_in",
            label = "Lets get to Work",
            icon = "circle",
            event = "casino:duty",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'possessions' },
    data = {
        {
            id = "possessions",
            label = "Grab my Shit",
            icon = "circle",
            event = "jailbreak:reclaimitems",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'pdm_open_catalog' },
    data = {
        {
            id = "pdm_open_catalog",
            label = "Open Catalog (PDM)",
            icon = "car",
            event = "np-showrooms:enterExperience",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'pdm_open_catalog2' },
    data = {
        {
            id = "pdm_open_catalog2",
            label = "Open Catalog (Tuners)",
            icon = "car",
            event = "np-showrooms-tuner:enterExperience",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'casino_shop' },
    data = {
        {
            id = "casino_shop",
            label = "Browse",
            icon = "shopping-cart",
            event = "taco:shop",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 4.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'nerd_shop' },
    data = {
        {
            id = "nerd_shop",
            label = "Browse",
            icon = "shopping-cart",
            event = "devious:darkmarket",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'Loot_Box1' },
    data = {
        {
            id = "Loot_Box1",
            label = "Loot Weapons",
            icon = "circle",
            event = "efe:silahver",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'Loot_Box2' },
    data = {
        {
            id = "Loot_Box2",
            label = "Loot Weapons",
            icon = "circle",
            event = "efe:silahveriki",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'Loot_Box3' },
    data = {
        {
            id = "Loot_Box3",
            label = "Loot Weapons",
            icon = "circle",
            event = "efe:thirdcrate",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'Bomb_Door' },
    data = {
        {
            id = "Bomb_Door",
            label = "Override System",
            icon = "circle",
            event = "efe:pediyurut",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'cash_trolley' },
    data = {
        {
            id = "cash_trolley",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:upper:firsttrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'cash_gold' },
    data = {
        {
            id = "cash_gold",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:upper:secondtrolley",
            parameters = {"gold"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'cash_trolley2' },
    data = {
        {
            id = "cash_trolley2",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:upper:thirdtrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lcash_trolley' },
    data = {
        {
            id = "lcash_trolley",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:firsttrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lcash_trolley2' },
    data = {
        {
            id = "lcash_trolley2",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:fourthlwtrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lgold_trolley' },
    data = {
        {
            id = "lgold_trolley",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:thirdlwtrolley",
            parameters = {"gold"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lgold_trolley2' },
    data = {
        {
            id = "lgold_trolley2",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:sextrolley",
            parameters = {"gold"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lcash_trolley3' },
    data = {
        {
            id = "lcash_trolley3",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:fifthlwtrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'lcash_trolley4' },
    data = {
        {
            id = "lcash_trolley4",
            label = "Grab it!",
            icon = "circle",
            event = "dark-vaultrob:lower:sixthlwtrolley",
            parameters = {"cash"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot1' },
    data = {
        {
            id = "jewelry_rob_spot1",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions1",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot2' },
    data = {
        {
            id = "jewelry_rob_spot2",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions2",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot3' },
    data = {
        {
            id = "jewelry_rob_spot3",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions3",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot4' },
    data = {
        {
            id = "jewelry_rob_spot4",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions4",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot5' },
    data = {
        {
            id = "jewelry_rob_spot5",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions5",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot6' },
    data = {
        {
            id = "jewelry_rob_spot6",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions6",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot7' },
    data = {
        {
            id = "jewelry_rob_spot7",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions7",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot8' },
    data = {
        {
            id = "jewelry_rob_spot8",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions8",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot9' },
    data = {
        {
            id = "jewelry_rob_spot9",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions9",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot10' },
    data = {
        {
            id = "jewelry_rob_spot10",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions10",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot11' },
    data = {
        {
            id = "jewelry_rob_spot11",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions11",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot12' },
    data = {
        {
            id = "jewelry_rob_spot12",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions12",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'jewelry_rob_spot13' },
    data = {
        {
            id = "jewelry_rob_spot13",
            label = "Smash!",
            icon = "circle",
            event = "dark-jewelry:jewelry:SmashFunctions13",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target1' },
    data = {
        {
            id = "store_safe_target1",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_1",
            parameters = {}
        },
        {
            id = "store_safe_target1s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_1",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target2' },
    data = {
        {
            id = "store_safe_target2",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_2",
            parameters = {}
        },
        {
            id = "store_safe_target2s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_2",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target3' },
    data = {
        {
            id = "store_safe_target3",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_3",
            parameters = {}
        },
        {
            id = "store_safe_target3s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_3",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target4' },
    data = {
        {
            id = "store_safe_target4",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_4",
            parameters = {}
        },
        {
            id = "store_safe_target4s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_4",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target5' },
    data = {
        {
            id = "store_safe_target5",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_5",
            parameters = {}
        },
        {
            id = "store_safe_target5s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_5",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target6' },
    data = {
        {
            id = "store_safe_target6",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_6",
            parameters = {}
        },
        {
            id = "store_safe_target6s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_6",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target7' },
    data = {
        {
            id = "store_safe_target7",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_7",
            parameters = {}
        },
        {
            id = "store_safe_target7s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_7",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target8' },
    data = {
        {
            id = "store_safe_target8",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_8",
            parameters = {}
        },
        {
            id = "store_safe_target8s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_8",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target9' },
    data = {
        {
            id = "store_safe_target9",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_9",
            parameters = {}
        },
        {
            id = "store_safe_target9s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_9",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target10' },
    data = {
        {
            id = "store_safe_target10",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_10",
            parameters = {}
        },
        {
            id = "store_safe_target10s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_10",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target11' },
    data = {
        {
            id = "store_safe_target11",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_11",
            parameters = {}
        },
        {
            id = "store_safe_target11s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_11",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target12' },
    data = {
        {
            id = "store_safe_target12",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_12",
            parameters = {}
        },
        {
            id = "store_safe_target12s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_12",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target13' },
    data = {
        {
            id = "store_safe_target13",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_13",
            parameters = {}
        },
        {
            id = "store_safe_target13s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_13",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target14' },
    data = {
        {
            id = "store_safe_target14",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_14",
            parameters = {}
        },
        {
            id = "store_safe_target14s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_14",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target15' },
    data = {
        {
            id = "store_safe_target15",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_15",
            parameters = {}
        },
        {
            id = "store_safe_target15s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_15",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target16' },
    data = {
        {
            id = "store_safe_target16",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_16",
            parameters = {}
        },
        {
            id = "store_safe_target16s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_16",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target17' },
    data = {
        {
            id = "store_safe_target17",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_17",
            parameters = {}
        },
        {
            id = "store_safe_target17s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_17",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target18' },
    data = {
        {
            id = "store_safe_target18",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_18",
            parameters = {}
        },
        {
            id = "store_safe_target18s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_18",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target19' },
    data = {
        {
            id = "store_safe_target19",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_19",
            parameters = {}
        },
        {
            id = "store_safe_target19s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_19",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'store_safe_target20' },
    data = {
        {
            id = "store_safe_target20",
            label = "Open Case",
            icon = "fas fa-box-open",
            event = "dark-storerob:stores:store_openSafe_20",
            parameters = {}
        },
        {
            id = "store_safe_target20s",
            label = "Crack Case",
            icon = "fas fa-user-secret",
            event = "dark-storerob:stores:store_safe_20",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 },
        
    }
} 

--[[Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore1' },
    data = {
        {
            id = "robstore1",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore1s' },
    data = {
        {
            id = "robstore1s",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore2' },
    data = {
        {
            id = "robstore2",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore2s' },
    data = {
        {
            id = "robstore2s",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore3' },
    data = {
        {
            id = "robstore3",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore4' },
    data = {
        {
            id = "robstore4",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore4s' },
    data = {
        {
            id = "robstore4s",
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore5' },
    data = {
        {
            id = "robstore5",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe5",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore6' },
    data = {
        {
            id = "robstore6",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe6",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore6s' },
    data = {
        {
            id = "robstore6s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe6s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore7' },
    data = {
        {
            id = "robstore7",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe7",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore7s' },
    data = {
        {
            id = "robstore7s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe7s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore8' },
    data = {
        {
            id = "robstore8",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe8",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore8s' },
    data = {
        {
            id = "robstore8s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe8s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore9' },
    data = {
        {
            id = "robstore9",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe9",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore10' },
    data = {
        {
            id = "robstore10",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe10",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore10s' },
    data = {
        {
            id = "robstore10s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe10s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore11' },
    data = {
        {
            id = "robstore11",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe11",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore11s' },
    data = {
        {
            id = "robstore11s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe11s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore12' },
    data = {
        {
            id = "robstore12",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe12",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore12s' },
    data = {
        {
            id = "robstore12s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe12s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore13' },
    data = {
        {
            id = "robstore13",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe13",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore13s' },
    data = {
        {
            id = "robstore13s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe13s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore14' },
    data = {
        {
            id = "robstore14",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe14",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore15' },
    data = {
        {
            id = "robstore15",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe15",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore16' },
    data = {
        {
            id = "robstore16",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe16",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore16s' },
    data = {
        {
            id = "robstore16s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe16s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore17' },
    data = {
        {
            id = "robstore17",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe17",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore17s' },
    data = {
        {
            id = "robstore17s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe17s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore18' },
    data = {
        {
            id = "robstore18",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe18",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore18s' },
    data = {
        {
            id = "robstore18s",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe18s",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} 

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'robstore19' },
    data = {
        {
            id = "robstore19",
            label = "Smash!",
            icon = "hammer",
            event = "dark-storerob:stores:crackwritesafe19",
            parameters = {}
        },
        
    },
    options = {
        distance = { radius = 0.75 },
        
    }
} ]]

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'cash_in' },
    data = {
        {
            id = "cash_in",
            label = "Cash in Receipts",
            icon = "circle",
            event = "np-foodchain:cash:in",
            parameters = {}
        },
        {
            id = "paycheck_kosta",
            label = "Cash Checks",
            icon = "circle",
            event = "kosta:paycheck",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'pillbox_checkin' },
    data = {
        {
            id = "pillbox_checkin",
            label = "Check In",
            icon = "circle",
            event = "np-hospitalization:checkin",
            parameters = {}
        },
        {
            id = "enable_checkin",
            label = "Turn off Nancy",
            icon = "circle",
            event = "attempt:change:check-in",
            parameters = {"ems"}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_cleaning_job_1' },
    data = {
        {
            id = "np_cleaning_job_1",
            label = "Clean this Mess",
            icon = "circle",
            event = "np-jail:work-clean-1",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_cleaning_job_2' },
    data = {
        {
            id = "np_cleaning_job_2",
            label = "Clean this Mess",
            icon = "circle",
            event = "np-jail:work-clean-2",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_cleaning_job_3' },
    data = {
        {
            id = "np_cleaning_job_3",
            label = "Clean this Mess",
            icon = "circle",
            event = "np-jail:work-clean-3",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_cleaning_job_4' },
    data = {
        {
            id = "np_cleaning_job_4",
            label = "Clean this Mess",
            icon = "circle",
            event = "np-jail:work-clean-4",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'select_job' },
    data = {
        {
            id = "select_job",
            label = "Start Work",
            icon = "circle",
            event = "np-jobs:jail-jobs:menu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang3_stash' },
    data = {
        {
            id = "gang3_stash",
            label = "Open Storage",
            icon = "circle",
            event = "gang3:storage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'boosting_prepscratch' },
    data = {
        {
            id = "boosting_prepscratch",
            label = "Prepare Vin Scratch",
            icon = "laptop",
            event = "ethicalpixel-boosting:client:UseComputer",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 },
        isEnabled = function(entity)
            return exports['ethicalpixel-boosting']:pCanUseComputer()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'gang3_craft' },
    data = {
        {
            id = "gang3_craft",
            label = "Inspect",
            icon = "circle",
            event = "gang3:craft",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_1' },
    data = {
        {
            id = "np_electrical_job_1",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-1",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_2' },
    data = {
        {
            id = "np_electrical_job_2",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-2",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_2' },
    data = {
        {
            id = "np_electrical_job_2",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-2",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_3' },
    data = {
        {
            id = "np_electrical_job_3",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-3",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_4' },
    data = {
        {
            id = "np_electrical_job_4",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-4",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_5' },
    data = {
        {
            id = "np_electrical_job_6",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-6",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_7' },
    data = {
        {
            id = "np_electrical_job_7",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-7",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'np_electrical_job_8' },
    data = {
        {
            id = "np_electrical_job_8",
            label = "Start Work",
            icon = "circle",
            event = "np-jail:work-box-8",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'card_door' },
    data = {
        {
            id = "card_door",
            label = "Swipe Card",
            icon = "circle",
            event = "efe:thirstdoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'pd_shared_garage_reset' },
    data = {
        {
            id = "pd_shared_garage_reset",
            label = "Reset Garage",
            icon = "circle",
            event = "np-garages:resetpdgarage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

-- Entries[#Entries + 1] = {
--     type = 'polytarget',
--     group = { 'ak_storage' },
--     data = {
--         {
--             id = "ak_storage",
--             label = "Open Storage",
--             icon = "circle",
--             event = "ak_customs:Stash",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 3.0 }
--     }
-- }

-- Entries[#Entries + 1] = {
--     type = 'polytarget',
--     group = { 'weap_crafting' },
--     data = {
--         {
--             id = "weap_crafting",
--             label = "Inspect",
--             icon = "circle",
--             event = "illegal:crafting",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 3.0 }
--     }
-- }






Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)


exports["np-polytarget"]:AddBoxZone("pd_shared_garage_reset", vector3(443.01, -973.6, 25.7), 2, 2, { -- PD shared reset
    heading=0,
    minZ=25.7 - 1,
    maxZ=25.7 + 1,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("mdm_craft", vector3(-1582.822, -278.280, 55.09), 2.5, 1.35, { -- Mandem Craft
    heading=282.3,
    minZ=53,
    maxZ=56,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("mango_craft", vector3(849.383, -2881.550, 11.321), 0.5, 0.5, { -- Mango Craft
    heading=268.2,
    minZ=10,
    maxZ=12,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("mango_stash", vector3(844.55,-2880.81, 11.48), 2.5, 1.35, { -- Mango Stash
    heading=175.3,
    minZ=10,
    maxZ=12,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("mat_refine", vector3(-33.868, -1040.714, 28.399), 0.5, 0.5, { -- Material Refining
    heading=68.9,
    minZ=28,
    maxZ=29,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("vpn_spot", vector3(-218.552, -1333.907, 30.759), 1.0, 1.0, { -- VPN Purchasing
    heading=267.7,
    minZ=30,
    maxZ=31,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("guerro_craft", vector3(488.184, -1966.342, 24.888), 0.5, 0.5, { -- Guerro Craft
    heading=118.2,
    minZ=24,
    maxZ=26,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("guerro_stash", vector3(489.716, -1965.143, 25.299), 1.35, 1.35, { -- Guerro Stash
    heading=38.1,
    minZ=24,
    maxZ=26,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("strokers_stash", vector3(578.49, -1870.1, 25.27), 2.4, 1, { -- Guerro Stash
    heading=335.5,
    minZ=110,
    maxZ=112,
    debugPoly=false
})

exports["np-polytarget"]:AddBoxZone("strokers_craft", vector3(2463.16, 3452.02, 50.11), 0.6, 1.2, {-- Guerro Stash
    heading=5,
    --debugPoly=true,
    minZ=47.31,
    maxZ=51.31
})


exports["np-polytarget"]:AddBoxZone("gang_stash", vector3(1599.06, -1669.06, 88.22), 1.6, 1, { -- Guerro Stash
    heading=20,
    --debugPoly=true
})

exports["np-polytarget"]:AddBoxZone("gang_craft", vector3(1598.36, -1667.14, 88.22), 0.6, 1, {-- Guerro Stash
    heading=20,
    --debugPoly=true,
    minZ=85.42,
    maxZ=89.42
})

exports["np-polytarget"]:AddBoxZone("gang2_stash", vector3(873.02, -1368.5, 26.32), 1.4, 1, { -- Guerro Stash
    heading=330,
    --debugPoly=true,
    minZ=23.52,
    maxZ=27.52
})

exports["np-polytarget"]:AddBoxZone("gang2_craft", vector3(873.91, -1366.78, 26.32), 0.6, 1.4, { -- Guerro Stash
    heading=330,
    --debugPoly=true,
    minZ=23.32,
    maxZ=27.32
})

exports["np-polytarget"]:AddBoxZone("gang3_stash", vector3(1609.23, 3774.43, 34.87), 1, 1, { -- black family Stash
    heading=305,
    minZ=34.87-1,
    maxZ=34.87+1
    --debugPoly=true
})

exports["np-polytarget"]:AddBoxZone("gang3_craft", vector3(1607.63, 3776.36, 34.69), 1, 1, { -- Guerro Stash
    heading=305,
    --debugPoly=true,
    minZ=34.87-1,
    maxZ=34.87+1
})

exports["np-polytarget"]:AddBoxZone("boosting_prepscratch", vector3(471.6, -1311.0, 29.22), 0.5, 0.5, {-- Guerro Stash
    heading=25,
    --debugPoly=true,
    minZ=25.62,
    maxZ=29.62
})