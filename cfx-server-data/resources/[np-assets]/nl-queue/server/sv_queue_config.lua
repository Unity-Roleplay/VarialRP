Config = {}

-- priority list can be any identifier. (hex steamid, steamid34, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    --Management
    ["steam:110000117715e54"] = 99, --Tempie
    ["steam:11000011772204f"] = 90, --kILLER420
    --High Staff
    ["steam:110000134fb0ac1"] = 90, --LemonWata
    ["steam:1100001154817f4"] = 90, --Merah*
    ["steam:1100001170eb5a1"] = 90, --AFIX
    ["steam:1100001374d7eae"] = 90, --Jax
    ["steam:110000106ab987e"] = 90, --Glass
    ["steam:11000013208db5c"] = 90, --Trickz
    --Low Staff
    ["steam:11000050523e060"] = 85, --Sean
    ["steam:110000502883a60"] = 85, --Rated
    ["steam:1100005071b343d"] = 85, --RAFF
    ["steam:11000060547c95c"] = 85, --iamcenz(Zep)
    ["steam:110000114a17dd4"] = 85, --MrBleezy(Troy Glass)
    ["steam:1100005051415ec"] = 85, --Nick(NickNack)
    ["steam:1100005078bd604"] = 85, --KingWally
    ["steam:110000104afd8c0"] = 85, --Marcelo(Daddymunkie)
    ["steam:110000134491fa8"] = 85, --Paredes(Bliping)
    --Tier 3 (70)
    ["steam:1100001364f3f65"] = 70, --Apera ENDS 6/18
    ["steam:11000013dc2dee9"] = 70, --Codey Dahl ENDS 6/23
    ["steam:11000011507f350"] = 70, --F|ippy ENDS 6/24
    ["steam:110000139ec2839"] = 70, --Scooby ENDS 6/28
    ["steam:110000116b4154c"] = 70, --Susiana ENDS 7/9
    --Tier 2 (60)S
    ["steam:11000010dd488f3"] = 60, --Maci ENDS 7/9
    --Tier 1 (50)
    ["steam:110000107055bb6"] = 50, --JumboFlex ENDS 6/24
    ["steam:1100001162a4dba"] = 50, --Katy ENDS 7/10
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