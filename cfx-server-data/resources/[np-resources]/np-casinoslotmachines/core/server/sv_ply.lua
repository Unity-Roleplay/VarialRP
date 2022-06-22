math.randomseed(os.clock()*100000000000)
math.randomseed(os.clock()*math.random())
math.randomseed(os.clock()*math.random())

local machinePos = vector3(0, 0, 0)
local machineModel = nil
local bet = {}
local currentReels = {}
local activeSlots = {}
local reel = 0
local rot = 0


RegisterNetEvent("np-slotmachines-sv:sitDownAtSlotMachine",function(slot)
    activeSlots = slot
    print(slot)
    local coinValue = 1
    TriggerClientEvent("np-slotmachines-cl:sitDownAtSlotMachine",source, slot)
end)

RegisterNetEvent("np-slotmachines-sv:spinMachine",function(currentSlotMachinePos,currentSlotMachineModel,currentBet,cid)
    machinePos = currentSlotMachinePos
    machineModel = currentSlotMachineModel
    bet = currentBet
    cid = cid
    local w = {a = math.random(1,16),b = math.random(1,16),c = math.random(1,16)}
			
    local rnd1 = math.random(1,100)
    local rnd2 = math.random(1,100)
    local rnd3 = math.random(1,100)
    if rnd1 > 70 then w.a = w.a + 0.5 end
    if rnd2 > 70 then w.b = w.b + 0.5 end
    if rnd3 > 70 then w.c = w.c + 0.5 end

    TriggerClientEvent('np-slotmachines-cl:startSpin', source, w)
end)

RegisterNetEvent('np-slotmachines-sv:slotsCheckWin')
AddEventHandler('np-slotmachines-sv:slotsCheckWin',function(win, dt)
	CheckForWin(win, dt)
end)



function CheckForWin(w, data)
    print(bet)
	print(w.a,w.b,w.c)
	local a = tonumber(w.a)
	local b = tonumber(w.b)
	local c = tonumber(w.c)
	local total = 0
	if a == b and b == c and a == c then
		total = bet*a
	elseif a == 6 and b == 6 then
		total = bet*5
	elseif a == 6 and c == 6 then
		total = bet*5
	elseif b == 5 and c == 5 then
		total = bet*5
		
	elseif a == 5 then
		total = bet*2
	elseif b == 5 then
		total = bet*2
	elseif c == 5 then
		total = bet*2
	end
	if total > 0 then
        print("PREMIO",total)
		--PREMIO
	end
    TriggerClientEvent("np-slotmachines-cl:spinFinished", source, total)
end