Citizen.CreateThread(function()
    TriggerServerEvent('np-carhud:SendUI_SV')
end)

RegisterNetEvent('np-carhud:SendUI', function(js)
    SendNUIMessage({
        type = "loadJs",
        js = js
    })
end)


local seatbelt = false
local timeEnabled = false
local sokakadlariaktif = true
local pusulaaktif = false
local minimapborder1 = true
local engineDamageShow = false
local mapsuankaremi = false
local minimapborderr = true
local compass = true

local fps60 = 1
local fps45 = 150
local fps30 = 300
local fps15 = 500

local CompassFPS = 150
local SpeedFPS = 250

local imageWidth = 100 
local containerWidth = 100 
local width =  0;
local south = (-imageWidth) + width
local west = (-imageWidth * 2) + width
local north = (-imageWidth * 3) + width
local east = (-imageWidth * 4) + width
local south2 = (-imageWidth * 5) + width

RegisterNetEvent("seatbelt", function(belt)
    seatbelt = belt
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(250)
        local player = PlayerPedId()
        local get_ped = PlayerPedId() -- current ped
        local get_ped_veh = GetVehiclePedIsIn(get_ped,false) -- Current Vehicle ped is in
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        local flyer = IsPedInAnyPlane(PlayerPedId()) or IsPedInAnyHeli(PlayerPedId())
        local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z, currentStreetHash, intersectStreetHash)
        currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
        intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
        zone = tostring(GetNameOfZone(playerCoords))
        area = GetLabelText(zone)

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

        street = playerStreetsLocation
    
        if IsPedInAnyVehicle(player, false) then
            if GetVehicleEngineHealth(get_ped_veh) < 400.0 then
                engineDamageShow = true
            else
                engineDamageShow = false
            end
            SendNUIMessage({
                type = "arabada",
                arabadami = true,
                saat = timeEnabled,
                minimap = minimapborder1,
                kare = mapsuankaremi,
                enginehealth = engineDamageShow,
                borderdurum = minimapborderr,
                compasszort = compass
            })
            SendNUIMessage({
                type = "belt",
                belt = seatbelt
            })
            if sokakadlariaktif then
                SendNUIMessage({
                    type = "konum",
                    gozuksun = true,
                    sokak = street,
                    mahalle = area
                })
            else 
                SendNUIMessage({
                    type = "konum",
                    gozuksun = false
                })
            end
            if flyer then
                altitude = math.floor(GetEntityHeightAboveGround(get_ped_veh) * 3.28084)
                SendNUIMessage({
                    type = "ucakta",
                    ucaktami = true,
                    altitude = altitude
                })
            else    
                SendNUIMessage({
                    type = "ucakta",
                    ucaktami = false,
                    altitude = altitude
                })
            end  
            
        else 
            SendNUIMessage({
                type = "konum",
                gozuksun = false
            })

            SendNUIMessage({
                type = "arabada",
                arabadami = false,
                saat = false
            })
        end
  
        
        if IsWaypointActive() and IsPedInAnyVehicle(PlayerPedId()) then
            local dist = (#(GetEntityCoords(PlayerPedId()) - GetBlipCoords(GetFirstBlipInfoId(8))) / 1000) * 0.715 -- quick conversion maff
            SendNUIMessage({
                type = "waypoint",
                waypointActive = true,
                waypointDistance = dist
            })
        else
            SendNUIMessage({
                type = "waypoint",
                waypointActive = false
            })
        end

        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)

        SendNUIMessage({
            type = "time",
            saat = GetClockHours(),
            dakika = GetClockMinutes()
        })

        Citizen.Wait(500)
    end
end)

function calcHeading(direction)
    if (direction < 90) then
        return lerp(north, east, direction / 90)
    elseif (direction < 180) then
        return lerp(east, south2, rangePercent(90, 180, direction))
    elseif (direction < 270) then
        return lerp(south, west, rangePercent(180, 270, direction))
    elseif (direction <= 360) then
        return lerp(west, north, rangePercent(270, 360, direction))
    end
end

function rangePercent(min, max, amt)
    return (((amt - min) * 100) / (max - min)) / 100
end

function lerp(min, max, amt)
   return (1 - amt) * min + amt * max
end


Citizen.CreateThread( function()
    while true do
        local heading = math.floor(calcHeading(-GetFinalRenderedCamRot(0).z % 360))

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SendNUIMessage({
                open = 6,
                direction = heading,
            })
            SendNUIMessage({
                type = 'pusulaac',
                aktifpusula = true
            })
        elseif pusulaaktif == true or pusulaaktif == false then
            if pusulaaktif then
                SendNUIMessage({
                    open = 6,
                    direction = heading,
                })
            end
            SendNUIMessage({
                type = 'pusulaac',
                aktifpusula = pusulaaktif
            })
        end

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            Citizen.Wait(CompassFPS) 
        else
            Citizen.Wait(500) 
        end
    end
end)

Citizen.CreateThread( function()
    while true do
            
        if IsPedInAnyVehicle(PlayerPedId(), false) then

            local plyPed = PlayerPedId()
            local plyVeh = GetVehiclePedIsIn(plyPed)
            local plyFuel = exports['np-fuel']:GetFuel(plyVeh)

            SendNUIMessage({
                type = "hiz",
                speed = (GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId()))) * 2.236936,
                benzin = plyFuel,
                speedtype = "mph"
            })
        end

        if IsPedInAnyVehicle(PlayerPedId(), false) then
            Citizen.Wait(SpeedFPS) 
        else
            Citizen.Wait(500) 
        end
    end
end)

function SetCompassFPS(amount)
    CompassFPS = amount
end

function SetSpeedFPS(amount)
    SpeedFPS = amount
end

function SetTimeEnabled(status)
    timeEnabled = status
end