RegisterNetEvent("np-jobsystem:PoliceJobMenu")
AddEventHandler("np-jobsystem:PoliceJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedPD", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:PoliceJobMenu2")
AddEventHandler("np-jobsystem:PoliceJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedPD", valid[1].input)
    end
end)

-- DOJ------------------------------------------------------------------------------------------------------------------
--Judge-----------------------------------

RegisterNetEvent("np-jobsystem:JudgeJobMenuHire")
AddEventHandler("np-jobsystem:JudgeJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedJudge", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:JudgeJobMenuFire")
AddEventHandler("np-jobsystem:JudgeJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedJudge", valid[1].input)
    end
end)
--DA------------------------------------

RegisterNetEvent("np-jobsystem:DAJobMenuHire")
AddEventHandler("np-jobsystem:DAJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedDA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:DAJobMenuFire")
AddEventHandler("np-jobsystem:DAJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedDA", valid[1].input)
    end
end)

--ADA---------------------------------------

RegisterNetEvent("np-jobsystem:ADAJobMenuHire")
AddEventHandler("np-jobsystem:ADAJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedADA", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:ADAJobMenuFire")
AddEventHandler("np-jobsystem:ADAJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedADA", valid[1].input)
    end
end)

--Defender-------------------------------------------

RegisterNetEvent("np-jobsystem:DefenderJobMenuHire")
AddEventHandler("np-jobsystem:DefenderJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedDefender", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:DefenderJobMenuFire")
AddEventHandler("np-jobsystem:DefenderJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedDefender", valid[1].input)
    end
end)

-- Tow Hire / Fire ----------------------------------------------------------------------------------------------------
RegisterNetEvent("np-jobsystem:TowJobMenuHire")
AddEventHandler("np-jobsystem:TowJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:TowJobMenuFire")
AddEventHandler("np-jobsystem:TowJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

-- Heat Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:heatJobMenuHire")
AddEventHandler("np-jobsystem:heatJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassHeat", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:heatJobMenuFire")
AddEventHandler("np-jobsystem:heatJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassHeat", valid[1].input)
    end
end)

-- Bondi Boys Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:bondiJobMenuHire")
AddEventHandler("np-jobsystem:bondiJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassBondi", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:bondiJobMenuFire")
AddEventHandler("np-jobsystem:bondiJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassBondi", valid[1].input)
    end
end)

-- Casino Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:casinoJobMenuHire")
AddEventHandler("np-jobsystem:casinoJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassCasino", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:casinoJobMenuFire")
AddEventHandler("np-jobsystem:casinoJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassCasino", valid[1].input)
    end
end)


-- Real Estate Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:reJobMenuHire")
AddEventHandler("np-jobsystem:reJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassRe", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:reJobMenuFire")
AddEventHandler("np-jobsystem:reJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassRe", valid[1].input)
    end
end)

-- Rockford Records Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:rrJobMenuHire")
AddEventHandler("np-jobsystem:rrJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassrr", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:rrJobMenuFire")
AddEventHandler("np-jobsystem:rrJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassrr", valid[1].input)
    end
end)


-- Yakuza Job Menu -------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:yakuzaJobMenuHire")
AddEventHandler("np-jobsystem:yakuzaJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassYakuza", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:yakuzaJobMenuFire")
AddEventHandler("np-jobsystem:yakuzaJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassYakuza", valid[1].input)
    end
end)

-- Winery Job Menu --------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:WineryJobMenuHire")
AddEventHandler("np-jobsystem:WineryJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassWinery", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:WineryJobMenuFire")
AddEventHandler("np-jobsystem:WineryJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassWinery", valid[1].input)
    end
end)

--- EMS --------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:EMSJobMenu")
AddEventHandler("np-jobsystem:EMSJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedEMS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:EMSJobMenu2")
AddEventHandler("np-jobsystem:EMSJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedEMS", valid[1].input)
    end
end)

----AK customs Hire / Fire --------------------------

RegisterNetEvent("np-jobsystem:AkJobMenuHire")
AddEventHandler("np-jobsystem:AkJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassAk_customs", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:AkJobMenuFire")
AddEventHandler("np-jobsystem:AkJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassAk_customs", valid[1].input)
    end
end)

---- Radical Hire / Fire --------------------------

RegisterNetEvent("np-jobsystem:RadicalJobMenuHire")
AddEventHandler("np-jobsystem:RadicalJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassRadical", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:RadicalJobMenuFire")
AddEventHandler("np-jobsystem:RadicalJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassRadical", valid[1].input)
    end
end)

----AOD Hire / Fire --------------------------

RegisterNetEvent("np-jobsystem:AodJobMenuHire")
AddEventHandler("np-jobsystem:AodJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassAod", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:AodJobMenuFire")
AddEventHandler("np-jobsystem:AodJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassAod", valid[1].input)
    end
end)
---- Pearls customs Hire / Fire ----------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:PearlsJobMenuHire")
AddEventHandler("np-jobsystem:PearlsJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassPearls", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:PearlsJobMenuFire")
AddEventHandler("np-jobsystem:PearlsJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassPearls", valid[1].input)
    end
end)

----VU Hire / Fire --------------------------

RegisterNetEvent("np-jobsystem:VUJobMenuHire")
AddEventHandler("np-jobsystem:VUJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassVU", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:VUJobMenuFire")
AddEventHandler("np-jobsystem:VUJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassVU", valid[1].input)
    end
end)

--PDM -------------------------------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:PDMJobMenu")
AddEventHandler("np-jobsystem:PDMJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedPDM", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:PDMJobMenu2")
AddEventHandler("np-jobsystem:PDMJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedPDM", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:NoodleJobMenu")
AddEventHandler("np-jobsystem:NoodleJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedNoodle", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:NoodleJobMenu2")
AddEventHandler("np-jobsystem:NoodleJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedNoodle", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:BSJobMenuHire")
AddEventHandler("np-jobsystem:BSJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassBS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:BSJobMenuFire")
AddEventHandler("np-jobsystem:BSJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassBS", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:SandersJobMenu")
AddEventHandler("np-jobsystem:SandersJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedSanders", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:SandersJobMenu2")
AddEventHandler("np-jobsystem:SandersJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedSanders", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:TowJobMenu")
AddEventHandler("np-jobsystem:TowJobMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedTow", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:TowJobMenu2")
AddEventHandler("np-jobsystem:TowJobMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedTow", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:releaseVehicle")
AddEventHandler("np-jobsystem:releaseVehicle", function()
    local ped = PlayerPedId()
	local dist = #(GetEntityCoords(ped)-vector3(-193.37142944336,-1162.4571533203,23.668823242188))
	if dist <= 2.5 then 
        local valid = exports["np-keyboard"]:KeyboardInput({
            header = "Release Vehicle Menu",
            rows = {
                {
                    id = 0,
                    txt = "Plate Number"
                },
            }
        })
        if valid then
            TriggerServerEvent("np-jobsystem:releaseVehicle", valid[1].input)
        end
    else
        exports['np-notification']:Alert({style = 'error', duration = 3000, message = 'You need to be at the front desk at the tow union to release the vehicle!'})
    end
end)

RegisterNetEvent("np-jobsystem:WeedMenu")
AddEventHandler("np-jobsystem:WeedMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedWeed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:WeedMenu2")
AddEventHandler("np-jobsystem:WeedMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedWeed", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:GalMenu")
AddEventHandler("np-jobsystem:GalMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedGal", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:GalMenu2")
AddEventHandler("np-jobsystem:GalMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedGal", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:LostMenu")
AddEventHandler("np-jobsystem:LostMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedLost", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:LostMenu2")
AddEventHandler("np-jobsystem:LostMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedLost", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:RedMenu")
AddEventHandler("np-jobsystem:RedMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedRed", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:RedMenu2")
AddEventHandler("np-jobsystem:RedMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedRed", valid[1].input)
    end
end)

RegisterNetEvent("np-jobsystem:UGMenu")
AddEventHandler("np-jobsystem:UGMenu", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addJobWhitelsitedUG", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:UGMenu2")
AddEventHandler("np-jobsystem:UGMenu2", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:fireJobWhitelsitedUG", valid[1].input)
    end
end)

-- Suits Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:suitsJobMenuHire")
AddEventHandler("np-jobsystem:suitsJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassSuits", valid[1].input, valid[2].input)
    end
end)


RegisterNetEvent("np-jobsystem:suitsJobMenuFire")
AddEventHandler("np-jobsystem:suitsJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassSuits", valid[1].input)
    end
end)

-- UG Casino Job Menu --------------------------------------------------------------------------------------

RegisterNetEvent("np-jobsystem:ugCasinoJobMenuHire")
AddEventHandler("np-jobsystem:ugCasinoJobMenuHire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:addCharacterPassUgCasino", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("np-jobsystem:ugCasinoJobMenuFire")
AddEventHandler("np-jobsystem:ugCasinoJobMenuFire", function()
    local valid = exports["np-keyboard"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("np-jobsystem:removeCharacterPassUgCasino", valid[1].input)
    end
end)