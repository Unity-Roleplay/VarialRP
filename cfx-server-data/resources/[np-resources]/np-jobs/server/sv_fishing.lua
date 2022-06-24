Config = {}

Config.location = {
    coords = vector3(1260.32, 3989.43, 31.33)
}

Config.fishing = {
    {
        name = "Bass",
        itemName = "fishingbass",
        chance = 4, -- Done
        skill = 5,
    },
    {
        name = "Cod",
        itemName = "fishingcod",
        chance = 5, -- Done
        skill = 4,
    },
    {
        name = "Mackerel",
        itemName = "fishingmackerel",
        chance = 6, -- Done
        skill = 3,
    },
    {
        name = "Bluefish",
        itemName = "fishingbluefish",
        chance = 7, -- Done
        skill = 2,
    },
    {
        name = "Flounder",
        itemName = "fishingflounder",
        chance = 8, -- Done
        skill = 1,
    },
    {
        name = "Shark",
        itemName = "fishingshark",
        chance = 10, -- Done
        skill = 8,
    },
    {
        name = "Dolphin",
        itemName = "fishingdolphin",
        chance = 11, 
        skill = 9,
    },
	{
        name = "Whale",
        itemName = "fishingwhale",
        chance = 12, 
        skill = 10,
    },
}

RPC.register("fishing:getAvailableFishes", function(pSource)
    return Config.fishing
end)

RPC.register("fishing:getActiveLocation", function(pSource)
    return Config.location
end)

RPC.register("givePlayerJobPay", function(pSource, pInfo, pCash)
    local src = pSource
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    user:addMoney(pCash)

    exports["np-log"]:AddLog("Civ Jobs", 
        src, 
        "Fishing Job Payment", 
        { amount = tostring(pCash) })
    return
end)