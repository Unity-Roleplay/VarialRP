local Groups = {}

RPC.register("np-phone:getIdleGroup", function(source)
    local src = source
    local idle = {}
    local g = MySQL.query.await([[
        SELECT * FROM job_group
    ]],{})
    for i,v in pairs(g) do
        table.insert(idle, {
            id = v.id,
            src = v.src,
            name = v.name,
            members = json.decode(v.members),
            status = v.status
        })
    end
    return idle
end)

RPC.register("np-phone:getMyGroup", function(source)
    local src = source
    local idle = {}
    local g = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]],{src})
    for i,v in pairs(g) do
        table.insert(idle, {
            id = v.id,
            src = v.src,
            name = v.name,
            members = json.decode(v.members),
            status = v.status
        })
    end
    return idle
end)

RPC.register("np-phone:c_group", function(source)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local pcid = user:getCurrentCharacter().id
    local name = getFullName(pcid)
    local group = {src}
    local affectedRows = MySQL.insert.await([[
        INSERT INTO job_group
        (src, name, members, status)
        VALUES (?, ?, ?, ?)
    ]],
    {src, name, json.encode(group), 0})
end)

function getFullName(cid)
    local name = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],{cid})

    return name[1].first_name.." "..name[1].last_name
end

RPC.register("np-phone:j_group", function(source, id)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    local gId = id.param
    local group = getMembers(gId)
    local name = getFullName(cid)
    -- print("TEST",json.encode(group))
    -- table.insert(group, src)
   for i=1, #group do
    local mem = Groups[i]
    table.insert(group[i]['members'], src)
    local inMember = group[i]['members']
    updateGroup(gId,inMember)
   end
   insertMember(src,gId,cid,name)
   TriggerClientEvent('refreshJobCenter', src)
end)

function updateGroup(gId,inMember)
    print("gId,inMember",gId,inMember)
    local affectedRows = MySQL.update.await([[
        UPDATE job_group
        SET members = ?
        WHERE id = ?
    ]],
    { json.encode(inMember),gId })
    -- user:removeBank(tonumber(payment))
    if not affectedRows or affectedRows < 1 then
        return false, "affectedRows ~= 1"
    end


end

function getMembers(gId)
    print(gId)
    local mems = {}
    local result = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE id = ?
    ]],{gId})
    for i=1, #result do
        local Group = {}
        Group['id'] = tonumber(result[i]['id'])
        Group['src'] = result[i]['src']
        Group['name'] = result[i]['name']
        Group['members'] = json.decode(result[i]['members'])
        Group['status'] = tonumber(result[i]['status'])
        table.insert(mems, Group)
    end

    return mems
end

function getLGroup(src)
    print("GETTING ID GROUP")
    local group = MySQL.query.await([[
        SELECT * FROM job_group
        WHERE src = ?
    ]],{src})
    return group[1].id
end

RPC.register("np-phone:get_groupsMem", function(source, id)
    print("GETTING MEMBERS")
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id

    local mem = MySQL.query.await([[
        SELECT k.id, k._cid, k._gid, k._src, k._name, h.name, h.src, h.status
        FROM group_members k
        INNER JOIN job_group h ON h.id = k._gid
        WHERE k._cid = ?
    ]],{cid})
   
    
    if mem[1] == nil or mem[1] == null then
        print('Getting here')
        local gId = getLGroup(src)
        print('need another function',gId)
            local members = MySQL.query.await([[
                SELECT * FROM
                group_members
                WHERE _gid = ?
            ]],{gId})
            print('members', json.encode(members))
        return groupers(members)
    end
    if mem[1]._src ~= src then
        mem = {}
        return mem
    end
    print("MEMBER", json.encode(mem))
    return groupers(mem)
end)


function groupers(group)
    groups = {}
    for i,k in pairs(group) do
        table.insert(groups,{
            id = k.id,
            cid = k._cid,
            gid = k._gid,
            src = k._src,
            name = k._name
        })
    end
    return groups
end

function insertMember(src,gid,cid,name)
    MySQL.insert.await([[
        INSERT INTO group_members
        (_cid, _gid, _src, _name) 
        VALUES
        (?, ?, ? ,?)
    ]],{cid, gid, src, name})
end

RPC.register('np-phone:g_ready', function(source,stat,id)
    local src = source
    local status = stat.param
    local gid = id.param

    local mem = MySQL.query.await([[
        SELECT k.id, k._cid, k._gid, k._src, k._name
        FROM group_members k
        INNER JOIN job_group h ON h.id = k._gid
        WHERE k._cid = ?
    ]],{cid})

end)

RPC.register('np-phone:leave_group', function(source,id)
    local src = source
    local gId = id.param

    local affectedRows = MySQL.update.await([[
        DELETE FROM group_members
        WHERE _gid = ? AND _src = ?
    ]],
    { gId, src})
    removeMember(gId,src)
end)

function removeMember(id,src)
    local group = getMembers(id)
    -- print("TEST",json.encode(group))
    -- table.insert(group, src)
   for i=1, #group do
    local mem = Groups[i]
    table.remove(group[i]['members'], src)
    local inMember = group[i]['members']
    updateGroup(id,inMember)
   end
end


-- CreateThread(function()
--     Wait(1500)
--     exports.oxmysql:fetch('SELECT * FROM job_group', {}, function(result)
--       if result then
--         Groups = {}
--         for i=1, #result do
--           local Group = {}
--           Group['id'] = tonumber(result[i]['id'])
--           Group['src'] = result[i]['src']
--           Group['name'] = result[i]['name']
--           Group['keys'] = json.decode(result[i]['keys'])
--           Group['status'] = tonumber(result[i]['status'])
--           table.insert(Groups, Group)
--         end
--       end
--     --   TriggerLatentClientEvent('mhnp-housing:collectHouses', -1, 30000, Houses)
--     end)
-- end)