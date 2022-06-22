local nearBuy = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("police_buy", vector3(464.53, -1012.86, 28.43), 1.6, 1.45, {
		name="police_buy",
		heading=0,
    }) 
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "police_buy" then
		local job = exports["isPed"]:isPed("myJob")
		if job == 'police' or job == 'state' or job == 'sheriff' then
            nearBuy = true
            AtPoliceBuy()
			exports['np-ui']:showInteraction(("[E] %s"):format("Purchase Vehicle"))
        end
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "police_buy" then
        nearBuy = false
    end
    exports['np-ui']:hideInteraction()
end)

function AtPoliceBuy()
	Citizen.CreateThread(function()
        while nearBuy do
            Citizen.Wait(5)
            local plate = GetVehicleNumberPlateText(vehicle)
            local job = exports["isPed"]:isPed("myJob")
            if job == 'police' or job == 'state' or job == 'sheriff' then
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('np-garages:shared:carmenu:open')
                end
            end
        end
    end)
end

RegisterNetEvent("np-garages:shared:carmenu:open", function()
    TriggerEvent('np-context:sendMenu', {
		{
            id = 0,
            header = "Police Vehicle Shop",
			txt = "",
        },
        {
            id = 1,
            header = "Browse Vehicles",
			txt = "",
			params = {
                event = "np-garages:carmenu:list",
                args = {
                    job = exports["isPed"]:isPed("myjob")
                }
            }
        }
    })
end)

RegisterNetEvent("np-garages:carmenu:list", function(params)
    local selected_job = tostring(params.job)


    TriggerEvent('np-context:sendMenu', {
        {
            id = 0,
            header = "Do you want the vehicle to be shared?",
            txt = "",
        },
        {
            id = 1,
            header = "Yes",
            txt = "Accessible by the whole department.",
            params = {
                event = "np-garages:carmenu:list:vehicles",
                args = {
                    job = exports["isPed"]:isPed("myjob"),
                    choice = true
                }
            }
        },

        {
            id = 2,
            header = "No",
            txt = "Your personal duty car.",
            params = {
                event = "np-garages:carmenu:list:vehicles",
                args = {
                    job = exports["isPed"]:isPed("myjob"),
                    choice = false
                }
            }
        }
    })

end)


RegisterNetEvent("np-garages:carmenu:list:vehicles", function(params)
    local selected_job = tostring(params.job)
    local p_choice = params.choice

    print(selected_job, p_choice)
    if selected_job == "police" or selected_job == "state" or selected_job == "sheriff" then
        TriggerEvent('np-context:sendMenu', {
            {
                id = 1,
                header = "What do you wanna buy?",
                txt = ""
            },
            {
                id = 2,
                header = "Ford Crown Victoria",
            	txt = "Price: $20,000",
                url = "https://i.imgur.com/eQV7F6m.png",
            	params = {
                    event = "np-garages:carmenu:attempt:buy",
            		args = {
            			vehicle = "npolvic",
                        price = "20000",
                        shared = p_choice
            		}
                }
            },
            {
                id = 3,
                header = "Ford Explorer",
                txt = "Price: $35,000",
                url = "https://i.imgur.com/KuNajbK.png",
            	params = {
                    event = "np-garages:carmenu:attempt:buy",
            		args = {
            			vehicle = "npolexp",
                        price = "35000",
                        shared = p_choice
            		}
                }
            },
            {
                id = 4,
                header = "Dodge Charger",
                txt = "Price: $84,000",
                url = "https://i.imgur.com/ow1tKPl.png",
            	params = {
                    event = "np-garages:carmenu:attempt:buy",
            		args = {
            			vehicle = "npolchar",
                        price = "84000",
                        shared = p_choice
            		}
                }
            },
        })
    elseif selected_job == "ems" then
        TriggerEvent('np-context:sendMenu', {
            {
                id = 1,
                header = "What do you wanna buy?",
                txt = ""
            },
            {
                id = 2,
                header = "2018 Vapid Speedo",
            	txt = "Price: $3000",
                url = "https://i.gyazo.com/80479c56dbceb8d5f825b5300f005af5.jpg",
            	params = {
                    event = "np-garages:carmenu:attempt:buy",
            		args = {
            			vehicle = "emsnspeedo",
                        price = "3000",
                        shared = p_choice
            		}
                }
            },
            -- {
            --     id = 3,
            --     header = "2014 Dodge Charger",
            --     txt = "Price: $8000",
            --     url = "https://i.gyazo.com/81b6007631a2afb4044cb578e9e289e2.jpg",
            -- 	params = {
            --         event = "np-garages:carmenu:attempt:buy",
            -- 		args = {
            -- 			vehicle = "emsc",
            --             price = "8000",
            --             shared = p_choice
            -- 		}
            --     }
            -- },

            -- {
            --     id = 4,
            --     header = "2016 Ford F350",
            --     txt = "Price: $12,000",
            --     url = "https://i.gyazo.com/505897f0a3e27bab7c5c5c97421aa526.png",
            -- 	params = {
            --         event = "np-garages:carmenu:attempt:buy",
            -- 		args = {
            -- 			vehicle = "emsf",
            --             price = "12000",
            --             shared = p_choice
            -- 		}
            --     }
            -- },

            -- {
            --     id = 5,
            --     header = "Wheelchair",
            --     txt = "Price: $1",
            --     url = "https://i.gyazo.com/c4764c13ed436133a0f61db03bde69b2.jpg",
            -- 	params = {
            --         event = "np-garages:carmenu:attempt:buy",
            -- 		args = {
            -- 			vehicle = "npwheelchair",
            --             price = "1",
            --             shared = p_choice
            -- 		}
            --     }
            -- },
        })
    end
end)    


RegisterNetEvent("np-garages:carmenu:attempt:buy", function(params)
    local success, receipt = RPC.execute("np-garages:attempt:buy", tonumber(params.price))

    if success then
        spawn_veh(params.vehicle, params.shared, tonumber(params.price))
    end

    TriggerEvent("DoLongHudText", receipt, 1)
end)


function spawn_veh(car, shared, price)
    local job = exports["isPed"]:isPed("myjob")


    RequestModel(car)
    while not HasModelLoaded(car) do
       RequestModel(car)
       Citizen.Wait(100)
    end
    
    local ParkingSpot = {
        ['police'] = {
            x = 449.61392211914, y = -1024.8341064453, z = 28.579444885254, h = 3.3486440181732
        },
        ['state'] = {
            x = 449.61392211914, y = -1024.8341064453, z = 28.579444885254, h = 3.3486440181732
        },
        ['sheriff'] = {
            x = 449.61392211914, y = -1024.8341064453, z = 28.579444885254, h = 3.3486440181732
        },

        ['ems'] = {
            x = 316.28414916992, y = -578.01086425781, z = 28.796854019165, h = 251.54804992676
        },
    }
    veh = CreateVehicle(car, ParkingSpot[job].x, ParkingSpot[job].y, ParkingSpot[job].z, ParkingSpot[job].h, true, false)
    Citizen.Wait(15)
    local plate = GetVehicleNumberPlateText(veh)
    SetModelAsNoLongerNeeded(car)
    local Fuel = 100
    DecorSetInt(veh, "CurrentFuel", Fuel)
    DecorSetBool(veh, "PlayerVehicle", true)
    SetVehicleOnGroundProperly(veh)
    SetVehicleNumberPlateText(veh, plate)
    SetPedIntoVehicle(PlayerPedId(), veh, -1)
    TriggerEvent("keys:addNew",veh, plate)
    SetVehicleHasBeenOwnedByPlayer(veh, true)


    SetVehicleExtra(veh, 1, toggle)
    SetVehicleExtra(veh, 2, toggle)
    SetVehicleExtra(veh, 3, toggle)
    SetVehicleExtra(veh, 4, toggle)
    SetVehicleExtra(veh, 5, toggle)       
    SetVehicleExtra(veh, 6, toggle)
    SetVehicleExtra(veh, 7, toggle)
    SetVehicleExtra(veh, 8, toggle)

    RPC.execute("np-garages:purchase:car", car, plate, shared, job, price)
end