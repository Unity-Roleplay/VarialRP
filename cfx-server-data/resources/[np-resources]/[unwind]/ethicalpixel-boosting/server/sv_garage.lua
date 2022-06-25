RegisterServerEvent('ethicalpixel-boosting:AddVehicle')
AddEventHandler('ethicalpixel-boosting:AddVehicle', function(model, plate)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    exports.oxmysql:execute("INSERT INTO characters_cars (cid, model, vehicle_state, current_garage, name, degredation, license_plate) VALUES (@cid, @model, @vehicle_state, @current_garage, @name, @degredation, @license_plate)", {
        ['@cid'] = cid,
        ['@model'] = model,
        ['@vehicle_state'] = 'Out',
        ['@current_garage'] = 'C',
        ['@name'] = model,
        ['@degredation'] = '100,100,100,100,100,100,100,100',
        ['@license_plate'] = plate
    })
    print('[VIN SCRATCH] State ID: '..cid)
    print('[VIN SCRATCH] License Plate: '..plate)
    print('[VIN SCRATCH] Vehicle Model: '..model)
end)
