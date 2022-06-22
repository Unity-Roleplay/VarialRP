RegisterNUICallback('btnWenmo', function(data)
    SendNUIMessage({
        openSection = "wenmo",
      })
end)

RegisterNUICallback('wenmoSubmit', function(data)
    local num = data.num
    local amount = data.amount
    local comment = data.comment
    if tonumber(amount) < 0 then 
        return TriggerEvent("DoLongHudText","You cant send negatives dummy!",2) 
    end
    TriggerServerEvent('np-phone:transferWenmo',num,amount,comment)
end)

RegisterNUICallback("np-phone:getWenmo", function(data, cb)
    local success, message = RPC.execute("np-phone:getWenmo")
    local wenmo = {}
    for i,v in pairs(message) do
        local name
        if v.status == "receive" then
            name = getContactName(v.numfrom)
        else
            name = getContactName(v.numto)
        end
        table.insert(wenmo, {
            id = v.id,
            name = name,
            numto = v.numto,
            fromto = v.numfrom,
            amount = v.amount,
            comment = v.comment,
            status = v.status,
            date = v.date
        })
    end
    cb({ data = wenmo, meta = { ok = success, message = (not success and wenmo or 'done') } })
  end)