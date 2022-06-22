RegisterNetEvent("showroom:purchaseVehicle")
AddEventHandler("showroom:purchaseVehicle", function(model, price, amount)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cash = user:getCash()
    local plate = GeneratePlate()
    if 7000000 >= price  then
        if user:getCash() >= price then
            user:removeMoney(price)
        PurchaseCar(src, model, plate)
        return
    else
        if tonumber(cash) >= price  then
            user:removeMoney(price)
            PurchaseCar(src, model, plate)
            return
            end
        end
    end;
end)

function PurchaseCar(source, vehicle, plate)
    local src = source;
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local player = user:getVar("hexid")
    local model = vehicle
    local plate = plate
    exports.ghmattimysql:execute('INSERT INTO characters_cars (cid, model, data, license_plate, name, vehicle_state , current_garage, purchase_price) VALUES (@cid, @model, @data, @license_plate, @name, @vehicle_state, @current_garage, @purchase_price)', {
        ['@cid']   = char.id,
        ['@model'] = vehicle,
        ['@data'] = json.encode(personalvehicle),
        ['@license_plate'] = plate,
        ['@name'] = vehicle,
        ['@vehicle_state'] = "Out",
        ['@current_garage'] = "T",
        ['@purchase_price'] = price,
    })
    TriggerClientEvent("showroom:clPurchaseVehicle", src, model, plate)
end

function GeneratePlate()
    local plate = math.random(10, 99)..""..GetRandomLetter(3)..""..math.random(100, 999)
    local result = exports.ghmattimysql:scalarSync('SELECT license_plate FROM characters_cars WHERE license_plate=@license_plate', {['@license_plate'] = plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end