local currentClassRoomBoardUrl = "https://cdn.discordapp.com/attachments/979775387896774661/982377179751018577/unknown.png"
local currentMeetingRoomBoardUrl = "https://cdn.discordapp.com/attachments/979775387896774661/982377179751018577/unknown.png"

RegisterNetEvent("police:changewhiteboard", function(pUrl, pRoom)
    local src = source

    if pRoom == "classroom" then
        currentClassRoomBoardUrl = pUrl
    elseif pRoom == "meetingroom" and inMeetingRoom and dui then
        currentMeetingRoomBoardUrl = pUrl
    end

    TriggerClientEvent("police:changewhiteboardcli", -1, pUrl, pRoom)
end)

