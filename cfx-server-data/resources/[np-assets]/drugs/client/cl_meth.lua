local cookingmeth = false
local allowedtostart = false
local donep1 = false
local donep2 = false
local donep3 = false

-- To Do: Package meth and selling meth

RegisterNetEvent('drp-meth:startMeth')
AddEventHandler('drp-meth:startMeth', function()
    local ped = PlayerPedId()
    if exports["drp-inventory"]:hasEnoughOfItem("methstick",1,false) then 
        TriggerEvent("animation:PlayAnimation","type")
        FreezeEntityPosition(ped, true)
        local finished = exports["drp-taskbar"]:taskBar(15000,"Starting meth production")
        if finished == 100 then
            FreezeEntityPosition(ped, false)
            allowedtostart = true
            TriggerEvent("inventory:removeItem", "methstick", 1)
            TriggerEvent('DoLongHudText', 'You can now start to make meth go check around to see how to start.')
        else
            FreezeEntityPosition(ped, false)
        end
    else
        TriggerEvent('DoLongHudText', 'You need something to be able to start making meth.', 2)
    end
end)

RegisterNetEvent('drp-meth:startp1')
AddEventHandler('drp-meth:startp1', function()
    local ped = PlayerPedId()
    if allowedtostart then
        if exports["drp-inventory"]:hasEnoughOfItem("chloroform",1,false) then
            TriggerEvent("animation:PlayAnimation","push")
            FreezeEntityPosition(ped, true)
            local finished = exports["drp-taskbar"]:taskBar(30000,"Placing chloroform into furnace")
            if finished == 100 then
                FreezeEntityPosition(ped, false)
                TriggerEvent("inventory:removeItem", "chloroform", 1)
                allowedtostart = false
                donep1 = true
                TriggerEvent('DoLongHudText', 'You can now go and prepare the oven')
                TriggerEvent('player:receiveItem', 'methbrick', 1)
            else
                FreezeEntityPosition(ped, false)
            end
        else
            TriggerEvent('DoLongHudText', 'You are missing a item', 2)
        end
      
    elseif not allowedtostart then
        TriggerEvent('DoLongHudText', 'Nice try! There is another step before this', 2)
    end
end)

RegisterNetEvent('drp-meth:PrepareOven')
AddEventHandler('drp-meth:PrepareOven', function()
    local ped = PlayerPedId()
    if donep1 then 
        TriggerEvent("animation:PlayAnimation","browse")
        FreezeEntityPosition(ped, true)
        local finished = exports["drp-taskbar"]:taskBar(30000,"Preparing oven")
        if finished == 100 then
            FreezeEntityPosition(ped, false)
            TriggerEvent('DoLongHudText', 'The oven is now prepared, you can start cooking your shit')
            donep1 = false
            donep2 = true
        else
            FreezeEntityPosition(ped, false)
        end
    else
        TriggerEvent('DoLongHudText', 'You have missed a step, maybe have a look around.', 2 )
    end
end)

--// Start Meth Cook

RegisterNetEvent("dreams-meth:begin-cook")
AddEventHandler("dreams-meth:begin-cook", function()
	local ped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1005.694152832, -3201.3181152344, -38.84700012207, false))		
	if donep2 then
        if exports["drp-inventory"]:hasEnoughOfItem("methbrick",1) then
            Cooking()
            TriggerEvent("animation:meth")
            FreezeEntityPosition(PlayerPedId(),true)
            SetEntityHeading(PlayerPedId(), 179.97245788574)
            local finished = exports["drp-taskbar"]:taskBar(115000,"Mixing Chemicals")
            if (finished == 100) then
                donep2 = false
                FreezeEntityPosition(PlayerPedId(),false)
                TriggerEvent("inventory:removeItem","methbrick", 1)
                cookingmeth = true
                cooking = true
                if cooking == true then
                    TriggerEvent("DoLongHudText", "You Successfully Cooked some meth")
                    TriggerEvent("player:receiveItem","methraw",math.random(1,12))
                    cookingmeth = false
                    cooking = false
                elseif cooking == false then
                    TriggerEvent("DoLongHudText", "Failed!")
                end
            end
        else
            TriggerEvent('DoLongHudText', 'You are missing Items', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'You have missed a step', 2)
    end
end)

RegisterNetEvent("pack:crystal") -- for target
AddEventHandler("pack:crystal", function()
	local playerped = PlayerPedId()
	local plyCoords = GetEntityCoords(PlayerPedId())
	local distance = (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 1006.0034179688, -3194.9982910156, -38.993167877197, false))	
	if exports["drp-inventory"]:hasEnoughOfItem("methraw",5,false) and exports["drp-inventory"]:hasEnoughOfItem("drugbaggy",1,false) and ongoing == false then
		FreezeEntityPosition(PlayerPedId(),true)
		SetEntityHeading(PlayerPedId(), 357.65960693359)
		Drying()
        TriggerEvent("animation:push")
		local finished = exports["drp-taskbar"]:taskBar(32000,"Drying crystals be careful!")
		if (finished == 100) then
			FreezeEntityPosition(PlayerPedId(),false)
			TriggerEvent("inventory:removeItem","methraw", 5)
			TriggerEvent("inventory:removeItem","drugbaggy", 1)
            drying = true
			ongoing = true
			if drying == true then
				TriggerEvent("DoLongHudText", "You Successfully Dried Meth!")
				TriggerEvent("player:receiveItem","methlabproduct",math.random(1,2))
				ongoing = false
				scaling = false
			elseif scaling == false then
				TriggerEvent("DoLongHudText", "Failed!", 2)
			end
		end
	end

end)

    --// Functions

    function Cooking()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(10)
                local ped = PlayerPedId()
                local targetRotation = vec3(180.0, 180.0, 180.0)
                local x,y,z = table.unpack(vec3(1005.7637939453, -3200.3767089844, -38.519256591797))
    
                local animDict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
        
                RequestAnimDict(animDict)
                RequestModel("bkr_prop_meth_ammonia")
                RequestModel("bkr_prop_meth_sacid")
                RequestModel("bkr_prop_fakeid_clipboard_01a")
                RequestModel("bkr_prop_fakeid_penclipboard")
        
                while not HasAnimDictLoaded(animDict) and
                    not HasModelLoaded("bkr_prop_meth_ammonia") and 
                    not HasModelLoaded("bkr_prop_meth_sacid") and 
                    not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
                    not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
                    Citizen.Wait(100)
                end
    
                ammonia = CreateObject(GetHashKey('bkr_prop_meth_ammonia'), x, y, z, 1, 0, 1)
                acido = CreateObject(GetHashKey('bkr_prop_meth_sacid'), x, y, z, 1, 0, 1)
                caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
                caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)   
    
    
                local netScene = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
                local netScene2 = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
                NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_long_ammonia", 4.0, -8.0, 1)
                NetworkAddEntityToSynchronisedScene(acido, netScene, animDict, "chemical_pour_long_sacid", 4.0, -8.0, 1)
                NetworkAddEntityToSynchronisedScene(caderneta, netScene, animDict, "chemical_pour_long_clipboard", 4.0, -8.0, 1)
                NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(caneta, netScene2, animDict, "chemical_pour_long_pencil", 4.0, -8.0, 1)
                
                Citizen.Wait(150)
                NetworkStartSynchronisedScene(netScene)
                NetworkStartSynchronisedScene(netScene2)
    
                Citizen.Wait(GetAnimDuration(animDict, "chemical_pour_long_cooker") * 770)
                DeleteObject(ammonia)
                DeleteObject(acido)
                DeleteObject(caderneta)
                DeleteObject(caneta)
                processo = false
                break    
            end
        end)
    end
	
	function Drying()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local  targetRotation = vec3(180.0, 180.0, 168.0)
			local x,y,z = table.unpack(vec3(1012.1636962891, -3195.181640625, -38.99312210083))    

			local animDict = "anim@amb@business@meth@meth_smash_weight_check@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_meth_scoop_01a")
			RequestModel("bkr_prop_meth_bigbag_03a")
			RequestModel("bkr_prop_meth_bigbag_04a")
			RequestModel("bkr_prop_fakeid_penclipboard")
			RequestModel("bkr_prop_fakeid_clipboard_01a")
			RequestModel("bkr_prop_meth_openbag_02")
			RequestModel("bkr_prop_coke_scale_01")
			RequestModel("bkr_prop_meth_smallbag_01a")
			RequestModel("bkr_prop_meth_openbag_01a")
			RequestModel("bkr_prop_fakeid_penclipboard")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_meth_scoop_01a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_03a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_04a") and
				not HasModelLoaded("bkr_prop_meth_openbag_02") and 
				not HasModelLoaded("bkr_prop_coke_scale_01") and 
				not HasModelLoaded("bkr_prop_meth_smallbag_01a") and 
				not HasModelLoaded("bkr_prop_meth_openbag_01a") and 
				not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
				not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
				Citizen.Wait(100)
			end

			pazinha = CreateObject(GetHashKey('bkr_prop_meth_scoop_01a'), x, y, z, 1, 0, 1)
			caixa_grande = CreateObject(GetHashKey('bkr_prop_meth_bigbag_03a'), x, y, z, 1, 0, 1)
			caixa_grande_2 = CreateObject(GetHashKey('bkr_prop_meth_bigbag_04a'), x, y, z, 1, 0, 1)
			bolsa = CreateObject(GetHashKey('bkr_prop_meth_openbag_02'), x, y, z, 1, 0, 1)
			bolsa_fechada = CreateObject(GetHashKey('bkr_prop_meth_smallbag_01a'), x, y, z, 1, 0, 1)
			bolsa_aberta = CreateObject(GetHashKey('bkr_prop_meth_openbag_01a'), x, y, z, 1, 0, 1)
			balanca = CreateObject(GetHashKey('bkr_prop_coke_scale_01'), x, y, z, 1, 0, 1)
			caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
			caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)


			local netScene = NetworkCreateSynchronisedScene(x - 5.3,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene3 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, "break_weigh_scoop", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande_2, netScene, animDict, "break_weigh_box01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa, netScene, animDict, "break_weigh_methbag01^3", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(balanca, netScene2, animDict, "break_weigh_scale", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande, netScene2, animDict, "break_weigh_box01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa_fechada, netScene2, animDict, "break_weigh_methbag01^2", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bolsa_aberta, netScene3, animDict, "break_weigh_methbag01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caderneta, netScene3, animDict, "break_weigh_clipboard", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caneta, netScene3, animDict, "break_weigh_pen", 4.0, -8.0, 1)
			
			NetworkStartSynchronisedScene(netScene)
			NetworkStartSynchronisedScene(netScene2)
			NetworkStartSynchronisedScene(netScene3)


			
			Citizen.Wait(GetAnimDuration(animDict, "break_weigh_char01") * 770)

			DeleteObject(pazinha)
			DeleteObject(caixa_grande)
			DeleteObject(caixa_grande_2)
			DeleteObject(bolsa)
			DeleteObject(bolsa_fechada)
			DeleteObject(bolsa_aberta)
			DeleteObject(balanca)
			DeleteObject(caderneta)
			DeleteObject(caneta)
			processo = false
			break
		end
	end)
end