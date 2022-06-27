RegisterNUICallback("np-ui:getAccounts", function(data, cb)
    local accounts = RPC.execute("GetAccounts", data.id, data.cid, data.name)

    if HasMonitoredAccounts(accounts) then
        SendAccessAlert("10-101")
    end

    cb({
        data = {
            is_atm = isNearATM(),
            accounts = accounts and accounts or {}
        },
        meta = {
            ok = true,
            message = "done"
        }
    })
end)


RegisterCommand('accounts', function()
    TriggerServerEvent('np-spawn:create_bank_accounts', exports['isPed']:isPed('cid'))
end)

-- CREATE ACCOUNT
RegisterNUICallback("np-ui:createAccount", function(data, cb)
    local name, accountType, is_frozen, is_monitored, is_owner = data.name, data.type_id, data.is_frozen, data.is_monitored, data.is_owner or false
    local cid, access = data.cid, data.access
    local success, message = RPC.execute("CreateAccount", name, cid, access, accountType, is_frozen, is_monitored, is_owner)

    cb({
        data = {},
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

-- EDIT ACCOUNT
RegisterNUICallback("np-ui:editAccount", function(data, cb)
    local id, name, accountType, is_frozen, is_monitored = data.id, data.name, data.type_id, data.is_frozen, data.is_monitored
    local success, message = RPC.execute("EditAccount", id, name, accountType, is_frozen, is_monitored)

    cb({
        data = {},
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

-- TODO: Backend Hookup
-- DELETE ACCOUNT
RegisterNUICallback("np-ui:deleteAccount", function(data, cb)
    local id = data.id
    Citizen.SetTimeout(500, function()
        cb({
            data = {},
            meta = {
                ok = true,
                message = "Account Deaded!"
            }
        })
    end)
end)

-- GET ACCOUNT TYPES
RegisterNUICallback("np-ui:getAccountTypes", function(data, cb)
    local success, message = RPC.execute("GetAccountTypes")

    cb({
        data = message,
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

-- GET ACCOUNT CHARACTERS
RegisterNUICallback("np-ui:getAccountCharacters", function(data, cb)
    local success, message = RPC.execute("GetCharactersWithAccess", data.account_id)

    cb({
        data = message,
        meta = {
            ok = success,
            message = "done"
        }
    })
end)

-- ADD CHARACTER TO ACCOUNT
RegisterNUICallback("np-ui:addAccountCharacterPermissions", function(data, cb)
    local account_id, cid, access = data.account.id, data.character.id, data.character.access
    local success, message = RPC.execute("AddCharacterToAccount", account_id, cid, access)

    cb({
        data = {},
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

-- EDIT CHARACTER PERMISSIONS
RegisterNUICallback("np-ui:editAccountCharacterPermissions", function(data, cb)
    local account_id, cid, access = data.account.id, data.character.id, data.character.access
    local success, message = RPC.execute("EditCharacterPermission", account_id, cid, access)

    cb({
        data = {},
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

RegisterNUICallback("np-ui:removeCharacterFromAccount", function(data, cb)
    local account_id = data.account.id
    local cid = data.character.id
    local success, message = RPC.execute("RemoveCharacterFromAccount", account_id, cid)

    cb({
        data = {},
        meta = {
            ok = success,
            message = (not success and message or "done")
        }
    })
end)

function HasMonitoredAccounts(accounts)
    local monitored, accountData = false

    if accounts then
        for _, account in pairs(accounts) do
        if account.is_monitored == 1 then
            monitored, accountData = true, account
            break
        end
        end
    end

    return monitored, account
end

function SendAccessAlert(dispatchCode)
    local plyPos = GetEntityCoords(PlayerPedId())
    local streetName, crossingRoad = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = GetStreetNameFromHashKey(streetName),
        secondStreet = GetStreetNameFromHashKey(crossingRoad),
        extraData = exports["isPed"]:isPed("fullname"),
        origin = { x = plyPos.x, y = plyPos.y, z = plyPos.z }
    })
end
