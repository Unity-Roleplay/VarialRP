

--[[addedPolyZone = false





Citizen.CreateThread(function()

    while(true) do

	    
	    local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

          
     

		if addedPolyZone == false then
			    exports["np-polyzone"]:AddBoxZone("carrent", vector3(110.4619140625, -1090.6267089844, 29.302474975586), 0.8, 0.9, {
				name="carrent",
				heading=331.47,
				debugPoly=false,
				minZ=22.37,
				maxZ=34.00
				}, {
					 options = {
                        {
                            event = "np-carrent:menu",
                            icon = "fas fa-circle",
                            label = "Rent Car",
                        },
                     },
                     job = {"all"},
				     distance = 1.5
			    })
			    addedPolyZone = true
		end


		Citizen.Wait(2)	
    end
end)
]]


--RegisterNetEvent('np-carrent:menu')
--AddEventHandler('np-carrent:menu', function()   




RegisterNetEvent('np-carrent:menu')
AddEventHandler('np-carrent:menu', function()                           
  TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Car Rental",
            txt = "",
            params = {
                event = ""
            }
        },
        {
            id = 2,
            header = Config.Car1,
            txt = Config.Car1Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car1,
                    price = Config.Car1Price
                }
            }
        },
		{
            id = 3,
            header = Config.Car2,
            txt = Config.Car2Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car2,
                    price = Config.Car2Price
                }
            }
        },

		{
            id = 4,
            header = Config.Car3,
            txt = Config.Car3Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car3,
                    price = Config.Car3Price
                }
            }
        },
		{
            id = 5,
            header = Config.Car4,
            txt = Config.Car4Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car4,
                    price = Config.Car4Price
                }
            }
        },
		{
            id = 6,
            header = Config.Car5,
            txt = Config.Car5Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car5,
                    price = Config.Car5Price
                }
            }
        },
		{
            id = 7,
            header = Config.Car6,
            txt = Config.Car6Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car6,
                    price = Config.Car6Price
                }
            }
        },
		{
            id = 8,
            header = Config.Car7,
            txt = Config.Car7Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car7,
                    price = Config.Car7Price
                }
            }
        },
		{
            id = 9,
            header = Config.Car8,
            txt = Config.Car8Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car8,
                    price = Config.Car8Price
                }
            }
        },
		{
            id = 10,
            header = Config.Car9,
            txt = Config.Car9Price.. "$",
			params = {
                event = "np-carrent:checkmoney",
                args = {
                    car = Config.Car9,
                    price = Config.Car9Price
                }
            }
        },
    })

end)

RegisterNetEvent('np-carrent:checkmoney')
AddEventHandler('np-carrent:checkmoney', function(data)                            
        local vehicle = data.car
        local price = data.price
        TriggerServerEvent("np-carrent:hasmoney", price, vehicle)

end)

RegisterNetEvent('np-carrent:spawncar')
AddEventHandler('np-carrent:spawncar', function(vehicleName)                            

        local hash = GetHashKey(vehicleName)


        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findclosestspawnPointCarRent(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 121.24167633057, -1082.7764892578, 29.19358253479, 3.8474090099335, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
        local vehname = GetDisplayNameFromVehicleModel(vehicleName)
		--TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetEntityAsMissionEntity(vehicle, true, true)
        giveRentalPapers(vehname, plate)
end)

function findclosestspawnPointCarRent(pCurrentPosition)
	local coords = vector3(121.24167633057, -1082.7764892578, 29.19358253479)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end



function giveRentalPapers(vehname, plate)
 local cid = exports["isPed"]:isPed("cid")
 information = {
    ["CID"] = cid,
    ["Car"] = vehname,
    ["Plate"] = plate
  }
  TriggerEvent("player:receiveItem","rentalpapers",1,true,information)
	
 
end