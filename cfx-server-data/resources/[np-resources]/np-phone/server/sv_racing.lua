RPC.register('np-phone:getRaceTrack', function()
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local raceTrackers = {}
    exports.ghmattimysql:execute(' SELECT * FROM racing_tracks', {}, function(result)
        raceTracks = result
        checkPoints(raceTracks[1].checkpoints)
        for i=1, #raceTracks do
            print(raceTracks[i].track_name)
            table.insert(raceTrackers, {
                id = raceTracks[i].id,
                checkpoints = json.decode(raceTracks[i].checkpoints),
                track_name = raceTracks[i].track_name,
                creator = raceTracks[i].creator,
                distance = raceTracks[i].distance,
                races = raceTracks[i].races,
                fastest_car = raceTracks[i].fastest_car,
                fastest_name = raceTracks[i].fastest_name,
                fastest_lap = raceTracks[i].fastest_lap,
                fastest_sprint = raceTracks[i].fastest_sprint, 
                fastest_sprint_name = raceTracks[i].fastest_sprint_name,
                description = raceTracks[i].description
            })
        end
    end)
    Wait(100)
    return raceTrackers
end)

function checkPoints(cpoints)
    -- print(json.encode(cpoints))
    -- for i=1, #cpoints do
    --     print(cpoints[i])
    -- end
    -- for i=1, #cpoints do
    --     print(cpoints[i])
    -- end
end