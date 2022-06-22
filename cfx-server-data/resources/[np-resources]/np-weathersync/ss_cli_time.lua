local frozen = false
local client_date = {}
local NEWsecondOfDay = 0
local secondOfDay = 5000 -- this ensure's we are desynced
daytime = true
primetime = false
lunchtime = false
cracktime = false
cocainetime = false

AddEventHandler( "onClientMapStart", function()
    TriggerServerEvent( "addTimeChatSuggests" )
end)

RegisterNetEvent("updateFromServerTime")
AddEventHandler("updateFromServerTime", function(serverSecondOfDay,serverDate,isTimeFrozen)
    frozen = isTimeFrozen
    NEWsecondOfDay = serverSecondOfDay
    client_date = serverDate
end)

Citizen.CreateThread( function()
    local timeBuffer = 0.0
    local h = 0
    local m = 0
    local s = 0
    while true do
        if NEWsecondOfDay < ( secondOfDay - 400 ) or NEWsecondOfDay > ( secondOfDay + 400) then -- The Actual Sync check
            --Citizen.Trace("Time is out of sync... variance (Seconds of Game Day):"..tostring(secondOfDay - NEWsecondOfDay)) 
            secondOfDay = NEWsecondOfDay 
        end 
        Citizen.Wait(33) -- (int)(GetMillisecondsPerGameMinute() / 60)
        if not frozen then
			local gameSecond = 33.33 / ss_night_time_speed_mult
			if secondOfDay >= 19800 and secondOfDay <= 75600 then
				gameSecond = 33.333 / ss_day_time_speed_mult
			end
            timeBuffer = timeBuffer + round( 33.0 / gameSecond, 4 )
			if timeBuffer >= 1.0 then
				local skipSeconds = math.floor( timeBuffer )
				timeBuffer = timeBuffer - skipSeconds
				secondOfDay = secondOfDay + skipSeconds
				if secondOfDay >= 86400 then
					secondOfDay = secondOfDay % 86400
                end
			end
        end
        h = math.floor( secondOfDay / 3600 )
		m = math.floor( (secondOfDay - (h * 3600)) / 60 )
		s = secondOfDay - (h * 3600) - (m * 60)
        secondOfDay = (h * 3600) + (m * 60) + s
        NetworkOverrideClockTime( math.floor( secondOfDay / 3600 ), math.floor( (secondOfDay - (h * 3600)) / 60 ), secondOfDay - (math.floor( secondOfDay / 3600 ) * 3600) - (math.floor( (secondOfDay - (h * 3600)) / 60 ) * 60) )
	end
end)

RegisterNetEvent("addTimeChatSuggests")
AddEventHandler("addTimeChatSuggests", function()
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {
        { name="hour"  , help="Hour of day in 24 hour format."},
        { name="minute", help="Minute of the hour."}
    })
end)


synctime = {}
secondOfDay = 31800
-- In-game Clock Manipulation Loop
Citizen.CreateThread( function()
	
	local timeBuffer = 0.0
	
	while true do
		Wait( 1000 ) -- (int)(GetMillisecondsPerGameMinute() / 60)
		
	--	SetWeather()
		SetTimeSync()

		local gameSecond = 10
			
		timeBuffer = timeBuffer + round( 100.0 / gameSecond, 0 )
		if timeBuffer >= 1.0 then
			local skipSeconds = math.floor( timeBuffer )
			
			timeBuffer = timeBuffer - skipSeconds
			secondOfDay = secondOfDay + skipSeconds
			
			if secondOfDay >= 86400 then
				secondOfDay = secondOfDay % 86400
			end
		end
		-- Apply time
		synctime.h = math.floor( secondOfDay / 3600 )
		synctime.m = math.floor( (secondOfDay - (synctime.h * 3600)) / 60 )
		synctime.s = secondOfDay - (synctime.h * 3600) - (synctime.m * 60)
		
		if enableSync and not insidebuilding and not inhotel and not robbing and not inhouse and not spawning then NetworkOverrideClockTime(synctime.h, synctime.m, synctime.s)  TriggerServerEvent('weather:receivefromcl', secondOfDay)end

	end

end)

local lastminute = 0

function SetTimeSync()
	local coordsply = GetEntityCoords(PlayerPedId())

	synctime.h = math.floor( secondOfDay / 3600 )
	synctime.m = math.floor( (secondOfDay - (synctime.h * 3600)) / 60 )
	synctime.s = secondOfDay - (synctime.h * 3600) - (synctime.m * 60)

	if (synctime.h > 19 or synctime.h < 7) and daytime then
		daytime = false
		TriggerEvent("daytime",daytime)
	elseif (synctime.h <= 19 and synctime.h >= 7) and not daytime then
		daytime = true
		TriggerEvent("daytime",daytime)
	end

	if (synctime.h > 9 or synctime.h < 17) and not lunchtime then
		lunchtime = true
		TriggerEvent("lunchtime",lunchtime)
	elseif (synctime.h <= 9 and synctime.h >= 17) and lunchtime then
		lunchtime = false
		TriggerEvent("lunchtime",lunchtime)
	end


	if (synctime.h > 21 or synctime.h < 23) and not cocainetime then
		cocainetime = true
		TriggerEvent("cocainetime",cocainetime)
	elseif (synctime.h <= 21 and synctime.h >= 23) and cocainetime then
		cocainetime = false
		TriggerEvent("cocainetime",cocainetime)
	end


	if (synctime.h > 6 or synctime.h < 10) and not cracktime then
		cracktime = true
		TriggerEvent("cracktime",cracktime)
	elseif (synctime.h <= 6 and synctime.h >= 10) and cracktime then
		cracktime = false
		TriggerEvent("cracktime",cracktime)
	end


	if (synctime.h > 15 or synctime.h < 23) and primetime then
		primetime = false
		TriggerEvent("primetime",primetime)
	elseif (synctime.h <= 15 and synctime.h >= 23) and not primetime then
		primetime = true
		TriggerEvent("primetime",primetime)
  end
  
  if synctime.m ~= lastminute then
    lastminute = synctime.m
    TriggerEvent("timeheader",synctime.h,synctime.m)
  end
end

RegisterNetEvent('kTimeSync')
AddEventHandler("kTimeSync", function( data )
	if not enableSync then return end
	secondOfDay = data
	weatherTimer = 0
end)
