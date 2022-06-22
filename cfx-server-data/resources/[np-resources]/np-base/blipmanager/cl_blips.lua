local blips = {
    {id = "casino1", name = "Casino Resort", color = 5, sprite = 207, x = 925.329, y = 46.152, z = 80.908 },
    {id = "hosp1", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = 1839.6, y= 3672.93, z= 34.28},
    {id = "hosp3", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = -449.67, y= -340.83, z= 34.50},
    {id = "hosp4", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = 357.43, y= -593.36, z= 28.79},
    {id = "hosp5", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = 295.83, y= -1446.94, z= 29.97},
    {id = "hosp6", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = -676.98, y= 310.68, z= 83.08},
    {id = "hosp7", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = 1151.21, y= -1529.62, z= 35.37},
    {id = "hosp8", name = "Hospital", scale = 0.75, color = 2, sprite = 61, x = -874.64, y= -307.71, z= 39.58},
    {id = "recycling", name = "Recycling plant", color = 2, sprite = 467, x = 892.37, y=-2171.84, z=32.29},
    {id = "bar1", name = "Bahama Mamas", sprite = 93, x = -1388.53430175781, y=-586.615295410156, z=29.2186660766602},
    {id = "bar2", name = "Tequilala", sprite = 93, x =-564.68, y= 276.15, z =83.12 },
    {id = "pcenter", name = "Payments & Internet Center", scale = 1.3, sprite = 351, color = 17, x=-1081.8293457031, y=-248.12872314453, z=37.763294219971},
    {id = "ttruckjob", name = "Impound Lot", color = 17, sprite = 68, x = -189.88, y = -1163.99, z = 23.68},
    {id = 'redline', name = 'Redline Performance', color = 1, sprite = 483, x = 937.03, y = -971.64, z = 41.37},
    {id = "lsbb", name = "Los Santos Billboards", color = 32, sprite = 475, x = -915.05, y = -452.75, z = 39.38},
    {id = "ironhog", name = "Iron Hog", color = 1, sprite = 226, x = 1769.51, y = 3327.99, z = 40.57},
    {id = "fire1", name = "Fire Station",scale = 0.9, color = 1, sprite = 153, x = 205.30201721191, y = -1651.4327392578, z = 29.803213119507},
    {id = "fire2", name = "Fire Tower",scale = 0.9, color = 1, sprite = 153, x =  -1195.5244140625, y = -1788.2210693359, z = 19.490871429443},
    {id = "fire3", name = "Fire Main",scale = 0.9, color = 1, sprite = 153, x =  1206.3913574219, y = -1473.1184082031, z = 34.859497070313},
    {id = "police-station-1", name = "Police Station 1", scale = 0.8, color = 3, sprite = 60, x=425.130, y=-979.558, z=30.711},
    {id = "vespucci-pd", name = "Vespucci PD", scale = 0.8, color = 3, sprite = 60, x=-1097.14, y=-829.4, z=37.68},
    {id = "fishingsales", name = "Fish Sales", scale = 0.7, color = 3, sprite = 304, x=-1507.86, y=1503.53, z=114.29},
    {id = "huntingshop", name = "Sporting & Survival", scale = 0.7, color = 3, sprite = 141, x=-675.3189, y=5836.144, z=17.70478},
    {id = "huntingsales", name = "Hunting Sales", scale = 0.7, color = 3, sprite = 442, x=569.32, y= 2796.66, z=14.14},
    {id = "bobcatsecurity", name = "Bobcat Security", scale = 0.7, color = 2, sprite = 498, x=880.8951, y=-2258.308, z=32.53486},
    {id = "airshop", name = "Aircraft Sales & Rentals", scale = 0.7, color = 2, sprite = 307, x=-1621.42, y=-3152.99, z=14.0},
    {id = "boatshop", name = "Boat Sales", scale = 0.7, color = 2, sprite = 427, x=-876.42, y=-1324.7, z=1.61},
    {id = "veh_rentals", name = "Vespucci Vehicle Rentals", scale = 0.5, color = 2, sprite = 326, x=108.77, y=-1088.88, z=29.3},
    {id = "bennys", name = "Benny's Repair", scale = 0.5, color = 2, sprite = 446, x=-33.5335, y=-1053.1345, z=28.39650},
    {id = "flight_school", name = "Flight School - AirX", scale = 0.6, color = 3, sprite = 307, x=-1875.02, y=2811.66, z=32.81},
    {id = "uwucafe", name = "UwU Cafe", color = 61, sprite = 621, x=-579.83, y=-1065.2, z=22.35},
    {id = "lmcbikes", name = "J&M Automotive Repair", scale = 0.7, color = 0, sprite = 494, x = 2522.296, y = 4102.870, z = 38.794},
    {id = "courthouse", name = "Los Santos City Hall", scale = 0.7, color = 5, sprite = 419, x=-549.5550079345, y=-195.0076904298, z=38.402359008789315},
    {id = "galleryvlc", name = "Vultur Lè Culturè", scale = 0.6, color = 18, sprite = 617, x=-424.47, y=22.29, z=46.27},
    {id = "PDM", name = "Premium Deluxe Motorsports", scale = 0.7, color = 7, sprite = 326, x=-33.737, y=-1102.322, z= 26.422},
    {id = "Tuner", name = "Tuner Shop", scale = 0.7, color = 7, sprite = 326, x=155.79, y = -3031.23, z = 7.04},
    {id = 'winery', name = 'The Winery', scale = 0.6, color = 6, sprite = 478, x = -1889.86, y = 2036.54, z = 140.83},
    {id = 'HarmonyRepairs', name = 'Harmony Repairs', scale = 0.7, color = 12, sprite = 478, x = 1183.18, y = 2651.66, z = 37.81},
    {id = 'HayesAutos', name = 'Hayes Autos Repairs', scale = 0.7, color = 12, sprite = 478, x = -1416.86, y = -447.97, z = 35.91},
    {id = "burgies", name = "Burger Shot", scale = 0.7, color = 8, sprite = 106, x = -1199.61, y = -899.79, z = 14.0},
    {id = "roosters", name = "Roosters Rest", scale = 0.6, color = 8, sprite = 93, x = -163.40, y = 297.81, z = 98.50},
    {id = "tavern", name = "The Tavern", scale = 0.7, color = 10, sprite = 93, x = 1216.33, y = -417.62, z = 67.72},
    {id = "digitalden", name = "Digital Den", scale = 0.8, color = 26, sprite = 619, x=1136.88, y=-474.85, z=66.44},    
    {id = "newscenter", name = "LS News Center", scale = 0.8, color = 5, sprite = 135, x=-582.95, y=-930.09, z=36.84},
    {id = "hunting", name = "Legal Hunting Area", scale = 0.8, color = 3, sprite = 141, x=-838.5, y=4176.4, z=192.5 },
    {id = "Crab Catching", name = "Crab Catching", scale = 0.7, color = 77, sprite = 371, x = 2257.4487304688, y = 4576.16607625, z = 30.970561981201},
    {id = "Crab Selling", name = "Crab Selling", scale = 0.7, color = 77, sprite = 371, x = 902.85455322266, y = -1722.8686523438, z = 32.159637451172},
    {id = "apartments", name = "Apartments", scale = 0.7, color = 0, sprite = 475, x = -267.9704284668, y = -958.87335205078, z = 31.230913162231},
    {id = "nfc", name = "NFC", scale = 0.8, color = 1, sprite = 546, x = -294.73, y = -1992.3, z = 30.97},
}

local circles = {
    { id = "hunting", name = "Legal Hunting Area", opacity = 80, radius = 1000.0, color = 1, sprite = 9, x=-838.5, y=4176.4, z=192.5 },
}


local circleBlips = {}

AddEventHandler("np-base:playerSessionStarted", function()
    Citizen.CreateThread(function()
        for k,v in ipairs(blips) do
            NPX.BlipManager:CreateBlip(v.id, v)
        end
        for k,v in ipairs(circles) do
            local blip = AddBlipForRadius(v.x,v.y,v.z,v.radius)
            SetBlipColour(blip,v.color)
            SetBlipAlpha(blip,v.opacity)
            SetBlipSprite(blip,9)
            circleBlips[#circleBlips+1] = {
                blip = blip,
                data = v
            }
        end

    end)

end)

AddEventHandler('np-island:hideBlips', function(pState)
    for k,v in ipairs(blips) do
        NPX.BlipManager:HideBlip(v.id, pState)
    end
    for _,blipData in ipairs(circleBlips) do
        if pState then
            SetBlipAlpha(blipData.blip, 0)
        else
            SetBlipAlpha(blipData.blip, blipData.data.opacity)
        end
    end
end)
