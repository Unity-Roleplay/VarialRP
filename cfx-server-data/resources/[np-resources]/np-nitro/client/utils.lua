local ELECTRIC_VEHICLES = {
  [GetHashKey('AIRTUG')] = true,
  [GetHashKey('CYCLONE')] = true,
  [GetHashKey('CADDY')] = true,
  [GetHashKey('CADDY2')] = true,
  [GetHashKey('CADDY3')] = true,
  [GetHashKey('DILETTANTE')] = true,
  [GetHashKey('IMORGON')] = true,
  [GetHashKey('KHAMEL')] = true,
  [GetHashKey('NEON')] = true,
  [GetHashKey('RAIDEN')] = true,
  [GetHashKey('SURGE')] = true,
  [GetHashKey('VOLTIC')] = true,
  [GetHashKey('VOLTIC2')] = true,
  [GetHashKey('TEZERACT')] = true
}

exports["np-keybinds"]:registerKeyMapping('', "TEST", "Toggle Nos / Purge Mode", "+toggleNitroMode", "-toggleNitroMode");
exports["np-keybinds"]:registerKeyMapping('', "TEST", "Nos Flow Increase", "+increaseNitroFlow", "-increaseNitroFlow");
exports["np-keybinds"]:registerKeyMapping('', "TEST", "Nos Flow Decrease", "+decreaseNitroFlow", "-decreaseNitroFlow");
exports["np-keybinds"]:registerKeyMapping('', "TEST", "Activate Nos", "+useNitro", "-useNitro", "LSHIFT");

function IsVehicleElectric(vehicle)
  local model = GetEntityModel(vehicle)
  return ELECTRIC_VEHICLES[model] or false
end

RegisterCommand("+useNitro", activateNitro, false);
RegisterCommand("-useNitro", deactiveNitro, false);
RegisterCommand("+increaseNitroFlow", INCREASE_MODE, false);
RegisterCommand("-increaseNitroFlow", function()end, false);
RegisterCommand("+decreaseNitroFlow", DECREASE_MODE, false);
RegisterCommand("-decreaseNitroFlow", function()end, false);
RegisterCommand("+toggleNitroMode", SWITCH_MODE, false);
RegisterCommand("-toggleNitroMode", function()end, false);