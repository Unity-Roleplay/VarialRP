
SpectateData = {}

-- [ Code ] --

-- [ Commands ] --


RegisterCommand("menu", function(source, args)
    local src = source
    local steamIdentifier = GetPlayerIdentifiers(src)[1]

    exports.oxmysql:execute('SELECT rank FROM users WHERE `hex_id`= ?', {steamIdentifier}, function(data)
        if data[1].rank == "dev" or data[1].rank == "admin" or data[1].rank == "mod" then
            TriggerClientEvent('np-admin-AttemptOpen', src,true) 
        
        end
    end)
    
end)


RegisterNetEvent("np-admin/server/open-menu", function()

    local src = source
    local steamIdentifier = GetPlayerIdentifiers(src)[1]

    exports.oxmysql:execute('SELECT rank FROM users WHERE `hex_id`= ?', {steamIdentifier}, function(data)
        if data[1].rank == "dev" or data[1].rank == "admin" or data[1].rank == "mod" then
            TriggerClientEvent('np-admin-AttemptOpen', src,true) 
        
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
    local player = ServerId
    local steamIdentifier
    local steamid  = false
    local license  = false
    local discord  = false
    local xbl      = false
    local liveid   = false
    local ip       = false
    for k,v in pairs(GetPlayerIdentifiers(player))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    exports.oxmysql:execute('INSERT INTO user_bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(ServerId),
        license,
        discord,
        ip,
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
    TriggerClientEvent('DoLongHudText', src, 'Successfully banned '..GetPlayerName(ServerId)".", 1)
end)

RegisterNetEvent("np-admin/server/change-weather-time", function(Weather, Time)
    local src = source
    if Time ~= nil and Time ~= 0 then
        TriggerEvent("np-weathersync:server:setTime",Time)
    end

    if Weather ~= nil and Weather ~= "" then
        TriggerEvent("np-weathersync:server:setWeather",Weather)
    end
end)

RegisterNetEvent("np-admin/server/kick-player", function(ServerId, Reason)
    local src = source

    DropPlayer(ServerId, Reason)
    TriggerClientEvent('DoLongHudText', src, 'Successfully kicked player.', 1)
end)

RegisterNetEvent("np-admin/server/give-item", function(ServerId, ItemName, ItemAmount)
    local src = source
    TriggerClientEvent('player:receiveItem',ServerId,ItemName, ItemAmount)
    TriggerClientEvent('DoLongHudText', src, 'Successfully gave player x'..ItemAmount..' of '..ItemName..'.', 1)
end)


RegisterNetEvent("np-admin/server/give-car", function(ServerId, ModelName, ThePlate)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(ServerId)
    local char = user:getVar("character")
    local player = user:getVar("hexid")
    local model = ModelName
    local plate = tostring(ThePlate)
    if plate == "" then
        plate = GeneratePlate()
    else
        plate = plate
    end
    exports.oxmysql:execute('INSERT INTO characters_cars (cid, model, data, license_plate, name, vehicle_state , current_garage, purchase_price) VALUES (@cid, @model, @data, @license_plate, @name, @vehicle_state, @current_garage, @purchase_price)', {
        ['@cid']   = char.id,
        ['@model'] = model,
        ['@data'] = '{"platestyle":0,"lights":[255,0,255],"interColour":0,"wheeltype":1,"extras":[0,0,0,0,0,0,0,0,0,0,0,0],"neon":{"1":false,"2":false,"3":false,"0":false},"colors":[112,0],"dashColour":0,"extracolors":[0,0],"smokecolor":[255,255,255],"plateIndex":0,"oldLiveries":0,"mods":{"1":-1,"2":-1,"3":-1,"4":-1,"5":-1,"6":-1,"7":-1,"8":-1,"9":-1,"10":-1,"11":-1,"12":-1,"13":-1,"14":-1,"15":-1,"16":-1,"17":false,"18":false,"19":false,"20":false,"21":false,"22":false,"23":-1,"24":-1,"25":-1,"26":-1,"27":-1,"28":-1,"29":-1,"30":-1,"31":-1,"32":-1,"33":-1,"34":-1,"35":-1,"36":-1,"37":-1,"38":-1,"39":-1,"40":-1,"41":-1,"42":-1,"43":-1,"44":-1,"45":-1,"46":-1,"47":-1,"48":-1,"0":-1},"xenonColor":255,"tint":0}',
        ['@license_plate'] = string.upper(plate),
        ['@name'] = model,
        ['@vehicle_state'] = "In",
        ['@current_garage'] = "T",
        ['@purchase_price'] = "101",
    })
    TriggerClientEvent('DoLongHudText', src, 'Successfully gave player '..ModelName..'.', 1)
end)

function GeneratePlate()
    local plate = math.random(10, 99)..""..GetRandomLetter(3)..""..math.random(100, 999)
    local result = exports.oxmysql:execute('SELECT license_plate FROM characters_cars WHERE license_plate=@license_plate', {['@license_plate'] = plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end



RegisterNetEvent("np-admin/server/request-job", function(ServerId, JobName)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(ServerId))
	local cid = user:getCurrentCharacter().id
    local owner = user:getCurrentCharacter().owner
    exports.oxmysql:execute("INSERT INTO character_passes (cid, rank, pass_type, business_name, giver) VALUES (@cid, @rank, @pass_type, @business_name, @giver)", {['@cid'] = cid, ['@rank'] = '5', ['@pass_type'] = JobName, ['@business_name'] = JobName, ['@giver'] = "Admin"})
    if JobName == "police" or JobName == "ems" then
        exports.oxmysql:execute("INSERT INTO jobs_whitelist (owner, rank, cid, job) VALUES (@owner, @rank, @cid, @job)", {['@owner'] = owner, ['@rank'] = '5', ['@cid'] = cid, ['@job'] = JobName})
    end
    local jobs = exports["np-base"]:getModule("JobManager")
    jobs:SetJob(user, JobName, false, function()
        TriggerClientEvent("DoLongHudText", src,"Job Set!", 1)
    end)
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
    TriggerClientEvent('Nopixel/client/specPlayer', src, ServerId, tgtCoords)
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
    TriggerClientEvent('DoLongHudText', ServerId, 'Stress Relieved.', 1)
    TriggerClientEvent('DoLongHudText', src, 'Successfully removed stress of player.', 1)
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
    TriggerClientEvent("np-admin:ReviveInDistance",src)
end)

RegisterNetEvent("np-admin/server/revive-target", function(ServerId)
    local src = source

    TriggerEvent('np-hospital:client:RemoveBleed', ServerId)
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


AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local player = source
    local steamIdentifier
    local steamid  = false
    local license  = false
    local discord  = false
    local xbl      = false
    local liveid   = false
    local ip       = false
    for k,v in pairs(GetPlayerIdentifiers(player))do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    deferrals.defer()
    deferrals.update(string.format(" Hello %s. Checking ban status!", playerName))


    exports.oxmysql:execute("SELECT * FROM user_bans WHERE license = @license", {['@license'] = license}, function(data)
        if data ~= nil then
            if(data[1] == nil) then
                deferrals.done()
            else
                local expiredata = tonumber(data[1].expire)
                local timeremaining = disp_time(expiredata)
                if(os.time() > math.floor(expiredata)) then
                    deferrals.done()
                    exports.oxmysql:execute('DELETE FROM user_bans WHERE license = @license', {['@license'] = license})
                else

                    if timeremaining.hours < 24 then
                        deferrals.done('\n🔰 You are banned. \n🛑 Reason: ' .. data[1].reason .. '\n ⏰Ban expires in '..timeremaining.hours..' hours and '..timeremaining.minutes ..' minutes!')
                    else
                        deferrals.done('\n🔰 You are banned. \n🛑 Reason: ' .. data[1].reason .. '\n ⏰Ban expires in '..timeremaining.days..' days, '..timeremaining.hours..' hours and '..timeremaining.minutes ..' minutes!')
                    end

                end
            end
        end
    end)
end)


function disp_time(time)
    local t = (os.difftime(time, os.time()))
    local d = math.floor(t / 86400)
    local h = math.floor((t % 86400) / 3600)
    local m = math.floor((t % 3600) / 60)
    local s = math.floor((t % 60))
    return {days = d , hours = h , minutes = m, seconds = s}
end


RegisterServerEvent('np-adminmenu:server:GiveCash')
AddEventHandler('np-adminmenu:server:GiveCash', function(pAmt, target)
    local src = source
    local user = exports['np-base']:getModule("Player"):GetUser(tonumber(target))

    user:addMoney(tonumber(pAmt))
end)
  