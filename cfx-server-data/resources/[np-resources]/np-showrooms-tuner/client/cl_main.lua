RegisterNUICallback("tunershowroomPurchaseCurrentVehicle", function(data, cb)
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
  TriggerServerEvent("showroom-tuner:purchaseVehicle", name, price, zoneName, false)
  cb({
    data = {},
    meta = {
      ok = true,
    }
  });
end);

RegisterNetEvent("showroom-tuner:clPurchaseVehicle",function(model, plate)
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
  veh = CreateVehicle(model, 124.06, -3047.64, 7.04, 267.1, true, false)
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
