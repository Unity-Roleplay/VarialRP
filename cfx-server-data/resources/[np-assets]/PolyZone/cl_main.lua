local comboZones = {}

RegisterNetEvent('np-base:PolyZoneUpdate')
AddEventHandler('np-base:PolyZoneUpdate', function()
    local combo = ComboZone:Create({}, {name = "np-polyzone", debugPoly = false})
    combo:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
        if enteredZones then
            for i = 1, #enteredZones do
                TriggerEvent('np-polyzone:entered:'.. enteredZones[i].data.cComboZone, enteredZones[i].name, enteredZones[i].data)
                print('np-polyzone:ssadasdsadsda2')
            end
        end
        if leftZones then
            for i = 1, #leftZones do
                TriggerEvent('np-polyzone:exited:'.. leftZones[i].data.cComboZone, leftZones[i].name)
                print('np-polyzone:stop2')
            end
        end
    end)



    for cComboZone, cComboZoneData in pairs(Config.Zones) do
        local zoneNames = {}
        for i, zone in ipairs(cComboZoneData) do
            zone.data.cComboZone = cComboZone
            combo:AddZone(zone)
            zoneNames[#zoneNames+1] = zone.name
            cComboZoneData[zone.name] = zone
            cComboZoneData[i] = nil
        end

        comboZones[cComboZone] = zoneNames
        comboZones["garages"] = zoneNames
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
    exports("GetCurrentZone", function()
        local isInside, insideZonesz = combo:isPointInsideExhaustive(GetEntityCoords(PlayerPedId()))
        local zoneNames = {}
        for i = 1, #zoneNames do
            zoneNames[#zoneNames+1] = insideZones[i].name
        end
        return zoneNames
    end)
end)

exports("GetZoneNamesInComboZone", function(pComboZoneName)
    return comboZones[pComboZoneName] or {}
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    local combo = ComboZone:Create({}, {name = "np-polyzone", debugPoly = false})
    combo:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
        if enteredZones then
            for i = 1, #enteredZones do
                TriggerEvent('np-polyzone:entered:'.. enteredZones[i].data.cComboZone, enteredZones[i].name, enteredZones[i].data)
                print('np-polyzone:wedasdsadasdsadsadsa')
            end
        end
        if leftZones then
            for i = 1, #leftZones do
                TriggerEvent('np-polyzone:exited:'.. leftZones[i].data.cComboZone, leftZones[i].name)
                print('np-polyzone:stop')
            end
        end

    end)

    for cComboZone, cComboZoneData in pairs(Config.Zones) do
        local zoneNames = {}
        for i, zone in ipairs(cComboZoneData) do
            zone.data.cComboZone = cComboZone
            combo:AddZone(zone)
            zoneNames[#zoneNames+1] = zone.name
            cComboZoneData[zone.name] = zone
            cComboZoneData[i] = nil
        end
        comboZones[cComboZone] = zoneNames
        comboZones["garages"] = zoneNames
    end
end)

function PrintTableOrString(t, s)
    if t then
        if type(t) ~= 'table' then 
            print("^1 [^3debug^1] ["..type(t).."] ^7", t)
            return
        else
            for k, v in pairs(t) do
                local kfmt = '["' .. tostring(k) ..'"]'
                if type(k) ~= 'string' then
                    kfmt = '[' .. k .. ']'
                end
                local vfmt = '"'.. tostring(v) ..'"'
                if type(v) == 'table' then
                    PrintTableOrString(v, (s or '')..kfmt)
                else
                    if type(v) ~= 'string' then
                        vfmt = tostring(v)
                    end
                    print(" ^1[^3debug^1] ["..type(t).."]^7", (s or '')..kfmt, '=', vfmt)
                end
            end
        end
    else
        print("^1Error Printing Request - The Passed through variable seems to be nil^7")
    end
end