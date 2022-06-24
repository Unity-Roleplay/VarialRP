local Entries = {}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPedShopGeneral' },
    data = {
        {
            id = "shopkeeper",
            label = "Purchase goods",
            icon = "fas fa-circle",
            event = "np-npcs:ped:keeper",
            parameters = { "2" }
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isGarbageMan' },
    data = {
        {
            id = "garbage_man",
            label = "Start Job",
            icon = "fas fa-circle",
            event = "np-jobs:garbagestart:menu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

-- Entries[#Entries + 1] = {
--     type = 'flag',
--     group = { 'isOxyRun' },
--     data = {
--         {
--             id = "oxy_run",
--             label = "Start Job",
--             icon = "fas fa-user-secret",
--             event = "oxyrun:client:sendToOxy",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 5.5 }
        
--     }
-- }


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isScrapStart' },
    data = {
        {
            id = "start_scrap",
            label = "Sign In",
            icon = "fas fa-circle",
            event = "unwind-carscrap:StarRegularMission",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}




Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isApartment' },
    data = {
        {
            id = "city_hall_npc_m",
            label = "Upgrade Apartment",
            icon = "fas fa-circle",
            event = "apartment:upgrades",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeedBuy' },
    data = {
        {
            id = "weed_buy",
            label = "Buy Weed",
            icon = "fas fa-circle",
            event = "weed:store",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeedPacking' },
    data = {
        {
            id = 'weed_packing',
            label = "Package Goods",
            icon = "fas fa-user-secret",
            event = "np-weed:preparePackage",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isIDCard' },
    data = {
        {
            id = "id_card",
            label = "Get ID",
            icon = "fas fa-circle",
            event = "courthouse:idbuy",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isMineSells' },
    data = {
        {
            id = "mine_sell",
            label = "Sell Mining",
            icon = "fas fa-circle",
            event = "np-jobs:miningsell:menu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 5.5 }
        
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWeaponShopKeeper' },
    data = {
        {
            id = "weaponShopKeeper",
            label = "Purchase weapons",
            icon = "fas fa-circle",
            event = "weapon:general",
            parameters = { "5" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isHuntingStore' },
    data = {
        {
            id = "huntingShopKeeper",
            label = "Purchase equipment",
            icon = "fas fa-circle",
            event = "np-npcs:ped:keeper",
            parameters = { "25" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}




--[[Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isWeedShopKeeper'},
    data = {
        {
            id = "weedshop_keeper",
            label = "Purchase Weed",
            icon = "cannabis",
            event = "weapon:general",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}]]


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isNPC' },
    data = {
        {
            id = "digital_den_npc",
            label = "Open Shop",
            icon = "circle",
            event = "np-npcs:ped:openDigitalDenShop",
        }
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"digital_den_npc"}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedShopMMall'},
    data = {
        {
            id = "MegMall",
            label = "Shop",
            icon = "fas fa-circle",
            event = "toolshop:general",
            parameters = {"2"}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedShopYouTool'},
    data = {
        {
            id = "YouTool",
            label = "Shop",
            icon = "fas fa-circle",
            event = "toolshop:general",
            parameters = {"2"}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedShopRecycle'},
    data = {
        {
            id = "recycle_exchange",
            label = "Trade",
            icon = "recycle",
            event = "np-npcs:ped:exchangeRecycleMaterial",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedDigital'},
    data = {
        {
            id = "ditigal_den",
            label = "Shop",
            icon = "circle",
            event = "shops:digitalden",
            parameters = {"1312"}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedHuntingStore'},
    data = {
        {
            id = "hunting_store",
            label = "Browse",
            icon = "shopping-basket",
            event = "np-hunting:start",
            parameters = {"2"}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isPedAnimalArk'},
    data = {
        {
            id = "animal_ark",
            label = "Sell Pelts",
            icon = "paw",
            event = "hunting:sell",
            parameters = {"2"}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isFishMarket'},
    data = {
        {
            id = "fish_market",
            label = "Sell Fish",
            icon = "fish",
            event = "np-npcs:ped:sellFish",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 3.0},
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isImpoundClockIn'},
    data = {
        {
            id = "tow_clock",
            label = "Clock in/out",
            icon = "clipboard-list",
            event = "np-jobs:towduty",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0},
        isEnabled = function(entity)
            return not IsPedAPlayer(entity) and exports["np-polyzone"]:IsInsideEvent(entity)
        end
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isMethHouse'},
    data = {
        {
            id = "methhouse_enter",
            label = "Enter I Guess",
            icon = "circle",
            event = "meth:enter",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}



Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isMethHouseExit'},
    data = {
        {
            id = "methhouse_exit",
            label = "Leave Meth Lab",
            icon = "circle",
            event = "meth:exit",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isCrackHouse'},
    data = {
        {
            id = "crack_houseenter",
            label = "Enter",
            icon = "circle",
            event = "crack:enter",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}



Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isCrackHouseOut'},
    data = {
        {
            id = "crack_houseexit",
            label = "Leave",
            icon = "circle",
            event = "crack:exit",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isSell'},
    data = {
        {
            id = "sell_goods",
            label = "Sell your shit",
            icon = "circle",
            event = "np-pawnshop:sell",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'entity',
    group = { 1 },
    data = {
        {
            id = "bobcatblowc4",
            label = _L("interact-bobcat-blowdoor", "Blow the Door!"),
            icon = "circle",
            event = "np-heists:interactBobcatC4Npc",
            parameters = {},
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity)
          return DecorGetBool(pEntity, "BobcatC4Ped")
        end,
    }
  }

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isEMSgarage'},
    data = {
        {
            id = "ems_spawn",
            label = "Grab Ambo",
            icon = "circle",
            event = "EMSSpawnVeh",
            parameters = { name = "ems"}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isDarkMarket'},
    data = {
        {
            id = "dark_market",
            label = "Big Spending Time",
            icon = "circle",
            event = "pfood:general",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isDrugMarket'},
    data = {
        {
            id = "drug_dealer",
            label = "Be Slick",
            icon = "circle",
            event = "pmeth:general",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isArcadeEnter'},
    data = {
        {
            id = "enter_arcade",
            label = "Enter Arcade",
            icon = "circle",
            event = "arcade:enter",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isArcadeExit'},
    data = {
        {
            id = "exit_arcade",
            label = "Exit Arcade",
            icon = "circle",
            event = "arcade:exit",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isBikeRental'},
    data = {
        {
            id = "Rental",
            label = "Rent a Bike",
            icon = "circle",
            event = "np-bikerent:menu",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isRental'},
    data = {
        {
            id = "RentalVehicle",
            label = "Rent a Vehicle",
            icon = "circle",
            event = "np-carrent:menu",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isFred'},
    data = {
        {
            id = "Fred",
            label = "Speak to Fred",
            icon = "circle",
            event = "speaktofredrick1",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isJim'},
    data = {
        {
            id = "Jim",
            label = "Speaking to Jim",
            icon = "circle",
            event = "jim:laptop1",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isCasMem'},
    data = {
        {
            id = "Casino",
            label = "Grab Memebership Card",
            icon = "circle",
            event = "casino-menu",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

--[[Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isTowIn'},
    data = {
        {
            id = "TowClockIn",
            label = "Clock In",
            icon = "circle",
            event = "clockonastow",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isTowTruck'},
    data = {
        {
            id = "Towtruck",
            label = "Grab a truck",
            icon = "circle",
            event = "gettruck",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.0}
    }
}]]


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPawnBuyer' },
    data = {
        {
            id = "pawn_give_items",
            label = _L("interact-pawn-give", "Give stolen items"),
            icon = "circle",
            event = "np-npcs:ped:giveStolenItems",
            parameters = {}
        },
        {
            id = "pawn_sell_items",
            label = _L("interact-pawn-sell", "Sell given items"),
            icon = "circle",
            event = "np-npcs:ped:sellStolenItems",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

--[[Entries[#Entries + 1] = {
    type = 'flag',
    group = {'isBobCat'},
    data = {
        {
            id = "blast_door",
            label = "Blast Door",
            icon = "circle",
            event = "efe:pediyurut",
            parameters = {}
        }
    },
    options = {
        distance = {radius = 2.5},
    }
}]]

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isCasinoChipSeller' },
    data = {
      {
          id = "casino_purchase_chips",
          label = "Buy Chips",
          icon = "fas fa-circle",
          event = "np-casino:purchaseChipsAction",
          parameters = { "purchase" }
      },
      {
          id = "casino_withdraw_cash",
          label = "Cashout (Cash)",
          icon = "wallet",
          event = "np-casino:purchaseChipsAction",
          parameters = { "withdraw:cash" }
      },
      {
          id = "casino_withdraw_bank",
          label = "Cashout (Bank)",
          icon = "university",
          event = "np-casino:purchaseChipsAction",
          parameters = { "withdraw:bank" }
      },
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isNPC' },
  data = {
    {
        id = "casino_wheel_spin_npc_toggle",
        label = "Toggle Wheel Enabled",
        icon = "fas fa-circle",
        event = "np-casino:wheel:toggleEnable",
    },
    {
        id = "casino_wheel_spin_npc_spin",
        label = "Spin Wheel! ($500)",
        icon = "dollar-sign",
        event = "np-casino:wheel:spinWheel",
    },
  },
  options = {
      distance = { radius = 2.5 },
      npcIds = {"casino_wheel_spin_npc"}
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isCasinoMembershipGiver' },
  data = {
    {
        id = "casino_membership_giver",
        label = "Purchase Membership ($250)",
        icon = "fas fa-circle",
        event = "np-casino:purchaseMembershipCard",
        parameters = {}
    },
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'flag',
  group = { 'isCasinoDrinkGiver' },
  data = {
    {
        id = "casino_drink_giver",
        label = "Purchase Drinks",
        icon = "fas fa-circle",
        event = "np-casino:purchaseDrinks",
        parameters = {}
    },
  },
  options = {
      distance = { radius = 2.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isWean' },
    data = {
      {
          id = "wean_laptop",
          label = "Talk to Robin Banks",
          icon = "fas fa-user-secret",
          event = "speaktowean",
          parameters = {}
      },
    },
    options = {
        distance = { radius = 2.5 }
    }
  }

  Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isVault' },
    data = {
        {
            id = "reset_vault",
            label = "Close Vault",
            icon = "circle",
            event = "dark:VAULTDOOR_REFRESH_GUY",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isPostOP' },
    data = {
        {
            id = "post_op",
            label = "Clock in",
            icon = "circle",
            event = "dreams-civjobs:start-post-op",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isFishRental' },
    data = {
        {
            id = "fish_rental",
            label = "Rent a Boat",
            icon = "circle",
            event = "np-fishing:rentBoat",
        },
        {
            id = "fish_return",
            label = "Return the Boat",
            icon = "circle",
            event = "np-fishing:returnBoat",
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = 'flag',
    group = { 'isScuba' },
    data = {
        {
            id = "scuba_boat",
            label = "Get a Boat",
            icon = "circle",
            event = "np-scuba:checkAndTakeDepo",
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}

local validAnimalModels = {
    [`a_c_chop`] = true,
    [`a_c_husky`] = true,
    [`a_c_husky_np`] = true,
    [`a_c_panther`] = true,
    [`a_c_cat_01`] = true,
    [`a_c_poodle`] = true,
    [`a_c_pug`] = true,
    [`a_c_retriever`] = true,
    [`a_c_retriever_np`] = true,
    [`a_c_shepherd`] = true,
    [`a_c_shepherd_np`] = true,
    [`a_c_pit_np`] = true,
    [`a_c_coyote`] = true,
    [`a_c_rottweiler`] = true,
    [`a_c_westy`] = true,
    [`a_c_horse`] = true,
  }
  Entries[#Entries + 1] = {
    type = 'entity',
    group = { 1 },
    data = {
        {
            id = "petthebaby",
            label = "Pet",
            icon = "fas fa-circle",
            event = "np-interact:doPettingAnimal",
            parameters = "petting",
        },
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
          -- -- Don't show options if this entity is dead 
          if pContext.isDead then
              return
          end
  
          return validAnimalModels[pContext.model]
        end,
    }
  }
  local lastStressTime = 0
  AddEventHandler("np-interact:doPettingAnimal", function()
    ClearPedTasksImmediately(PlayerPedId())
    TriggerEvent("animation:runtextanim", "petting")
    if lastStressTime == 0 or lastStressTime + (60000 * 15) < GetGameTimer() then
      lastStressTime = GetGameTimer()
      TriggerEvent("client:newStress", false, 250)
    end
  end)


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
