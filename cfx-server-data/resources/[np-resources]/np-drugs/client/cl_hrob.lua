
local payment = math.random(10, 110)

RegisterNetEvent('sell_goods1')
AddEventHandler('sell_goods1', function()
    if exports["np-inventory"]:hasEnoughOfItem("rolexwatch",25,false) then
            TriggerEvent('inventory:removeItem', 'rolexwatch', 25)
            TriggerServerEvent("pawnshop:sellrolex")
            TriggerEvent('DoLongHudText', 'You successfully sold a Rolexwatches.', 1)
        else
		print("Testing")
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods2')
AddEventHandler('sell_goods2', function()
    if exports["np-inventory"]:hasEnoughOfItem("oxy",20,false) then
            TriggerEvent('inventory:removeItem', 'oxy', 20)
			TriggerServerEvent("pawnshop:selloxy")
			
            TriggerEvent('DoLongHudText', 'You successfully sold oxy bottles.', 1)
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods3')
AddEventHandler('sell_goods3', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolentv",1,false) then
            TriggerEvent('inventory:removeItem', 'stolentv', 1)
            TriggerServerEvent("pawnshop:selltv")
            TriggerEvent('DoLongHudText', 'You successfully sold a TV.', 1)
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods4')
AddEventHandler('sell_goods4', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenart",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenart', 1)
            TriggerServerEvent("pawnshop:sellart")
            TriggerEvent('DoLongHudText', 'You successfully sold a Art.', 1)
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods5')
AddEventHandler('sell_goods5', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolencoffee",1,false) then
            TriggerEvent('inventory:removeItem', 'stolencoffee', 1)
            TriggerServerEvent("pawnshop:sellcoffee")
            TriggerEvent('DoLongHudText', 'You successfully sold a Coffee Machine .', 1)
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods6')
AddEventHandler('sell_goods6', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenmusic",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenmusic', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen Music Equipment.', 1)
			TriggerServerEvent("pawnshop:sellmusic")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods7')
AddEventHandler('sell_goods7', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolencasinowatch",3,false) then
            TriggerEvent('inventory:removeItem', 'stolencasinowatch', 3)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen casino watch.', 1)
			TriggerServerEvent("pawnshop:sellcw")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods8')
AddEventHandler('sell_goods8', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolengameboy",2,false) then
            TriggerEvent('inventory:removeItem', 'stolengameboy', 2)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen gameboy.', 1)
			TriggerServerEvent("pawnshop:sellgameboy")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods9')
AddEventHandler('sell_goods9', function()
    if exports["np-inventory"]:hasEnoughOfItem("stoleniphone",1,false) then
            TriggerEvent('inventory:removeItem', 'stoleniphone', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen Iphone.', 1)
			TriggerServerEvent("pawnshop:selliphone")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods10')
AddEventHandler('sell_goods10', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolennokia",1,false) then
            TriggerEvent('inventory:removeItem', 'stolennokia', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen nokiaphone.', 1)
			TriggerServerEvent("pawnshop:sellnokia")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods11')
AddEventHandler('sell_goods11', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenpsp",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenpsp', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen PSP.', 1)
			TriggerServerEvent("pawnshop:sellpsp")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods12')
AddEventHandler('sell_goods12', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenoakleys",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenoakleys', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen Oakleys.', 1)
			TriggerServerEvent("pawnshop:selloak")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)


RegisterNetEvent('sell_goods13')
AddEventHandler('sell_goods13', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolens8",1,false) then
            TriggerEvent('inventory:removeItem', 'stolens8', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen S8.', 1)
			TriggerServerEvent("pawnshop:sells8")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods14')
AddEventHandler('sell_goods14', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenraybans",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenraybans', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen RayBans.', 1)
			TriggerServerEvent("pawnshop:sellrays")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods15')
AddEventHandler('sell_goods15', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolenmicrowave",1,false) then
            TriggerEvent('inventory:removeItem', 'stolenmicrowave', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen microwave.', 1)
			TriggerServerEvent("pawnshop:sellwave")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods16')
AddEventHandler('sell_goods16', function()
    if exports["np-inventory"]:hasEnoughOfItem("stolencomputer",1,false) then
            TriggerEvent('inventory:removeItem', 'stolencomputer', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold stolen computer.', 1)
			TriggerServerEvent("pawnshop:sellcomputer")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)

RegisterNetEvent('sell_goods17')
AddEventHandler('sell_goods17', function()
    if exports["np-inventory"]:hasEnoughOfItem("goldbar",1,false) then
            TriggerEvent('inventory:removeItem', 'goldbar', 1)
            TriggerEvent('DoLongHudText', 'You successfully sold Gold bars.', 1)
			TriggerServerEvent("pawnshop:sellgold")
        else
            TriggerEvent('DoLongHudText', 'Not enough', 2)
    end
end)


RegisterNetEvent('np-pawnshop:sell', function()
    TriggerEvent('np-context:sendMenu', {
        {
            id = 0,
            header = "Misc Sells",
            txt = "",
            params = {
                event = "",
            },
        },
        {
            id = 1,
            header = "Sell Rolexwatches",
            txt = "Sell your watches",
            params = {
                event = "sell_goods1",
            },
        },
        {
            id = 2,
            header = "Sell Oxy's",
            txt = "Sell your bottles",
            params = {
            event = "sell_goods2",
            },
        },  
        {
            id = 3,
            header = "Sell a TV",
            txt = "Sell this Thick TV",
            params = {
            event = "sell_goods3",
            },
        },  
        {
            id = 4,
            header = "Sell Art Piece",
            txt = "Sell this GIANT THING!",
            params = {
            event = "sell_goods4",
             },
        },  
        {
            id = 5,
            header = "Sell MicroWave",
            txt = "Sell this toaster",
            params = {
            event = "sell_goods5",
            },
        },  
        {
            id = 6,
            header = "Sell Music",
            txt = "Sell this slapper",
            params = {
            event = "sell_goods6",
            },
        },
        {
            id = 7,
            header = "Sell Watches",
            txt = "Looks like it from Casino",
            params = {
            event = "sell_goods7",
            },
        },
        {
            id = 8,
            header = "Sell Gameboy",
            txt = "Sell this oldschool ting",
            params = {
            event = "sell_goods8",
            },
        },
        {
            id = 9,
            header = "Sell Iphone",
            txt = "Sell this overused phone",
            params = {
            event = "sell_goods9",
            },
        },
        {
            id = 10,
            header = "Sell Nokia",
            txt = "Sell flip phone",
            params = {
            event = "sell_goods10",
            },
        },
        {
            id = 11,
            header = "Sell PSP",
            txt = "Sell this oldschool ting",
            params = {
            event = "sell_goods11",
            },
        },
        {
            id = 12,
            header = "Sell Oakleys",
            txt = "Sell shades",
            params = {
            event = "sell_goods12",
            },
        },
        {
            id = 13,
            header = "Sell Samsung8",
            txt = "Sell a better phone than iphone",
            params = {
            event = "sell_goods13",
            },
        },
        {
            id = 14,
            header = "Sell RayBans",
            txt = "Sell this awesome glasses",
            params = {
            event = "sell_goods14",
            },
        },
        {
            id = 15,
            header = "Sell Microwave",
            txt = "Sell this toaster",
            params = {
            event = "sell_goods15",
            },
        },
        {
            id = 16,
            header = "Sell Computer",
            txt = "Sell this Beast of a PC",
            params = {
            event = "sell_goods16",
            },
        },
        {
            id = 17,
            header = "Sell Gold",
            txt = "Got Gold?",
            params = {
            event = "sell_goods17",
            },
        },
        {
            id = 18,
            header = "Close menu",
			txt = "",
			params = {
                event = "",
            }
        },
    })
end)








  exports["np-polytarget"]:AddBoxZone("sell_goods", vector3(-278.78, 2205.87, 129.82), 0.8, 0.6, {
    heading=0
  })