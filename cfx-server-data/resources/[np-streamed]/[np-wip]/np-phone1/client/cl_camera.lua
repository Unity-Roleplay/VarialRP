--[[

    Variables

]]

local selfieMode = false

--[[

    Functions

]]

local function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

--[[

    NUI

]]

RegisterNUICallback("phone:selfie", function()
    selfieMode = not selfieMode

    if selfieMode then
        closePhone()
        DestroyMobilePhone()
        CreateMobilePhone(4)
        CellCamActivate(true, true)
        CellFrontCamActivate(true)

        while selfieMode do
            if IsControlJustPressed(0, 177) then
                selfieMode = false
                DestroyMobilePhone()
                CellCamActivate(false, false)
            end

            Citizen.Wait(1)
        end
    else
        closePhone()
        CellCamActivate(false, false)
        CellFrontCamActivate(false)
        DestroyMobilePhone()
        selfieMode = false
    end
end)