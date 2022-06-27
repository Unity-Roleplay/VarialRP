-- Police Duty --

local PDService = false

RegisterNetEvent('np-duty:PoliceMenu')
AddEventHandler('np-duty:PoliceMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDuty"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDuty"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDuty')
AddEventHandler('np-duty:OnDuty', function()
	if PDService == false then
		TriggerServerEvent('np-duty:AttemptDuty')
		TriggerEvent('np_clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDuty')
AddEventHandler('np-duty:OffDuty', function()
	if PDService == true then
		PDService = false
		TriggerEvent('np_clothing:inService', false)
		exports['np-voice']:removePlayerFromRadio()
		exports["np-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('np-duty:OffDutyComplete')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:PDSuccess')
AddEventHandler('np-duty:PDSuccess', function()
	if PDService == false then
		exports["np-voice"]:setVoiceProperty("radioEnabled", true)
		exports['np-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		PDService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		TriggerEvent("armory:ammo")
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- EMS Duty --

local EMSService = false

RegisterNetEvent('np-duty:EMSMenu')
AddEventHandler('np-duty:EMSMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyEMS"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyEMS"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyEMS')
AddEventHandler('np-duty:OnDutyEMS', function()
	if EMSService == false then
		TriggerServerEvent('np-duty:AttemptDutyEMS')
		TriggerEvent('np-clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyEMS')
AddEventHandler('np-duty:OffDutyEMS', function()
	if EMSService == true then
		EMSService = false
		TriggerEvent('np-clothing:inService', false)
		exports['np-voice']:removePlayerFromRadio()
		exports["np-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('np-duty:OffDutyCompleteEMS')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:EMSSuccess')
AddEventHandler('np-duty:EMSSuccess', function()
	if EMSService == false then
		exports["np-voice"]:setVoiceProperty("radioEnabled", true)
		exports['np-voice']:addPlayerToRadio(2)
		TriggerEvent('radio:SetRadioStatus', true)
		EMSService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Suits Duty ----------------------------------------------------------------

local SuitsService = false

RegisterNetEvent('np-duty:SuitsMenu')
AddEventHandler('np-duty:SuitsMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutySuits"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutySuits"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutySuits')
AddEventHandler('np-duty:OnDutySuits', function()
	if SuitsService == false then
		TriggerServerEvent('np-duty:AttemptDutySuits')
		TriggerEvent('np-clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutySuits')
AddEventHandler('np-duty:OffDutySuits', function()
	if SuitsService == true then
		SuitsService = false
		TriggerEvent('np-clothing:inService', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('np-duty:OffDutyCompleteSuits')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:SuitsSuccess')
AddEventHandler('np-duty:SuitsSuccess', function()
	if SuitsService == false then
		SuitsService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Judge Duty ------------------------------------------------------------

local JudgeService = false

RegisterNetEvent('np-duty:JudgeMenu')
AddEventHandler('np-duty:JudgeMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyJudge"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyJudge"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyJudge')
AddEventHandler('np-duty:OnDutyJudge', function()
	if JudgeService == false then
		TriggerServerEvent('np-duty:AttemptDutyJudge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyJudge')
AddEventHandler('np-duty:OffDutyJudge', function()
	if JudgeService == true then
		JudgeService = false
		TriggerServerEvent('np-duty:OffDutyCompleteEMS')
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:JudgeSuccess')
AddEventHandler('np-duty:JudgeSuccess', function()
	if JudgeService == false then
		JudgeService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- DA Duty --

local DAService = false

RegisterNetEvent('np-duty:DAMenu')
AddEventHandler('np-duty:DAMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyDA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyDA"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyDA')
AddEventHandler('np-duty:OnDutyDA', function()
	if DAService == false then
		TriggerServerEvent('np-duty:AttemptDutyDA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyDA')
AddEventHandler('np-duty:OffDutyDA', function()
	if DAService == true then
		DAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:DASuccess')
AddEventHandler('np-duty:DASuccess', function()
	if DAService == false then
		DAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Public Duty --

local PublicService = false

RegisterNetEvent('np-duty:PublicMenu')
AddEventHandler('np-duty:PublicMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyPublic"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyPublic"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyPublic')
AddEventHandler('np-duty:OnDutyPublic', function()
	if PublicService == false then
		TriggerServerEvent('np-duty:AttemptDutyPublic')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyPublic')
AddEventHandler('np-duty:OffDutyPublic', function()
	if PublicService == true then
		PublicService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:PublicSuccess')
AddEventHandler('np-duty:PublicSuccess', function()
	if PublicService == false then
		PublicService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- ADA Duty --

local ADAService = false

RegisterNetEvent('np-duty:ADAMenu')
AddEventHandler('np-duty:ADAMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyADA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyADA"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyADA')
AddEventHandler('np-duty:OnDutyADA', function()
	if PublicService == false then
		TriggerServerEvent('np-duty:AttemptDutyADA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyADA')
AddEventHandler('np-duty:OffDutyADA', function()
	if ADAService == true then
		ADAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:ADASuccess')
AddEventHandler('np-duty:ADASuccess', function()
	if ADAService == false then
		ADAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- PDM Duty --

local PDMService = false

RegisterNetEvent('np-duty:PDMMenu')
AddEventHandler('np-duty:PDMMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyPDM"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyPDM"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyPDM')
AddEventHandler('np-duty:OnDutyPDM', function()
	if PDMService == false then
		TriggerServerEvent('np-duty:AttemptDutyPDM')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyPDM')
AddEventHandler('np-duty:OffDutyPDM', function()
	if PDMService == true then
		PDMService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:PDMSuccess')
AddEventHandler('np-duty:PDMSuccess', function()
	if PDMService == false then
		PDMService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local SandersService = false

RegisterNetEvent('np-duty:SandersMenu')
AddEventHandler('np-duty:SandersMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutySanders"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutySanders"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutySanders')
AddEventHandler('np-duty:OnDutySanders', function()
	if SandersService == false then
		TriggerServerEvent('np-duty:AttemptDutySanders')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutySanders')
AddEventHandler('np-duty:OffDutySanders', function()
	if SandersService == true then
		SandersService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:SandersSuccess')
AddEventHandler('np-duty:SandersSuccess', function()
	if SandersService == false then
		SandersService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local TowService = false

RegisterNetEvent('np-duty:TowMenu')
AddEventHandler('np-duty:TowMenu', function()
	TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "np-duty:OnDutyTow"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "np-duty:OffDutyTow"
            }
        },
    })
end)

RegisterNetEvent('np-duty:OnDutyTow')
AddEventHandler('np-duty:OnDutyTow', function()
	if TowService == false then
		TriggerServerEvent('np-duty:AttemptDutyTow')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('np-duty:OffDutyTow')
AddEventHandler('np-duty:OffDutyTow', function()
	if TowService == true then
		TowService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('np-duty:TowSuccess')
AddEventHandler('np-duty:TowSuccess', function()
	if TowService == false then
		TowService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterCommand('dutyon', function()
	TriggerEvent('np-duty:OnDuty')
end)
RegisterCommand('dutyoff', function()
	TriggerEvent('np-duty:OffDuty')
end)