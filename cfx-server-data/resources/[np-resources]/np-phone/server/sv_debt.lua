local repayTime = 72 * 60 -- hours * 60 168 * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer ((60 * 1000) * 10)

RPC.register('np-phone:debt', function(source)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id
    local car = getVehicle(owner)
    local house = getHouse(owner)
    local debt = getPlayerDebt(owner)
    return car, house, debt
end)

function getVehicle(cid)
    local result = MySQL.query.await([[
        SELECT *
        FROM characters_cars
        WHERE cid = ? AND payments_left <= 4000
    ]],
    { cid})
    return getPaymentsLeft(result)
end

function getPaymentsLeft(car)
    local cars = {}
    for k,v in pairs(car) do
        local daysLeft = math.floor((v.payments_left/60)/24)
        -- if daysLeft < 2 then
        if v.payments_left <= 4 then
            local currentPayment = math.floor((v.financed/v.payments_left))
            local daysLeft = math.floor((v.payments_left/60)/24)
            table.insert(cars, {
                id = v.id,
                name = v.name,
                model = v.model,
                financed = v.financed,
                last_payment = v.last_payment,
                license_plate = v.license_plate,
                payments_left = v.payments_left,
                payments_left = v.payments_left,
                days_left = daysLeft,
                price = currentPayment
            })
        end
    end
    return cars
end

function getHouse(cid)
    -- local result = MySQL.query.await([[
    --     SELECT hid,last_payment,DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()), FROM_UNIXTIME(last_payment)) AS last_payment 
    --     FROM character_housing 
    --     WHERE cid = ?
    -- ]],
    -- { cid })
    
    --return buildInfo(result)
    return nil
end

function buildInfo(house)
    local housing = {}
    
    for k,v in pairs(house) do
        local hPrice = MySQL.query.await([[SELECT price FROM housing_price WHERE hid = ?]],{v.hid})
        local street = exports['np-housing']:HouseStreet(v.hid)
        table.insert(housing, {
            id = v.id,
            house_id = v.hid,
            house_name = street,
            price = hPrice[1].price,
            last_payment = v.last_payment
        })
    end
    return housing
end

function updatePayment(plate,left,fin)
    local leftP = left - 1
    local financeUp = fin
    local zero = 0
    local affectedRows = MySQL.update.await([[
        UPDATE characters_cars
        SET payments_left = ?, payments_left = ?, financed = ?, repoed = ?
        WHERE license_plate = ?
    ]],
    { repayTime+1000, leftP, financeUp,zero, plate})
    
    if not affectedRows or affectedRows < 1 then
        return false, "affectedRows ~= 1"
    end
    return true
end

function getPlayerDebt(cid)
    local result = MySQL.query.await([[
        SELECT *
        FROM debt_logs
        WHERE cid = ?
        AND status = 1
    ]],
    {cid})
    return getDebt(result)
end

function getDebt(debt)
    local debts = {}
    for i,v in pairs(debt) do
        table.insert(debts,{
            id = v.id,
            cid = v.cid,
            biller = v.biller,
            type = v.type,
            price = v.price,
            comment = v.comment,
            number = v.number,
            name = v.name
        })
    end
    return debts
end

RPC.register('np-phone:debtPrice', function(source, id)
    local src = source
    local hId = id.param
    return getPrice(hId)
end)

function getPrice(hId)
    local house = MySQL.query.await([[
        SELECT price FROM housing_price WHERE hid = ?
    ]], {hId})
    return house[1].price
end

RPC.register('np-phone:car_payment', function(source, pl)
    local src = source
    local plate = pl.param
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local status
    local carPaid = MySQL.query.await([[
        SELECT * FROM characters_cars WHERE license_plate = ?
    ]], {plate})

    if carPaid ~= nil then

        local CurrentPayment = math.floor((carPaid[1].financed/carPaid[1].payments_left))
        local left = carPaid[1].payments_left
        local fin = carPaid[1].financed - CurrentPayment
        
        if user:getBalance() >= CurrentPayment then
            local complete = updatePayment(plate,left,fin)
            user:removeBank(CurrentPayment)
            status = complete
        else
            status = false
        end
    end
    return status
end)

RPC.register('np-phone:h_payment', function(source,id,pay)
    local src = source
    local hId = id.param
    local payment = pay.param
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local status
    local bal = user:getBalance()
    if tonumber(user:getBalance()) >= tonumber(payment) then
        local affectedRows = MySQL.update.await([[
            UPDATE character_housing
            SET last_payment = last_payment - 604800
            WHERE hid = ?
        ]],
        { hId })
        -- user:removeBank(tonumber(payment))
        if not affectedRows or affectedRows < 1 then
            return false, "affectedRows ~= 1"
        end
        status = true
    else
        status = false
    end
    if status then
        user:removeBank(tonumber(payment))
    end
    return status
end)

RPC.register('np-phone:p_payment', function(source,id,p,did)
    local src = source
    local pId = id.param
    local dId = did.param
    local payment = p.param
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local status
    if tonumber(user:getBalance()) >= tonumber(payment) then
        local affectedRows = MySQL.update.await([[
            UPDATE debt_logs
            SET status = ?
            WHERE cid = ? AND id = ?
        ]],
        { 0, pId, dId })
        -- user:removeBank(tonumber(payment))
        if not affectedRows or affectedRows < 1 then
            return false, "affectedRows ~= 1"
        end
        status = true
    else
        status = false
    end
    if status then
        user:removeBank(tonumber(payment))
    end
    return status
end)

RPC.register('np-phone:addBill', function(source,id,a,t,c)
    local src = source
    local cid = id.param
    local amount = a.param
    local type = t.param
    local comment = c.param
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local pcid = user:getCurrentCharacter().id
    local number, name = getDetailByCid(pcid)

    local status
    local insertId = MySQL.insert.await([[
            INSERT INTO debt_logs (cid,biller,price,type,comment,number,name)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid,pcid,amount,type,comment,number,name})
    if not insertId then
        status = false
    end
        status = true
    return status
end)

function getDetailByCid(cid)
    local num = MySQL.query.await([[
        SELECT * 
        FROM characters
        WHERE id = ?
    ]],{cid})

    return num[1].phone_number, num[1].first_name.." "..num[1].last_name
end