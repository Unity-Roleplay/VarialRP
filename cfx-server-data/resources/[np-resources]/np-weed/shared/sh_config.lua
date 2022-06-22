PlantConfig = {
    TypeModifiers = {
        --npk = nitrogen, phosphorus and potassium content (nutrients)
        --each ground type affects quality
        --players can alter by adding water, fertilizer
        --planting on farmland has best quality but risky, easily spotted, etc.
        --water = starting water content
        {n = 0.6, p = 0.6, k = 0.6, water = 0.5}, --1, grass
        {n = 0.3, p = 0.3, k = 0.3, water = 0.4}, --2, normal ground
        {n = 0.6, p = 0.6, k = 0.6, water = 0.6}, --3, unk
        {n = 0.6, p = 0.6, k = 0.6, water = 0.5}, --4, grassy rocks
        {n = 0.6, p = 0.6, k = 0.6, water = 0.4}, --5, mountain grass
        {n = 0.3, p = 0.3, k = 0.3, water = 0.5}, --6, unk
        {n = 0.3, p = 0.3, k = 0.3, water = 0.5}, --7, unk
        {n = 0.9, p = 0.9, k = 0.9, water = 0.9}, --8, wet ground
        {n = 0.9, p = 0.9, k = 0.9, water = 0.5}, --9, farmland
    },
    --Script automatically splits this into %'s
    GrowthObjects = {
        --{hash = `bkr_prop_weed_01_small_01c`, zOffset = -0.5},
        --{hash = `bkr_prop_weed_01_small_01a`, zOffset = -0.5},
        {hash = `bkr_prop_weed_01_small_01b`, zOffset = -0.5},
        {hash = `bkr_prop_weed_med_01a`, zOffset = -3.0},
        {hash = `bkr_prop_weed_med_01b`, zOffset = -3.0},
        {hash = `bkr_prop_weed_lrg_01a`, zOffset = -3.0},
        {hash = `bkr_prop_weed_lrg_01b`, zOffset = -3.0},
        -- {hash = `prop_weed_02`, zOffset = 0.0},
        -- {hash = `prop_weed_01`, zOffset = 0.0},
    },
    -- Plant Growing time in minutes
    GrowthTime = 180,
    -- Plant total lifetime (minutes) from planted -> destroyed
    LifeTime = 1920,
    -- How much longer should a male plant take to grow
    MaleFactor = 1.5,
    -- How many seeds should come from a male plant (range)
    SeedsFromMale = {3, 5},
    -- Chance of getting a male seed
    MaleChance = 0.34,
    -- Should male plants be removed when harvested?
    RemoveMaleOnHarvest = true,
    -- Percent at which the plant becomes harvestable
    HarvestPercent = 100.0,
    -- Time between plant harvests (minutes)
    TimeBetweenHarvest = 400,
    -- How often should the server update growth from DB, expensive (ms) Set to -1 to disable
    UpdateTimer = 10 * 60 * 1000, -- 10 minutes
    -- How much should 1 water bottle add
    WaterAdd = 0.2,
    -- How much should 1 fertilizer bag add to the inputted nutrient
    FertilizerAdd = 0.4,
    -- How much should growth speed up with >= 0.9 in N nutrient
    FertilizerFactor = 1.1,
    -- Nutrient weights
    -- Affects how much each nutrient contributes to the final quality
    NWeight = 25,
    PWeight = 50,
    KWeight = 25,
    -- Target water value in the plant, going over = less quality
    WaterOptimal = 0.9
}

WeedConfig = {
    -- How long does it take to go from wet bud -> dried bud (minutes)
    DryTime = 12 * 60,
    -- Which inventories should be valid to dry bud in. (Prefixes)
    ValidDryingInvs = {"warehouse", "motel", "housing"},
    -- How many packed buds (20g) from 1 dried bud (100g)
    BudPerDried = 5,
    -- How much does the Large Delivery list costs
    ListCost = 3000,
    -- restart cooldown past restart, and before restart (in minutes)
    RestartCooldown = 25,
    -- server-side cooldown for large dropoffs
    TimeBetweenLrgDeliveries = 15 * 60 * 1000,
    -- How many dried buds per 1 brick
    WeedsPerBrick = 10,
    -- How many bricks for 1 weed run
    BricksPerLargeRun = 10,
    -- How much cash is a brick worth
    BrickValue = 1000,
    -- How much should quality affect sale price (ie. 0% will multiply by 1.0, 50% quality will multiply by 1.1, 100% is 1.2)
    QualityFactor = 1.5,
    -- Chance of alerting police once someone arrives at a delivery spot
    AlertChance = 0.3,
    -- Time to prepare a brick of weed in seconds
    BrickPreparingTime = 10,
    -- Selling 500k worth of weed will get you 1.5x payment
    MaxProgressionBonus = 1.5,
    -- How many large runs can be active at a time
    MaxLargeRuns = 6,
}

CornerConfig = {
    BaggiesPerBrick = 28,
    -- default: 2 min/populate, -1 to disable
    PopulateRate = 1000 * 60 * 2,
    -- default: 1 min/ped
    TimeBetweenAcquisition = 60 * 1000,
    --How much should repeatedly selling in an area bring players
    MaxZoneBonus = 1.2,
    -- other config stuff
    RequireScales = true,
    DropEvidence = true,
}

-- Map material hash -> material type
MaterialHashes = {
    [-461750719] = 1,
    [930824497] = 1,
    [581794674] = 2,
    [-2041329971] = 2,
    [-309121453] = 2,
    [-913351839] = 2,
    [-1885547121] = 2,
    [-1915425863] = 2,
    [-1833527165] = 2,
    [2128369009] = 2,
    [-124769592] = 2,
    [-840216541] = 2,
    [-2073312001] = 3,
    [627123000] = 3,
    [1333033863] = 4,
    [-1286696947] = 5,
    [-1942898710] = 5,
    [-1595148316] = 6,
    [435688960] = 7,
    [223086562] = 8,
    [1109728704] = 8
}

WeedZones = {
    -- x, y, z, radius
    {vector3(-1586.36, 4153.03, 50.0), 2087.36},
    {vector3(2292.42, 4577.27, 50.0), 681.29},
    {vector3(2218.18, 5568.18, 50.0), 78.20},
    {vector3(928.79, 4540.91, 50.0), 750.88},
    {vector3(1709.03, 2592.45, 59.88), 200.0},
    {vector3(1452.94, 1105.35, 114.33), 200.0},
    {vector3(3283.27, 5183.88, 18.42), 100.0},
    {vector3(1800.77, 6523.15, 70.33), 200.0},
}

StrainNames = {
    -- Name given quality rounded to nearest 10s
    [0] = "Scuffjuana",
    [10] = "Cherry",
    [20] = "Pixel Pie",
    [30] = "Headband",
    [40] = "Kali Mist",
    [50] = "Kosher",
    [60] = "Hurkle",
    [70] = "White Widow",
    [80] = "Golden Goat",
    [90] = "Afghani",
    [100] = "B. Jangles"
}

WhitelistedZones = {
    ["AIRP"] = "Los Santos International Airport",
    ["ALTA"] = "Alta",
    ["BANNING"] = "Banning",
    ["BEACH"] = "Vespucci Beach",
    ["BURTON"] = "Burton",
    ["CHAMH"] = "Chamberlain Hills",
    ["CHIL"] = "Vinewood Hills",
    ["CHU"] = "Chumash",
    ["CYPRE"] = "Cypress Flats",
    ["DAVIS"] = "Davis",
    ["DELBE"] = "Del Perro Beach",
    ["DELPE"] = "Del Perro",
    ["DELSOL"] = "La Puerta",
    ["DOWNT"] = "Downtown",
    ["DTVINE"] = "Downtown Vinewood",
    ["EAST_V"] = "East Vinewood",
    ["EBURO"] = "El Burro Heights",
    ["ELGORL"] = "El Gordo Lighthouse",
    ["ELYSIAN"] = "Elysian Island",
    ["GALFISH"] = "Galilee",
    ["GOLF"] = "GWC and Golfing Society",
    ["GRAPES"] = "Grapeseed",
    ["GREATC"] = "Great Chaparral",
    ["HARMO"] = "Harmony",
    ["HAWICK"] = "Hawick",
    ["HORS"] = "Vinewood Racetrack",
    ["KOREAT"] = "Little Seoul",
    ["LEGSQU"] = "Legion Square",
    ["LMESA"] = "La Mesa",
    ["LOSPUER"] = "La Puerta",
    ["MIRR"] = "Mirror Park",
    ["MORN"] = "Morningwood",
    ["MOVIE"] = "Richards Majestic",
    ["MURRI"] = "Murrieta Heights",
    ["NCHU"] = "North Chumash",
    ["PALETO"] = "Paleto Bay",
    ["PBLUFF"] = "Pacific Bluffs",
    ["PBOX"] = "Pillbox Hill",
    ["RANCHO"] = "Rancho",
    ["RGLEN"] = "Richman Glen",
    ["RICHM"] = "Richman",
    ["ROCKF"] = "Rockford Hills",
    ["SANDY"] = "Sandy Shores",
    ["SKID"] = "Mission Row",
    ["STAD"] = "Maze Bank Arena",
    ["STRAW"] = "Strawberry",
    ["TEXTI"] = "Textile City",
    ["VCANA"] = "Vespucci Canals",
    ["VESP"] = "Vespucci",
    ["VINE"] = "Vinewood",
    ["WVINE"] = "West Vinewood",
}
