NPX.SpawnManager = {}

function NPX.SpawnManager.Initialize(self)
    Citizen.CreateThread(function()

        FreezeEntityPosition(PlayerPedId(), true)

        TransitionToBlurred(500)
        DoScreenFadeOut(500)

        ShutdownLoadingScreen()

        local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)

        SetCamRot(cam, 0.0, 0.0, -45.0, 2)
        SetCamCoord(cam, -682.0, -1092.0, 226.0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)

        local ped = PlayerPedId()

        SetEntityCoordsNoOffset(ped, -682.0, -1092.0, 200.0, false, false, false, true)

        SetEntityVisible(ped, false)

        DoScreenFadeIn(500)

        while IsScreenFadingIn() do
            Citizen.Wait(0)
        end

        TriggerEvent("np-base:spawnInitialized")
        TriggerServerEvent("np-base:spawnInitialized")

    end)
end

function NPX.SpawnManager.InitialSpawn(self)
    Citizen.CreateThread(function()
        DisableAllControlActions(0)
      
        DoScreenFadeOut(10)

        while IsScreenFadingOut() do
            Citizen.Wait(0)
        end

        local character = NPX.LocalPlayer:getCurrentCharacter()


        --Tells raid clothes to set ped to correct skin
        TriggerEvent("np-base:initialSpawnModelLoaded")

        local ped = PlayerPedId()

        SetEntityVisible(ped, true)
        FreezeEntityPosition(PlayerPedId(), false)
        
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)
        --ClearPlayerWantedLevel(PlayerId())

        EnableAllControlActions(0)

        TriggerEvent("character:finishedLoadingChar")
    end)
end

AddEventHandler("np-base:firstSpawn", function()
    NPX.SpawnManager:InitialSpawn()

    Citizen.CreateThread(function()
        Citizen.Wait(600)
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end)

RegisterNetEvent('np-base:clearStates')
AddEventHandler('np-base:clearStates', function()
  TriggerEvent("isJudgeOff")
  TriggerEvent("nowCopSpawnOff")
  TriggerEvent("nowEMSDeathOff")
  TriggerEvent("police:noLongerCop")
  TriggerEvent("nowCopDeathOff")
  TriggerEvent("ResetFirstSpawn")
  TriggerEvent("stopSpeedo")
  TriggerServerEvent("TokoVoip:removePlayerFromAllRadio",GetPlayerServerId(PlayerId()))
  TriggerEvent("wk:disableRadar")
end)



NPX.SettingsData = NPX.SettingsData or {}
NPX.Settings = NPX.Settings or {}

NPX.Settings.Current = {}
-- Current bind name and keys
NPX.Settings.Default = {
  ["tokovoip"] = {
    ["stereoAudio"] = true,
    ["localClickOn"] = true,
    ["localClickOff"] = true,
    ["remoteClickOn"] = true,
    ["remoteClickOff"] = true,
    ["clickVolume"] = 0.8,
    ["radioVolume"] = 0.8,
    ["phoneVolume"] = 0.8,
    ["releaseDelay"] = 200
  },
  ["hud"] = {

  }

}


function NPX.SettingsData.setSettingsTable(settingsTable, shouldSend)
  if settingsTable == nil then
    NPX.Settings.Current = NPX.Settings.Default
    TriggerServerEvent('np-base:sv:player_settings_set',NPX.Settings.Current)
    NPX.SettingsData.checkForMissing()
  else
    if shouldSend then
      NPX.Settings.Current = settingsTable
      TriggerServerEvent('np-base:sv:player_settings_set',NPX.Settings.Current)
      NPX.SettingsData.checkForMissing()
    else
       NPX.Settings.Current = settingsTable
       NPX.SettingsData.checkForMissing()
    end
  end

  TriggerEvent("event:settings:update",NPX.Settings.Current)

end

function NPX.SettingsData.setSettingsTableGlobal(self, settingsTable)
  NPX.SettingsData.setSettingsTable(settingsTable,true);
end

function NPX.SettingsData.getSettingsTable()
    return NPX.Settings.Current
end

function NPX.SettingsData.setVarible(self,tablename,atrr,val)
  NPX.Settings.Current[tablename][atrr] = val
  TriggerServerEvent('np-base:sv:player_settings_set',NPX.Settings.Current)
end

function NPX.SettingsData.getVarible(self,tablename,atrr)
  return NPX.Settings.Current[tablename][atrr]
end

function NPX.SettingsData.checkForMissing()
  local isMissing = false

  for j,h in pairs(NPX.Settings.Default) do
    if NPX.Settings.Current[j] == nil then
      isMissing = true
      NPX.Settings.Current[j] = h
    else
      for k,v in pairs(h) do
        if  NPX.Settings.Current[j][k] == nil then
           NPX.Settings.Current[j][k] = v
           isMissing = true
        end
      end
    end
  end
  

  if isMissing then
    TriggerServerEvent('np-base:sv:player_settings_set',NPX.Settings.Current)
  end


end

RegisterNetEvent("np-base:cl:player_settings")
AddEventHandler("np-base:cl:player_settings", function(settingsTable)
  NPX.SettingsData.setSettingsTable(settingsTable,false)
end)


RegisterNetEvent("np-base:cl:player_reset")
AddEventHandler("np-base:cl:player_reset", function(tableName)
  if NPX.Settings.Default[tableName] then
      if NPX.Settings.Current[tableName] then
        NPX.Settings.Current[tableName] = NPX.Settings.Default[tableName]
        NPX.SettingsData.setSettingsTable(NPX.Settings.Current,true)
      end
  end
end)
