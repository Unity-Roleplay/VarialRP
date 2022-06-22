--[[

    Functions

]]

function loadBank()
    local accounts = RPC.execute("np-financials:getAccounts")

    SendNUIMessage({
        openSection = "loadBank",
        accounts = accounts,
    })
end

--[[

    NUI

]]

RegisterNUICallback("btnBank", function()
    loadBank()
end)

RegisterNUICallback("bankTransfer", function(data)
    local success, error = RPC.execute("np-financials:bankTransfer", tonumber(data.bankid), tonumber(data.targetid), tonumber(data.amount), data.comment)
	if success then
        loadBank()
    else
        phoneNotification("fas fa-exclamation-circle", "Error", error, 5000)
    end
end)