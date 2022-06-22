local ongoing = false
local mixing = false

RegisterNetEvent("crack:start")
AddEventHandler("crack:start", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId()) 
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1092.8562011719, -3196.6508789062, -38.99348449707, false))		
	if exports["np-inventory"]:hasEnoughOfItem("bakingsoda",5,false) and exports["np-inventory"]:hasEnoughOfItem("chloroform",2,false) and exports["np-inventory"]:hasEnoughOfItem("dye",3,false) and ongoing == false then
		TriggerEvent("animation:crack")
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 357.96401977539)
		local finished = exports["np-taskbar"]:taskBar(10000,"Mixing This Shit!")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			if math.random(1,30) == 18  then
				TriggerEvent("inventory:removeItem","bakingsoda", 5)
				TriggerEvent("inventory:removeItem","chloroform", 2)
				TriggerEvent("inventory:removeItem","dye", 3)
				TriggerEvent("DoLongHudText", "You Placed The Ingredients In Wrong!")
				TriggerEvent("np-dispatch:methexplosion")
				DaBabyBoom()
			else
				TriggerEvent("inventory:removeItem","bakingsoda", 5)
				TriggerEvent("inventory:removeItem","chloroform", 2)
				TriggerEvent("inventory:removeItem","dye", 3)
				TriggerEvent("DoLongHudText", "You Successfully Turned On The Cooker, Wait 3 Minutes For Results.")
				ongoing = true
				mixing = true
				Citizen.Wait(180000)
				TriggerEvent("DoLongHudText", "I hear bubbling coming from the cooker, may wanna go check on it.")
				Citizen.Wait(5000)
				if mixing == true then
					TriggerEvent("DoLongHudText", "Finished!")
					TriggerEvent("player:receiveItem","1gcrack", 1)
					ongoing = false
					mixing = false
				elseif mixing == false then
					TriggerEvent("DoLongHudText", "Failed!")
				end
			end
		end
	end
end)


RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:crack')
AddEventHandler('animation:crack', function()
	inanimation = true
	local lPed = GetPlayerPed(-1)
	RequestAnimDict("anim@amb@business@coc@coc_unpack_cut@")
	while not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut@") do
		Citizen.Wait(0)
	end

	if IsEntityPlayingAnim(lPed, "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v1_cokepacker", 3) then
		ClearPedSecondaryTask(lPed)
	else
		TaskPlayAnim(lPed, "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v1_cokepacker", 8.0, -8, -1, 49, 0, 0, 0, 0)
		seccount = 4
		while seccount > 0 do
			Citizen.Wait(10000)
			FreezeEntityPosition(PlayerPedId(),false)
			seccount = seccount - 1
		end
		ClearPedSecondaryTask(lPed)
	end		
	inanimation = false
end)

RegisterNetEvent("crack:sell")
AddEventHandler("crack:sell", function()
	if exports["np-inventory"]:hasEnoughOfItem("1gcrack",1,false) then
		LoadDict('mp_safehouselost@')
		TaskPlayAnim(GetPlayerPed(-1), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
		local finished = exports["np-taskbar"]:taskBar(3000,"Handing Over Something")
		if (finished == 100) then
			local crack = 245
			TriggerServerEvent("meth:givemoney", crack)
			TriggerEvent("inventory:removeItem","1gcrack", 1)
			TriggerEvent("player:receiveItem","rollcash",math.random(10,20))
			TriggerEvent("DoLongHudText", "Thanks Man, Heres a lil something for that.")
			Citizen.Wait(5000)
		end
	else
	 TriggerEvent('DoLongHudText', "You need something!!", 2)
	end
end)


function DaBabyBoom()
	local ped = PlayerPedId()
    local coords = vector3(1092.8562011719, -3196.6508789062, -38.99348449707)
	local coords2 = vector3(1095.5218505859, -3196.6569824219, -38.993476867676)
	RequestWeaponAsset(GetHashKey("WEAPON_RPG")) 
    while not HasWeaponAssetLoaded(GetHashKey("WEAPON_RPG")) do
        Wait(0)
    end
	ShootSingleBulletBetweenCoords( 
		coords.x,
        coords.y,
        coords.z, 
	    coords.x,
        coords.y,
        coords.z,  
		500,
		true,
		GetHashKey("WEAPON_RPG"),
		ped,
		true,
		true,
		-1.0
    )
	ShootSingleBulletBetweenCoords( 
		coords2.x,
        coords2.y,
        coords2.z, 
	    coords2.x,
        coords2.y,
        coords2.z,  
		500,
		true,
		GetHashKey("WEAPON_RPG"),
		ped,
		true,
		true,
		-1.0
    )
	while true do 
		Citizen.Wait(5)
		StopFireInRange(coords.x,coords.y,coords.z, 300.0)
	end
end

RegisterNetEvent("stopmixing")
AddEventHandler("stopmixing", function()
	if mixing == true then
		TriggerEvent("DoLongHudText", "Failed, You Left The Crack Lab To Early!")
		mixing = false
		ongoing = false
	end
end)

      exports["np-polytarget"]:AddBoxZone("crack_start", vector3(1092.93, -3195.72, -38.99), 1.2, 2.6, {
    heading=0
  })