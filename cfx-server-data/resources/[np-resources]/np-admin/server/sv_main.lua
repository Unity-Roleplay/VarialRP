
SpectateData = {}

-- [ Code ] --

-- [ Commands ] --

RegisterCommand("menu", function(source, args)
    local src = source
    local steamIdentifier = GetPlayerIdentifiers(src)[1]

    exports.oxmysql:execute('SELECT rank FROM users WHERE `hex_id`= ?', {steamIdentifier}, function(data)
        if data[1].rank == "dev" or data[1].rank == "admin" or data[1].rank == "mod" then
            TriggerClientEvent('np-admin-AttemptOpen', src, true) 
        end
    end)
end)


local playerss = {}

-- Console

RegisterCommand('AdminPanelKick', function(source, args, rawCommand)
    if source == 0 then
        local ServerId = tonumber(args[1])
        table.remove(args, 1)
        local Msg = table.concat(args, " ")
        DropPlayer(ServerId, "\n🛑 You got kicked from the server! \nReason: "..Msg)
    end
end, false)

RegisterCommand('AdminPanelAddItem', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, ItemName, ItemAmount = tonumber(args[1]), tostring(args[2]), tonumber(args[3])
        local Player = GetPlayerrr(ServerId)
        if Player ~= nil then
            Player.Functions.AddItem(ItemName, ItemAmount, false, false)
        end
    end
end, false)

RegisterCommand('AdminPanelAddMoney', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, Amount = tonumber(args[1]), tonumber(args[2])
        local Player = (ServerId)
        if Player ~= nil then
            Player.Functions.AddMoney('cash', Amount)
        end
    end
end, false)

RegisterCommand('AdminPanelSetJob', function(source, args, rawCommand)
    if source == 0 then
        local ServerId, JobName, Grade = tonumber(args[1]), tostring(args[2]), tonumber(args[3])
        local Player = GetPlayerrr(ServerId)
        if Player ~= nil then
            Player.Functions.SetJob(JobName, Grade)
        end
    end
end, false)

RegisterCommand('AdminPanelRevive', function(source, args, rawCommand)
    if source == 0 then
        local ServerId = tonumber(args[1])
        TriggerClientEvent('hospital:client:Revive', ServerId, true)
    end
end, false)

-- [ Callbacks ] --

RPC.register('np-adminmenu/server/get-permission', function(source, cb)
    if AdminCheck(source) then
        cb(true)
    else
        cb(false)
    end
end)

RPC.register('np-admin/server/get-active-players-in-radius', function(Source, Cb, Coords, Radius)
	local Coords, Radius = Coords ~= nil and vector3(Coords.x, Coords.y, Coords.z) or GetEntityCoords(GetPlayerPed(Source)), Radius ~= nil and Radius or 5.0
    local ActivePlayers = {}
	for k, v in pairs(GetPlayers()) do
        local TargetCoords = GetEntityCoords(GetPlayerPed(v))
        local TargetDistance = #(TargetCoords - Coords)
        if TargetDistance <= Radius then
            local ReturnData = {
                ['ServerId'] = v,
                ['Name'] = GetPlayerName(v)
            }
            table.insert(ActivePlayers, ReturnData)
        end
	end
	Cb(ActivePlayers)
end)
local function GetIdentiy ()
    local src = source
    local user = exports['np-base']:getModule("Player"):GetUser(src)
    local b = user:getVar("hexid")
    return b
end
 
 RPC.register('np-admin/server/get-players', function(source, Cb)
    local PlayerList = {}
    for k, v in pairs(GetPlayers()) do

        local NewPlayer = {
            ServerId = v,
            Name = GetPlayerName(v),
            Steam = GetIdentiy(),
            License = 'GetIdentiy(v, "license")'
        }
        table.insert(PlayerList, NewPlayer)
    end
    return(PlayerList)
 end)

 RPC.register('np-admin/server/get-player-data', function(source, Cb, License)
    for LicenseId, _ in pairs(License) do
        local TPlayer = GetPlayerFromIdentifier(LicenseId)
        local PlayerCharInfo = {
            Name = TPlayer.PlayerData.name,
            Steam = GetIdentiy(TPlayer.PlayerData.source, "steam"),
            CharName = TPlayer.PlayerData.charinfo.firstname..' '..TPlayer.PlayerData.charinfo.lastname,
            Source = TPlayer.PlayerData.source,
            CitizenId = TPlayer.PlayerData.citizenid
        }
        Cb(PlayerCharInfo)
    end
end)

--  [ Functions ] --

function AdminCheck(ServerId)
    local Player = GetPlayerrr(ServerId)
    local Promise = promise:new()
    if Player ~= nil then
        if HasPermission(ServerId, "admin") then
            Promise:resolve(true)
        else
            Promise:resolve(false)
        end
    end
    return Promise
end


function GetBanTime(Expires)
    local Time = os.time()
    local Expiring = nil
    local ExpireDate = nil
    if Expires == '1 Hour' then
        Expiring = os.date("*t", Time + 3600)
        ExpireDate = tonumber(Time + 3600)
    elseif Expires == '6 Hours' then
        Expiring = os.date("*t", Time + 21600)
        ExpireDate = tonumber(Time + 21600)
    elseif Expires == '12 Hours' then
        Expiring = os.date("*t", Time + 43200)
        ExpireDate = tonumber(Time + 43200)
    elseif Expires == '1 Day' then
        Expiring = os.date("*t", Time + 86400)
        ExpireDate = tonumber(Time + 86400)
    elseif Expires == '3 Days' then
        Expiring = os.date("*t", Time + 259200)
        ExpireDate = tonumber(Time + 259200)
    elseif Expires == '1 Week' then
        Expiring = os.date("*t", Time + 604800)
        ExpireDate = tonumber(Time + 604800)
    elseif Expires == 'Permanent' then
        Expiring = os.date("*t", Time + 315360000) -- 10 Years
        ExpireDate = tonumber(Time + 315360000)
    end
    return Expiring, ExpireData
end

-- [ Events ] --

-- User Actions

RegisterNetEvent("np-admin/server/ban-player", function(ServerId, Expires, Reason)
    local src = source

    local Expiring, ExpireDate = GetBanTime(Expires)
    exports.oxmysql:execute('INSERT INTO user_bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(ServerId),
        GetIdentiy(ServerId, 'license'),
        GetIdentiy(ServerId, 'discord'),
        GetIdentiy(ServerId, 'ip'),
        Reason,
        ExpireDate,
        GetPlayerName(src)
    })
    local ExpireHours = tonumber(Expiring['hour']) < 10 and "0"..Expiring['hour'] or Expiring['hour']
    local ExpireMinutes = tonumber(Expiring['min']) < 10 and "0"..Expiring['min'] or Expiring['min']
    if Expires == "Permanent" then
        DropPlayer(ServerId, '\n🔰 You are permanently banned.'..'\n🛑 Reason:'..Reason)
    else
        DropPlayer(ServerId, '\n🔰 You are banned.' .. '\n🛑 Reason: ' .. Reason .. "\n\n⏰Ban expires on " .. Expiring['day'] .. '/' .. Expiring['month'] .. '/' .. Expiring['year'] .. ' '..ExpireHours..':'..ExpireMinutes..'.')
    end
    TriggerClientEvent('DoLongHudText', src, 'Successfully banned '..GetPlayerName(ServerId)..' for '..Reason, 1)
end)

RegisterNetEvent("np-admin/server/kick-player", function(ServerId, Reason)
    local src = source

    DropPlayer(ServerId, Reason)
    TriggerClientEvent('DoLongHudText', src, 'Successfully kicked player.', 1)
end)

RegisterNetEvent("np-admin/server/give-item", function(ServerId, ItemName, ItemAmount)
    local src = source
print(ServerId, ItemName, ItemAmount)

    TriggerClientEvent('player:receiveItem',ServerId,ItemName, ItemAmount)
    TriggerClientEvent('DoLongHudText', src, 'Successfully gave player x'..ItemAmount..' of '..ItemName..'.', 1)
end)

RegisterNetEvent("np-admin/server/request-job", function(ServerId, JobName)
    local src = source

    local TPlayer = GetPlayerrr(ServerId)
    TPlayer.Functions.SetJob(JobName, 1, 'Admin-Menu-Give-Job')
    TriggerClientEvent('DoLongHudText', src, 'Successfully set player as '..JobName..'.', 1)
end)

RegisterNetEvent('np-admin/server/start-spectate', function(ServerId)
    local src = source

    -- Check if Person exists
    local Target = GetPlayerPed(ServerId)
    if not Target then
        return TriggerClientEvent('DoLongHudText', src, 'Player not found, leaving spectate..', 'error')
    end

    -- Make Check for Spectating
    local SteamIdentifier = GetIdentiy(src, "steam")
    if SpectateData[SteamIdentifier] ~= nil then
        SpectateData[SteamIdentifier]['Spectating'] = true
    else
        SpectateData[SteamIdentifier] = {}
        SpectateData[SteamIdentifier]['Spectating'] = true
    end

    local tgtCoords = GetEntityCoords(Target)
    TriggerClientEvent('Mercy/client/specPlayer', src, ServerId, tgtCoords)
end)

RegisterNetEvent('np-admin/server/stop-spectate', function()
    local src = source

    local SteamIdentifier = GetIdentiy(src, "steam")
    if SpectateData[SteamIdentifier] ~= nil and SpectateData[SteamIdentifier]['Spectating'] then
        SpectateData[SteamIdentifier]['Spectating'] = false
    end
end)

RegisterNetEvent("np-admin/server/drunk", function(ServerId)
    local src = source

    TriggerClientEvent('np-admin/client/drunk', ServerId)
end)

RegisterNetEvent("np-admin/server/animal-attack", function(ServerId)
    local src = source

    TriggerClientEvent('np-admin/client/animal-attack', ServerId)
end)

RegisterNetEvent("np-admin/server/set-fire", function(ServerId)
    local src = source

    TriggerClientEvent('np-admin/client/set-fire', ServerId)
end)

RegisterNetEvent("np-admin/server/fling-player", function(ServerId)
    local src = source

    TriggerClientEvent('np-admin/client/fling-player', ServerId)
end)

RegisterNetEvent("np-admin/server/play-sound", function(ServerId, SoundId)
    local src = source

    TriggerClientEvent('np-admin/client/play-sound', ServerId, SoundId)
end)

-- Utility Actions

RegisterNetEvent("np-admin/server/toggle-blips", function()
    local src = source

    local BlipData = {}
    for k, v in pairs(GetPlayers()) do
        local NewPlayer = {
            ServerId = v,
            Name = GetPlayerName(v),
            Coords = GetEntityCoords(GetPlayerPed(v)),
        }
        table.insert(BlipData, NewPlayer)
    end
    TriggerClientEvent('np-admin/client/UpdatePlayerBlips', -1, BlipData)
end)


RegisterNetEvent("np-admin/server/teleport-player", function(ServerId, Type)
    local src = source

    local Msg = ""
    if Type == 'Goto' then
        Msg = 'teleported to'
        local TCoords = GetEntityCoords(GetPlayerPed(ServerId))
        TriggerClientEvent('np-admin/client/teleport-player', src, TCoords)
    elseif Type == 'Bring' then
        Msg = 'brought'
        local Coords = GetEntityCoords(GetPlayerPed(src))
        TriggerClientEvent('np-admin/client/teleport-player', ServerId, Coords)
    end
    TriggerClientEvent('DoLongHudText', src, 'Successfully '..Msg..' player.', 1)
end)

RegisterNetEvent("np-admin/server/chat-say", function(Message)
    TriggerClientEvent('chatMessage', -1, 'Admin', 1, Message)
end)

-- Player Actions

RegisterNetEvent("np-admin/server/toggle-godmode", function(ServerId)
    TriggerClientEvent('np-admin/client/toggle-godmode', ServerId)
end)

RegisterNetEvent("np-admin/server/set-food-drink", function(ServerId)
    local src = source

    local TPlayer = GetPlayerrr(ServerId)
    if TPlayer ~= nil then
        TPlayer.Functions.SetMetaData('thirst', 100)
        TPlayer.Functions.SetMetaData('hunger', 100)
        TriggerClientEvent('hud:client:UpdateNeeds', ServerId, 100, 100)
        TPlayer.Functions.Save();
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player food and water.', 1)
    end
end)

RegisterNetEvent("np-admin/server/remove-stress", function(ServerId)
    local src = source

    local TPlayer = GetPlayerrr(ServerId)
    if TPlayer ~= nil then
        TPlayer.Functions.SetMetaData('stress', 0)
        TPlayer.Functions.Save();
        TriggerClientEvent('DoLongHudText', src, 'Successfully removed stress of player.', 1)
    end
end)

RegisterNetEvent("np-admin/server/set-armor", function(ServerId)
    local src = source

    local TPlayer = GetPlayerrr(ServerId)
    if TPlayer ~= nil then
        SetPedArmour(GetPlayerPed(ServerId), 100)
        TPlayer.Functions.SetMetaData('armor', 100)
        TPlayer.Functions.Save();
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player shield.', 1)
    end
end)

RegisterNetEvent("np-admin/server/reset-skin", function(ServerId)
    local src = source

    local TPlayer = GetPlayerrr(ServerId)
    local ClothingData = exports.oxmysql:execute('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { TPlayer.PlayerData.citizenid, 1 })
    if ClothingData[1] ~= nil then
        TriggerClientEvent("np-clothes:loadSkin", ServerId, false, ClothingData[1].model, ClothingData[1].skin)
    else
        TriggerClientEvent("np-clothes:loadSkin", ServerId, true)
    end
end)

RegisterNetEvent("np-admin/server/set-model", function(ServerId, Model)
    local src = source

    TriggerClientEvent('np-admin/client/set-model', ServerId, Model)
end)

RegisterNetEvent("np-admin/server/revive-in-distance", function()
    local src = source
    print('HERE')
    TriggerClientEvent("np-admin:ReviveInDistance",src)
end)

RegisterNetEvent("np-admin/server/revive-target", function(ServerId)
    local src = source
    print("Player Id Server:" ..ServerId)

    TriggerClientEvent('np-hospital:client:RemoveBleed', ServerId)
    TriggerEvent("np-death:reviveSV", ServerId)
    TriggerEvent("reviveGranted", ServerId)
    TriggerEvent("ems:healplayer",ServerId)

    TriggerClientEvent('DoLongHudText', src, 'Successfully revived player.', 1)
end)

RegisterNetEvent("np-admin/server/open-clothing", function(ServerId)
    local src = source

    TriggerClientEvent('np-clothing:client:openMenu', ServerId)
    TriggerClientEvent('DoLongHudText', src, 'Successfully gave player clothing menu.', 1)
end)


RegisterServerEvent("np-adminmenu:CheckInventory")
AddEventHandler("np-adminmenu:CheckInventory", function(target)
    local src = source
    if target ~= "" then
        local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(target))
        local char = user:getCurrentCharacter()

        Wait(1)
        TriggerClientEvent("server-inventory-open", src, "1", "ply-"..char.id)
    else
        TriggerClientEvent('DoLongHudText', src, 'You need to select someone to search!', 2)
    end
end)

RegisterServerEvent('np-adminmenu:server:GiveCash')
AddEventHandler('np-adminmenu:server:GiveCash', function(pAmt, target)
    local src = source
    local user = exports['np-base']:getModule("Player"):GetUser(tonumber(target))

    user:addMoney(tonumber(pAmt))
end)