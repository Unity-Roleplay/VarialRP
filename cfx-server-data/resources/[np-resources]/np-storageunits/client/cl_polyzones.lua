near_storage_unit = false
showStorageUnits = false
storage_units_data = {}
currently_visiting_unit = 0

Citizen.CreateThread(function()
    local storage_units = RPC.execute("np-storageunits:get")
    for i = 1, #storage_units do
   
        exports["np-polyzone"]:AddBoxZone(storage_units[i].storage_name, vector3(storage_units[i].coords.x, storage_units[i].coords.y, storage_units[i].coords.z), storage_units[i].coords.width, storage_units[i].coords.height, {
            name= storage_units[i].storage_name,
            heading = storage_units[i].coords.h,
            minZ= storage_units[i].coords.minZ,
            maxZ= storage_units[i].coords.maxZ
        })

        local storage_data = {
            storage_id = storage_units[i].storage_id,
            storage_name = storage_units[i].storage_name
        }

        table.insert(storage_units_data, storage_data)
    end
end)


RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    for i = 1, #storage_units_data do
        if (name == storage_units_data[i].storage_name) then
            near_storage_unit = true
            storage_unit_thread()
            currently_visiting_unit = storage_units_data[i].storage_id
            TriggerEvent('np-textui:ShowUI', 'show', "[E] Open storage unit "..currently_visiting_unit) 
        end
    end
end)


RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    for i = 1, #storage_units_data do
        if (name == storage_units_data[i].storage_name) then
            near_storage_unit = false
            currently_visiting_unit = 0
            TriggerEvent('np-textui:HideUI')
        end
    end
end)

function storage_unit_thread()
    Citizen.CreateThread(function()
        while near_storage_unit do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                RPC.execute("np-storageunits:occupied", currently_visiting_unit)
            end
        end
    end)
end