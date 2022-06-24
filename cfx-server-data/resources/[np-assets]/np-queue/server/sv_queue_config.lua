Config = {}

-- priority list can be any identifier. (hex steamid, steamid34, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    -- Management
    ["steam:1100001084c0a85"] = 99, -- Kosta
    ["steam:110000109296083"] = 90, -- Kym
    -- Staff
    ["steam:11000013cb4bebd"] = 90, -- Trexze
    ["steam:110000117c68137"] = 90, -- Ghostface
    ["steam:11000010bb33d91"] = 90, -- Bliss
    ["steam:110000117715e54"] = 90, -- Tempie
    ["steam:110000111cd2aac"] = 90, -- Jakku
    ["steam:11000013218ef32"] = 90, -- Sydres
    ["steam:110000105446384"] = 90, -- 0xi
    ["steam:110000100e401f5"] = 90, -- Smeech
    -- Trust
    ["steam:11000010c0f6e96"] = 85, -- Nightmares
    ["steam:1100001357db9d9"] = 85, -- P1lowPants
    ["steam:11000011a6bbebf"] = 85, -- Guerro
    ["steam:11000010acb8def"] = 85, -- Eleven
    ["steam:1100001429f6658"] = 85, -- Dewy
    -- Tier 3 (70)
    ["steam:"] = 70, -- N/A
    -- Tier 2 (60)S
    ["steam:"] = 60, -- N/A
    -- Tier 1 (50)
    ["steam:"] = 50, -- N/A

}

-- require people to run steam
Config.RequireSteam = true

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 50 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 120

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = true

-- how much priority power grace time will give
Config.GracePower = 85

-- how long grace time lasts in seconds
Config.GraceTime = 120

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the  settle and lets other resources finish initializing
Config.JoinDelay = 40000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Joining Dares FiveM Leaks...",
    connecting = "\xE2\x8F\xB3Connecting to Dares FiveM Leaks...",
    idrr = "\xE2\x9D\x97[NPXQueue] Error: Couldn't retrieve any of your id's, try restarting.",
    err = "\xE2\x9D\x97[NPXQueue] There was an error",
    pos = "\xF0\x9F\x90\x8CYou are %d/%d in queue \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[NPXQueue] Error: Error adding you to connecting list",
    timedout = "\xE2\x9D\x97[NPXQueue] Error: Timed out?",
    wlonly = "\xE2\x9D\x97[NPXQueue] You must be whitelisted to join this server. To apply, head to : https://discord.gg/novelcity",
    steam = "\xE2\x9D\x97 [NPXQueue] Error: Steam must be running"
}