RPC.register("GetTransactionLogs", function(pSource, pSourceAccountId, pTransactionType, pStartDate, pEndDate)
    return getTransactionLogs(pSourceAccountId, pTransactionType, pStartDate, pEndDate)
end)

RPC.register("GetAccounts", function(source, pAccountId, pCharacterId, pAccountName)
    local validJob, jobResponse = getCharacterJob(source)

    if not validJob then print("Error", jobResponse) else  end

    if not pAccountId or not pCharacterId or not pAccountName then
        local validCharacter, response = getCharacterId(source)

        if validCharacter then
            return getAccounts(pAccountId, response, pAccountName, validJob and jobResponse or nil)
        else
            return validCharacter, response
        end
    else
        return getAccounts(pAccountId, pCharacterId, pAccountName,  validJob and jobResponse or nil)
    end
end)

RPC.register("GetDefaultBankAccount", function(pSource, pCharacterId, pIgnoreFrozenCheck)
    return getDefaultBankAccount(pCharacterId, false, pIgnoreFrozenCheck)
end)

RPC.register("GetCharactersWithAccess", function(source, pAccountId)
    return GetCharactersWithAccess(pAccountId)
end)

RPC.register("GetAccountTypes", function(source)
    return getAccountTypes()
end)

RPC.register("GetTaxLevel", function(pSource, pType)
    if (type(pType) == "string") then
        return getTaxLevelByName(pType)
    elseif (type(pType) == "number") then
        return getTaxLevelById(pType)
    end

    return false, "Invalid type"
end)

RPC.register("PriceWithTaxString", function(pSource, pPrice, pTaxLevel)
    return priceWithTaxString(pPrice, pTaxLevel)
end)

RPC.register("GetTaxLevels", function(source, pOnlyEditable)
    return getTaxLevels(pOnlyEditable)
end)

RPC.register("GetTaxHistory", function(source)
    return getTaxHistory()
end)

RPC.register("SetTaxLevel", function(source, pNewTaxLevels)
    return setTaxLevel(pNewTaxLevels)
end)

RPC.register("GetAssetTaxes", function(source, pCharacterId)
    return getAssetTaxes(pCharacterId)
end)

RPC.register("PayAssetTaxes", function(source, pCharacterId, pSourceAccountId, pAssetTaxId, pAssetName)
    return payAssetTaxes(pCharacterId, pSourceAccountId, pAssetTaxId, pAssetName)
end)

RPC.register("CalculateTax", function(pSource, pSalePrice, pTaxLevel)
    return calculateTax(pSalePrice, pTaxLevel)
end)

RPC.register("GetCurrentBank", function(pSource, pAccountId)
    return getAccountBalance(pAccountId)
end)

RPC.register("doStateForfeiture", function(pSource, pAmount)
    return doStateForfeiture(pSource, pAmount)
end)
