RegisterNetEvent("np-paycheck:client:call", function()
    local cid = exports["np-fw"]:GetModule("LocalPlayer").id
    TriggerServerEvent("np-paycheck:server:send", cid)
end)

RegisterNetEvent('np-collect:paycheck', function()
    local cid = exports["np-fw"]:GetModule("LocalPlayer").id
    TriggerServerEvent("np-paycheck:collect", cid)
end)