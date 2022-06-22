--[[ Contacts stuff ]]

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number, fmsg)
  local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local characterId = user:getVar("character").id
  local handle = handle
  exports.ghmattimysql:execute('INSERT INTO user_contacts (identifier, name, number) VALUES (@identifier, @name, @number)', {
      ['identifier'] = characterId,
      ['name'] = name,
      ['number'] = number
  }, function(result)
    if not fmsg then
      TriggerEvent('getContacts', true, src)
      TriggerClientEvent('refreshContacts', src)
      TriggerClientEvent('phone:newContact', src, name, number)
    end
  end)
end)

RegisterNetEvent('phone:editContact')
AddEventHandler('phone:editContact', function(name, number,oldname)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local characterId = user:getVar("character").id

    exports.ghmattimysql:execute("SELECT * FROM user_contacts WHERE identifier = @identifier AND name = @name",{
        ['identifier'] = characterId,
        ['name'] = oldname
    },function(user)
    end)
    exports.ghmattimysql:execute("UPDATE user_contacts SET name = @name, number = @number WHERE identifier = @identifier AND name = @oldname", {
        ['identifier'] = tonumber(characterId),
        ['name'] = name,
        ['number'] = number,
        ['oldname'] = oldname
    })
end)

RegisterNetEvent('deleteContact')
AddEventHandler('deleteContact', function(name, number)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local characterId = user:getVar("character").id

    exports.ghmattimysql:execute('DELETE FROM user_contacts WHERE name = @name AND number = @number LIMIT 1', {
        ['name'] = name,
        ['number'] = number
    }, function (result)
        TriggerEvent('getContacts', true, src)
        TriggerClientEvent('refreshContacts', src)
        TriggerClientEvent('phone:deleteContact', src, name, number)
    end)
end)

RegisterNetEvent('phone:getContacts')
AddEventHandler('phone:getContacts', function()
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local characterId = user:getVar("character").id

    if (user == nil) then
        TriggerClientEvent('phone:loadContacts', src, json.encode({}))
    else
        local contacts = getContacts(characterId, function(contacts)
            if (contacts) then
                TriggerClientEvent('phone:loadContacts', src, contacts)
            else
                TriggerClientEvent('phone:loadContacts', src, {})
            end
        end)
    end
end)

function getContacts(identifier, callback)
    exports.ghmattimysql:execute("SELECT name,number FROM user_contacts WHERE identifier = @identifier ORDER BY name ASC", {
        ['identifier'] = identifier
    }, function(result) callback(result) end)
end

RegisterNetEvent('getNM')
AddEventHandler('getNM', function(pNumber)
  local src = source
local user = exports["np-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local characterId = user:getVar("character").id
  local pNumber = getNumberPhone(characterId)
  TriggerClientEvent("client:updatePNumber",src,pNumber)
end)


RegisterCommand("pnum", function(source, args, rawCommand)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    local srcPhone = getNumberPhone(char.id)
    TriggerClientEvent('sendMessagePhoneN', src, srcPhone)
end, false)