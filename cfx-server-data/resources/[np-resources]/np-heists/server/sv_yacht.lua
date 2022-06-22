local radio = false
local ppc = false
local ppq = false

RegisterNetEvent("np-heists:yacht:heistStart", function()
    TriggerClientEvent("np-heists:yacht:updateGameDuiPanels", source, "override")
    TriggerClientEvent("np-heists:yacht:SetHeistActive", source, true)
end)

RegisterNetEvent("np-heists:yacht:final", function()
    if radio and ppq then
        TriggerClientEvent("np-heists:yacht:updateGameDuiPanels", source, "complete")
        TriggerClientEvent("np-doors:change-lock-state", -1, 475, false)
        TriggerClientEvent("np-heists:yacht:SetHeistActive", -1 , false)
    end
end)

local envelope = nil

RPC.register("np-heists:yacht:isActiveTarget", function(pSource, targetId)
    id = targetId.param
    if id == "ld_steam_1" then
        isTarget = true
        envelope = "textbox"
    elseif id == "mf_laptop_1" then
        code = math.random(0000,9999)
        print(code)
        isTarget = true
        --envelope = id["laptop"].code
        envelope = "laptop"
    else
        isTarget = false
    end
    return isTarget, envelope
end)

RPC.register("np-heists:yacht:searchStash", function(pSource, stashId)
    armario = stashId.param
    if amario == "md_stash_3" then
        metadata = json.encode({
            PPQ = math.random(0000,9999),
        })
        print(codigoppq)
        TriggerClientEvent('player:receiveItem', src, "heistmicroenvelope", false, {}, metadata)
    elseif armario == "md_stash_1" then
        local pista1 = "Gullies"
        metadata = json.encode({
            Pista = pista1
        })
        print(pista)
    elseif amario == "md_stash_2" then
        local pista2 = "Steam"
        metadata = json.encode ({
            Pista = pista2
        })
    elseif amario == "md_stash_4" then
        metadata = json.encode({
            Radio = math.random(0000, 9999)
        })
    elseif amario == "md_stash_5" then
        metadata = json.encode({
            Cavalo = math.random(0000, 9999)
        })
        print(cavalo)
    elseif amario == "md_stash_6" then
        local pista4 = "P: Password"
        metadata = json.encode ({
            Pista = pista4
        })
    elseif amario == "md_stash_7" then
        local pista6 = "Q: Bedroom"
        metadata = json.encode ({
            Pista = pista6
        })
    elseif amario == "md_stash_8" then
        local pista7 = "C: Up"
        metadata = json.encode ({
            Pista = pista7
        })
    elseif amario == "md_stash_9" then
        local pista5 = "P: Portable"
        metadata = json.encode ({
            Pista = pista5
        })
    elseif amario == "md_stash_10" then
        metadata = json.encode({
            PPC = math.random(0000,9999),
        })
    elseif amario == "md_stash_11" then
        local pista3 = "Phones"
        metadata = json.encode ({
            Pista = pista3
        })
    elseif amario == "md_stash_12" then
        local pista4 = "Radios"
        metadata = json.encode ({
            Pista = pista4
        })
    end
    TriggerClientEvent('player:receiveItem', src, "heistmicroenvelope", false, {}, metadata)
end)

RPC.register("np-heists:yacht:envelopeUsed", function(pSource, pCodigo)
    print("envelope code", pCodigo)
    return pCodigo
end)

RPC.register("np-heists:yacht:laptopCode", function(pSource, pCodigo)
    local src  = source
    local codigo = PCodigo.param
    print("code envelop", codigo)
    TriggerClientEvent("np-heists:yacht:laptopcode", src, codigo)
end)


RPC.register("np-heists:yacht:radioResult", function(pSource, pResult)
    radio = pResult.param
end)

RPC.register("np-heists:yacht:ppcResult", function(pSource, pResult)
    ppc = pResult.param
end)

RPC.register("np-heists:yacht:ppqResult", function(pSource, pResult)
    ppq = pResult.param
end)

RegisterNetEvent("np-heists:yacht:final", function()
    if radio and ppq and ppc then
        TriggerClientEvent("np-heists:yacht:updateGameDuiPanels", source, "complete")
        TriggerClientEvent("np-doors:change-lock-state", -1, 475, false)
        TriggerClientEvent("np-heists:yacht:SetHeistActive", -1 , false)
    end
end)

