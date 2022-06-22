--FiveM's list of Ped Models can be found here: https://docs.fivem.net/docs/game-references/ped-models/
--A list of all the animations can be found here: https://alexguirre.github.io/animations-list/

Config = {}
Config.Invincible = true --Do you want the peds to be invincible?
Config.Frozen = true --Do you want the peds to be unable to move? It's probably a yes, so leave true in there.
Config.Stoic = true --Do you want the peds to react to what is happening in their surroundings?
Config.Fade = true-- Do you want the peds to fade into/out of existence? It looks better than just *POP* its there.
Config.Distance = 25.0 --The distance you want peds to spawn at
Config.MinusOne = true

pedList = {

    

	{
		model = `cs_brad`,
		coords = vector3(-17.153085708618, 6303.44140625, 31.374612808228), -- (Trucking)
		heading = 40.0, 
		gender = "male", 
		animName = "WORLD_HUMAN_AA_SMOKE",
	},

	
	{
		model = `mp_m_weed_01`,
		coords = vector3(-1612.7983398438, 5262.236328125, 3.9741015434265), -- (Boat Rental)
		heading = 205.71180725098, 
		gender = "male", 
		animName = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT",
	},

	
}

local genderNum = 0
local isNearPed = false
local ped 
local hasAlreadyEntered = false


Citizen.CreateThread(function()
    local waitTime = 250
	while true do
		Citizen.Wait(waitTime)
		for k,v in pairs (pedList) do
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)
			if dist < 20.0 and hasAlreadyEntered == false then
				TriggerEvent('np-peds:nearPed', v.model, v.coords, v.heading, v.gender, v.animDict, v.animName)
				hasAlreadyEntered = true
			end

			if dist >= 25.0 and dist <= 45.0 then
                for i = 255, 0, -51 do
                    Citizen.Wait(50)
                    SetEntityAlpha(ped, i, false)
                end
				hasAlreadyEntered = false
				DeleteEntity(ped)
			end
		end
	end
end)

AddEventHandler('np-peds:nearPed', function(model, coords, heading, gender, animDict, animName)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(250)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	end	

    local x, y, z = table.unpack(coords)
    ped = CreatePed(genderNum, model, x, y, z - 1, heading, false, true)
	SetEntityAlpha(ped, 0, false)
	
	FreezeEntityPosition(ped, true)

	SetEntityInvincible(ped, true)

	SetBlockingOfNonTemporaryEvents(ped, true)
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	elseif animName and not animDict then
		TaskStartScenarioInPlace(ped, animName, 0, true)
	end
	
    for i = 0, 255, 51 do
        Citizen.Wait(50)
        SetEntityAlpha(ped, i, false)
    end
end)

Config.PedList = {
	----------------------------------------
	---       24/7 SUPERMARKETS          ---
	----------------------------------------
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-3037.773, 584.8989, 7.97),
		heading = 30.0, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1960.64, 3739.03, 32.50),
		heading = 321.36, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1393.84,3606.8,35.99),
		heading = 172.8, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(549.01,2672.44,43.16),
		heading = 122.33, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(2558.39,380.74,109.63),
		heading = 21.54, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-1819.57,793.59,139.09),
		heading = 134.3, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-1221.26,-907.92,12.3), 
		heading = 54.44, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-706.12,-914.56,19.22),
		heading = 94.66, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(24.47,-1348.47,29.5),
		heading = 298.26, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-47.36,-1758.68,29.43),
		heading = 50.84, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1164.95,-323.7,69.21),
		heading = 101.73, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(372.19,325.74,103.57),
		heading = 276.17, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(2678.63,3278.86,55.25),
		heading = 344.4, 
		gender = "male", 
	},
	
	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1727.3,6414.27,35.04),
		heading = 259.1, 
		gender = "male", 
	},

	{
		model = "mp_m_shopkeep_01",
		coords = vector3(-160.56,6320.76,31.59),
		heading = 319.99, 
		gender = "male", 
	},

	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1165.29,2710.85,38.16),
		heading = 178.47, 
		gender = "male", 
	},

	{
		model = "mp_m_shopkeep_01",
		coords = vector3(1697.23,4923.42,42.07),
		heading = 327.94, 
		gender = "male", 
	},

	----------------------------------------
	---           AMMUNATION             ---
	----------------------------------------

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(23.36,-1105.82,29.8),
		heading = 156.03, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(1696.02,3760.72,34.71),
		heading = 193.3, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(808.26,-2157.71,29.62),
		heading = 276.46, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(254.32,-49.28,69.95),
		heading = 70.86, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(840.21,-1032.9,28.2),
		heading = 289.83, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(-331.75,6084.95,31.46),
		heading = 224.64, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(-666.13,-938.73,21.83),
		heading = 269.52, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(-1310.05,-389.17,36.7),
		heading = 144.36, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(-1116.51,2700.33,18.58),
		heading = 149.9, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(2571.79,298.1,108.74),
		heading = 84.22, 
		gender = "male", 
	},

	{
		model = "s_m_y_ammucity_01",
		coords = vector3(-3169.53,1089.59,18.84),
		heading = 237.35, 
		gender = "male", 
	},

	
	----------------------------------------
	---       Tool Stores         ---
	----------------------------------------

	{
		model = "s_m_m_gaffer_01",
		coords = vector3(44.838947296143, -1748.5364990234, 29.549386978149),
		heading = 35.3, 
		gender = "male", 
	},

	{
		model = "s_m_m_gaffer_01",
		coords = vector3(2749.2309570313, 3472.3308105469, 55.679393768311),
		heading = 244.4, 
		gender = "male", 
	},

	----------------------------------------
	---           Unknown         		 ---
	----------------------------------------

	-- Green ---

	-- {
	-- 	model = "mp_m_waremech_01",
	-- 	coords = vector3(-227.31428527832,-1329.3363037109,30.880615234375),
	-- 	heading = 274.96063232422, 
	-- 	gender = "male", 
	-- },

	-- -- Blue ---

	-- {
	-- 	model = "g_f_y_lost_01",
	-- 	coords = vector3(-39.349449157715,-614.25494384766,35.261596679688),
	-- 	heading = 243.77952575684, 
	-- 	gender = "male", 
	-- },

	-- -- Red ---

	-- {
	-- 	model = "g_m_m_chigoon_02",
	-- 	coords = vector3(891.63958740234,-2538.158203125,28.420532226562),
	-- 	heading = 181.41734313965, 
	-- 	gender = "male", 
	-- },

	----------------------------------------
	---       	 Vault Bank         	 ---
	----------------------------------------

	{
		model = "cs_bankman",
		coords = vector3(242.020568847656, 227.114593505859, 106.031478881835),
		heading = 160.0, 
		gender = "male", 
	},


	----------------------------------------
	---       	 Taxi        	 ---
	----------------------------------------

	{
		model = "cs_bankman",
		coords = vector3(904.087890625,-174.29010009766,74.066650390625),
		heading = 240.94488525391, 
		gender = "male", 
	},


	----------------------------------------
	---       	 Garbage        	 ---
	----------------------------------------

	{
		model = "s_m_y_garbage",
		coords = vector3(-321.54724121094,-1545.8374023438,31.015380859375),
		heading = 0.0, 
		gender = "male", 
	},
	----------------------------------------
	---       	 Lumberjack        	 ---
	----------------------------------------

	{
		model = "s_m_y_construct_01",
		coords = vector3(-553.04174804688,5348.8745117188,74.74072265625),
		heading = 62.362197875977, 
		gender = "male", 
	},
	
	----------------------------------------
	---       	 Mining        	 ---
	----------------------------------------

	{
		model = "cs_bankman",
		coords = vector3(412.23297119141,315.01977539062,103.13256835938),
		heading = 209.76377868652, 
		gender = "male", 
	},


	----------------------------------------
	---       	 News        	 ---
	----------------------------------------

	{
		model = "cs_bankman",
		coords = vector3(-598.29888916016,-929.85491943359,23.854248046875),
		heading = 87.874015808105, 
		gender = "male", 
	},

	----------------------------------------
	---       	 Paintball        	 ---
	----------------------------------------

	{
		model = "a_m_y_ktown_02",
		coords = vector3(2356.7341308594,2488.9714355469,46.517211914062),
		heading = 354.33071899414, 
		gender = "male", 
	},

	----------------------------------------
	---       	 Casino        	 ---
	----------------------------------------

	{
		model = "u_f_m_casinocash_01",
		coords = vector3(1109.48, 229.35, -49.64),
		heading = 200.0, 
		gender = "male", 
	},

	----------------------------------------
	---       	 Unknown O       	 ---
	----------------------------------------

	{
		model = "s_m_y_dockwork_01",
		coords = vector3(494.51867675781,-3065.6044921875,6.060791015625),
		heading = 2.8346455097198, 
		gender = "male", 
	},

	----------------------------------------
	---       	 Unknown P       	 ---
	----------------------------------------

	{
		model = "s_m_y_dockwork_01", --mest [ed]
		coords = vector3(485.6449, -1477.298, 29.29008),
		heading = 192.0655, 
		gender = "male", 
	},

	{
		model = "s_m_y_dockwork_01",
		coords = vector3(-2079.7978515625,2610.0131835938,3.078369140625),
		heading = 110.55118560791, 
		gender = "male", 
	},
	{
		model = "s_m_y_dockwork_01",
		coords = vector3(-428.3193, -2843.426, 6.0),
		heading = 232.391, 
		gender = "male", 
	},
	{
		model = "mp_m_waremech_01",
		coords = vector3(474.8318, -1308.799, 29.20654),
		heading = 171.664, 
		gender = "male", 
	},
	{
		model = "ig_cletus",
		coords = vector3(1746.6, 3300.11, 41.22),
		heading = 100.664, 
		gender = "male", 
	},
	{

	----------------------------------------
	---       	 Weed Man      	 ---
	----------------------------------------
		model = "cs_omega",
		coords = vector3(1175.6590576172, -437.50082397461, 66.925537109375),
		heading = 257.16186523438, 
		gender = "male", 
	},
}
	