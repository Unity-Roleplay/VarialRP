RegisterNUICallback('btnDebt', function()
    local cars, house, debt = RPC.execute('np-phone:debt')
    SendNUIMessage({
        openSection = "debt",
        cars = cars,
        house = housing(house),
        debt = debt
    })
end)

function housing(house)
    local houses = {}
    for i,v in pairs(house) do
        local lastPaid = v.last_payment
        if lastPaid <= 7 then
            table.insert(houses, {
                house_id = v.house_id,
                house_name = v.house_name,
                price = v.price,
                last_payment = lastPaid
            })
        end
    end
    return houses
end

RegisterNUICallback('car_paid', function(data)
    local plate = data.plate
    local payment = data.payment
    local complete = RPC.execute('np-phone:car_payment', plate,payment)
    if complete then
        phoneNotification("email","You made a payment of $"..payment,"Finance")
    end
    TriggerEvent('DoLongHudText', "You don't have enough money in your bank.",2)
end)

RegisterNUICallback('h_paid', function(data)
    local id = data.hid
    local payment = data.payment
    local complete = RPC.execute('np-phone:h_payment', id,payment)
    if complete then
        phoneNotification("email","You made a payment of $"..payment,"Housing")
        return
    end
    TriggerEvent('DoLongHudText', "You don't have enough money in your bank.",2)
end)

RegisterNUICallback('p_paid', function(data)
    local id = data.pid
    local payment = data.payment
    local did = data.did
    -- print("DATA",json.encode(data))
    local complete = RPC.execute('np-phone:p_payment',id,payment,did)
    -- print("COMPLETE",complete)
    if complete then
        phoneNotification("email","You made a payment of $"..payment,"Debt")
        return
    end
    TriggerEvent('DoLongHudText', "You don't have enough money in your bank.",2)
end)

RegisterNetEvent('np-phone:MakeBill', function()
    -- print("MAKING BILLS")
    local input = exports["np-ui"]:showInput({
        {
            icon = "id-card",
            label = "CID",
            name = "cid",
        },
        {
            icon = "dollar-sign",
            label = "Amount",
            name = "amount",
        },
        {
            icon = "pen-square",
            label = "Type: Ex. Finance",
            name = "type",
        },
        {
            icon = "clipboard",
            label = "Comment",
            name = "comment",
        },
    })
    if input["cid"] ~= nil and input["amount"] ~= nil then
        local cid = input["cid"]
        local amount = input["amount"]
        local comment = input["comment"]
        local type = input["type"]

        local complete = RPC.execute("np-phone:addBill",cid,amount,type,comment)
        if complete then
            TriggerEvent('DoLongHudText', "Successfully adding player bill.")
            return
        end
    end
end)

RegisterCommand('signin', function()
    TriggerServerEvent("np-signin:duty", "police")
end)