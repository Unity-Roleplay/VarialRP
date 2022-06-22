--[[

    NUI

]]

RegisterNUICallback("accountInformation", function()
    local _cid = exports["np-base"]:getChar("id")
    local _accountid = exports["np-base"]:getChar("bankid")
    local _phone = exports["np-base"]:getChar("phone")
    local _cash = RPC.execute("np-financials:getCash")
    local _bank = RPC.execute("np-financials:getBalance", _accountid)
    local _job = exports["np-jobs"]:jobName(exports["np-base"]:getChar("job"))
    local _licenses = RPC.execute("np-licenses:getLicenses", false, true)

	SendNUIMessage({
        openSection = "accountInformation",
        response = {
            cid = _cid,
            accountid = _accountid,
            phone = _phone,
            cash = _cash,
            bank = _bank,
            casino = 0,
            job = _job,
            licenses = _licenses,
        },
    })
end)