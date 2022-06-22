local methlocation = { ['x'] = 1763.75,['y'] = 2499.44,['z'] = 50.43,['h'] = 213.58, ['info'] = ' cell1' }
------------------------------
--FONCTIONS
-------------------------------
local cellcoords = { 
	[1] =  { ['x'] = 1763.75,['y'] = 2499.44,['z'] = 50.43,['h'] = 213.58, ['info'] = ' cell1' },
	[2] =  { ['x'] = 1761.18,['y'] = 2497.56,['z'] = 50.43,['h'] = 208.44, ['info'] = ' cell2' },
	[3] =  { ['x'] = 1758.35,['y'] = 2495.69,['z'] = 50.43,['h'] = 201.86, ['info'] = ' cell3' },
	[4] =  { ['x'] = 1755.23,['y'] = 2494.2,['z'] = 50.43,['h'] = 202.71, ['info'] = ' cell4' },
	[5] =  { ['x'] = 1752.35,['y'] = 2492.39,['z'] = 50.43,['h'] = 201.77, ['info'] = ' cell5' },
	[6] =  { ['x'] = 1749.21,['y'] = 2490.48,['z'] = 50.43,['h'] = 212.78, ['info'] = ' cell6' },
	[7] =  { ['x'] = 1745.86,['y'] = 2488.94,['z'] = 50.43,['h'] = 213.06, ['info'] = ' cell7' },
	[8] =  { ['x'] = 1743.28,['y'] = 2486.98,['z'] = 50.43,['h'] = 212.35, ['info'] = ' cell8' },
	[9] =  { ['x'] = 1743.2,['y'] = 2486.85,['z'] = 45.82,['h'] = 212.24, ['info'] = ' cell9' },
	[10] =  { ['x'] = 1745.87,['y'] = 2489.08,['z'] = 45.82,['h'] = 208.68, ['info'] = ' cell10' },
	[11] =  { ['x'] = 1748.99,['y'] = 2490.77,['z'] = 45.82,['h'] = 202.26, ['info'] = ' cell11' },
	[12] =  { ['x'] = 1752.14,['y'] = 2492.47,['z'] = 45.82,['h'] = 208.49, ['info'] = ' cell12' },
	[13] =  { ['x'] = 1755.08,['y'] = 2494.0,['z'] = 45.82,['h'] = 212.58, ['info'] = ' cell13' },
	[14] =  { ['x'] = 1761.12,['y'] = 2497.27,['z'] = 45.83,['h'] = 215.37, ['info'] = ' cell14' },
	[15] =  { ['x'] = 1763.93,['y'] = 2499.34,['z'] = 45.83,['h'] = 217.65, ['info'] = ' cell15' },
	[16] =  { ['x'] = 1772.74,['y'] = 2482.72,['z'] = 50.43,['h'] = 24.74, ['info'] = ' cell16' },
	[17] =  { ['x'] = 1769.67,['y'] = 2480.9,['z'] = 50.43,['h'] = 29.66, ['info'] = ' cell17' },
	[18] =  { ['x'] = 1766.94,['y'] = 2479.04,['z'] = 50.43,['h'] = 32.87, ['info'] = ' cell18' },
	[19] =  { ['x'] = 1763.79,['y'] = 2477.64,['z'] = 50.42,['h'] = 22.54, ['info'] = ' cell19' },
	[20] =  { ['x'] = 1760.55,['y'] = 2476.16,['z'] = 50.42,['h'] = 38.85, ['info'] = ' cell20' },
	[21] =  { ['x'] = 1757.82,['y'] = 2473.99,['z'] = 50.42,['h'] = 32.59, ['info'] = ' cell21' },
	[22] =  { ['x'] = 1754.61,['y'] = 2472.72,['z'] = 50.42,['h'] = 38.6, ['info'] = ' cell22' },
	[23] =  { ['x'] = 1751.35,['y'] = 2470.67,['z'] = 50.42,['h'] = 31.17, ['info'] = ' cell23' },
	[24] =  { ['x'] = 1772.55,['y'] = 2483.08,['z'] = 45.82,['h'] = 33.01, ['info'] = ' cell24' },
	[26] =  { ['x'] = 1769.41,['y'] = 2481.15,['z'] = 45.82,['h'] = 32.61, ['info'] = ' cell25' },
	[27] =  { ['x'] = 1766.78,['y'] = 2478.99,['z'] = 45.82,['h'] = 27.96, ['info'] = ' cell26' },
	[28] =  { ['x'] = 1763.71,['y'] = 2477.66,['z'] = 45.82,['h'] = 33.65, ['info'] = ' cell27' },
	[29] =  { ['x'] = 1760.7,['y'] = 2475.73,['z'] = 45.82,['h'] = 30.13, ['info'] = ' cell28' },
	[30] =  { ['x'] = 1757.74,['y'] = 2473.94,['z'] = 45.82,['h'] = 29.95, ['info'] = ' cell29' },
	[31] =  { ['x'] = 1754.95,['y'] = 2471.86,['z'] = 45.82,['h'] = 40.79, ['info'] = ' cell30' },
	[32] =  { ['x'] = 1751.72,['y'] = 2470.46,['z'] = 45.82,['h'] = 13.22, ['info'] = ' cell31' },

}

local tool_shops = {
	{ ['x'] = 44.838947296143, ['y'] = -1748.5364990234, ['z'] = 29.549386978149 },
	{ ['x'] = 2749.2309570313, ['y'] = 3472.3308105469, ['z'] = 55.679393768311 },
}

local twentyfourseven_shops = {
	{ ['x'] = 25.925277709961, ['y'] = -1347.4022216797, ['z'] = 29.482055664062},
    { ['x'] = -48.34285736084, ['y'] = -1757.7890625, ['z'] = 29.414672851562},
    { ['x'] = -707.9208984375, ['y'] = -914.62414550781, ['z'] = 19.20361328125},
    { ['x'] = 1135.6878662109, ['y'] = -981.71868896484, ['z'] = 46.399291992188},
    { ['x'] = -1223.6307373047, ['y'] = -906.76483154297, ['z'] = 12.312133789062},
    { ['x'] = 373.81979370117, ['y'] = 326.0439453125, ['z'] = 103.55383300781},
    { ['x'] = 1163.6439208984, ['y'] = -324.13186645508, ['z'] = 69.197021484375},
    { ['x'] = -2968.298828125, ['y'] = 390.59341430664, ['z'] = 15.041748046875},
    { ['x'] = -3242.4658203125, ['y'] = 1001.6703491211, ['z'] = 12.817626953125},
    { ['x'] = -1820.7427978516, ['y'] = 792.36926269531, ['z'] = 138.11279296875},
    { ['x'] = 2557.1472167969, ['y'] = 382.12747192383,['z'] = 108.60876464844},
    { ['x'] = 2678.8879394531, ['y'] = 3280.3911132812, ['z'] = 55.228515625},
    { ['x'] = 1961.5648193359, ['y'] = 3740.6901855469, ['z'] = 32.329711914062},
    { ['x'] = 1392.3824462891, ['y'] = 3604.5495605469, ['z'] = 34.97509765625},
    { ['x'] = 1698.158203125, ['y'] = 4924.404296875, ['z'] = 42.052001953125},
    { ['x'] = 1728.9230957031, ['y'] = 6414.3823242188, ['z'] = 35.025634765625},
    { ['x'] = 1166.4000244141, ['y'] = 2709.1647949219, ['z'] = 38.142822265625},
    { ['x'] = 547.49011230469, ['y'] = 2671.2131347656, ['z'] = 42.153076171875},
    --{ ['x'] = 460.9186706543,['y'] = -982.31207275391, ['z'] = 30.678344726562},
    --{ ['x'] = 448.23297119141, ['y'] = -973.95166015625, ['z'] = 34.958251953125},
    { ['x'] = 1841.3670654297, ['y'] = 2591.2878417969,['z'] = 46.01171875},
}

local weashop_locations = {
	{entering = {811.973572,-2155.33862,28.8189938}, inside = {811.973572,-2155.33862,28.8189938}, outside = {811.973572,-2155.33862,28.8189938},delay = 900},
	{entering = { 1692.54, 3758.13, 34.71}, inside = { 1692.54, 3758.13, 34.71}, outside = { 1692.54, 3758.13, 34.71},delay = 600},
	{entering = {252.915,-48.186,69.941}, inside = {252.915,-48.186,69.941}, outside = {252.915,-48.186,69.941},delay = 600},
	{entering = {844.352,-1033.517,28.094}, inside = {844.352,-1033.517,28.194}, outside = {844.352,-1033.517,28.194},delay = 780},
	{entering = {-331.487,6082.348,31.354}, inside = {-331.487,6082.348,31.454}, outside = {-331.487,6082.348,31.454},delay = 600},
	{entering = {-664.268,-935.479,21.729}, inside = {-664.268,-935.479,21.829}, outside = {-664.268,-935.479,21.829},delay = 600},
	{entering = {-1305.427,-392.428,36.595}, inside = {-1305.427,-392.428,36.695}, outside = {-1305.427,-392.428,36.695},delay = 600},
	{entering = {-1119.1, 2696.92, 18.56}, inside = {-1119.1, 2696.92, 18.56}, outside = {-1119.1, 2696.92, 18.56},delay = 600},
	{entering = {2569.978,294.472,108.634}, inside = {2569.978,294.472,108.734}, outside = {2569.978,294.472,108.734},delay = 800},
	{entering = {-3172.584,1085.858,20.738}, inside = {-3172.584,1085.858,20.838}, outside = {-3172.584,1085.858,20.838},delay = 600},
	{entering = {20.0430,-1106.469,29.697}, inside = {20.0430,-1106.469,29.797}, outside = {20.0430,-1106.469,29.797},delay = 600},
}


local weashop_blips = {}

RegisterNetEvent("shop:createMeth")
AddEventHandler("shop:createMeth", function()
	methlocation = cellcoords[math.random(#cellcoords)]
end)


RegisterNetEvent("shop:isNearPed")
AddEventHandler("shop:isNearPed", function()
	local pedpos = GetEntityCoords(PlayerPedId())
	local found = false
	for k,v in ipairs(twentyfourseven_shops)do
		local dist = #(vector3(v.x, v.y, v.z) - vector3(pedpos.x,pedpos.y,pedpos.z))
		if(dist < 10 and not found)then
			found = true
			TriggerServerEvent("exploiter", "User sold to a shop keeper at store.")
		end
	end
end)

function setShopBlip()

	for station,pos in pairs(weashop_locations) do
		local loc = pos
		pos = pos.entering
		local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
		-- 60 58 137
		SetBlipSprite(blip,110)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 17)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Ammunation')
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,true)
		SetBlipAsMissionCreatorBlip(blip,true)
		weashop_blips[#weashop_blips+1]= {blip = blip, pos = loc}
	end

	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Shop")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in ipairs(tool_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 52)
		SetBlipScale(blip, 0.7)
		SetBlipColour(blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Tool Shop")
		EndTextCommandSetBlipName(blip)
	end	

end
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


Citizen.CreateThread(function()
	setShopBlip()
	while true do
		local found = false
		local dstscan = 3.0
		local pos = GetEntityCoords(PlayerPedId(), false)
		Citizen.Wait(1)
			if(Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 10.0)then
				found = true
				if(Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 5.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ what dis?")
					if IsControlJustPressed(1, 38) then
					local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
				  		if (finished == 100) and Vdist(methlocation["x"],methlocation["y"],methlocation["z"], pos.x, pos.y, pos.z) < 2.0 then
						TriggerEvent("server-inventory-open", "25", "Shop");
						Wait(1000)
					end
				end
			end
		end
	end
end)

RegisterNetEvent('np-shops:exchangeGold')
AddEventHandler('np-shops:exchangeGold', function()
	if exports["np-inventory"]:hasEnoughOfItem("goldbar",70,true) then
		local finished = exports["np-taskbar"]:taskBar(120000,"Trading Bars")
		if finished == 100 then
			if exports["np-inventory"]:hasEnoughOfItem("goldbar",70,true) then
				TriggerServerEvent('np-banking:addMoney', 35000)
				TriggerEvent("inventory:removeItem", "goldbar", 70)
			else
				TriggerEvent("DoLongHudText", "Does not look like you have enough gold bars!", 2)
			end
		else
			TriggerEvent("DoLongHudText", "Does not look like you have enough gold bars!", 2)
		end
	end
end)


RegisterNetEvent('shop:general')
AddEventHandler('shop:general', function()
	TriggerEvent("server-inventory-open", "2", "Shop")
	Wait(1000)
end)
RegisterNetEvent('produceshop:general')
AddEventHandler('produceshop:general', function()
	TriggerEvent("server-inventory-open", "12", "Shop")
	Wait(1000)
end)

RegisterNetEvent('weed:store')
AddEventHandler('weed:store', function()
	TriggerEvent("server-inventory-open", "714", "Shop")
	Wait(1000)
end)


RegisterNetEvent('police:general')
AddEventHandler('police:general', function()
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "10", "Shop");	
		Wait(1000)
	else
	end
end)

RegisterNetEvent('toolshop:general')
AddEventHandler('toolshop:general', function()
	TriggerEvent("server-inventory-open", "4", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('parachute:general')
AddEventHandler('parachute:general', function()
	TriggerEvent("server-inventory-open", "0412", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('evidence:general')
AddEventHandler('evidence:general', function()
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "trash-1")
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	else
	end
end)

RegisterNetEvent('personallocker:general')
AddEventHandler('personallocker:general', function()
	local cid = exports["isPed"]:isPed("cid")
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "personalMRPD-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	else
	end
end)

RegisterNetEvent('personallocker2:general')
AddEventHandler('personallocker2:general', function()
	local cid = exports["isPed"]:isPed("cid")
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "personalSandy-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	else
	end
end)

RegisterNetEvent('personallocker3:general')
AddEventHandler('personallocker3:general', function()
	local cid = exports["isPed"]:isPed("cid")
	local job = exports["isPed"]:isPed("myJob")
	if (job == "police") then
		TriggerEvent("server-inventory-open", "1", "personalPaleto-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	else
	end
end)

RegisterNetEvent('emslocker:general')
AddEventHandler('emslocker:general', function()
    local cid = exports["isPed"]:isPed("cid")
    local job = exports["isPed"]:isPed("myJob")
    if (job == "ems") then
        TriggerEvent("server-inventory-open", "1", "personalEMS-"..cid)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
        Wait(1000)
    else
    end
end)

RegisterNetEvent('prisonap:general')
AddEventHandler('prisonap:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "26", "Shop");
	  	Wait(1000)
  	end
end)


RegisterNetEvent('prisonlp:general')
AddEventHandler('prisonlp:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"Searching...")
	if (finished == 100) then
	  	TriggerEvent("server-inventory-open", "23", "Craft");
	  	Wait(1000)
  	end
end)


RegisterNetEvent('slushy:general')
AddEventHandler('slushy:general', function()
	ExecuteCommand("e handshake")
	local finished = exports ["np-ui"]:taskBarSkill(18000,math.random(10,20))
	if (finished == 100) then
		ExecuteCommand("e handshake")
		local finished = exports ["np-ui"]:taskBarSkill(18000,math.random(10,20))
		if (finished == 100) then
			ExecuteCommand("e handshake")
			local finished = exports ["np-ui"]:taskBarSkill(18000,math.random(10,20))
			if (finished == 100) then
		TriggerEvent("server-inventory-open", "998", "Shop")
		Wait(1000)
			end
		end
	end
end)

RegisterNetEvent('lockpickshit:general')
AddEventHandler('lockpickshit:general', function()
	local finished = exports["np-taskbar"]:taskBar(60000,"What dis????")
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "205", "Shop")
		Wait(1000)
	end
end)

RegisterNetEvent('pfood:general')
AddEventHandler('pfood:general', function()
	TriggerEvent("server-inventory-open", "22", "Shop")
	Wait(1000)
end)

RegisterNetEvent('ak_customs:Stash')
AddEventHandler('ak_customs:Stash', function()
    local job = exports["isPed"]:GroupRank('ak_customs')
    if job >= 2 then
		TriggerEvent("server-inventory-open", "1", "storage-ak-customs")
		Wait(1000)
	end
end)

RegisterNetEvent('aod:stash')
AddEventHandler('aod:stash', function()
    local job = exports["isPed"]:GroupRank('aod')
    if job >= 1 then
		TriggerEvent("server-inventory-open", "1", "AOD storage")
		Wait(1000)
	end
end)

RegisterNetEvent('tuner2:stash')
AddEventHandler('tuner2:stash', function()
    local job = exports["isPed"]:GroupRank('ak_customs')
    if job >= 2 then
		TriggerEvent("server-inventory-open", "1", "storage-tunerharm")
		Wait(1000)
	end
end)

RegisterNetEvent('tuner3:stash')
AddEventHandler('tuner3:stash', function()
    local job = exports["isPed"]:GroupRank('ak_customs')
    if job >= 4 then
		TriggerEvent("server-inventory-open", "1", "storage-tunerpersonal")
		Wait(1000)
	end
end)

RegisterNetEvent('harmony:stash')
AddEventHandler('harmony:stash', function()
    local job = exports["isPed"]:GroupRank('harmony_autos')
    if job >= 1 then
		TriggerEvent("server-inventory-open", "1", "storage-harmonypersonal")
		Wait(1000)
	end
end)

RegisterNetEvent('illegal:stash')
AddEventHandler('illegal:stash', function()
	local rankX = exports["isPed"]:GroupRank("illegal_shop")
	if rankX > 4 then 
		TriggerEvent("server-inventory-open", "1", "storage-illegalshop")
		Wait(1000)
	else
	end
end)

RegisterNetEvent("illegal:crafting")
AddEventHandler("illegal:crafting", function()
	ExecuteCommand('e search')
	local finished = exports['np-taskbar']:taskBar(12000, 'Inspecting Table')
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "31", "Craft")
		Wait(1000)
	end
end)

-- RegisterNetEvent('smelt:crafting')
-- AddEventHandler('smelt:crafting', function()
-- 	local finished = exports['np-taskbar']:taskBar(20000, 'Smelting')
-- 	if (finished == 100) then
-- 		TriggerEvent("server-inventory-open", "17", "Craft");	
-- 		Wait(1000)
-- 	end
-- end)

RegisterNetEvent('ugcasino:stash')
AddEventHandler('ugcasino:stash', function()
	local rankZ = exports["isPed"]:GroupRank("ug_casino")
	if rankZ >= 4 then 
		TriggerEvent("server-inventory-open", "1", "storage-ugcasino")
		Wait(1000)
	else
	end
end)

RegisterNetEvent("ugcasino:wineCabinet")
AddEventHandler("ugcasino:wineCabinet", function()
	local rankZ = exports["isPed"]:GroupRank("ug_casino")
	if rankZ >= 1 then
		TriggerEvent("server-inventory-open", "1", "wineCabinet-ugcasino")
		Wait(1000)
	end
end)

RegisterNetEvent("ugcasinobarcraft")
AddEventHandler("ugcasinobarcraft", function()
	local rankZ = exports["isPed"]:GroupRank("ug_casino")
	if rankZ >= 1 then
		TriggerEvent("server-inventory-open", "226", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent("ugcasinoshop:general")
AddEventHandler("ugcasinoshop:general", function()
	local rankZ = exports["isPed"]:GroupRank("ug_casino")
	if rankZ >= 1 then
		TriggerEvent("server-inventory-open", "221", "Shop");	
		Wait(1000)
	end
end)




RegisterNetEvent('smelt:crafting')
AddEventHandler('smelt:crafting', function()
	local finished = exports['np-taskbar']:taskBar(20000, 'Smelting')
	if (finished == 100) then
		TriggerEvent("server-inventory-open", "17", "Craft");	
		Wait(1000)
	end
end)

---- Ak Customs -------------------------------------------------------------------------------
RegisterNetEvent('tuner:crafting')
AddEventHandler('tuner:crafting', function()
    local job = exports["isPed"]:GroupRank('ak_customs')
    if job >= 3 then
		TriggerEvent("server-inventory-open", "206", "Craft");	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "You are not a ak customs worker!", 2)
    end
end)

RegisterNetEvent('akpersonallocker:general')
AddEventHandler('akpersonallocker:general', function()
	local cid = exports["isPed"]:isPed("cid")
	local job = exports["isPed"]:GroupRank('ak_customs')
	if job >= 1 then
		TriggerEvent("server-inventory-open", "1", "personalAk-"..cid)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'LockerOpen', 0.4)
		Wait(1000)
	else
	end
end)



---- EMS ----------------------------------------------------------------------------------

RegisterNetEvent('ems:general')
AddEventHandler('ems:general', function()
	local job = exports["isPed"]:isPed("myJob")
	if (job == "ems" or job == "doctor") then
		TriggerEvent("server-inventory-open", "15", "Shop");	
	else
		TriggerEvent("server-inventory-open", "29", "Shop");	
	end
end)

RegisterNetEvent("np-shops:redCounter")
AddEventHandler("np-shops:redCounter", function()
    TriggerEvent("server-inventory-open", "1", "redcircle_counter");
end)

RegisterNetEvent("np-shops:redCounter2")
AddEventHandler("np-shops:redCounter2", function()
    TriggerEvent("server-inventory-open", "1", "redcircle_counter2");
end)

local WLicense = false
RegisterNetEvent("weapon:general:yes")
AddEventHandler("weapon:general:yes", function(allowed)
    WLicense = true
end) 


RegisterNetEvent("weapon:general:no")
AddEventHandler("weapon:general:no", function(allowed)
    WLicense = false
end)

RegisterNetEvent('weapon:general')
AddEventHandler('weapon:general', function()
    TriggerServerEvent("weapon:general:check")
    Wait(1000)
    if WLicense == true then
        print("hello?")
        TriggerEvent("server-inventory-open", "5", "Shop");
        Wait(1000)
    elseif WLicense == false then
        TriggerEvent("server-inventory-open", "6", "Shop");
        Wait(1000)
        TriggerEvent("DoLongHudText", "You dont have an active Weapons License, contact the Police to purchase one.", 2)
    end
end)

RegisterNetEvent('huntingbuy:general')
AddEventHandler('huntingbuy:general', function()
	TriggerEvent("server-inventory-open", "209", "Shop");
	Wait(1000)
end)


RegisterNetEvent("hunting:level1")
AddEventHandler("hunting:level1", function()
	if exports["np-inventory"]:getQuantity("coyotepelt") >= 1 then
		playerAnim()
		local finished = exports["np-taskbar"]:taskBar(4000,"Selling Coyotepelt",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("coyotepelt") >= 1 then
				ClearPedTasksImmediately(PlayerPedId())
				TriggerEvent('inventory:removeItem', 'coyotepelt', 1)
				TriggerServerEvent('np-banking:addMoney', math.random(80, 150))
			else
				TriggerEvent("DoLongHudText", "Might want to try again you do not have a coyotepelt in your pockets", 2)
			end
		end
	else
		TriggerEvent("DoLongHudText", "You do not have enough coyotepelt to sell!", 2)
	end
end)


RegisterNetEvent("hunting:level2")
AddEventHandler("hunting:level2", function()
	if exports["np-inventory"]:getQuantity("buck") >= 1 then
		playerAnim()
		local finished = exports["np-taskbar"]:taskBar(4000,"Selling Buck",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("buck") >= 1 then
				ClearPedTasksImmediately(PlayerPedId())
				TriggerEvent('inventory:removeItem', 'buck', 1)
				TriggerServerEvent('np-banking:addMoney', math.random(160, 200))
			else
				TriggerEvent("DoLongHudText", "Might want to try again you do not have a buck in your pockets", 2)
			end
		end
	else
		TriggerEvent("DoLongHudText", "You do not have enough buck to sell!", 2)
	end
end)

RegisterNetEvent("hunting:level3")
AddEventHandler("hunting:level3", function()
	if exports["np-inventory"]:getQuantity("boar") >= 1 then
		playerAnim()
		local finished = exports["np-taskbar"]:taskBar(4000,"Selling Boar",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("boar") >= 1 then
				ClearPedTasksImmediately(PlayerPedId())
				TriggerEvent('inventory:removeItem', 'boar', 1)
				TriggerServerEvent('np-banking:addMoney', math.random(350, 500))
			else
				TriggerEvent("DoLongHudText", "Might want to try again you do not have a boar in your pockets", 2)
			end
		end
	else
		TriggerEvent("DoLongHudText", "You do not have enough boar to sell!", 2)
	end
end)


-- function menuHunting()
--     exports['np-menuinteract']:AddButton("Sell Coyotepelt", "Wow you suck", "hunting:level1", 'example button 1', "jobmenu")
--     exports['np-menuinteract']:AddButton("Sell Buck", "Wow you kinda okay", "hunting:level2", 'example button 2', "jobmenu")
--     exports['np-menuinteract']:AddButton("Sell Boar", "Wow you good", "hunting:level3", 'example button 3', "jobmenu")
--     exports['np-menuinteract']:SubMenu("Hunting Menu" , "Click to select sell!" , "jobmenu")
-- end

--[[RegisterNetEvent("np-scoreboard:playerscount")
AddEventHandler("np-scoreboard:playerscount", function(a)
    SetRichPresence(a .. "/90 | Getting more knowledge")
    SetDiscordAppId(824438525302407189)
    SetDiscordRichPresenceAsset('logo')
    SetDiscordRichPresenceAction(0, 'Join Today!', 'https://discord.gg/logicrp')
end)]]

RegisterNetEvent('bar:general')
AddEventHandler('bar:general', function()
	local rankJ = exports["isPed"]:GroupRank("casino")
	if rankJ > 0 then 
		TriggerEvent("server-inventory-open", "226", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('barshop:general')
AddEventHandler('barshop:general', function()
	local rankJ = exports["isPed"]:GroupRank("casino")
	if rankJ > 0 then 
		TriggerEvent("server-inventory-open", "221", "Shop");	
		Wait(1000)
	end
end)

RegisterNetEvent('redcirclebar:general')
AddEventHandler('redcirclebar:general', function()
	local rankQ = exports["isPed"]:GroupRank("redcircle")
	if rankQ > 0 then 
		TriggerEvent("server-inventory-open", "226", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('redcirclebarshop:general')
AddEventHandler('redcirclebarshop:general', function()
	local rankQ = exports["isPed"]:GroupRank("redcircle")
	if rankQ > 0 then 
		TriggerEvent("server-inventory-open", "221", "Shop");	
		Wait(1000)
	end
end)

RegisterNetEvent('bean:craft')
AddEventHandler('bean:craft', function()
	local job = exports["isPed"]:GroupRank('radical_coffee')
    if job >= 1 then
	TriggerEvent("server-inventory-open", "888", "Craft");	
	Wait(1000)
else
	TriggerEvent("DoLongHudText", "Your not a Radical Coffee Employee", 2)
	end
end)

-- Yakuza ---------------------------------------

RegisterNetEvent('yakuza:crafting')
AddEventHandler('yakuza:crafting', function()
    local job = exports["isPed"]:GroupRank('yakuza')
    if job >= 5 then
		TriggerEvent("server-inventory-open", "666999", "Craft");	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "性交オフ", 2)
    end
end)

RegisterNetEvent("yakuza:stash")
AddEventHandler("yakuza:stash", function()
	local job = exports["isPed"]:GroupRank('yakuza')
	if job >= 4 then
		TriggerEvent("server-inventory-open", "1", "storage-yakuza")	
		Wait(1000)
	else
		TriggerEvent("DoLongHudText", "性交オフ", 2)
	end
end)

RegisterNetEvent('libertycraft:general')
AddEventHandler('libertycraft:general', function()
	local rankQ = exports["isPed"]:GroupRank("redcircle")
	if rankQ > 0 then 
		TriggerEvent("server-inventory-open", "500", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('libertystorage:general')
AddEventHandler('libertystorage:general', function()
	local rankQ = exports["isPed"]:GroupRank("redcircle")
	if rankQ > 0 then 
		TriggerEvent("server-inventory-open", "1", "libertystorage:general")
		Wait(1000)
	else
	end
end)

RegisterNetEvent('vubar:general')
AddEventHandler('vubar:general', function()
	local jobs = exports["isPed"]:GroupRank('vanilla_unicorn')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "226", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('vucoke:general')
AddEventHandler('vucoke:general', function()
	local jobs = exports["isPed"]:GroupRank('vanilla_unicorn')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "504", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('vucoke:stash')
AddEventHandler('vucoke:stash', function()
	local jobs = exports["isPed"]:GroupRank('vanilla_unicorn')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "vu:storage")
		Wait(1000)
	end
end)

RegisterNetEvent('vubarshop:general')
AddEventHandler('vubarshop:general', function()
	local jobs = exports["isPed"]:GroupRank('vanilla_unicorn')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "221", "Shop");	
		Wait(1000)
	end
end)

RegisterNetEvent('casino:armory')
AddEventHandler('casino:armory', function()
	local rankJ = exports["isPed"]:GroupRank("casino")
	if rankJ > 0 then 
		TriggerEvent("server-inventory-open", "1", "casino-armory")
		Wait(1000)
	else
	end
end)

RegisterNetEvent('casino:membershipcards')
AddEventHandler('casino:membershipcards', function()
	local rankJ = exports["isPed"]:GroupRank("casino")
	if rankJ > 0 then 
		TriggerEvent("server-inventory-open", "1", "membership-cards")
		Wait(1000)
	else
	end
end)

RegisterNetEvent('artgallery:storage')
AddEventHandler('artgallery:storage', function()
	local jobs = exports["isPed"]:GroupRank('art_gallery')
	if jobs > 0 then 
		TriggerEvent("server-inventory-open", "1", "artgallery:storage")
		Wait(1000)
	else
	end
end)

RegisterNetEvent('artcounter:storage')
AddEventHandler('artcounter:storage', function()
	local jobs = exports["isPed"]:GroupRank('art_gallery')
	if jobs > 0 then 
		TriggerEvent("server-inventory-open", "1", "artcounter:storage")
		Wait(1000)
	else
	end
end)

RegisterNetEvent('libertystorage:general')
AddEventHandler('libertystorage:general', function()
	local jobs = exports["isPed"]:GroupRank('TLB')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "libertystorage:general")
		Wait(1000)
	end
end)

RegisterNetEvent('suitsstorage:general')
AddEventHandler('suitsstorage:general', function()
	local rankJ = exports["isPed"]:GroupRank("suits")
	if rankJ >= 3 then 
		TriggerEvent("server-inventory-open", "1", "suitsstorage:general")
		Wait(1000)
	end
end)

RegisterNetEvent('mibstorage:general')
AddEventHandler('mibstorage:general', function()
	local jobs = exports["isPed"]:GroupRank('winery')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "mibstorage:general")
		Wait(1000)
	end
end)

RegisterNetEvent('wineryshop:general')
AddEventHandler('wineryshop:general', function()
	local jobs = exports["isPed"]:GroupRank('winery')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "517", "Shop");	
		Wait(1000)
	end
end)

RegisterNetEvent('winerycraft:general')
AddEventHandler('winerycraft:general', function()
	local jobs = exports["isPed"]:GroupRank('winery')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "518", "Craft");	
		Wait(1000)
	end
end)

RegisterNetEvent('bondistorage:general')
AddEventHandler('bondistorage:general', function()
	local jobs = exports["isPed"]:GroupRank('bondi_boys')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "bondistorage:general")
		Wait(1000)
	end
end)

RegisterNetEvent('loststorage:general')
AddEventHandler('loststorage:general', function()
	local jobs = exports["isPed"]:GroupRank('lostmc')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "loststorage:general")
		Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('weedshop:counter1')
AddEventHandler('weedshop:counter1', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter1");
end)

RegisterNetEvent('weedshop:counter2')
AddEventHandler('weedshop:counter2', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter2");
end)

RegisterNetEvent('weedshop:counter3')
AddEventHandler('weedshop:counter3', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter3");
end)

RegisterNetEvent('weedshop:counter4')
AddEventHandler('weedshop:counter4', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter4");
end)

RegisterNetEvent('weedshop:counter5')
AddEventHandler('weedshop:counter5', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter5");
end)

RegisterNetEvent('weedshop:counter6')
AddEventHandler('weedshop:counter6', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter6");
end)

RegisterNetEvent('weedshop:counter7')
AddEventHandler('weedshop:counter7', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter7");
end)

RegisterNetEvent('weedshop:counter8')
AddEventHandler('weedshop:counter8', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter8");
end)

RegisterNetEvent('weedshop:general')
AddEventHandler('weedshop:general', function()
	local jobs = exports["isPed"]:GroupRank('cosmic_cannabis')
	if jobs > 0 then 
		TriggerEvent("server-inventory-open", "204", "Shop");	
		Wait(1000)
	end
end)

RegisterNetEvent('weedshop:counterStash')
AddEventHandler('weedshop:counterStash', function()
	local jobs = exports["isPed"]:GroupRank('cosmic_cannabis')
	if jobs > 0 then 
		TriggerEvent("server-inventory-open", "1", "cosmic_counterStash");
	end
end)

-- RegisterNetEvent('vencut:general')
-- AddEventHandler('vencut:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 	TriggerEvent("server-inventory-open", "513", "Craft");
-- 	Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('pubcut:general')
-- AddEventHandler('pubcut:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 	TriggerEvent("server-inventory-open", "514", "Craft");
-- 	Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('pubcook:general')
-- AddEventHandler('pubcook:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 	TriggerEvent("server-inventory-open", "515", "Craft");
-- 	Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('pubprepare:general')
-- AddEventHandler('pubprepare:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 	TriggerEvent("server-inventory-open", "516", "Craft");
-- 	Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('pubbar:general')
-- AddEventHandler('pubbar:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 		TriggerEvent("server-inventory-open", "226", "Craft");	
-- 		Wait(1000)
-- 	end
-- end)

-- RegisterNetEvent('pubbarshop:general')
-- AddEventHandler('pubbarshop:general', function()
-- 	local rankY = exports["isPed"]:GroupRank("paleto_pub")
-- 	if rankY > 0 then 
-- 		TriggerEvent("server-inventory-open", "221", "Shop");	
-- 		Wait(1000)
-- 	end
-- end)

RegisterNetEvent('courthouse:idbuy')
AddEventHandler('courthouse:idbuy', function()
	TriggerServerEvent('shops:GetIDCardSV')
	Wait(1000)
end)

RegisterNetEvent('familystorage:general')
AddEventHandler('familystorage:general', function()
	local jobs = exports["isPed"]:GroupRank('drift_school')
	if jobs >= 1 then
		TriggerEvent("server-inventory-open", "1", "familystorage:general")
		Wait(1000)
	end
end)

RegisterNetEvent('shops:water')
AddEventHandler('shops:water', function()
	TriggerEvent("server-inventory-open", "421", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:food')
AddEventHandler('shops:food', function()
	TriggerEvent("server-inventory-open", "4242", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:digitalden')
AddEventHandler('shops:digitalden', function()
	TriggerEvent("server-inventory-open", "1312", "Shop");	
	Wait(1000)
end)

RegisterNetEvent('shops:coffee')
AddEventHandler('shops:coffee', function()
	TriggerEvent("server-inventory-open", "422", "Shop");
	Wait(1000)
end)

RegisterNetEvent('shops:soda')
AddEventHandler('shops:soda', function()
	TriggerEvent("server-inventory-open", "4292", "Shop");
	Wait(1000)
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 
