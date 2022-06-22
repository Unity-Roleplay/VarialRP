cars = [
    // Motorcycles - başl
    { model: "zx10", label: "ZX10R", price: 615000, onStock: 5, category: 1 },
    { model: "bmwr", label: "R 110R Street Fighter", price: 815000, onStock: 3, category: 1 },

    // Muscle - başl
    { model: "dukes3", label: "Beater Dukes", price: 650000, onStock: 5, category: 2 },
    { model: "gauntlet5", label: "Gauntlet Classic Custom", price: 500000, onStock: 1, category: 2 },
    { model: "69charger", label: "Charger 1969", price: 1100000, onStock: 3, category: 2 },
    { model: "ellie6str", label: "Ellie 6STR", price: 1050000, onStock: 2, category: 2 },
    { model: "gauntlet6str", label: "BeaterGauntlet 6STR", price: 1100000, onStock: 2, category: 2 },
    { model: "demon", label: "Challenger Demon", price: 1250000, onStock: 3, category: 2 },
    { model: "gauntlet4", label: "Gauntlet Hellfire", price: 750000, onStock: 5, category: 2 },
    { model: "deviant", label: "Deviant", price: 850000, onStock: 3, category: 2 },

    // off road - başl
    { model: "vagrant", label: "Vagrant", price: 405000, onStock: 7, category: 3 },
    { model: "raid", label: "Challenger Raid", price: 885000, onStock: 1, category: 3 },
    { model: "hellion6str", label: "Hellion", price: 315000, onStock: 4, category: 3 },
    { model: "hoabrawler", label: "Brawler", price: 115000, onStock: 10, category: 3 },
    { model: "bifta", label: "Bifta", price: 55000, onStock: 1, category: 3 },

    // suvs -başl
    { model: "toros", label: "Toros", price: 595000, onStock: 4, category: 4 },
    { model: "mwgranger", label: "Granger", price: 115000, onStock: 5, category: 4 },
    { model: "rebla", label: "Rebla", price: 169000, onStock: 5, category: 4 },

    // sedans - başl
    { model: "stratumc", label: "Stratum C", price: 800000, onStock: 4, category: 5 },
    { model: "futo3", label: "Futo 6STR", price: 900000, onStock: 4, category: 5 },
    { model: "primoard", label: "Primo ARD", price: 450000, onStock: 6, category: 5 },
    { model: "payneschaf", label: "Schafter Business", price: 195000, onStock: 6, category: 5 },
    { model: "stratumc", label: "Stratum C", price: 800000, onStock: 4, category: 5 },
    { model: "tessaoracle", label: "Oracle XS ROW", price: 150000, onStock: 10, category: 5 },
    { model: "vuwashington", label: "Washington", price: 89000, onStock: 20, category: 5 },
    { model: "vustretch", label: "Stretch", price: 185000, onStock: 6, category: 5 },

    //sports - başl
    { model: "comet6", label: "Comet S2", price: 1100000, onStock: 1, category: 6 },
    { model: "victor", label: "Victor", price: 235000, onStock: 1, category: 6 },
    { model: "lc500", label: "LC500", price: 1150000, onStock: 1, category: 6 },
    { model: "starone", label: "1", price: 1450000, onStock: 1, category: 6 },
    { model: "bt62r", label: "BT62-R", price: 1500000, onStock: 1, category: 6 },
    { model: "valkyrietp", label: "Valkyrie", price: 2000000, onStock: 1, category: 6 },
    { model: "lp700", label: "Aventador LP700", price: 1600000, onStock: 2, category: 6 },
    { model: "lfa", label: "LFA", price: 1200000, onStock: 2, category: 6 },
    { model: "gt17", label: "GT", price: 1400000, onStock: 2, category: 6 },
    { model: "r32", label: "Skyline R32 GT-R", price: 1150000, onStock: 3, category: 6 },
    { model: "m4", label: "M4 Competition", price: 950000, onStock: 6, category: 6 },
    { model: "r8h", label: "R8 Hycade", price: 1350000, onStock: 2, category: 6 },
    { model: "deluxo6str", label: "Deluxo 6STR", price: 700000, onStock: 1, category: 6 },
    { model: "hustler6str", label: "Hustler 6STR", price: 1400000, onStock: 1, category: 6 },
    { model: "schwarzer2", label: "Schwartzer 6STR", price: 950000, onStock: 3, category: 6 },
    { model: "sentinel6str", label: "Sentinel 6STR", price: 815000, onStock: 3, category: 6 },
    { model: "sentinel6str2", label: "Sentinel Classic 6STR", price: 855000, onStock: 1, category: 6 },
    { model: "filthynsx", label: "NSX", price: 1300000, onStock: 1, category: 6 },
    { model: "elegy", label: "Elegy Retro", price: 800000, onStock: 7, category: 6 },
    { model: "banshee2", label: "Banshee 900R", price: 850000, onStock: 5, category: 6 },
    { model: "bdragon", label: "Continental GT Dragon", price: 1500000, onStock: 1, category: 6 },
    { model: "e36prb", label: "M3 E36", price: 950000, onStock: 3, category: 6 },
    { model: "m3e46", label: "M3 E46", price: 1150000, onStock: 1, category: 6 },
    { model: "rudiharley", label: "Davidson Fatboy", price: 395000, onStock: 1, category: 6 },
    { model: "dc5", label: "Integra Type-R DC5", price: 800000, onStock: 4, category: 6 },
    { model: "na1", label: "NSX NA1", price: 1250000, onStock: 3, category: 6 },
    { model: "500gtrlam", label: "Diablo GTR", price: 1300000, onStock: 2, category: 6 },
    { model: "tempesta2", label: "Huracan", price: 1550000, onStock: 2, category: 6 },
    { model: "rcf", label: "RCF", price: 1150000, onStock: 3, category: 6 },
    { model: "granlb", label: "Gran Turismo", price: 1120000, onStock: 3, category: 6 },
    { model: "c63", label: "C63 AMG", price: 570000, onStock: 2, category: 8 },
    { model: "cp9a", label: "Lancer Evolution VI GSR TME", price: 850000, onStock: 3, category: 6 },
    { model: "evo9", label: "Lancer Evolution IX MR FQ-400", price: 1150000, onStock: 3, category: 6 },
    { model: "gtr", label: "GT-R R35", price: 1150000, onStock: 3, category: 6 },
    { model: "r35", label: "GT-R R35", price: 1255000, onStock: 5, category: 6 },
    { model: "fnf4r34", label: "Skyline GTR R34", price: 1300000, onStock: 2, category: 6 },
    { model: "s15rb", label: "Silvia S15", price: 1100000, onStock: 4, category: 6 },
    { model: "sultanrs", label: "Sultan RS", price: 855000, onStock: 6, category: 6 },
    { model: "schwarzer", label: "Schwartzer 6STR", price: 1100000, onStock: 4, category: 6 },
    { model: "sultanrsv8", label: "RCF", price: 1150000, onStock: 3, category: 6 },
    { model: "ruiner6str", label: "Ruiner 6STR", price: 1000000, onStock: 4, category: 6 },
    { model: "sultanrsv8", label: "RCF", price: 1150000, onStock: 3, category: 6 },
    { model: "a80", label: "Supra A80", price: 1250000, onStock: 3, category: 6 },
    { model: "tsgr20", label: "Supra A90", price: 1350000, onStock: 4, category: 6 },
    { model: "peyote2", label: "Peyote Gasser", price: 900000, onStock: 2, category: 6 },


    // sports classics -başl
    { model: "monroec", label: "Monroe Custom", price: 690000, onStock: 2, category: 7 },
    { model: "por930", label: "911 930", price: 1200000, onStock: 3, category: 7 },
    { model: "nebula", label: "Nebula Turbo", price: 555000, onStock: 6, category: 7 },

    //super - başl
    { model: "675ltsp", label: "675LT", price: 1400000, onStock: 0, category: 8 },
    { model: "720s", label: "720S", price: 1400000, onStock: 1, category: 8 },
    { model: "chimera", label: "Chimera", price: 565000, onStock: 6, category: 8 },
    { model: "deathbike", label: "Deathbike", price: 450000, onStock: 5, category: 8 },
    { model: "diablous2", label: "Diabolus Custom", price: 475000, onStock: 9, category: 8 },
    { model: "fcr2", label: "FCR 1000 Custom", price: 1400000, onStock: 6, category: 8 },
    { model: "hakuchou2", label: "Hakuchou Drag", price: 450000, onStock: 4, category: 8 },
    { model: "sanctus", label: "Sanctus", price: 755000, onStock: 4, category: 8 },
    { model: "shotaro", label: "Shotaro", price: 885000, onStock: 1, category: 8 },

    //vans - başl
    { model: "rumpo2", label: "Rumpo HerrKutz", price: 20500, onStock: 10, category: 9 },
]