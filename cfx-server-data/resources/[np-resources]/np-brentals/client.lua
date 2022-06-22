RegisterNetEvent('np-bikerent:menu')
AddEventHandler('np-bikerent:menu', function()                           
  TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Bike Rental",
            txt = "",
            params = {
                event = ""
            }
        },
        {
            id = 2,
            header = Config.bike1,
            txt = Config.bike1Price.. "$",
			params = {
                event = "np-bikerent:checkmoney",
                args = {
                    car = Config.bike1,
                    price = Config.bike1Price
                }
            }
        },
    })

end)


RegisterNetEvent('np-bikerent:checkmoney')
AddEventHandler('np-bikerent:checkmoney', function(data)                            
        local vehicle = data.car
        local price = data.price
        TriggerServerEvent("np-bikerent:hasmoney", price, vehicle)

end)

RegisterNetEvent('np-bikerent:spawnbike')
AddEventHandler('np-bikerent:spawnbike', function(vehicleName)                            

        local hash = GetHashKey(vehicleName)


        if not IsModelAVehicle(hash) then return end
        if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
        
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(0)
        end

		local spawnLocation = findclosestspawnPointBikeRent(GetEntityCoords(PlayerPedId()))
		local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
		if DoesEntityExist(getVehicleInArea) then
		  TriggerEvent("DoLongHudText", "The area is crowded", 2)
		  return
		end

        local vehicle = CreateVehicle(hash, 1631.3310546875, 2590.2429199219, 45.552833557129, 358.02600097656, true, false)

        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("keys:addNew",vehicle,plate)
        SetModelAsNoLongerNeeded(hash)
        SetVehicleDirtLevel(vehicle, 0)
        SetVehicleWindowTint(vehicle, 0)
        local vehname = GetDisplayNameFromVehicleModel(vehicleName)
	    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        SetEntityAsMissionEntity(vehicle, true, true)
        giveRentalPapers(vehname, plate)
end)

function findclosestspawnPointBikeRent(pCurrentPosition)
	local coords = vector3(1631.3310546875, 2590.2429199219, 45.552833557129)
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


RegisterNetEvent('pickup:bike')
AddEventHandler('pickup:bike', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
    local bone = GetPedBoneIndex(playerPed, 0xE5F3)
    local bike = false

    if GetEntityModel(vehicle) == GetHashKey("bmx") or GetEntityModel(vehicle) == GetHashKey("scorcher") or GetEntityModel(vehicle) == GetHashKey("cruiser") or GetEntityModel(vehicle) == GetHashKey("fixter") or GetEntityModel(vehicle) == GetHashKey("tribike") or GetEntityModel(vehicle) == GetHashKey("tribike2") or GetEntityModel(vehicle) == GetHashKey("tribike3") then

    AttachEntityToEntity(vehicle, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
    TriggerEvent("DoLongHudText","Press G to drop the bike.", 5000)

    RequestAnimDict("anim@heists@box_carry@")
    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
    bike = true

    RegisterCommand('dropbike', function()
        if IsEntityAttached(vehicle) then
        DetachEntity(vehicle, nil, nil)
        SetVehicleOnGroundProperly(vehicle)
        ClearPedTasksImmediately(playerPed)
        bike = false
        end
    end, false)

        RegisterKeyMapping('dropbike', 'Drop Bike', 'keyboard', 'g')

                Citizen.CreateThread(function()
                while true do
                Citizen.Wait(0)
                if bike and IsEntityPlayingAnim(playerPed, "anim@heists@box_carry@", "idle", 3) ~= 1 then
                    RequestAnimDict("anim@heists@box_carry@")
                    while (not HasAnimDictLoaded("anim@heists@box_carry@")) do Citizen.Wait(0) end
                    TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 2.0, 2.0, 50000000, 51, 0, false, false, false)
                    if not IsEntityAttachedToEntity(playerPed, vehicle) then
                        bike = false
                        ClearPedTasksImmediately(playerPed)
                    end
                end
            end
        end)
    end
end)