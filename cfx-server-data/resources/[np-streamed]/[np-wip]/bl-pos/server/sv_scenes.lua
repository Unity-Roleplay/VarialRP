RegisterNetEvent("nc-pos:printPos")
AddEventHandler("nc-pos:printPos", function(pos) 
    print(json.encode(pos))
end)