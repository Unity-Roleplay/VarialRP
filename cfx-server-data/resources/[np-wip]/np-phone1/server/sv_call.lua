--[[

    Variables

]]

local activeCallsByNumber = {}
local activeCallsBySource = {}

--[[

    Events

]]

AddEventHandler("playerDropped", function(pData)
    if activeCallsBySource[pData.source] then
        if activeCallsByNumber[activeCallsBySource[pData.source]].caller == pData.source then
            activeCallsByNumber[activeCallsBySource[pData.source]].caller = nil
        else
            activeCallsByNumber[activeCallsBySource[pData.source]].receiver = nil
        end
        endCall(activeCallsBySource[pData.source])
    end
end)

RegisterNetEvent("np-phone:callStart")
AddEventHandler("np-phone:callStart", function(pCaller, pTarget)
    local caller = source
    local target = exports["np-base"]:getSidWithPhone(pTarget)

    TriggerClientEvent("phone:call:dialing", caller, pTarget, target)

    if target ~= 0 and not activeCallsBySource[target] then
        TriggerClientEvent("phone:call:receive", target, pCaller, caller)
    end
end)

RegisterNetEvent("np-phone:callAccept")
AddEventHandler("np-phone:callAccept", function(callerID)
    local receiverID = source

    local receiverPhoneNumber = exports["np-base"]:getChar(receiverID, "phone")
    local callerPhoneNumber = math.ceil(exports["np-base"]:getChar(callerID, "phone"))

    activeCallsByNumber[receiverPhoneNumber] = {caller = callerID, receiver = receiverID}
    activeCallsBySource[callerID] = receiverPhoneNumber
    activeCallsBySource[receiverID] = receiverPhoneNumber

    TriggerEvent("caue:voice:server:phone:startCall", receiverPhoneNumber, receiverID, callerID)

    TriggerClientEvent("phone:call:in-progress", receiverID, callerPhoneNumber, receiverPhoneNumber)
    TriggerClientEvent("phone:call:in-progress", callerID, receiverPhoneNumber, receiverPhoneNumber)
end)

RegisterNetEvent("np-phone:callDecline")
AddEventHandler("np-phone:callDecline", function(pCallId)
    local src = source

    TriggerClientEvent("phone:call:inactive", src)

    if pCallId ~= nil and pCallId ~= false and pCallId ~= 0 then
        TriggerClientEvent("phone:call:inactive", pCallId)
    end
end)

RegisterNetEvent("np-phone:callEnd")
AddEventHandler("np-phone:callEnd", function(pCallId)
    local src = source

    local phoneNumber = pCallId
    local callerID = activeCallsByNumber[phoneNumber]["caller"]
    local receiverID = activeCallsByNumber[phoneNumber]["receiver"]

    TriggerEvent("caue:voice:server:phone:endCall", phoneNumber, callerID, receiverID)

    TriggerClientEvent("phone:call:inactive", callerID)
    TriggerClientEvent("phone:call:inactive", receiverID)

    activeCallsBySource[callerID] = nil
    activeCallsBySource[receiverID] = nil
end)