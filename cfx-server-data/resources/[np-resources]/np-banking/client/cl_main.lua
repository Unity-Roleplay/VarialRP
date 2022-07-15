local opened = false
local pIsOpening = false
local pIsATM = false
local atm = true
local hasbusinessbool
local bizname
local bizbankid
local bizbank
local recentresults = {}

RegisterNetEvent("np-banking:infos")
AddEventHandler("np-banking:infos", function()
    local firstname, lastname, bank, cash, bankid = remoteCalls.execute("np-banking:getBankingInfo")
    local pBankName, pBBankID, pBankBalance = remoteCalls.execute("np-banking:getBusiness")

    if pBankName ~= nil then
        hasbusinessbool = true
    else
        hasbusinessbool = false
    end

    if not hasbusinessbool then
        SendNUIMessage({
            type = "infos",
            firstname = firstname,
            lastname = lastname,
            bank = bank,
            cash = cash,
            bankid = bankid,
            hasbusiness = false
        })
    else
        SendNUIMessage({
            type = "infos",
            firstname = firstname,
            lastname = lastname,
            bank = bank,
            cash = cash,
            bankid = bankid,
            hasbusiness = true,
            biz_name = pBankName, 
            biz_bank_id = pBBankID, 
            biz_bank = pBankBalance
        })
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function bankanimation(pIsATM, pIsOpening)
    local playerId = PlayerPedId()
    if pIsATM then
      loadAnimDict("amb@prop_human_atm@male@enter")
      loadAnimDict("amb@prop_human_atm@male@exit")
      loadAnimDict("amb@prop_human_atm@male@idle_a")
      if pIsOpening then
        TaskPlayAnim(playerId, "amb@prop_human_atm@male@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        exports['np-taskbar']:Progress({
            duration = 3000,
            label = "Inserting card",
        }, function(cancelled)
            if not cancelled then
                ClearPedSecondaryTask(playerId)
            end
        end)
      else
        ClearPedTasks(playerId)
        TaskPlayAnim(playerId, "amb@prop_human_atm@male@exit", "exit", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        exports['np-taskbar']:Progress({
            duration = 1000,
            label = "Retrieving Card",
        }, function(cancelled)
            if not cancelled then
                ClearPedTasks(playerId)
            end
        end)
      end
    else
      loadAnimDict("mp_common")
      if pIsOpening then
        ClearPedTasks()
        TaskPlayAnim(playerId, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        exports['np-taskbar']:Progress({
            duration = 1000,
            label = "Showing bank documentation",
        }, function(cancelled)
            if not cancelled then
                ClearPedTasks(playerId)
            end
        end)
      else
        TaskPlayAnim(playerId, "mp_common", "givetake1_a", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        exports['np-taskbar']:Progress({
            duration = 1000,
            label = "Collecting documentation",
        }, function(cancelled)
            if not cancelled then
                Citizen.Wait(1000)
                ClearPedTasks(playerId)
            end
        end)
      end
    end
  end

function Nui(close)
    if close and not atm then
        SetNuiFocus(true, true)
        SendNUIMessage({type = "bank", toggle = true})
    elseif close and atm then
        SetNuiFocus(true, true)
        SendNUIMessage({type = "bank", toggle = true, boa = "atm"})
    else
        SetNuiFocus(false, false)
        SendNUIMessage({type = "bank", toggle = false})
    end
end

function loadanim()
    TriggerEvent("np-banking:infos")
    recent()
    SendNUIMessage({type = "load"})
end

RegisterNetEvent("np-banking:refresh")
AddEventHandler("np-banking:refresh", function()
    TriggerEvent("np-banking:infos")
    SendNUIMessage({type = "ccon"})
    recent()
end)

RegisterNetEvent("np-banking:refreshBiz")
AddEventHandler("np-banking:refreshBiz", function(bizname)
    TriggerEvent("np-banking:infos")
    SendNUIMessage({type = "ccon"})
    recent()
    recentbiz(bizname)
end)

RegisterNetEvent("np-banking:open-atm")
AddEventHandler("np-banking:open-atm", function()
    bankanimation(true, true)
    pIsATM = true
    loadanim()
    Citizen.Wait(1000)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "bank", toggle = true, boa = "atm"})
end)

RegisterNetEvent("np-banking:open-bank")
AddEventHandler("np-banking:open-bank", function()
    bankanimation(false, true)
    TriggerServerEvent("np-banking:playerLoaded")
    Citizen.Wait(100)
    loadanim()
    Citizen.Wait(900)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "bank", toggle = true})
end)

function recent()
    recentresults = remoteCalls.execute("np-banking:bank:recent")
    local firstname, lastname, bankamount, cash, bankingid = remoteCalls.execute("np-banking:getBankingInfo")
    if #recentresults > 0 then
        for k, v in ipairs(recentresults) do
            SendNUIMessage({
                type = "recent",
                sender = v.sender,
                target = v.target,
                amount = v.amount,
                label = v.label,
                date = v.date,
                iden = v.iden,
                rtype = v.type,
                bankid = bankingid,
                bank = bankamount
            })
        end
    else
        SendNUIMessage({type = "recent", sender = "empty"})
    end
end

RegisterNUICallback('getRecentBiz', function(data)
    recentbiz(data.bizname)
end)

RegisterNUICallback('getRecent', function(data)
    recent()
end)

function recentbiz(bizname)
    local firstname, lastname, bankamount, cash, bankingid = remoteCalls.execute("np-banking:getBankingInfo")
    local recentbizresults = remoteCalls.execute("np-banking:business:recent", bizname)
    if #recentbizresults > 0 then
        for k, v in ipairs(recentbizresults) do
            SendNUIMessage({
                type = "recentbiz",
                senderbiz = v.sender,
                targetbiz = v.target,
                amountbiz = v.amount,
                labelbiz = v.label,
                datebiz = v.date,
                idenbiz = v.iden,
                rtypebiz = v.type,
                bank = bankamount
            })
        end
    else
        SendNUIMessage({type = "recentbiz", sender = "empty"})
    end
end

local years, months, days, hours, minutes, seconds
local date = 31

function time()
    years, months, days, hours, minutes, seconds =
    Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(),Citizen.PointerValueInt(), Citizen.PointerValueInt())

    if months < 10 then months = "0" .. months end

    if days < 10 then days = "0" .. days end

    if minutes < 10 then minutes = "0" .. minutes - 1 end

    if seconds < 10 then seconds = "0" .. seconds end

    if hours < 10 then hours = "0" .. hours end

    date = years .. "-" .. months .. "-" .. days .. "T" .. hours .. ":" ..minutes .. ":" .. seconds

end

RegisterNUICallback('withdraw', function(data, cb)
    time()
    remoteCalls.execute("np-banking:bank:withdraw", tonumber(data.value), data.comment, date)
    cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
    time()
    remoteCalls.execute("np-banking:bank:deposit", tonumber(data.value), data.comment, date)
    cb('ok')
end)


RegisterNUICallback('transfer', function(data, cb)
    time()
    remoteCalls.execute("np-banking:bank:transfer", tonumber(data.value), data.comment, data.id, date)
    cb('ok')
end)

-- BIZ STUFF

RegisterNUICallback('withdrawBiz', function(data, cb)
    time()
    remoteCalls.execute("np-banking:business:withdraw", tonumber(data.value), data.comment, date, data.bizname)
    cb('ok')
end)

RegisterNUICallback('depositBiz', function(data, cb)
    time()
    remoteCalls.execute("np-banking:business:deposit", tonumber(data.value), data.comment, date, data.bizname)
    cb('ok')
end)

RegisterNUICallback('transferBiz', function(data, cb)
    time()
    remoteCalls.execute("np-banking:business:transfer", tonumber(data.value), data.comment, tonumber(data.id), date, data.bizname)
    cb('ok')
end)

-- BIZ STUFF

RegisterNUICallback('close', function(data, cb)
    Nui(false)
    cb('ok')
    bankanimation(pIsATM, false)
    pIsATM = false
end)

RegisterNetEvent('bank:givecash')
AddEventHandler('bank:givecash', function(sender, reciever, amount)
	t, distance = GetClosestPlayer()
  	if(distance ~= -1 and distance < 7.5) then
		if tonumber(reciever) == GetPlayerServerId(t) then
			TriggerServerEvent("bank:givemecash", sender, reciever, amount)
			TriggerEvent("animation:PlayAnimation","id")
		else
			TriggerEvent("DoLongHudText", "This player is not online", 2)
		end
	else
    	TriggerEvent("DoLongHudText", "You are not near this player", 2)
  	end
end)

function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
        players[#players+1]= i
        end
    end

    return players
end


function GetClosestPlayer()
        local players = GetPlayers()
        local closestDistance = -1
        local closestPlayer = -1
        local closestPed = -1
        local ply = PlayerPedId()
        local plyCoords = GetEntityCoords(ply, 0)
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestPed = target
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance, closestPed
end