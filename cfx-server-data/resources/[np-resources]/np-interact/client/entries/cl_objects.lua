local Entries = {}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChicken' },
    data = {
        {
            id = 'chicken',
            label = "Slaught Chicken",
            icon = "circle",
            event = "portionthechicken",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isSafe' },
    data = {
        {
            id = 'RobSafe',
            label = "Smash!",
            icon = "hammer",
            event = "np-heists:safe:rob",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'use_gas',
            label = " Use Gas Pump",
            icon = "gas-pump",
            event = "np-fuel:SelectFuel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
        isEnabled = function(pEntity, pContext)
            return not exports['np-fuel']:hasNozle()
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'return_hose',
            label = "Return Hose",
            icon = "hand-holding",
            event = "np-fuel:ReturnNozel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
        isEnabled = function(pEntity, pContext)
            return exports['np-fuel']:hasNozle()
        end
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChickenPack' },
    data = {
        {
            id = 'ChickenPack',
            label = "Pack the Chicken",
            icon = "circle",
            event = "packingchicken",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.7 },
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isYogaMat' },
    data = {
        {
            id = 'yoga',
            label = "Yoga",
            icon = "circle",
            event = "np-healthcare:yoga",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return IsEntityTouchingEntity(PlayerPedId(), pEntity)
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isExercise' },
    data = {
        {
            id = 'weights',
            label = "Weights",
            icon = "circle",
            event = "np-healthcare:exercise",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.2 },
    }
}

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isSmokeMachineTrigger' },
--     data = {
--         {
--             id = 'smoke_machine',
--             label = "Smoke Machine",
--             icon = "circle",
--             event = "np-stripclub:smokemachine",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 1.2 },
--     }
-- }

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFuelPump' },
    data = {
        {
            id = 'jerrycan_refill',
            label = "Refill Can",
            icon = "circle",
            event = "vehicle:refuel:showMenu",
            parameters = { isJerryCan = true }
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return HasWeaponEquipped(GetHashKey('WEAPON_PetrolCan'))
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isVendingMachine' },
    data = {
        {
            id = 'vending_machine',
            label = "Browse",
            icon = "shopping-basket",
            event = "shops:food",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isHotDogStand' },
    data = {
        {
            id = 'vending_machine_hotdog',
            label = "Menu",
            icon = "shopping-basket",
            event = "shops:hotdog",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFruitStand' },
    data = {
        {
            id = 'vending_machine_fruitstand',
            label = "Purchase Fruits",
            icon = "shopping-basket",
            event = "shops:fruits",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isBurgerStand' },
    data = {
        {
            id = 'vending_machine_burger',
            label = "Menu",
            icon = "shopping-basket",
            event = "shops:burger",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isGumball' },
    data = {
        {
            id = 'vending_machine_gumball',
            label = "Put a Dollar in",
            icon = "shopping-basket",
            event = "kosta:gumball",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isChair' },
    data = {
        {
            id = 'sit_on_chair',
            label = _L("interact-sit", "Sit"),
            icon = "chair",
            event = "np-emotes:sitOnChair",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isStopSign' },
    data = {
        {
            id = 'steal_sign',
            label = "Steal!",
            icon = "hammer",
            event = "np-usableprops:stealStopSign",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
}


--[[Entries[#Entries + 1] = {
    type = 'model',
    group = { 'isStopSign' },
    data = {
        {
            id = 'np-usableprops:stealStopSign',
            label = "Steal!",
            icon = "hammer",
            event = "np-usableprops:stealStopSign",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.5 }
    }
  }]]


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isATM' },
    data = {
        {
            id = 'use_atm',
            label = "Use ATM",
            icon = "credit-card",
            event = "np-ui:openATM",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isJewel' },
  data = {
      {
          id = 'Jewlery',
          label = "Thermite Vent",
          icon = "circle",
          event = "jewel:card",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 3.0 }
  }
}

--[[Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isHunting' },
  data = {
      {
          id = 'Hunting',
          label = "Start Hunting",
          icon = "circle",
          event = "np-hunting:start",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isHuntingStop' },
  data = {
      {
          id = 'HuntingStop',
          label = "Return Hunting Equipment",
          icon = "circle",
          event = "np-hunting:stop",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}]]

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBox' },
  data = {
      {
          id = 'Boxes',
          label = "Search Box",
          icon = "circle",
          event = "np-dumpster",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBox2' },
  data = {
      {
          id = 'Boxes',
          label = "Search Box",
          icon = "circle",
          event = "np-dumpster",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBox3' },
  data = {
      {
          id = 'Boxes',
          label = "Search Box",
          icon = "circle",
          event = "np-dumpster",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBox4' },
  data = {
      {
          id = 'Boxes',
          label = "Search Box",
          icon = "circle",
          event = "np-boxes1",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 2.0 }
  }
}



Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeedPlant' },
    data = {
        {
            id = 'weed',
            label = _L("interact-weedplant-check", "Check"),
            icon = "cannabis",
            event = "np-weed:checkPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isLrgWeedPlant' },
    data = {
        {
            id = 'weed2',
            label = _L("interact-weedplant-harvest", "Harvest"),
            icon = "hand-paper",
            event = "np-weed:pickPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBeehive' },
  data = {
      {
          id = 'beehive1',
          label = _L("interact-beehive-check", "Check"),
          icon = "archive",
          event = "np-beekeeping:checkBeehive",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 7.0 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isBeehive' },
  data = {
      {
          id = 'beehive2',
          label = _L("interact-beehive-harvest", "Harvest"),
          icon = "hand-holding-water",
          event = "np-beekeeping:harvestHive",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 7.0 }
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin2' },
    data = {
        {
            id = 'Pin2',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:secpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin3' },
    data = {
        {
            id = 'Pin3',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:thirdpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}
Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPin4' },
    data = {
        {
            id = 'Pin4',
            label = "Enter PinCode",
            icon = "circle",
            event = "dark-vaultrob:lower:fourthpindoor",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

--[[Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_ch_cash_trolly_01c` },
  data = {
      {
          id = 'trolleygrab',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:firsttrolley",
          parameters = { type = "cash" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_ch_gold_trolly_01c` },
  data = {
      {
          id = 'trolleygrabgold',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:secondtrolley",
          parameters = { type = "gold" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'model',
  group = { `ch_prop_cash_trolly_01c` },
  data = {
      {
          id = 'trolleygrab2',
          label = "Grab it!",
          icon = "hand-holding",
          event = "dark-vaultrob:upper:thirdtrolley",
          parameters = { type = "cash" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}]]

Entries[#Entries + 1] = {
  type = 'model',
  group = { 'isMech' },
  data = {
      {
          id = 'mech:craft',
          label = "Start Crafting",
          icon = "circle",
          event = "mech:craft",
          parameters = {}
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}


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
