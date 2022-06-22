RegisterServerEvent('police:spikesLocation')
AddEventHandler('police:spikesLocation', function(spikePosition,heading)
    TriggerClientEvent('addSpikes', -1, spikePosition, heading)
    exports["np-log"]:AddLog("Spikes", 
        source, "Add Spikes", { pos = json.encode(spikePosition), heading = json.encode(heading) })
end)
