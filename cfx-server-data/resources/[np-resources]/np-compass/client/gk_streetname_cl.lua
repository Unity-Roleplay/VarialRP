local street_bool = false
local zone_bool = true
local full_oof = true

Citizen.CreateThread( function()
	local lastStreetA = 0
	local lastStreetB = 0

	while Config.ShowStreet do
		Citizen.Wait(0)

		local playerCoords = GetEntityCoords(PlayerPedId(), true)
        local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z, currentStreetHash, intersectStreetHash)
        currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
        zone = tostring(GetNameOfZone(playerCoords))
        if zone_bool then
            area = GetLabelText(zone)
        else
            area = ""
        end
        if area == "Fort Zancudo" then
            area = "Williamsburg"
        end
        if intersectStreetName ~= nil and intersectStreetName ~= "" then
            playerStreetsLocation = currentStreetName .. " [" .. intersectStreetName .. "]"
        elseif currentStreetName ~= nil and currentStreetName ~= "" then
            playerStreetsLocation = currentStreetName
        else
            playerStreetsLocation = ""
        end 
        if zone_bool then
            street = playerStreetsLocation
        else
            street = ""
        end
        local hour
        local minute
		if IsPedInAnyVehicle(PlayerPedId()) and full_oof == true and not IsPauseMenuActive() then
			SendNUIMessage({action = "display", streetB =  street})
			SendNUIMessage({action = "display", streetA =  area})
            SendNUIMessage({action = "display", timer =  CalculateTimeToDisplay()})
            SendNUIMessage({action = "time", street_bool =  street_bool})
		else
			SendNUIMessage({action = "hide", type = streetA})
		end
		Citizen.Wait(250)
	end
end)

function CalculateTimeToDisplay()
    hour = GetClockHours()
    minute = GetClockMinutes()

    if useMilitaryTime == false then
        if hour == 0 or hour == 24 then
            hour = 12
        elseif hour >= 13 then
            hour = hour - 12
        end
    end

    if hour <= 9 then
        hour = "0" .. hour
    end
    if minute <= 9 then
        minute = "0" .. minute
    end
    local msg = hour .. ":" .. minute
    return msg
end
RegisterNetEvent('change:street')
AddEventHandler('change:street', function(bool)
	zone_bool = bool
end)

RegisterNetEvent('change:compass')
AddEventHandler('change:compass', function(bool)
	street_bool = bool
end)

RegisterNetEvent('change:full_oof')
AddEventHandler('change:full_oof', function(bool)
	full_oof = bool
end)