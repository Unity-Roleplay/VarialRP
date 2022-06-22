--666561306, -58485588, -206690185, 1511880420, 682791951
local searched = {3423423424}
local canSearch = true
local dumpsters = {218085040}
local dumpsters2 = {-58485588}
local dumpsters3 = {666561306}

local searchTime = 14000

function checkforGarbage()
    for i = 1, #dumpsters do
      local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 5.0, dumpsters[i], 0, 0, 0)
      if DoesEntityExist(objFound) then
        return true
      end
    end
    return false
end
  
RegisterNetEvent('np-dumpster')
AddEventHandler('np-dumpster', function() 
    print('here')
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dumpsterFound = false
    for i = 1, #dumpsters do
        local dumpster = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters[i], false, false, false)
        local dumpPos = GetEntityCoords(dumpster)
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true) then

  
            for i = 1, #searched do
                if searched[i] == dumpster then
                    dumpsterFound = true
                end
                if i == #searched and dumpsterFound then
                    TriggerEvent('DoLongHudText', 'This dumpster has already been searched', 2)
                elseif i == #searched and not dumpsterFound then
                    TriggerEvent('DoLongHudText', 'You begin to search the dumpster')
                    local dict = 'amb@prop_human_bum_bin@base'
                    LoadDict(dict)
                    FreezeEntityPosition(PlayerPedId(),true)
                    TaskPlayAnim(PlayerPedId(), dict, 'base', 3.0, -8, -1, 63, 0, 0, 0, 0 )
                    local finished = exports ['np-taskbar']:taskBar(10000, 'search')
                    if (finished ==100) then
                        TriggerServerEvent('novel:giveDumpsterReward')
                        TriggerServerEvent('novel:startDumpsterTimer', dumpster)
                        FreezeEntityPosition(PlayerPedId(),false)
                        ClearPedTasks(PlayerPedId())
                    end
                    table.insert(searched, dumpster)

                end

                FreezeEntityPosition(PlayerPedId(),false)
            end
        end

    end
end)

RegisterNetEvent('np-dumpster2')
AddEventHandler('np-dumpster2', function() 
    print('here')

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dumpsterFound = false
    for i = 1, #dumpsters2 do
        local dumpster2 = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters2[i], false, false, false)
        local dumpPos = GetEntityCoords(dumpster2)
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true) then

  
            for i = 1, #searched do
                if searched[i] == dumpster2 then
                    dumpsterFound = true
                end
                if i == #searched and dumpsterFound then
                    TriggerEvent('DoLongHudText', 'This dumpster has already been searched', 2)
                elseif i == #searched and not dumpsterFound then
                    TriggerEvent('DoLongHudText', 'You begin to search the dumpster')
                    local dict = 'amb@prop_human_bum_bin@base'
                    LoadDict(dict)
                    FreezeEntityPosition(PlayerPedId(),true)
                    TaskPlayAnim(PlayerPedId(), dict, 'base', 3.0, -8, -1, 63, 0, 0, 0, 0 )
                    local finished = exports ['np-taskbar']:taskBar(10000, 'search')
                    if (finished ==100) then
                        TriggerServerEvent('novel:giveDumpsterReward')
                        TriggerServerEvent('novel:startDumpsterTimer', dumpster2)
                        FreezeEntityPosition(PlayerPedId(),false)
                        ClearPedTasks(PlayerPedId())
                    end
                    table.insert(searched, dumpster2)

                end
            end
        end

    end
end)

RegisterNetEvent('np-dumpster3')
AddEventHandler('np-dumpster3', function() 
    print('here')
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dumpsterFound = false
    for i = 1, #dumpsters3 do
        local dumpster3 = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, dumpsters3[i], false, false, false)
        local dumpPos = GetEntityCoords(dumpster3)
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, dumpPos.x, dumpPos.y, dumpPos.z, true) then

  
            for i = 1, #searched do
                if searched[i] == dumpster3 then
                    dumpsterFound = true
                end
                if i == #searched and dumpsterFound then
                    TriggerEvent('DoLongHudText', 'This dumpster has already been searched', 2)
                elseif i == #searched and not dumpsterFound then
                    TriggerEvent('DoLongHudText', 'You begin to search the dumpster')
                    local dict = 'amb@prop_human_bum_bin@base'
                    LoadDict(dict)
                    FreezeEntityPosition(PlayerPedId(),true)
                    TaskPlayAnim(PlayerPedId(), dict, 'base', 3.0, -8, -1, 63, 0, 0, 0, 0 )
                    local finished = exports ['np-taskbar']:taskBar(10000, 'search')
                    if (finished ==100) then
                        TriggerServerEvent('novel:giveDumpsterReward')
                        TriggerServerEvent('novel:startDumpsterTimer', dumpster3)
                        FreezeEntityPosition(PlayerPedId(),false)
                        ClearPedTasks(PlayerPedId())
                    end
                    table.insert(searched, dumpster3)

                end
            end
        end

    end
end)

RegisterNetEvent('novel:removeDumpster')
AddEventHandler('novel:removeDumpster', function(object)
    for i = 1, #searched do
        if searched[i] == object then
            table.remove(searched, i)
        end
    end
end)

-- Functions

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end



