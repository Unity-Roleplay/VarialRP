--[[

    Functions

]]

local function loadGroup(group)
    if not group then return end

    local infos = RPC.execute("np-groups:groupInformations", group)
    if not infos then return end

    SendNUIMessage({
        openSection = "groupManage",
        groupData = {
            groupName = exports["np-groups"]:GroupName(group),
            groupId = group,
            employees = infos["members"],
            rank = exports["np-groups"]:GroupRankInfo(group),
            isEmergency = exports["np-jobs"]:getJob(group, "is_emergency"),
        },
    })
end

--[[

    NUI

]]

RegisterNUICallback("btnTaskGroups", function()
    local groups = exports["np-base"]:getChar("groups")
    local _groups = {}

    for i, v in ipairs(groups) do
        table.insert(_groups, {
            namesent = v["name"],
            ranksent = exports["np-groups"]:GroupRankInfo(v["group"], "name"),
            idsent = v["group"]
        })
    end

    SendNUIMessage({
        openSection = "groups",
        groups = _groups,
    })
end)

RegisterNUICallback("manageGroup", function(data)
    loadGroup(data["GroupID"])
end)

RegisterNUICallback("promoteGroup", function(data)
    local group = data["gangid"]
    local rank = tonumber(data["newrank"])
    local cid = tonumber(data["cid"])

    if not group or not rank or not cid then return end

    local update = RPC.execute("np-groups:setRank", group, rank, cid)
    if update then
        loadGroup(group)
    end
end)

RegisterNUICallback("groupLogs", function(data)
    local group = data["group"]

    if not group then return end

    local logs = RPC.execute("np-groups:groupLogs", group)

    local list = {}
    for i, v in ipairs(logs) do
        table.insert(list, "<b>Type -</b> " .. v["type"] .. "<br><b>Text -</b> " .. v["text"] .. "<br><b>Date -</b> " .. v["date"])
    end

    phoneList(list)
end)

RegisterNUICallback("groupRanks", function(data, cb)
    local group = data.group
    local ranks = RPC.execute("np-groups:ranks", group)

    cb(ranks)
end)

RegisterNUICallback("changeCallsign", function(data)
    local group = data["gangid"]
    local callsign = data["callsign"]
    local cid = tonumber(data["cid"])

    if not group or not callsign or not cid then return end

    local update, message = RPC.execute("np-jobs:setCallsign", cid, group, callsign)
    if update then
        phoneNotification("fas fa-users", "Groups", message, 5000)
    else
        phoneNotification("fas fa-exclamation-circle", "Error", message, 5000)
    end
end)