

local hidden = {}
local showPlayerBlips = false
local ignorePlayerNameDistance = false
local disPlayerNames = 50
local playerSource = 0


Citizen.CreateThread(function()
    while true do 
        if IsPedArmed(PlayerPedId(), 6) then
            Citizen.Wait(1)
        else
           Citizen.Wait(1500)
        end  

       if IsPedShooting(PlayerPedId()) then
           local ply = PlayerPedId()
           local GamePlayCam = GetFollowPedCamViewMode()
           local Vehicled = IsPedInAnyVehicle(ply, false)
           local MovementSpeed = math.ceil(GetEntitySpeed(ply))
           if MovementSpeed > 69 then
               MovementSpeed = 69
           end
           local _,wep = GetCurrentPedWeapon(ply)
           local group = GetWeapontypeGroup(wep)
           local p = GetGameplayCamRelativePitch()
           local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(ply))
           local recoil = math.random(130,140+(math.ceil(MovementSpeed*0.5)))/100
           local rifle = false
           local uzi = false


             if group == 970310034 or group == 1159398588 then
                 rifle = true
             end


           if Vehicled then
               recoil = recoil + (recoil)
           else
               recoil = recoil * 0.1
           end

           if GamePlayCam == 4 then

               recoil = recoil * 0.5
               if rifle then
                   recoil = recoil * 0.1
               end

           end

           if rifle then
               recoil = recoil * 0.1
           end

           local rightleft = math.random(4)
           local h = GetGameplayCamRelativeHeading()
           local hf = math.random(10,40+MovementSpeed)/100

           if Vehicled then
               hf = hf * 2.0
           end

           if rightleft == 1 then
               SetGameplayCamRelativeHeading(h+hf)
           elseif rightleft == 2 then
               SetGameplayCamRelativeHeading(h-hf)
           end 
       
           local set = p+recoil
           SetGameplayCamRelativePitch(set,0.8)                   
        end
    end
end)

function DrawText3D(x,y,z, text, textColor) -- some useful function, use it if you want!
    local color = { r = 255, g = 255, b = 255, alpha = 255 } -- Color of the text 
    if textColor ~= nil then 
        color = {r = textColor[1] or 255, g = textColor[2] or 255, b = textColor[3] or 255, alpha = textColor[4] or 255}
    end
    
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.3,0.3)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function DrawText3DTalking(x,y,z, text, textColor) -- some useful function, use it if you want!
    local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
    if textColor ~= nil then 
        color = {r = textColor[1] or 22, g = textColor[2] or 55, b = textColor[3] or 155, alpha = textColor[4] or 255}
    end

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.75*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("hud:HidePlayer")
AddEventHandler("hud:HidePlayer", function(player, toggle)
    if type(player) == "table" then
        for k,v in pairs(player) do
            if DoesPlayerExist(k) then
                local id = GetPlayerFromServerId(k)
                hidden[id] = k
            end
        end
        return
    end
    if DoesPlayerExist(player) then
        local id = GetPlayerFromServerId(player)
        if toggle == true then
            hidden[id] = player
        else
            for k,v in pairs(hidden) do
                if v == player then hidden[k] = nil end
            end
        end
    end
end)

Controlkey = {["generalScoreboard"] = {303,"U"}} 
RegisterNetEvent('event:control:update')
AddEventHandler('event:control:update', function(table)
    Controlkey["generalScoreboard"] = table["generalScoreboard"]
end)


Citizen.CreateThread(function()
    while true do
        if IsControlPressed(0, Controlkey["generalScoreboard"][1]) then

            for i=0,255 do
                N_0x31698aa80e0223f8(i)
            end

            local playerped = PlayerPedId()
            local HeadBone = 0x796e

            for id = 0, 255 do
                if NetworkIsPlayerActive(id) then
                    local ped = GetPlayerPed(id)

                    local playerCoords = GetPedBoneCoords(playerped, HeadBone)

                    if ped == playerped then
                        DrawText3DTalking(playerCoords.x, playerCoords.y, playerCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {152, 251, 152, 255})
                    else
                        local pedCoords = GetPedBoneCoords(ped, HeadBone)

                        local distance = math.floor(#(playerCoords - pedCoords))

                        local isDucking = IsPedDucking(ped)
                        local cansee = HasEntityClearLosToEntity(playerped, ped, 17 )
                        local isReadyToShoot = IsPedWeaponReadyToShoot(ped)
                        local isStealth = GetPedStealthMovement(ped)
                        local isDriveBy = IsPedDoingDriveby(ped)
                        local isInCover = IsPedInCover(ped,true)
                        if isStealth == nil then
                            isStealth = 0
                        end

                        if isDucking or isStealth == 1 or isDriveBy or isInCover then
                            cansee = false
                        end

                        if hidden[id] then cansee = false end

                        if (distance < disPlayerNames) then
                            if(NetworkIsPlayerTalking(id)) then                            
                                if cansee then
                                    DrawText3DTalking(pedCoords.x, pedCoords.y, pedCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {22, 55, 155, 255})
                                end
                            else
                                if cansee then
                                    DrawText3D(pedCoords.x, pedCoords.y, pedCoords.z+0.5, " ".. GetPlayerServerId(id) .. " ", {255, 255, 255, 255})
                                end
                            end
                        end
                    end                        
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(2000)
        end        
    end
end)





Citizen.CreateThread(function()
    SetRadarBigmapEnabled(true, false)
    Citizen.Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        --
        -- 1 : WANTED_STARS
        -- 2 : WEAPON_ICON
        -- 3 : CASH
        -- 4 : MP_CASH
        -- 5 : MP_MESSAGE
        -- 6 : VEHICLE_NAME
        -- 7 : AREA_NAME
        -- 8 : VEHICLE_CLASS
        -- 9 : STREET_NAME
        -- 10 : HELP_TEXT
        -- 11 : FLOATING_HELP_TEXT_1
        -- 12 : FLOATING_HELP_TEXT_2
        -- 13 : CASH_CHANGE
        -- 14 : RETICLE
        -- 15 : SUBTITLE_TEXT
        -- 16 : RADIO_STATIONS
        -- 17 : SAVING_GAME
        -- 18 : GAME_STREAM
        -- 19 : WEAPON_WHEEL
        -- 20 : WEAPON_WHEEL_STATS
        -- 21 : HUD_COMPONENTS
        -- 22 : HUD_WEAPONS
        --
        HideHudComponentThisFrame(1)
        -- HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        -- HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(10)
        HideHudComponentThisFrame(11)
        HideHudComponentThisFrame(12)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(14)
        --HideHudComponentThisFrame(16)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(18)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)

        DisableControlAction(0, 37, true)
    
        SetRadarZoom(1200)

        Citizen.Wait(0)
    end
end)
