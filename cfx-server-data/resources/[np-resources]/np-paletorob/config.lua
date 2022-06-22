Paleto = {}
Paleto.blackmoney = false -- enable this if you want blackmoney as a reward
Paleto.maxcash = 7500 -- maximum amount of cash a pile can hold
Paleto.mincash = 5000 -- minimum amount of cash a pile holds
Paleto.cooldown = 600 -- amount of time to do the heist again in seconds (15min)
Paleto.mincops = 0 -- minimum required cops to start mission
Paleto.vaultdoor = "v_ilev_cbankvauldoor01"
Paleto.Banks = {
    P1 = {
        doors = {
            startloc = {x = -105.41538238525, y = 6471.6791992188, z = 31.621948242188, h = 31.721450805664, animcoords = {x = -105.2922744751, y = 6471.3833007813, z = 30.626731872559, h = 31.721450805664}},
        },
        prop = {
            first = {coords = vector3(-105.41538238525,6471.6791992188,30.621948242188), rot = vector3(31.0, 31.0, 31.0)},
        },
        trolley = {x =-102.32084655762, y = 6476.7885742188, z = 30.663579940796, h = 82.893577575684},
        objects = {
            vector3(-102.32084655762, 6476.7885742188, 30.663579940796)
        },
        loot = false,
        onaction = false,
        lastrobbed = 0
    },
}

