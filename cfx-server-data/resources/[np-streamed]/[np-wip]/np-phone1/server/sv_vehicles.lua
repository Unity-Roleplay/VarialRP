--[[

    Variables

]]

local vehiclesCoords = {}

--[[

    Events

]]

RegisterNetEvent("np-phone:vehicleCoords")
AddEventHandler("np-phone:vehicleCoords", function(identifier, coords)
    local src = source

    vehiclesCoords[identifier] = coords
end)

--[[

    RPCs

]]

RPC.register("np-phone:getVehicles", function(src)
    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return {} end

    local vehicles = MySQL.query.await([[
        SELECT v1.id, v1.plate, v1.model, v2.fuel, v2.body_damage, v2.engine_damage, v3.state, v3.garage, v3.coords, v4.price AS payment_price, v4.left AS payment_left, DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()), FROM_UNIXTIME(v4.last)) AS payment_last
        FROM vehicles v1
        INNER JOIN vehicles_metadata v2 ON v2.vid = v1.id
        INNER JOIN vehicles_garage v3 ON v3.vid = v1.id
        INNER JOIN vehicles_payments v4 ON v4.vid = v1.id
        WHERE cid = ?
    ]],
    { cid })

    return vehicles
end)

RPC.register("np-phone:vehicleCoords", function(src, identifier)
    if vehiclesCoords[identifier] ~= nil then
        return vehiclesCoords[identifier]
    end

    local garage = exports["np-vehicles"]:selectVehicle(identifier, "garage", "garage")
    local garagePos = exports["np-vehicles"]:getGarage(garage, "pos")
    if garage and garagePos then
        return garagePos
    end

    return false
end)

RPC.register("np-phone:payVehicle", function(src, identifier)
    return exports["np-vehicles"]:payVehicle(identifier, src)
end)

RPC.register("np-phone:carshopOutstandings", function(src, group)
    local vehicles = MySQL.query.await([[
        SELECT v1.vid, v2.plate, v2.model, CONCAT(c1.first_name, c1.last_name) as name, c1.phone, v3.price AS payment_price, v3.left AS payment_left, DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()), FROM_UNIXTIME(v3.last)) AS payment_last
        FROM carshop_logs v1
        INNER JOIN vehicles v2 ON v2.id = v1.vid
        INNER JOIN characters c1 ON c1.id = v2.cid
        INNER JOIN vehicles_payments v3 ON v3.vid = v1.vid
        WHERE shop = ?
    ]],
    { group })

    return vehicles
end)