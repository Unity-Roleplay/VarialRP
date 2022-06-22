--[[######################################################

TEMPIE WROTE THIS ALL BITCHES!


######################################################]]



RegisterNetEvent('speaktowean')
AddEventHandler('speaktowean', function()
    if exports["np-inventory"]:hasEnoughOfItem("vpnxja",1,false) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        local finished = exports["np-taskbar"]:taskBar(2000,"Speaking to BJS")
        if finished == 100 then
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent("weanmenu")
            TriggerEvent('DoLongHudText', 'What are you in need of?', 1)
        else
            TriggerEvent('DoLongHudText', 'Wean - You missing shit, Get outta here', 2)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText', 'A vpn could be useful for this!', 2)
    end
end)

--Fleeca Robbery

RegisterNetEvent('FleecaShit')
AddEventHandler('FleecaShit', function()
	FreezeEntityPosition(GetPlayerPed(-1),true)
    if exports["np-inventory"]:hasEnoughOfItem("heistusb4",1,false) then
		FreezeEntityPosition(GetPlayerPed(-1),false)
		TriggerEvent("player:receiveItem", "heistlaptop3", 1)
		TriggerServerEvent("fleeca")
		TriggerEvent("phone:addnotification", "Wean","Fleeca Bank Time! Don't screw this up.")
		TriggerEvent("inventory:removeItem", "heistusb4", 1)
	else
		TriggerEvent('DoLongHudText', 'Wean - You missing shit, Get outta here', 2)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end
end)

RegisterNetEvent('PaletoBank')
AddEventHandler('PaletoBank', function()
	FreezeEntityPosition(GetPlayerPed(-1),true)
    if exports["np-inventory"]:hasEnoughOfItem("heistusb1",1,false) then
		FreezeEntityPosition(GetPlayerPed(-1),false)
		TriggerEvent("player:receiveItem", "heistlaptop2", 1)
		TriggerServerEvent("PaletoBank")
		TriggerEvent("phone:addnotification", "Wean","Paleto Bank Time! Don't screw this up.")
		TriggerEvent("inventory:removeItem", "heistusb1", 1)
	else
		TriggerEvent('DoLongHudText', 'Wean - You missing shit, Get outta here', 2)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end
end)

RegisterNetEvent('BigBank')
AddEventHandler('BigBank', function()
	FreezeEntityPosition(GetPlayerPed(-1),true)
    if exports["np-inventory"]:hasEnoughOfItem("heistusb2",1,false) then
		FreezeEntityPosition(GetPlayerPed(-1),false)
		TriggerEvent("player:receiveItem", "heistlaptop4", 1)
		TriggerServerEvent("BigBank")
		TriggerEvent("phone:addnotification", "Wean","BIG Bank Time! Don't screw this up.")
		TriggerEvent("inventory:removeItem", "heistusb2", 1)
	else
		TriggerEvent('DoLongHudText', 'Wean - You missing shit, Get outta here', 2)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end
end)

RegisterNetEvent('BigBank2')
AddEventHandler('BigBank2', function()
	FreezeEntityPosition(GetPlayerPed(-1),true)
    if exports["np-inventory"]:hasEnoughOfItem("heistusb3",1,false) then
		FreezeEntityPosition(GetPlayerPed(-1),false)
		TriggerEvent("player:receiveItem", "heistlaptop1", 1)
		TriggerServerEvent("BigBank")
		--TriggerEvent("phone:addnotification", "Wean","BIG Bank Time! Don't screw this up.")
		TriggerEvent("inventory:removeItem", "heistusb2", 1)
	else
		TriggerEvent('DoLongHudText', 'Wean - You missing shit, Get outta here', 2)
		FreezeEntityPosition(GetPlayerPed(-1),false)
	end
end)

RegisterNetEvent("weanmenu")
AddEventHandler("weanmenu", function()
	TriggerEvent('np-context:sendMenu', {
		{
			id = "1",
			header = "Green Laptop",
			txt = "Must have Reqs",
			params = {
				event = "FleecaShit",

			}
		},
		{
			id = "2",
			header = "Blue Laptop",
			txt = "Must have Reqs",
			params = {
				event = "PaletoBank",
			}
		},
		{
			id = "3",
			header = "Red Laptop",
			txt = "Must have Reqs",
			params = {
				event = "BigBank",
			}
		},
		{
			id = "4",
			header = "Gold Laptop",
			txt = "Must have Reqs",
			params = {
				event = "BigBank",
			}
		},
		{
			id = "5",
			header = "Close Menu",
			txt = "Fuck Wean",
			params = {
				event = "",
			}
		},
	})
end)

exports["np-polytarget"]:AddBoxZone("wean_laptop", vector3(-1359.3, -760.39, 22.3), 1, 1, {
    heading=0
  })