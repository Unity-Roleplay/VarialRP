local isTriageEnabled = false
local isdoc = false
local isadded = false
local injurycount = 0
local inbed = false

local bedcoords = {
    [1] =  { ['x'] = 310.26,['y'] = -577.63,['z'] = 43.29,['h'] = 53.16 },   
    [2] =  { ['x'] = 321.9,['y'] = -585.86,['z'] = 43.29,['h'] = 193.55 },
    [3] =  { ['x'] = 318.56,['y'] = -580.69,['z'] = 43.29,['h'] = 245.66 },
    [4] =  { ['x'] = 316.87,['y'] = -584.93,['z'] = 43.29,['h'] = 247.1 },
    [5] =  { ['x'] = 313.56,['y'] = -583.83,['z'] = 43.29,['h'] = 250.0 },
    [6] =  { ['x'] = 314.91,['y'] = -579.39,['z'] = 43.29,['h'] = 68.7 },
    [7] =  { ['x'] = 312.01,['y'] = -583.34,['z'] = 43.29,['h'] = 66.16 },
}

RegisterNetEvent("np-hospitalization:checkin")
AddEventHandler("np-hospitalization:checkin", function()
	if exports["isPed"]:isPed("countems") <= 0 or exports["isPed"]:isPed("myJob") == 'ems'  then
		loadAnimDict('anim@narcotics@trash')
		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',1.0, 1.0, -1, 1, 0, 0, 0, 0)
		local finished = exports["np-taskbar"]:taskBar(1700,"Checking Credentials")
		if finished == 100 then
			TriggerEvent("bed:checkin")
		end
	else
		TriggerEvent('DoLongHudText', 'There is ems on duty please page them!', 2)
	end
end)

function GetStreetAndZone()
    local plyPos = GetEntityCoords(PlayerPedId(),  true)
    local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local street1 = GetStreetNameFromHashKey(s1)
    local street2 = GetStreetNameFromHashKey(s2)
    zone = tostring(GetNameOfZone(plyPos.x, plyPos.y, plyPos.z))
    local playerStreetsLocation = GetLabelText(zone)
    local street = street1 .. ", " .. playerStreetsLocation
    return street
end

RegisterNetEvent("np-hospitalization:page")
AddEventHandler("np-hospitalization:page", function()
	loadAnimDict('anim@narcotics@trash')
	TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',1.0, 1.0, -1, 1, 0, 0, 0, 0)
	local finished = exports["np-taskbar"]:taskBar(1700,"Paging a Doctor")
	if finished == 100 then
		if exports["isPed"]:isPed("countems") >= 1  and not isTriageEnabled then
			TriggerEvent('DoLongHudText', 'A doctor has been paged. Please take a seat and wait.', 1)
			local pos = GetEntityCoords(PlayerPedId(),  true)
			TriggerServerEvent("dispatch:svNotify", {
				dispatchCode = "Pager",
				firstStreet = GetStreetAndZone(),
				isImportant = false,
				priority = 3,
				dispatchMessage = "Someone need asstiance at pillbox medical!",
				recipientList = {
					ems = "ems"
				  },
				origin = {
					x = pos.x,
					y = pos.y,
					z = pos.z
				}
			})
		end
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

RegisterNetEvent("attempt:change:check-in", function()
	if exports['isPed']:isPed("myjob") == "ems" then
		TriggerServerEvent("ems:toggle")
	else
		TriggerEvent("DoLongHudText", "This is only for EMS to use.", 2)
	end
end)


function CheckBeds(x,y,z)
	local players = GetPlayers()
	local ply = PlayerPedId()
	local closestplayers = {}
	local closestdistance = {}
	local closestcoords = {}
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(x,y,z))
			if(distance < 3) then
				return false
			end
		end
	end
	return true
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

sleeping = false
showInteraction = true
local shit = false

local beds = {
  2117668672,
  1631638868,
  -1787305376,
  666470117,
  -1182962909,
  -1519439119, -- operation
  -289946279, -- mri
  -1091386327,
}

RegisterNetEvent("client:bed")
AddEventHandler("client:bed",function()
  local ped = PlayerPedId()
  lastPlayerPos = GetEntityCoords(PlayerPedId())

  local objFound = nil
  local near = 999

  for i=1, #beds do

    local curobjFound = GetClosestObjectOfType(lastPlayerPos, 3.0, beds[i], 0, 0, 0)
    if curobjFound ~= 0 then
      local dist = #(GetEntityCoords(curobjFound) - GetEntityCoords(ped))

      if DoesEntityExist(curobjFound) then
        if dist ~= 0 and dist < near then
          near = dist
          objFound = curobjFound
        end
      end
    end
  end

  if DoesEntityExist(objFound) then
    loadAnimDict( "missfinale_c1@" )
    Citizen.Wait(500)

    sleeping = true
    showInteraction = true
	icon = "<center><i class='fas fa-bed' style=' color: white;font-size: 2vh;text-align:center; padding:5px;'></i></center>"
	exports['np-textui']:showInteraction("[E] Leave Bed")

    if GetEntityModel(objFound) and shit == true then
		sleeping = false
	  exports['np-textui']:hideInteraction()

	  local counter = 0
		SetEntityHeading(GetEntityHeading(PlayerPedId()-90))
		TriggerEvent("animation:PlayAnimation","getup")
		local count=0
		while counter < 400 do
		  counter = counter + 1
  
		  if counter > 250 then
			count = count + 0.004
			AttachEntityToEntity(ped, objFound, 1, 0.1, 0.02, 2 / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
		  else
			 AttachEntityToEntity(ped, objFound, 1, 0.1, 0.02, 2 / 2.0, 0.0, 0.0, -90.0, false, false, false, false, 0, false)
		  end
		  Citizen.Wait(1)
		end
		camOff()
		DetachEntity(PlayerPedId(), 1, true)
		shit = false
	  end
    end

      while sleeping do
		local bedOffset = vector3(-0.2, 0.1, 1.4)
        AttachEntityToEntity(ped, objFound, 1, bedOffset.x, bedOffset.y, bedOffset.z, 0.0, 0.0, 180.0, true, true, true, true, 1, true)
		shit = true
		TaskPlayAnim( ped, "missfinale_c1@", "lying_dead_player0", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
		if not showInteraction then
			exports['np-textui']:hideInteraction()
        end
        Citizen.Wait(1000)
    end
end)

function camOn()
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetCamActive(cam,  true)
		RenderScriptCams(true,  false,  0,  true,  true)
	end	
end

function camOff()
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
end

RegisterNetEvent("bed:checkin")
AddEventHandler("bed:checkin",function()
	findBed(true)
end)

function findBed(fadein)
    
	if not inbed then
		myinjury = "General Checkups"
		local mybedx,mybedy,mybedz = 363.86135864258,-593.99725341797,43.389274597168
		for i = 1, #bedcoords do
			if CheckBeds(bedcoords[i]["x"],bedcoords[i]["y"],bedcoords[i]["z"]) and not inbed then
				inbed = true
				mybedx,mybedy,mybedz = bedcoords[i]["x"],bedcoords[i]["y"],bedcoords[i]["z"]
			end
		end

		SetEntityCoords(PlayerPedId(),mybedx,mybedy,mybedz)

		if inbed then
			TriggerEvent("client:bed")
		end
		
		TriggerEvent("inbedrect",fadein)
		
		Citizen.Wait(5000)

		TriggerEvent("chatMessagess", "Service ", 5, "It was a success, you have been billed for your injuries in the amount of: $100.")

		SetEntityHealth(PlayerPedId(),200)
		Citizen.Wait(1000)
		inbed = false
		injurycount = 0
		TriggerEvent('np-hospital:client:ResetLimbs')
		TriggerEvent('np-hospital:client:RemoveBleed')
		TriggerServerEvent("ragdoll:reviveSV2")
	end
end

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(5)
		if IsControlJustReleased(1, 38) and shit == true then
			TriggerEvent("client:bed")
		end
	end
end)

RegisterNetEvent("inbedrect")
AddEventHandler("inbedrect",function(fadein)
	local opacityc
	if fadein then
		opacityc = 0
	else
		opacityc = 255
	end
	while inbed do
		if opacityc < 255 then
			opacityc = opacityc + 1
		end
		DrawRect(0, 0, 10.0, 10.0, 1, 1, 1, opacityc)
		Citizen.Wait(1)
	end
end)