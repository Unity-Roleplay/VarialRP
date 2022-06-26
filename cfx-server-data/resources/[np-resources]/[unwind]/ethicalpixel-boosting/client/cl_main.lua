
----------------------------------------------------------------------------------------------------------------------------
local CoreName = nil
local ESX = nil

if Config['General']["Core"] == "QBCORE" then
    if Config['CoreSettings']["QBCORE"]["Version"] == "new" then
        CoreName = Config['CoreSettings']["QBCORE"]["Export"]
    else
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(10)
                if CoreName == nil then
                    TriggerEvent(Config['CoreSettings']["QBCORE"]["Trigger"], function(obj) CoreName = obj end)
                    Citizen.Wait(200)
                end
            end
        end)
    end
elseif Config['General']["Core"] == "ESX" then
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent(Config['CoreSettings']["ESX"]["Trigger"], function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

DropOffLocations = {
	[1] =  { ['x'] = 196.87251281738,['y'] = -156.60850524902,['z'] = 56.786975860596},
	[2] =  { ['x'] = -1286.9621582031,['y'] = -274.47973632813,['z'] = 38.724918365479},
	[3] =  { ['x'] = -1330.8432617188,['y'] = -1034.8623046875,['z'] = 7.518029212951},
}

----------------------------------------------------------------------------------------------------------------------------

local authorized = false
local gay = nil
local DisablerUsed = false
local DisablerTimes = 0
local NoMore = nil
local started = false
local startedcontractid = 0
local checked = false
local vinstarted = false
local CanUseComputer = false
local CanScratchVehicle = false
local URL = Config['Utils']["Laptop"]["DefaultBackground"]
local ModelHash = nil

InBoostingQueue = false
OnTheDropoffWay = false
CompletedTask = false
DropblipCreated = false
CallingCops = false
Contracts = {}




local function getField(field , vehicle)
  return GetVehicleHandlingFloat(vehicle, 'CHandlingData', field)
end

function CreateVeh(model , coord, id)
    local ModelHash = tostring(model)
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Citizen.Wait(10)
    end
    Vehicle = CreateVehicle(ModelHash, coord.x, coord.y , coord.z, 0.0, true, false)
    print(coord.x, coord.y , coord.z)
    SetModelAsNoLongerNeeded(ModelHash) 
    SetVehicleEngineOn(Vehicle, false, false)
    local vehClass = "F"
    for k,v in pairs(Config.Vehicles) do
      if v.vehicle == ModelHash then
        vehClass = v.class
      end
    end
    return ({c = vehClass , v = GetVehicleNumberPlateText(Vehicle) , vehicleshit = Vehicle})
end

function PlayerEXP()
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.TriggerCallback('ethicalpixel-boosting:getplayerexp', function(result)
      playerexp = result
      
    end)
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('ethicalpixel-boosting:getplayerexp', function(result)
      playerexp = result
    end)
  elseif Config['General']["Core"] == "NPBASE" then
    local result = RPC.execute("ethicalpixel-boosting:getplayerexp")
    playerexp = result
  end
  if(playerexp == nil) then
    Wait(200)
  end
  return tonumber(playerexp)
end

function ethicalpixelLevel()
  local exp = tonumber(PlayerEXP())
  for idk = 1 , #Config['EXP']['Levels'] do
    local xp = Config['EXP']['Levels'][idk].xp
    if Config['EXP']['Levels'][idk+1] ~= nil then
      if((exp >= xp) and (exp <= Config['EXP']['Levels'][idk+1].xp)) then
        local currentlevelxp = xp
        local nextlevelxp = Config['EXP']['Levels'][idk+1].xp
        local currentplayerxp = exp
        local matheq = (currentlevelxp-currentplayerxp)/(nextlevelxp-currentplayerxp)
        local total = (matheq * (-1)) * 10
        local n = ( nextlevelxp  - currentplayerxp)
        local num = ( (currentplayerxp / nextlevelxp)* 100)
        return {nextlevel = Config['EXP']['Levels'][idk+1].level ,  currentlevel = Config['EXP']['Levels'][idk].level , todisplay =num}
      end
    else
      return {nextlevel = Config['EXP']['Levels'][idk].level ,  currentlevel = Config['EXP']['Levels'][idk].level , todisplay = 1100}
    end
  end
end

RegisterNetEvent('ethicalpixel-boosting:CreateContract')
AddEventHandler('ethicalpixel-boosting:CreateContract' , function(shit)
  local vehicletable = {}
  local xx = ethicalpixelLevel()
  local curr = xx.currentlevel
  for k,v in pairs(Config.Vehicles) do
    if (tostring(Config.Vehicles[k].class) == tostring(curr)) then
      if (Config.Vehicles[k].class == "X") then
        data = {
          vehicle = Config.Vehicles[k].vehicle,
          price =  Config['Utils']["ClassPrices"][curr]
        }
      else
        data = {
          vehicle = Config.Vehicles[k].vehicle,
          price =  Config['Utils']["ClassPrices"][curr]
        }
      end
      table.insert(vehicletable,data)
    end
  end
  local num = vehicletable[math.random(1, #vehicletable)]
  local dick = num.vehicle
  local coord = Config.VehicleCoords[math.random(#Config.VehicleCoords)]
  local owner = Config.CitizenNames[math.random(#Config.CitizenNames)].name  
  local response = CreateVeh(dick , vector3(0.0,0.0,0.0))
  VehiclePrice = Config['EXP']["Rewards"][response.c]
  if(shit == nil) then
    shit = false
  else
    shit = true
  end
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.TriggerCallback('ethicalpixel-boosting:GetExpireTime', function(result)
      if result then
        local data = {
          vehicle = dick,
          owner = owner,
          price = VehiclePrice,
          type = response.c,
          expires = '6 Hours',
          time = result,
          id = #Contracts+1,
          coords = coord,
          plate = 'ddd',
          started = false,
          vin = shit

      }
        local class = data.type
        if(HasItem('pixellaptop') == true) then
          if Config['General']["UseNotificationsInsteadOfEmails"] then
            CoreName.Functions.Notify("You have recieved a "..class.. " Boosting...", "success", 3500)   
          else
            RevievedOfferEmail(data.owner, data.type)
          end
        end
        table.insert(Contracts , data)
      end
    end)
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('ethicalpixel-boosting:GetExpireTime', function(result)
      if result then
        local data = {
          vehicle = dick,
          owner = owner,
          price = VehiclePrice,
          type = response.c,
          expires = '6 Hours',
          time = result,
          id = #Contracts+1,
          coords = coord,
          plate = 'ddd',
          started = false,
          vin = shit
      }
      local class = data.type
      if(HasItem('pixellaptop') == true) then
        if Config['General']["UseNotificationsInsteadOfEmails"] then
          ShowNotification("You have recieved a "..class.. " Boosting...", "success")
        else
          RevievedOfferEmail(data.owner, data.type)
        end
        table.insert(Contracts , data)
        end
      end
    end)
  elseif Config['General']["Core"] == "NPBASE" then
    local ExpireTime = RPC.execute("ethicalpixel-boosting:GetExpireTime")

    if ExpireTime then
      local data = {
        vehicle = dick,
        owner = owner,
        price = VehiclePrice,
        type = response.c,
        expires = '6 Hours',
        time = result,
        id = #Contracts+1,
        coords = coord,
        plate = 'ddd',
        started = false,
        vin = shit
  
    }
    if(HasItem('pixellaptop') == true) then
      if Config['General']["UseNotificationsInsteadOfEmails"] then
        local class = data.type
        TriggerEvent("DoLongHudText","You have recieved a "..class.. " Boosting...")
      else
        RevievedOfferEmailNPBASE(data.owner, data.type)
      end
      table.insert(Contracts , data)
      end
    end
  end
  DeleteVehicle(response.vehicleshit)
end)



RegisterNetEvent("ethicalpixel-boosting:StartContract")
AddEventHandler("ethicalpixel-boosting:StartContract" , function(id , vin)
  for k,v in ipairs(Contracts) do
    if(tonumber(v.id) == tonumber(id)) then
        local extracoors = v.coords
        local shit = CreateVeh(v.vehicle , v.coords , k)
        SetEntityHeading(Vehicle, extracoors.h)
        CreateBlip(v.coords)
        Contracts[k].plate = shit.v
        if(vin == true) then
            vinstarted = true
        else
            started = true
        end
        startedcontractid = v.id
        local VehicleNmae = GetDisplayNameFromVehicleModel(Contracts[startedcontractid].vehicle)
        local VehicleClass = Contracts[startedcontractid].type
        local VehiclePlate = Contracts[startedcontractid].plate
        if Config['General']["UseNotificationsInsteadOfEmails"] then
          if Config['General']["Core"] == "QBCORE" then
            CoreName.Functions.Notify("Vehicle : "..VehicleNmae.." ,Class : "..VehicleClass.." ,Plate : "..VehiclePlate, "success", 3500)   
          elseif Config['General']["Core"] == "ESX" then
            ShowNotification("Vehicle : "..VehicleNmae.." ,Class : "..VehicleClass.." ,Plate : "..VehiclePlate,'success')
          elseif Config['General']["Core"] == "NPBASE" then
            TriggerEvent("DoLongHudText","Vehicle : "..VehicleNmae.." ,Class : "..VehicleClass.." ,Plate : "..VehiclePlate)
          end
        else
          if Config['General']["Core"] == "QBCORE" then
            CreateListEmail()
          elseif Config['General']["Core"] == "ESX" then
              CreateListEmail()
          elseif Config['General']["Core"] == "NPBASE" then
              CreateListEmailNPBASE()
          end
        end
    end
  end
end)


RegisterNetEvent("ethicalpixel-boosting:DeleteContract")
AddEventHandler("ethicalpixel-boosting:DeleteContract" , function(id)
  for k,v in ipairs(Contracts) do
    if(tonumber(v.id) == tonumber(id)) then
      table.remove(Contracts, k)
      started = false
      vinstarted = false
      CallingCops = false
      DeleteCopBlip()
      DeleteCircle()
    end
  end
end)


RegisterNUICallback('dick', function(data)
  if Config['General']["Core"] == "QBCORE" then
    if Config['General']["MinPolice"] == 0 then
      if started or vinstarted then
        TriggerEvent("DoLongHudText", 'A contract is already in progress',2)
      else
        TriggerEvent("ethicalpixel-boosting:StartContract" , data.id)
        Contracts[data.id].started = true
      end
    else
      CoreName.Functions.TriggerCallback('ethicalpixel-boosting:server:GetActivity', function(result) 
        if started or vinstarted then
            TriggerEvent("DoLongHudText", 'A contract is already in progress',2)
          else
            TriggerEvent("ethicalpixel-boosting:StartContract" , data.id)
            Contracts[data.id].started = true
          end 
      end)
    end
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('ethicalpixel-boosting:server:GetActivity', function(result)
      if result >= Config['General']["MinPolice"] then
        if started or vinstarted then
            TriggerEvent("DoLongHudText", 'A contract is already in progress',2)
        else
          TriggerEvent("ethicalpixel-boosting:StartContract" , data.id)
          Contracts[data.id].started = true
        end
      else
        ShowNotification("Not enough police",'error')
      end
    end)  
  elseif Config['General']["Core"] == "NPBASE" then
      if started or vinstarted then
          TriggerEvent("DoLongHudText", 'A contract is already in progress',2)
      else
        TriggerEvent("ethicalpixel-boosting:StartContract" , data.id)
        Contracts[data.id].started = true
      end
  end
end)


RegisterNUICallback('decline', function(data)
  TriggerEvent("ethicalpixel-boosting:DeleteContract" , data.id)
  -- SetNuiFocus(false ,false)
end)

RegisterNUICallback('close', function(data)
  SetNuiFocus(false ,false)
  toggleTablet()
end)

RegisterNUICallback('vin', function(data)
  if(tonumber(BNEBoosting['functions'].GetCurrentBNE().bne) >= tonumber(Config['Utils']["VIN"]["BNEPrice"])) then
    if started or vinstarted then
      TriggerEvent("DoLongHudText", 'A contract is already in progress',2)
    else
      Contracts[data.id].started = true
      BNEBoosting['functions'].RemoveBNE(Config['Utils']["VIN"]["BNEPrice"])
      TriggerEvent("ethicalpixel-boosting:StartContract" , data.id , true)
    end
  else
    TriggerEvent("DoLongHudText", 'Not enough BNE',2)
  end
end)



RegisterNUICallback('updateurl' , function(data)
  URL = data.url
  BNEBoosting['functions'].SetBackground(data.url)
end)


RegisterNetEvent("ethicalpixel-boosting:DisablerUsed")
AddEventHandler("ethicalpixel-boosting:DisablerUsed" , function()
  if OnTheDropoffWay or vinstarted then
    local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        local PlayerPed = PlayerPedId()
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          local Class = Contracts[startedcontractid].type 
          if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
              TriggerEvent("DoLongHudText", 'Seems like this vehicle doesn\'t have a tracker on', 2)
          elseif(not vinstarted) then
            if(DisablerTimes < 5) then
              DisablerUsed = true
              local minigame = exports['ethicalpixel-minigame']:Open()   
              if(minigame == true) then
                Config['Utils']["Blips"]["BlipUpdateTime"] = Config['Utils']["Blips"]["BlipUpdateTime"] + 5000
                DisablerTimes = DisablerTimes + 1
                TriggerEvent('phone:addnotification', 'Anonymous', '('..DisablerTimes..'/5) Trackers Disabled.')
                TriggerServerEvent("ethicalpixel-boosting:SetBlipTime")
                if DisablerTimes == 5 then
                  CallingCops = false
                  OnTheDropoffWay = true
                  TriggerServerEvent("ethicalpixel-boosting:removeblip")
                  TriggerEvent('phone:addnotification', 'Anonymous', 'Tracker removed, head to the drop off location.')
                  rnd = math.random(1,#DropOffLocations)
                  if OnTheDropoffWay then
                      blip = AddBlipForCoord(DropOffLocations[rnd]["x"],DropOffLocations[rnd]["y"],DropOffLocations[rnd]["z"])
                  end
                  SetBlipSprite(blip, 227)
                  SetBlipScale(blip, 1.5)
                  SetBlipRoute(blip, 1)
                  SetBlipRouteColour(blip, 3)
                  SetBlipAsShortRange(blip, false)
                  BeginTextCommandSetBlipName("STRING")
                  AddTextComponentString("Drop Off")
                  EndTextCommandSetBlipName(blip)
                  DropblipCreated = true
                end
              end
            end
        elseif vinstarted == true then
          if(DisablerTimes < 10) then
            DisablerUsed = true
            local minigame = exports['ethicalpixel-minigame']:Open()   
            if(minigame == true) then
              Config['Utils']["Blips"]["BlipUpdateTime"] = Config['Utils']["Blips"]["BlipUpdateTime"] + 5000
              DisablerTimes = DisablerTimes + 1
              TriggerEvent('phone:addnotification', 'Anonymous', '('..DisablerTimes..'/10) Trackers Disabled.')
              TriggerServerEvent("ethicalpixel-boosting:SetBlipTime")
              if DisablerTimes == 10 then
                CallingCops = false
                TriggerServerEvent("ethicalpixel-boosting:removeblip")
                CanUseComputer = true
                TriggerEvent('phone:addnotification', 'Anonymous', 'Tracker removed, head to the scratch location.')
                pDropVinVeh = AddBlipForCoord(472.08, -1310.73, 29.22)
                SetBlipSprite(pDropVinVeh, 227)
                SetBlipScale(pDropVinVeh, 1.5)
                SetBlipRoute(pDropVinVeh, 1)
                SetBlipRouteColour(pDropVinVeh, 3)
                SetBlipAsShortRange(pDropVinVeh, false)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Drop Off")
                EndTextCommandSetBlipName(pDropVinVeh)
              end
            end
          end
        end
      end
    end
  end
end)

local NuiLoaded = false

RegisterNetEvent("ethicalpixel-boosting:DisplayUI")
AddEventHandler("ethicalpixel-boosting:DisplayUI" , function()
  if NuiLoaded then
    for k,v in ipairs(Contracts) do
      local data = {
        vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
        price = v.price,
        owner = v.owner,
        type = v.type,
        expires = '6 Hours',
        id = v.id,
        started = v.started,
        vin = v.vin,
       
      }
      SendNUIMessage({add = 'true' , data = data })
    end
    if(BNEBoosting['functions'].GetCurrentBNE().back ~= nil ) then
      URL =  BNEBoosting['functions'].GetCurrentBNE().back
    end
    TriggerServerEvent("ethicalpixel-boosting:loadNUI")
    SetNuiFocus(true ,true)
    local t = {h = GetClockHours(), m = GetClockMinutes()}
    local Level = ethicalpixelLevel()

    SendNUIMessage({rank = Level , show = 'true' , vinprice = Config['Utils']["VIN"]["BNEPrice"],logo = Config['Utils']["Laptop"]["LogoUrl"] , background = URL, time = string.format("%02d:%02d", t.h, t.m) , BNE =   BNEBoosting['functions'].GetCurrentBNE().bne , defaultback = Config['Utils']["Laptop"]["DefaultBackground"]})
    toggleTablet()
  else
    TriggerEvent("DoLongHudText", 'The UI is still loading use the laptop again.', 2)
    TriggerServerEvent("ethicalpixel-boosting:loadNUI")
    Citizen.Wait(1000)
    NuiLoaded = true
  end
end)



local colorNames = {
  ['0'] = "Metallic Black",
  ['1'] = "Metallic Graphite Black",
  ['2'] = "Metallic Black Steal",
  ['3'] = "Metallic Dark Silver",
  ['4'] = "Metallic Silver",
  ['5'] = "Metallic Blue Silver",
  ['6'] = "Metallic Steel Gray",
  ['7'] = "Metallic Shadow Silver",
  ['8'] = "Metallic Stone Silver",
  ['9'] = "Metallic Midnight Silver",
  ['10'] = "Metallic Gun Metal",
  ['11'] = "Metallic Anthracite Grey",
  ['12'] = "Matte Black",
  ['13'] = "Matte Gray",
  ['14'] = "Matte Light Grey",
  ['15'] = "Util Black",
  ['16'] = "Util Black Poly",
  ['17'] = "Util Dark silver",
  ['18'] = "Util Silver",
  ['19'] = "Util Gun Metal",
  ['20'] = "Util Shadow Silver",
  ['21'] = "Worn Black",
  ['22'] = "Worn Graphite",
  ['23'] = "Worn Silver Grey",
  ['24'] = "Worn Silver",
  ['25'] = "Worn Blue Silver",
  ['26'] = "Worn Shadow Silver",
  ['27'] = "Metallic Red",
  ['28'] = "Metallic Torino Red",
  ['29'] = "Metallic Formula Red",
  ['30'] = "Metallic Blaze Red",
  ['31'] = "Metallic Graceful Red",
  ['32'] = "Metallic Garnet Red",
  ['33'] = "Metallic Desert Red",
  ['34'] = "Metallic Cabernet Red",
  ['35'] = "Metallic Candy Red",
  ['36'] = "Metallic Sunrise Orange",
  ['37'] = "Metallic Classic Gold",
  ['38'] = "Metallic Orange",
  ['39'] = "Matte Red",
  ['40'] = "Matte Dark Red",
  ['41'] = "Matte Orange",
  ['42'] = "Matte Yellow",
  ['43'] = "Util Red",
  ['44'] = "Util Bright Red",
  ['45'] = "Util Garnet Red",
  ['46'] = "Worn Red",
  ['47'] = "Worn Golden Red",
  ['48'] = "Worn Dark Red",
  ['49'] = "Metallic Dark Green",
  ['50'] = "Metallic Racing Green",
  ['51'] = "Metallic Sea Green",
  ['52'] = "Metallic Olive Green",
  ['53'] = "Metallic Green",
  ['54'] = "Metallic Gasoline Blue Green",
  ['55'] = "Matte Lime Green",
  ['56'] = "Util Dark Green",
  ['57'] = "Util Green",
  ['58'] = "Worn Dark Green",
  ['59'] = "Worn Green",
  ['60'] = "Worn Sea Wash",
  ['61'] = "Metallic Midnight Blue",
  ['62'] = "Metallic Dark Blue",
  ['63'] = "Metallic Saxony Blue",
  ['64'] = "Metallic Blue",
  ['65'] = "Metallic Mariner Blue",
  ['66'] = "Metallic Harbor Blue",
  ['67'] = "Metallic Diamond Blue",
  ['68'] = "Metallic Surf Blue",
  ['69'] = "Metallic Nautical Blue",
  ['70'] = "Metallic Bright Blue",
  ['71'] = "Metallic Purple Blue",
  ['72'] = "Metallic Spinnaker Blue",
  ['73'] = "Metallic Ultra Blue",
  ['74'] = "Metallic Bright Blue",
  ['75'] = "Util Dark Blue",
  ['76'] = "Util Midnight Blue",
  ['77'] = "Util Blue",
  ['78'] = "Util Sea Foam Blue",
  ['79'] = "Uil Lightning blue",
  ['80'] = "Util Maui Blue Poly",
  ['81'] = "Util Bright Blue",
  ['82'] = "Matte Dark Blue",
  ['83'] = "Matte Blue",
  ['84'] = "Matte Midnight Blue",
  ['85'] = "Worn Dark blue",
  ['86'] = "Worn Blue",
  ['87'] = "Worn Light blue",
  ['88'] = "Metallic Taxi Yellow",
  ['89'] = "Metallic Race Yellow",
  ['90'] = "Metallic Bronze",
  ['91'] = "Metallic Yellow Bird",
  ['92'] = "Metallic Lime",
  ['93'] = "Metallic Champagne",
  ['94'] = "Metallic Pueblo Beige",
  ['95'] = "Metallic Dark Ivory",
  ['96'] = "Metallic Choco Brown",
  ['97'] = "Metallic Golden Brown",
  ['98'] = "Metallic Light Brown",
  ['99'] = "Metallic Straw Beige",
  ['100'] = "Metallic Moss Brown",
  ['101'] = "Metallic Biston Brown",
  ['102'] = "Metallic Beechwood",
  ['103'] = "Metallic Dark Beechwood",
  ['104'] = "Metallic Choco Orange",
  ['105'] = "Metallic Beach Sand",
  ['106'] = "Metallic Sun Bleeched Sand",
  ['107'] = "Metallic Cream",
  ['108'] = "Util Brown",
  ['109'] = "Util Medium Brown",
  ['110'] = "Util Light Brown",
  ['111'] = "Metallic White",
  ['112'] = "Metallic Frost White",
  ['113'] = "Worn Honey Beige",
  ['114'] = "Worn Brown",
  ['115'] = "Worn Dark Brown",
  ['116'] = "Worn straw beige",
  ['117'] = "Brushed Steel",
  ['118'] = "Brushed Black steel",
  ['119'] = "Brushed Aluminium",
  ['120'] = "Chrome",
  ['121'] = "Worn Off White",
  ['122'] = "Util Off White",
  ['123'] = "Worn Orange",
  ['124'] = "Worn Light Orange",
  ['125'] = "Metallic Securicor Green",
  ['126'] = "Worn Taxi Yellow",
  ['127'] = "police car blue",
  ['128'] = "Matte Green",
  ['129'] = "Matte Brown",
  ['130'] = "Worn Orange",
  ['131'] = "Matte White",
  ['132'] = "Worn White",
  ['133'] = "Worn Olive Army Green",
  ['134'] = "Pure White",
  ['135'] = "Hot Pink",
  ['136'] = "Salmon pink",
  ['137'] = "Metallic Vermillion Pink",
  ['138'] = "Orange",
  ['139'] = "Green",
  ['140'] = "Blue",
  ['141'] = "Mettalic Black Blue",
  ['142'] = "Metallic Black Purple",
  ['143'] = "Metallic Black Red",
  ['144'] = "hunter green",
  ['145'] = "Metallic Purple",
  ['146'] = "Metaillic V Dark Blue",
  ['147'] = "MODSHOP BLACK1",
  ['148'] = "Matte Purple",
  ['149'] = "Matte Dark Purple",
  ['150'] = "Metallic Lava Red",
  ['151'] = "Matte Forest Green",
  ['152'] = "Matte Olive Drab",
  ['153'] = "Matte Desert Brown",
  ['154'] = "Matte Desert Tan",
  ['155'] = "Matte Foilage Green",
  ['156'] = "DEFAULT ALLOY COLOR",
  ['157'] = "Epsilon Blue",
}

function getStreetandZone(coords)
	local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
	local currentStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	playerStreetsLocation = currentStreetName .. ", " .. zone
	return playerStreetsLocation
end

NotifySent = false

Citizen.CreateThread(function()
  while true do
    Wait(0)
    while started == true do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          DeleteCircle()
          rnd = math.random(1,#DropOffLocations)
          local Driver = GetPedInVehicleSeat(veh, -1)
          if Driver == PlayerPedId() then
            if not(DropblipCreated) then
              OnTheDropoffWay = true
              DropblipCreated = true
              local Class = Contracts[startedcontractid].type 
              if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
                CallingCops = false
              else
                local primary, secondary = GetVehicleColours(veh)
                primary = colorNames[tostring(primary)]
                secondary = colorNames[tostring(secondary)]
                local hash = GetEntityModel(Vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                if not NotifySent then
                  TriggerServerEvent("ethicalpixel-boosting:CallCopsNotify" , Contracts[startedcontractid].plate , modelName, primary..', '..secondary , getStreetandZone(GetEntityCoords(PlayerPedId())))
                  CallingCops = true
                  NotifySent = true
                end
              end
            end
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    while vinstarted == true do
      Wait(1000)
      local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
      if(veh ~= 0) then
        local PlayerPed = PlayerPedId()
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          local PedVehicle = GetVehiclePedIsIn(PlayerPed)
          local Driver = GetPedInVehicleSeat(PedVehicle, -1)
          if Driver == PlayerPed then
            OnTheDropoffWay = true
            local Class = Contracts[startedcontractid].type 
            if (Config['Utils']["Contracts"]["DisableTrackingOnDCB"]) and (Class == "D" or Class == "C" or Class == "B") then
              CallingCops = false
            else
              local primary, secondary = GetVehicleColours(veh)
              primary = colorNames[tostring(primary)]
              secondary = colorNames[tostring(secondary)]
              local hash = GetEntityModel(Vehicle)
              local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
              if not NotifySent then
                TriggerServerEvent("ethicalpixel-boosting:CallCopsNotify" , Contracts[startedcontractid].plate , modelName, primary..', '..secondary , getStreetandZone(GetEntityCoords(PlayerPed)))
                CallingCops = true
                NotifySent = true
              end
            end
            DeleteCircle()
          end
        end
      end
    end
  end
end)



Citizen.CreateThread(function()
  while true do
    if InBoostingQueue then
      Citizen.Wait(15000)
      local shit = math.random(1,10)
      local DVTen = Config['Utils']["Contracts"]["ContractChance"] / 10
      if(shit <= DVTen) then
        if Config['Utils']["VIN"]["ForceVin"] then
          TriggerEvent('ethicalpixel-boosting:CreateContract', true)
        else
          TriggerEvent("ethicalpixel-boosting:CreateContract")
        end
      end
    else
      Citizen.Wait(500)
    end
  end
end)


Citizen.CreateThread(function()
  while true do
    if OnTheDropoffWay then
      if vinstarted then
        return
      else
        Citizen.Wait(1000)
        local coordA = GetEntityCoords(PlayerPedId())
        local veh = GetVehiclePedIsIn(GetPlayerPed(PlayerId()) , false)
        if(veh ~= 0) then
          local PlayerPed = PlayerPedId()
          if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
            local PedVehicle = GetVehiclePedIsIn(PlayerPed)
            local aDist = GetDistanceBetweenCoords(DropOffLocations[rnd]["x"],DropOffLocations[rnd]["y"],DropOffLocations[rnd]["z"], coordA["x"],coordA["y"],coordA["z"])
            if aDist < 10.0 then
              CallingCops = false
              CompletedTask = true
              Citizen.Wait(300)
              DeleteBlip()
              if OnTheDropoffWay then
                TriggerEvent('ethicalpixel-boosting:ContractDone')
              end
              OnTheDropoffWay = false
              DisablerTimes = 0
            end
          end
        end
      end
    else
      Wait(5000)
    end
  end
end)

RegisterNetEvent("ethicalpixel-boosting:ContractDone")
AddEventHandler("ethicalpixel-boosting:ContractDone" , function()
  if CompletedTask then
    TriggerEvent('phone:addnotification', 'Anonymous', 'Get out of the car and flee the area, keep an eye on your Vehicle Class Bar.')
    TriggerServerEvent("ethicalpixel-boosting:removeblip")
    Citizen.Wait(math.random(25000,35000))
    TriggerServerEvent("ethicalpixel-boosting:expreward", Contracts[startedcontractid].type)
    BNEBoosting['functions'].AddBne(VehiclePrice)
    table.remove(Contracts , startedcontractid)
    started = false
    SetEntityAsMissionEntity(Vehicle,true,true)
    DeleteEntity(Vehicle)
    CompletedTask = false
    DropblipCreated = false
    CallingCops = false
    NotifySent= false
  end
end)


--- HAS ITEM CHECK

function HasItem(item)
  local hasitem = false
  if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.TriggerCallback(Config['CoreSettings']['QBCORE']["HasItem"], function(result)
        hasitem = result
    end, item)
    Citizen.Wait(500)
    return hasitem
  elseif Config['General']["Core"] == "ESX" then
    ESX.TriggerServerCallback('ethicalpixel-boosting:canPickUp', function(result)
      hasitem = result
    end , item)
    Citizen.Wait(500)
    return hasitem
  elseif Config['General']["Core"] == "NPBASE" then
    hasitem = exports[Config['CoreSettings']['NPBASE']["HasItem"]]:hasEnoughOfItem(item, 1, false, true)
    Citizen.Wait(500)
    return hasitem
  end
end

---------------- Cop Blip Thingy ------------------

local copblip


Citizen.CreateThread(function()
  while true do
    if CallingCops then
      Citizen.Wait(Config['Utils']["Blips"]["BlipUpdateTime"])
      local coords = GetEntityCoords(Vehicle)
      if CallingCops then
        TriggerServerEvent('ethicalpixel-boosting:alertcops', coords.x, coords.y, coords.z)
      end
    else
      Wait(500)
    end
  end
end)


RegisterNetEvent('ethicalpixel-boosting:SendNotify')
AddEventHandler('ethicalpixel-boosting:SendNotify' , function(data)
  if Config['General']["PoliceNeedLaptopToseeNotifications"] then
    if(HasItem('pixellaptop') == true) then
      SendNUIMessage({addNotify = 'true' , plate = data.plate , model = data.model , color = data.color , place = data.place , length = Config['Utils']['Laptop']['CopNotifyLength']})
    end
  else
    SendNUIMessage({addNotify = 'true' , plate = data.plate , model = data.model , color = data.color , place = data.place , length = Config['Utils']['Laptop']['CopNotifyLength']})
  end
end)

RegisterNetEvent('ethicalpixel-boosting:removecopblip')
AddEventHandler('ethicalpixel-boosting:removecopblip', function()
  DeleteCopBlip()
end)

RegisterNetEvent('ethicalpixel-boosting:setcopblip')
AddEventHandler('ethicalpixel-boosting:setcopblip', function(cx,cy,cz)
  if Config['General']["PoliceNeedLaptopToseeNotifications"] then
    if(HasItem('pixellaptop') == true) then
      CreateCopBlip(cx,cy,cz)
    end
  else
    CreateCopBlip(cx,cy,cz)
  end
end)

RegisterNetEvent('ethicalpixel-boosting:setBlipTime')
AddEventHandler('ethicalpixel-boosting:setBlipTime', function()
  Config['Utils']["Blips"]["BlipUpdateTime"] = 7000
end)



--------- EMIAL ---------------
function CreateListEmail()
  TriggerServerEvent(Config['General']["EmailEvent"], {
    sender = Contracts[startedcontractid].owner,
    subject = "Boosting details",
    message = "Yo buddy , this is the vehicle details.<br /><br /><strong>Vehicle Model:  "..GetDisplayNameFromVehicleModel(Contracts[startedcontractid].vehicle).."<br />Vehicle Class :"..Contracts[startedcontractid].type.."<br />Vehicle Plate :"..Contracts[startedcontractid].plate.." </strong><br />",
    button = {}
  })
end

function RevievedOfferEmail(owner, class)
  TriggerServerEvent(Config['General']["EmailEvent"], {
    sender = owner,
    subject = "Contract Offer",
    message = "You have recieved a "..class.. " Boosting... <br />",
    button = {}
  })
end

function CreateListEmailNPBASE()
  TriggerEvent(Config['General']["EmailEvent"], "Boosting details", "Yo buddy , this is the vehicle details.<br /><br /><strong>Vehicle Model:  "..GetDisplayNameFromVehicleModel(Contracts[startedcontractid].vehicle).."<br />Vehicle Class :"..Contracts[startedcontractid].type.."<br />Vehicle Plate :"..Contracts[startedcontractid].plate.." </strong><br />")
end

function RevievedOfferEmailNPBASE(owner, class)
  TriggerEvent(Config['General']["EmailEvent"], "Boosting details", "You have recieved a "..class.. " Boosting... <br />")
end



-------------------------------
local isVisible = false
local tabletObject = nil
function toggleTablet()
  local playerPed = PlayerPedId()

  if not isVisible then
      local dict = "amb@world_human_seat_wall_tablet@female@base"
      RequestAnimDict(dict)
      if tabletObject == nil then
          tabletObject = CreateObject(GetHashKey("prop_cs_tablet"), GetEntityCoords(playerPed), 1, 1, 1)
          AttachEntityToEntity(
              tabletObject,
              playerPed,
              GetPedBoneIndex(playerPed, 28422),
              0.0,
              0.0,
              0.03,
              0.0,
              0.0,
              0.0,
              1,
              1,
              0,
              1,
              0,
              1
          )
      end
      while not HasAnimDictLoaded(dict) do
          Citizen.Wait(100)
      end
      if not IsEntityPlayingAnim(playerPed, dict, "base", 3) then
          TaskPlayAnim(playerPed, dict, "base", 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
      end
      isVisible = true
  else
      ClearPedTasks(playerPed)
      DeleteEntity(tabletObject)
      tabletObject = nil
      isVisible = false
  end
end


---------------------- VIN SCRATCH ------------------------

local function AddVehicleToGarage()
  local EntityModel = GetEntityModel(Vehicle)
  TriggerServerEvent('ethicalpixel-boosting:AddVehicle', Contracts[startedcontractid].vehicle, Contracts[startedcontractid].plate)
  vinstarted = false
  CanScratchVehicle = false
  table.remove(Contracts , startedcontractid)
end

RegisterNetEvent("ethicalpixel-boosting:client:UseComputer")
AddEventHandler("ethicalpixel-boosting:client:UseComputer" , function()
  if CanUseComputer then
    CanUseComputer = false
    RemoveBlip(pDropVinVeh)
    FreezeEntityPosition(PlayerPedId(),true)
    TriggerEvent("animation:PlayAnimation", 'type')
    local finished = exports['np-taskbar']:taskBar(1500, 'Opening Laptop')
    if (finished == 100) then
      Citizen.Wait(250)
      TriggerEvent("animation:PlayAnimation", 'type')
      local finished = exports['np-taskbar']:taskBar(7000, 'Connection to network...')
      if (finished == 100) then
        Citizen.Wait(250)
        TriggerEvent("animation:PlayAnimation", 'type')
        local finished = exports['np-taskbar']:taskBar(13000, "Wiping Online Paperwork...")
        if finished == 100 then
          CanScratchVehicle = true
          TriggerEvent("DoLongHudText", 'Head to the vehicle and scratch off the vin!', 1)
          FreezeEntityPosition(PlayerPedId(),false)
          ClearPedTasks(PlayerPedId())
        end
      end
    end
  else
    TriggerEvent("DoLongHudText","Can't use this now!",2)
  end
end)

function LoadDict(dict)
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
      Citizen.Wait(10)
  end
end

RegisterNetEvent("ethicalpixel-boosting:client:ScratchVehicle")
AddEventHandler("ethicalpixel-boosting:client:ScratchVehicle" , function()
    CanScratchVehicle = false
    FreezeEntityPosition(PlayerPedId(),true)
    TriggerEvent('animation:PlayAnimation', 'kneel')
    local finished = exports['np-taskbar']:taskBar(10000, 'Scratching Vin')
    if (finished == 100) then
      AddVehicleToGarage()
      TriggerEvent("DoLongHudText", 'Vin Scratch Complete.', 1)
      CallingCops = false
      DeleteBlip()
      FreezeEntityPosition(PlayerPedId(),false)
    end
  NotifySent = false
end)

Citizen.CreateThread(function()
  while true do
    if CanScratchVehicle then
      Citizen.Wait(1000)
      local playerped = PlayerPedId()
      local coordA = GetEntityCoords(playerped, 1)
      local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
      local targetVehicle = getVehicleInDirection(coordA, coordB)
      if targetVehicle ~= 0 then
        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        if(GetVehicleNumberPlateText(veh) == Contracts[startedcontractid].plate) then
          while dist > 2.5 and count > 0 do
            dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
          end
        end
      end
    else
      Wait(5000)
    end
  end
end)

function getVehicleInDirection(coordFrom, coordTo)
  local offset = 0
  local rayHandle
  local vehicle

  for i = 0, 100 do
      rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
      a, b, c, d, vehicle = GetRaycastResult(rayHandle)
      
      offset = offset - 1

      if vehicle ~= 0 then break end
  end
  
  local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
  
  if distance > 25 then vehicle = nil end

  return vehicle ~= nil and vehicle or 0
end

RegisterNetEvent('XZCore:Client:OnPlayerLoaded')
AddEventHandler('XZCore:Client:OnPlayerLoaded', function()
  CoreName.Functions.TriggerCallback('ethicalpixel-boosting:server:checkVin' , function(res)
    if(res == true) then
      TriggerEvent('ethicalpixel-boosting:CreateContract'  , true)
      return
    end
  end)
end)

----------- QUEUE -------------------

RegisterNUICallback("QueueUpdate", function()
  InBoostingQueue = not InBoostingQueue  
end)


----------- TRANSFER ------------------

function iSPlayerActive(id)
  for _, player in ipairs(GetActivePlayers()) do
    local PlayerId = GetPlayerServerId(player)
    if PlayerId == tonumber(id) then
      return true
    end
    return false
  end
end

RegisterNUICallback("transfercontract", function(data)
  local zebjdid = 0
  local target = data.target
  local istargetonline = iSPlayerActive(target)
  if (tonumber(target) ~= GetPlayerServerId(PlayerId())) then
    if istargetonline then
      for k,v in ipairs(Contracts) do
        if v.id == data.contract.id then
          zebjdid = zebjdid + 1
          local newid = zebjdid + 1
          local contract = {
            vehicle = GetDisplayNameFromVehicleModel(v.vehicle),
            price = v.price,
            owner = v.owner,
            type = v.type,
            expires = '6 Hours',
            id = newid,
            started = v.started,
            vin = v.vin
          }
          table.remove(Contracts, v.id)
          TriggerEvent("DoLongHudText", 'You successfully sent a contract to '..target)
          TriggerServerEvent('ethicalpixel-boosting:server:transfercontract',contract,target)
          SetNuiFocus(false,false)
        end
      end
    else
      TriggerEvent("DoLongHudText", 'ID doesnt exist', 2)
    end
  else
    TriggerEvent("DoLongHudText", 'You cant transfer yourself your own contract.',2)
  end
end)


RegisterNetEvent('ethicalpixel-boosting:AddContract')
AddEventHandler('ethicalpixel-boosting:AddContract' , function(contract, sender)
  TriggerEvent("DoLongHudText", 'You recieved a new contract from '..sender)
  table.insert(Contracts, contract)
end)

-- EXPORTS --

function pCanVin()
  if CanScratchVehicle then
    CanScratchVehicle = true
  elseif not CanScratchVehicle then
    CanScratchVehicle = false
  end
  return CanScratchVehicle
end

function pCanUseComputer()
  if CanUseComputer then
    CanUseComputer = true
  elseif not CanUseComputer then
    CanUseComputer = false
  end
  return CanUseComputer
end