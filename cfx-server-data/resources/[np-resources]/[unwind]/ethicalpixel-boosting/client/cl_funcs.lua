BNEBoosting = {}

BNEBoosting['functions'] = {
    GetCurrentBNE = function()
        local amount = RPC.execute("ethicalpixel-boosting:getCurrentBNE")
        if amount ~= nil then
            value =  amount.BNE
            background =  amount.background
            Wait(200)
            return ({bne = value ,back =  background})
        end
    end,
    RemoveBNE = function(amount)
        RPC.execute("ethicalpixel-boosting:removeBNE",amount)
            Wait(200)
        return true
    end,
    SetBackground = function(backgroundurl)
        TriggerServerEvent("ethicalpixel-boosting:server:setBacgkround" , backgroundurl)
    end,

    AddBne = function(amount)
        RPC.execute("ethicalpixel-boosting:addBne",amount)
            Wait(200)
        return true
    end,
}


RegisterCommand("zab", function()
    MainThread()
end)