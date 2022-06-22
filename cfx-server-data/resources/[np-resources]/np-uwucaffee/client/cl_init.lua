
Citizen.CreateThread(function()

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_signon", vector3(-594.62, -1052.38, 22.34), 2, 1, {
        heading=0,
        minZ=22.34-1,
        maxZ=22.34+1,
        data = {
            id="1"
        }
    })

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_shelfstorage", vector3(-587.45, -1059.62, 22.36), 2, 2, {
        heading=34,
        minZ=21.36,
        maxZ=23.36,
        data = {
            id="1"
        }
    })

    --Food

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_station2", vector3(-591.12, -1063.14, 22.34), 1.8, 1.0, {
        heading=0,
        minZ=22.34-1,
        maxZ=22.34+1,
        data = {
            id="1"
        }
    })

    --Drinks
    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_station3", vector3(-587.08, -1061.93, 22.34), 1, 1, {
        heading=0,
        minZ=22.34-1,
        maxZ=22.34+1,
        data = {
            id="1"
        }
    })

    --Drinks2
    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_station3", vector3(-1190.14, -904.47, 13.98), 0.6, 2.2, {
        heading=304,
        minZ=13.98,
        maxZ=14.78,
        data = {
            id="2"
        }
    })

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_register1", vector3(-584.02, -1058.65, 22.34), 0.5, 0.5, {
        heading=35,
        minZ=22.34-1,
        maxZ=22.34+1,
        data = {
            id="1"
        }
    })

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_register2", vector3(-584.01, -1061.42, 22.34), 0.5, 0.5, {
        heading=35,
        minZ=22.34-1,
        maxZ=22.34+1,
        data = {
            id="1"
        }
    })

    exports["np-polytarget"]:AddBoxZone("np-uwucafee:cafeejob_fridge", vector3(-590.96, -1059.19, 22.35), 3, 1, {
        heading=0,
        minZ=22.35-1,
        maxZ=22.35+1,
        data = {
            id="1"
        }
    })

end)
