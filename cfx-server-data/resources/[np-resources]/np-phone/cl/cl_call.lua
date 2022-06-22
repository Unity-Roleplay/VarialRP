local isNotInCall, isDialing, isReceivingCall, isCallInProgress = 0, 1, 2, 3
local callStatus = isNotInCall
local recentcalls = {}
local PayPhoneHex = {
    [1] = 1158960338,
    [2] = -78626473,
    [3] = 1281992692,
    [4] = -1058868155,
    [5] = -429560270,
    [6] = -2103798695,
    [7] = 295857659,
  }
local callid = 0
  myID = 0
  mySourceID = 0
  local targetSRC = 0
  local mySRC = 0
  mySourceHoldStatus = false
  TriggerEvent('phone:setCallState', isNotInCall)
  costCount = 1

RegisterNUICallback('getCallHistory', function()
  SendNUIMessage({
    openSection = "callHistory",
    callHistory = recentcalls
  })
end)

RegisterNetEvent('animation:phonecallstart')
AddEventHandler('animation:phonecallstart', function()
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",true)
  local lPed = PlayerPedId()
  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Citizen.Wait(0)
  end
  local count = 0
  costCount = 1
  inPhone = false
  Citizen.Wait(200)
  ClearPedTasks(lPed)
  
  TriggerEvent("attachItemPhone","phone01")
  -- TriggerEvent("DoLongHudText","[E] Toggles Call.", 6)


  while callStatus ~= isNotInCall do

    if isDead then
      endCall()
    end


    if IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_call_listen_base", 3) and not IsPedRagdoll(PlayerPedId()) then
    else 



      if IsPedRagdoll(PlayerPedId()) then
        Citizen.Wait(1000)
      end
      TaskPlayAnim(lPed, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
    end
    Citizen.Wait(1)
    count = count + 1

    if IsControlJustPressed(0, 38) then
      TriggerEvent("phone:holdToggle")
    end

    if onhold then
      if count == 800 then
         count = 0
        --  TriggerEvent("DoLongHudText","Call On Hold.", 1)
      end
    end

      --check if not unarmed
    local curw = GetSelectedPedWeapon(PlayerPedId())
    noweapon = `WEAPON_UNARMED`
    if noweapon ~= curw then
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end

  end
  ClearPedTasks(lPed)
  TaskPlayAnim(lPed, "cellphone@", "cellphone_call_out", 2.0, 2.0, 800, 49, 0, 0, 0, 0)
  Citizen.Wait(700)
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",false)
end)

RegisterNetEvent('phone:makecall')
AddEventHandler('phone:makecall', function(pnumber)
  local pnumber = tonumber(pnumber)
  if callStatus == isNotInCall and not isDead and hasPhone() then
    local dialingName = getContactName(pnumber)
    TriggerEvent('phone:setCallState', isDialing, dialingName)
    TriggerEvent("animation:phonecallstart")
    recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = pnumber, ["name"] = dialingName }
    TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, true)
  else
    TriggerEvent("It appears you are already in a call, injured or without a phone, please type /hangup to reset your calls.", 2)
  end
end)

--[[ The following happens for regular calls too ]]

RegisterNUICallback('callContact', function(data, cb)
    -- closeGui()
    -- Wait(1500)
    if callStatus == isNotInCall and not isDead and hasPhone() then
      local dialingName = getContactName(data.number)
      SendNUIMessage({
        openSection = 'callnotify',
        pCNumber = dialingName
      })
      if exports['np-phone']:pOpen() == false then 
        -- print("FUCK THIS SHIT")
          SendNUIMessage({openSection = "phonemedio"}) 
      end
      TriggerEvent('phone:setCallState', isDialing, data.name == "" and data.number or data.name)
      TriggerEvent("animation:phonecallstart")
      -- print("FUCK THIS SHIT 2")
      TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), data.number, true)
    else
      TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
    end
    cb('ok')
  end)
  
  debugn = false
  function t(trace)
    print(trace)
  end
  
  RegisterNetEvent('phone:failedCall')
  AddEventHandler('phone:failedCall', function()
      t("Failed Call")
      endCall()
  end)
  
  
  RegisterNetEvent('phone:hangup')
  AddEventHandler('phone:hangup', function()
      t("Call Hangup")
      endCall()
  end)
  

  
  RegisterNetEvent('phone:endCalloncommand')
  AddEventHandler('phone:endCalloncommand', function()
      TriggerServerEvent('phone:EndCall', mySourceID, callid, true)
      SendNUIMessage({
        openSection = 'callnotifyEnd'
      })
      SendNUIMessage({
        openSection = 'phonemedioclose'
      })
  end)
  
RegisterNetEvent('phone:otherClientEndCall')
AddEventHandler('phone:otherClientEndCall', function()
    TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
    -- TriggerEvent("DoLongHudText", "Your call was ended!", 2)
    callid = 0
    myID = 0
    mySourceID = 0
    mySourceHoldStatus = false
    TriggerEvent('phone:setCallState', isNotInCall)
    onhold = false
    SendNUIMessage({
    openSection = 'callnotifyEnd'
    })
end)
  
  RegisterNUICallback('btnAnswer', function()
      -- closeGui()
      TriggerEvent("phone:answercall")
  end)
  
  RegisterNUICallback('btnHangup', function()
      TriggerEvent("phone:hangup")
      SendNUIMessage({
        openSection = 'callnotifyEnd'
      })
  end)
  
  -- RegisterCommand('answer', function()
  --   TriggerEvent("phone:answercall")
  -- end)
  
  RegisterCommand("+hangup", function()
    TriggerEvent("phone:hangup")
  end, false)
  RegisterCommand('-hangup', function() end, false)
  RegisterCommand("+answer", function()
    TriggerEvent("phone:answercall")
  end, false)
  RegisterCommand('-answer', function() end, false)
  Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Player", "Hangup Call", "+hangup", "-hangup", "5")
    exports["np-keybinds"]:registerKeyMapping("", "Player", "Answer Call", "+answer", "-answer", "6")
  end)
  
  RegisterNetEvent('phone:answercall')
  AddEventHandler('phone:answercall', function()
      if callStatus == isReceivingCall and not isDead then
      answerCall()
      TriggerEvent("animation:phonecallstart")
      TriggerEvent("DoLongHudText","You have answered a call.", 1)
      callTimer = 0
    else
      TriggerEvent("DoLongHudText","You are not being called, injured, or you took too long.", 2)
    end
  end)
  
  
  RegisterNetEvent('phone:initiateCall')
  AddEventHandler('phone:initiateCall', function(pnumber)
      TriggerEvent("DoLongHudText","You have started a call.",1)
      local dialingName = getContactName(pnumber)
      local pnumber = tonumber(pnumber)
      recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = pnumber, ["name"] = dialingName }
      -- print("INITIAL CALL",dialingName,pnumber)
      initiatingCall(dialingName)
  end)
  
  
  RegisterNetEvent('phone:addToCall')
  AddEventHandler('phone:addToCall', function(voipchannel)
    exports['np-voice']:addPlayerToCall(tonumber(voipchannel))
    -- if exports['np-phone']:pOpen() == false then
    --   print("PHONE MEDIO 2") 
    --   -- SendNUIMessage({openSection = "phonemedio"}) 
    -- end
  end)
  
  RegisterNetEvent('phone:callFullyInitiated')
  AddEventHandler('phone:callFullyInitiated', function(srcID,sentSource,caller)
   TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
   local contact = getContactName(caller)
    myID = srcID
    SendNUIMessage({
        callisAnswer = true,
        number = caller,
        name = contact
    })
    mySourceID = sentSource
    TriggerEvent('phone:setCallState', isCallInProgress)
    callTimer = 0
    TriggerEvent("phone:callactive")
    
  end)

  function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('phone:callactive')
AddEventHandler('phone:callactive', function()
    Citizen.Wait(100)
    local held1 = false
    local held2 = false
    while callStatus == isCallInProgress do
      local phoneString = ""
      Citizen.Wait(1)

      if onhold then
        phoneString = phoneString .. "They are on Hold | "
        if not held1 then
          TriggerEvent("DoLongHudText","You have put the caller on hold.",888)
          held1 = true
        end
      else
        phoneString = phoneString .. "Call Active | "
        if held1 then
          TriggerEvent("DoLongHudText","Your call is no longer on hold.",888)
          held1 = false
        end
      end

      if mySourceHoldStatus then
        phoneString = phoneString .. "You are on hold"
        if not held2 then
          TriggerEvent("DoLongHudText","You are on hold.",2)
          held2 = true
        end
      else
        phoneString = phoneString .. "Caller Active"
        if held2 then
          TriggerEvent("DoLongHudText","You are no longer on hold.",2)
          held2 = false
        end
      end
      drawTxt(0.97, 1.46, 1.0,1.0,0.33, phoneString, 255, 255, 255, 255)  -- INT: kmh
    end
end)



RegisterNetEvent('phone:id')
AddEventHandler('phone:id', function(sentcallid)
  callid = sentcallid
end)

RegisterNetEvent('phone:setCallState')
AddEventHandler('phone:setCallState', function(pCallState, pCallInfo)
  callStatus = pCallState
  SendNUIMessage({
    openSection = 'callState',
    callState = pCallState,
    callInfo = pCallInfo
  })
end)

RegisterNetEvent('phone:receiveCall')
AddEventHandler('phone:receiveCall', function(phoneNumber, srcID, calledNumber)
  -- print("RECEIVE CALL",phoneNumber, srcID, getContactName(calledNumber))
  local enableCallN = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall")
  if hasPhone() and enableCallN then
    local callFrom = getContactName(calledNumber)

    -- SendNUIMessage({
    --   openSection = 'callnotify',
    --   pCNumber = callFrom
    -- })

    -- if exports['np-phone']:pOpen() == false then 
    --   print("PHONE MEDIO")
      SendNUIMessage({
        openSection = "incomingcall",
        number = calledNumber,
        name = callFrom
    })
    -- end
    
    recentcalls[#recentcalls + 1] = { ["type"] = 1, ["number"] = calledNumber, ["name"] = callFrom }

    if callStatus == isNotInCall then
      myID = 0
      mySourceID = srcID
      TriggerEvent('phone:setCallState', isReceivingCall, callFrom)

      receivingCall(callFrom) -- Send contact name if exists, if not send number
    else
      TriggerEvent("DoLongHudText","You are receiving a call from " .. callFrom .. " but are currently already in one, sending busy response.",2)
    end
  end
end)
callTimer = 0
function initiatingCall(name)
  callTimer = 8
  -- TriggerEvent("DoLongHudText","You are making a call, please hold.", 1)
  -- phoneCallNotification("icall","Calling",name)
  while (callTimer > 0 and callStatus == isDialing) do
    TriggerEvent("InteractSound_CL:PlayOnOne","cellcall",0.5)
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus == isDialing or callTimer == 0 then
    endCall()
  end
end

function receivingCall(callFrom)
  callTimer = 8
  -- phoneCallNotification("rcall","Calling",callFrom)
  while (callTimer > 0 and callStatus == isReceivingCall) do
    if hasPhone() then
      Citizen.Wait(1)
      -- TriggerEvent("DoLongHudText","Call from: " .. callFrom .. " /answer | /hangup", 1)
      local call = GetResourceKvpInt(exports['isPed']:isPed('cid').."-ncall")
      if call then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cellcall', 0.5)
      end
    end
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus ~= isCallInProgress then
    endCall()
  end
end

RegisterNetEvent('np-phone:RemoveCall')
AddEventHandler('np-phone:RemoveCall', function()
    SendNUIMessage({
      openSection = 'callnotifyEnd'
    })
    SendNUIMessage({
      openSection = 'phonemedioclose'
    })
end)

function answerCall()

  if mySourceID ~= 0 then

    --NetworkSetVoiceChannel(mySourceID+1)
    --NetworkSetTalkerProximity(0.0)

    TriggerServerEvent("phone:StartCallConfirmed",mySourceID)
    TriggerEvent('phone:setCallState', isCallInProgress)
    TriggerEvent("phone:callactive")
  end
end

RegisterNetEvent('phone:removefromToko')
AddEventHandler('phone:removefromToko', function(playerRadioChannel)
  exports['np-voice']:removePlayerFromCall()
end)

function endCall()

  TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  TriggerEvent('np-phone:RemoveCall')
  onhold = false
  mySourceHoldStatus = false
  callid = 0
end

function endCall2()
  TriggerEvent("InteractSound_CL:PlayOnOne","payphoneend",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  onhold = false
  mySourceHoldStatus = false
  callid = 0
  --closeGui()
  --[[ 
  NetworkSetTalkerProximity(1.0)
  Citizen.Wait(300)
  NetworkClearVoiceChannel()
  Citizen.Wait(300)
  NetworkSetTalkerProximity(18.0)
  ]]
end


RegisterNetEvent('phone:holdToggle')
AddEventHandler('phone:holdToggle', function()
  if myID == nil then
    myID = 0
  end
  if myID ~= 0 then
    if not onhold then
      TriggerEvent("DoShortHudText", "Call on hold.",10)
      onhold = true

      --[[  
      NetworkSetTalkerProximity(1.0)
      Citizen.Wait(300)
      NetworkClearVoiceChannel()
      Citizen.Wait(300)
      NetworkSetTalkerProximity(18.0)
      ]]

      TriggerServerEvent("OnHold:Server",mySourceID,true)
    else
      TriggerEvent("DoShortHudText", "No longer on hold.",10)
      TriggerServerEvent("OnHold:Server",mySourceID,false)
      onhold = false

      --NetworkSetVoiceChannel(myID+1)
      --NetworkSetTalkerProximity(0.0)
    end
  else

    if mySourceID ~= 0 then
      if not onhold then
        TriggerEvent("DoShortHudText", "Call on hold.",10)
        onhold = true

        --[[ 
        NetworkSetTalkerProximity(1.0)
        Citizen.Wait(300)
        NetworkClearVoiceChannel()
        Citizen.Wait(300)
        NetworkSetTalkerProximity(18.0)
        ]]

        TriggerServerEvent("OnHold:Server",mySourceID,true)
      else
        TriggerEvent("DoShortHudText", "No longer on hold.",10)
        TriggerServerEvent("OnHold:Server",mySourceID,false)
        onhold = false

        --NetworkSetVoiceChannel(mySourceID+1)
        --NetworkSetTalkerProximity(0.0)
      end
    end
  end
end)

RegisterNetEvent('phone:CallingSomeone')
AddEventHandler('phone:CallingSomeone', function(targetsrc,mysrc)
    targetSRC = targetsrc
    mySRC = mysrc
    mySourceID = mysrc
end)

RegisterNetEvent('OnHold:Client')
AddEventHandler('OnHold:Client', function(newHoldStatus,srcSent)
    mySourceHoldStatus = newHoldStatus
    if mySourceHoldStatus then
        local playerId = GetPlayerFromServerId(srcSent)
        MumbleSetVolumeOverride(playerId, -1.0)
        -- TriggerEvent("DoLongHudText","You just got put on hold.", 1)
    else
        if not onhold then
          local playerId = GetPlayerFromServerId(srcSent)
          MumbleSetVolumeOverride(playerId, 1.0)
        end
        -- TriggerEvent("DoLongHudText","Your caller is back on the line.", 1)
    end
end)
----------

function checkForPayPhone()
    for i = 1, #PayPhoneHex do
      local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 5.0, PayPhoneHex[i], 0, 0, 0)
      if DoesEntityExist(objFound) then
        return true
      end
    end
    return false
  end
  
  AddEventHandler('phone:makepayphonecall', function(pnumber) 
    if not checkForPayPhone() then
      TriggerEvent("DoLongHudText","You are not near a payphone.",2)
      return
    end
  
    PhoneBooth = GetEntityCoords( PlayerPedId() )
    AnonCall = true
  
    local pnumber = tonumber(pnumber)
    if callStatus == isNotInCall and not isDead then
      TriggerEvent('phone:setCallState', isDialing)
      TriggerEvent("animation:phonecallstart")
      TriggerEvent("InteractSound_CL:PlayOnOne","payphonestart",0.5)
      TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, false)
      TriggerServerEvent("phone:RemovePayPhoneMoney")
    else
      TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
    end
  end)
  
  RegisterNetEvent("payphone:ui")
  AddEventHandler("payphone:ui", function()
  local ph = exports["np-applications"]:KeyboardInput({
    header = "Payphone",
    rows = {
      {
        id = 1,
        txt = "Number"
      }
    }
  })
  if ph then
    if ph[1].input ~= nil then
      TriggerEvent("phone:makepayphonecall", ph[1].input)
    end
  end
  end)