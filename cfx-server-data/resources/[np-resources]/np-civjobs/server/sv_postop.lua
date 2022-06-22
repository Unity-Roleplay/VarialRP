

RegisterServerEvent('dreams-civjobs:post-op-payment')
AddEventHandler('dreams-civjobs:post-op-payment', function()
    local src = tonumber(source)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local payment = math.random(350, 850)
    user:addBank(payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "PostOp Payment", 
        { amount = tostring(payment) })
end)