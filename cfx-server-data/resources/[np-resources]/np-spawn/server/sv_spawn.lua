function Login.decode(tablestring)
    if tablestring == nil or tablestring == "" then
        return {}
    else
        return json.decode(tablestring)
    end
end

RegisterServerEvent("login:getCharModels")
AddEventHandler("login:getCharModels", function(charlist,isReset)
    local src = source
    local char

    local list = ""
    for i=1,#charlist do
        if i == #charlist then
            list = list..charlist[i]
        else
            list = list..charlist[i]..","
        end
    end

    if charlist == nil or json.encode(charlist) == "[]" then
        TriggerClientEvent("login:CreatePlayerCharacterPeds", src, nil, isReset)
        return
    end

    exports.ghmattimysql:execute("SELECT cc.*, cf.* FROM character_face cf LEFT JOIN character_current cc on cc.cid = cf.cid WHERE cf.cid IN ("..list..")",{},function(result)
        if result then
            local temp_data = {}

            for k,v in pairs(result) do
                temp_data[v.cid] = {
                    model = v.model,
                    drawables = Login.decode(v.drawables),
                    props = Login.decode(v.props),
                    drawtextures = Login.decode(v.drawtextures),
                    proptextures = Login.decode(v.proptextures),
                    hairColor = Login.decode(v.hairColor),
                    headBlend = Login.decode(v.headBlend),
                    headOverlay = Login.decode(v.headOverlay),
                    headStructure = Login.decode(v.headStructure),
                    tattoos = Login.decode(v.tattoos),
                }
            end

            for i=1,#charlist do
                if temp_data[charlist[i]] == nil then
                    temp_data[charlist[i]] = nil
                end
            end

            TriggerClientEvent("login:CreatePlayerCharacterPeds",src,temp_data,isReset)
        end
    end)
end)

RegisterServerEvent("np-login:disconnectPlayer")
AddEventHandler("np-login:disconnectPlayer", function()
    local src = source
    DropPlayer(src, "You DisConnected")
end)

RegisterServerEvent("np-base:playerSessionStarted")
AddEventHandler("np-base:playerSessionStarted", function()
    local src = source
    Citizen.CreateThread(function()
        Citizen.Wait(600000 * 3)
        local user = exports["np-base"]:getModule("Player"):GetUser(src)
        if not user or not user:getVar("characterLoaded") then
            DropPlayer(src, "You timed out while choosing a character")
            return
        end
    end)
end)

-- RPC.register("playercoords",function(coords)
--     local src = source
--     local user = exports["np-base"]:getModule("Player"):GetUser(src)
--     local cid = user:getCurrentCharacter()
--     local sql = SQL('SELECT `coords` FROM characters WHERE id = @id', {['id'] = cid})
--     if sql[1] then
--         return coords
--     end
-- end)



