--exports["np-log"]:AddLog("Admin", GetPlayerName(src), "Dev Debug", {item = tostring("Disabled")}) 
function AddLog(Module, Caller, Title, Metadata)
    -- print(Caller)
    playerid = PlayerIdentifier("steam", Caller)
	Await(SQL.execute("INSERT INTO `adminlogs` (PlayerHex, Module, Title, MetaData) VALUES (?, ?, ?, ?)", 
        tostring(playerid),
        tostring(Module),
        tostring(Title),
        json.encode(Metadata)
    ))
end

function AddLogHex(Module, Hex, Title, Metadata)
    Await(SQL.execute("INSERT INTO `adminlogs` (PlayerHex, Module, Title, MetaData) VALUES (?, ?, ?, ?)", 
        tostring(Hex),
        tostring(Module),
        tostring(Title),
        json.encode(Metadata)
    ))
end

function PlayerIdentifier(type, id)
    local identifiers = {}
    local numIdentifiers = GetNumPlayerIdentifiers(id)

    for a = 0, numIdentifiers do
        table.insert(identifiers, GetPlayerIdentifier(id, a))
    end

    for b = 1, #identifiers do
        if string.find(identifiers[b], type, 1) then
            return identifiers[b]
        end
    end
    return false
end