RegisterNUICallback("showroomPurchaseCurrentVehicle", function(data, cb)
  --QBCore.Functions.TriggerCallback("showroom:purchaseVehicle", function(success, model, plate)
  local name = data.model
  local zoneName = data.zoneName
  local price = data.price
  local plate = GetVehicleNumberPlateText(name)
  DoScreenFadeOut(0)
  Wait(400)
  DoScreenFadeIn(1000)
  SetNuiFocus(false, false)
  ClearFocus()
  RenderScriptCams(false, false, 0, 1, 0)
  DeleteEntity(vehicle)
  TriggerEvent("inhotel", false)
  TriggerServerEvent("showroom:purchaseVehicle", name, price, zoneName, false)
  cb({
    data = {},
    meta = {
      ok = true,
    }
  });
end);

local function isNear(pos1, pos2, distMustBe)
    local diff = pos2 - pos1
	local dist = (diff.x * diff.x) + (diff.y * diff.y)

	return (dist < (distMustBe * distMustBe))
end

RegisterNetEvent("showrooms:catalog", function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	nearTuner = isNear(coords, vector3(140.2422, -3024.448, 7.04089), 20.0)

	if nearTuner then
		TriggerEvent("np-showrooms-tuner:enterExperience")
	else
		TriggerEvent("np-showrooms:enterExperience")
	end 
end)

RegisterNetEvent("showroom:clPurchaseVehicle",function(model, plate)
  TakeOutVehicle(model, plate)
end)

-- RegisterCommand("das", function()
-- TriggerServerEvent("saas")
-- end)


function TakeOutVehicle(vehicle, plate)
  enginePercent = 100
  bodyPercent = 100
  currentFuel = 100
  model = vehicle
  veh = CreateVehicle(model, -45.60,-1080.9, 26.706,70.0, true, false)
  SetEntityAsMissionEntity(veh, true, true)
  SetModelAsNoLongerNeeded(model)
  SetVehicleOnGroundProperly(veh)
  TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
  SetVehicleNumberPlateText(veh, plate)
  TriggerEvent("keys:addNew",veh,plate)
end

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end
