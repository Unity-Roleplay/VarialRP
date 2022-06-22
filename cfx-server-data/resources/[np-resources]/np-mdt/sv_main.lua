local usersRadios = {}

RegisterCommand("mdt", function(source)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    local userjob = user:getVar("job")
	local rankInfo = GetRankInfo(char.id)
	local rankfinel = ""
	if (userjob == "police") then
		rankfinel = Ranks[rankInfo.dept][rankInfo.rank] or ""
	end
	if userjob == "police" or userjob == "ems" then
        TriggerClientEvent('np-mdt:open', src, rankfinel, char.last_name, char.first_name, rankInfo.nickname, rankInfo.dept, userjob, rankInfo.rank)
	end
end)

RegisterServerEvent('np-mdt:openMDTMenu')
AddEventHandler("np-mdt:openMDTMenu", function()
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    local userjob = user:getVar("job")
	local rankInfo = GetRankInfo(char.id)
	local rankfinel = ""
	if (userjob == "police") then
		rankfinel = Ranks[rankInfo.dept][rankInfo.rank] or ""
	end
	if userjob == "police" or userjob == "ems" then
        TriggerClientEvent('np-mdt:open', src, rankfinel, char.last_name, char.first_name, rankInfo.nickname, rankInfo.dept, userjob, rankInfo.rank)
	end
end)

local CallSigns = {}
function GetRankInfo(cid)
	local query = "SELECT `callsign`, `nickname`, `rank`, `dept` FROM `jobs_whitelist` WHERE cid = ?"
    local result = Await(SQL.execute(query, cid))
    if result[1] ~= nil and result[1].callsign ~= nil then
     	return result[1]
    else
        return 0
    end
end

RegisterServerEvent('np-mdt:setRadio')
AddEventHandler("np-mdt:setRadio", function(radio)
	local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if not user then return end
	usersRadios[tonumber(char.id)] = radio
end)

RegisterServerEvent('police:setCallSign')
AddEventHandler("police:setCallSign", function(callsign)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if not user then return end
    CallSigns[tonumber(char.id)] = callsign
	TriggerEvent("np-mdt:newLog", user.first_name .. " " .. user.last_name .. " changed callsign to: " .. callsign, time)
end)	

RegisterServerEvent("np-mdt:opendashboard")
AddEventHandler("np-mdt:opendashboard", function()
    local src = source
	UpdateWarrants(src)
	Updatebulletin(src)
	UpdateDispatch(src)
	UpdateUnits(src)	
	getVehicles(src)
	--getProfiles(src)
	UpdateReports(src)
end) 

function UpdateWarrants(src)	
	local firsttime = true
	local result = Await(SQL.execute("SELECT * FROM ___mdw_incidents"))
	local warrnts = {}
	
	for k, v in pairs(result) do
		for k2, v2 in ipairs(json.decode(v.associated)) do
			if v2.warrant == true then
				TriggerClientEvent("np-mdt:dashboardWarrants", src, {firsttime = firsttime, time = v.time, linkedincident = v.id, reporttitle = v.title, name = v2.name, cid = v2.cid})  
				firsttime = false
			end
		end
	end
end

function UpdateReports(src)	
	local query = "SELECT * FROM ____mdw_reports"
    local result = Await(SQL.execute(query))
	TriggerClientEvent("np-mdt:dashboardReports", src, result)
end	

function Updatebulletin(src)	
    local result = Await(SQL.execute("SELECT * FROM ___mdw_bulletin"))
	TriggerClientEvent("np-mdt:dashboardbulletin", src, result)
end

function UpdateUnits(src)	
	local lspd, bcso, sasp, doc, sapr, pa, ems, da, judge, boa = {},{},{},{},{},{},{},{},{},{}
	
	for k, v in pairs(GetPlayers()) do
	local user = exports["np-base"]:getModule("Player"):GetUser(tonumber(v))
        if user then
		    local userjob = user:getVar("job")
		    if userjob == "police" or userjob == "ems" then
		         local char = user:getCurrentCharacter()
                local name = char.first_name .. " " .. char.last_name
			    local pedInfo = GetRankInfo(char.id)
				if userjob == "police" then
					if (pedInfo["dept"] == 1) then -- BCSO
						bcsos = #bcso + 1
						bcso[bcsos] = {}
						bcso[bcsos].duty = 1
						bcso[bcsos].cid = char.id
						bcso[bcsos].radio = usersRadios[char.id] or nil
						bcso[bcsos].callsign = pedInfo["callsign"]
						bcso[bcsos].nickname = pedInfo["nickname"]
						bcso[bcsos].rank = pedInfo["rank"]
						bcso[bcsos].dept = pedInfo["dept"]
						bcso[bcsos].name = name
					elseif (pedInfo["dept"] == 2) then -- State Troopers
						sasps = #sasp + 1
						sasp[sasps] = {}
						sasp[sasps].duty = 1
						sasp[sasps].cid = char.id
						sasp[sasps].radio = usersRadios[char.id] or nil
						sasp[sasps].callsign = pedInfo["callsign"]
						sasp[sasps].nickname = pedInfo["nickname"]
						sasp[sasps].rank = pedInfo["rank"]
						sasp[sasps].dept = pedInfo["dept"]
						sasp[sasps].name = name
					elseif (pedInfo["dept"] == 3) then -- Park Rangers
						saprs = #sapr + 1
						sapr[saprs] = {}
						sapr[saprs].duty = 1
						sapr[saprs].cid = char.id
						sapr[saprs].radio = usersRadios[char.id] or nil
						sapr[saprs].callsign = pedInfo["callsign"]
						sapr[saprs].nickname = pedInfo["nickname"]
						sapr[saprs].rank = pedInfo["rank"]
						sapr[saprs].dept = pedInfo["dept"]
						sapr[saprs].name = name
					else                          -- LSPD
						lspds = #lspd + 1
						lspd[lspds] = {}
						lspd[lspds].duty = 1
						lspd[lspds].cid = char.id
						lspd[lspds].radio = usersRadios[char.id] or nil
						lspd[lspds].callsign = pedInfo["callsign"]
						lspd[lspds].nickname = pedInfo["nickname"]
						lspd[lspds].rank = pedInfo["rank"]
						lspd[lspds].dept = pedInfo["dept"]
						lspd[lspds].name = name
					end
				elseif userjob == "ems" then
					emss = #ems + 1
					ems[emss] = {}
					ems[emss].duty = 1
					ems[emss].cid = char.id
					ems[emss].radio = usersRadios[char.id] or nil
					ems[emss].callsign = pedInfo["callsign"]
					ems[emss].nickname = pedInfo["nickname"]
					ems[emss].rank = pedInfo["rank"]
					ems[emss].name = name
				elseif userjob == "doc" then
					docs = #doc + 1
					doc[docs] = {}
					doc[docs].duty = 1
					doc[docs].cid = char.id
					doc[docs].radio = usersRadios[char.id] or nil
					doc[docs].callsign = pedInfo["callsign"]
					doc[docs].nickname = pedInfo["nickname"]
					doc[docs].rank = pedInfo["rank"]
					doc[docs].name = name
				elseif userjob == "judge" then
					judges = #judge + 1
					judge[judges] = {}
					judge[judges].duty = 1
					judge[judges].cid = char.id
					judge[judges].radio = usersRadios[char.id] or nil
					judge[judges].callsign = pedInfo["callsign"]
					judge[judges].nickname = pedInfo["nickname"]
					judge[judges].rank = pedInfo["rank"]
					judge[judges].name = name
				end
	        end
	    end
    end	
    TriggerClientEvent("np-mdt:getActiveUnits", src, lspd, bcso, sahp, sasp, doc, sapr, pa, ems, judge)
end	


function getVehicles(src)	
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    ORDER BY id ASC
    ]]
    local result =  Await(SQL.execute(query))
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
	end
	TriggerClientEvent("np-mdt:searchVehicles", src, result, true)
end


RegisterServerEvent("np-mdt:getProfileData")
AddEventHandler("np-mdt:getProfileData", function(id)
	local src = source
	if type(id) == "string" then id = tonumber(id) end		
    local data = getProfile(id)
	TriggerClientEvent("np-mdt:getProfileData", src, data, false)
end) 

RegisterServerEvent("np-mdt:getVehicleData")
AddEventHandler("np-mdt:getVehicleData", function(plate)
	local src = source
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    WHERE license_plate = ? LIMIT 1
    ]]
    local result =  Await(SQL.execute(query, plate))
	
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.notes and v.notes ~= nil then 
		    result[k].information = v.notes
        else
            result[k].information = ""		
		end		
		
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
    end
    TriggerClientEvent("np-mdt:updateVehicleDbId", src, result[1].id)
	TriggerClientEvent("np-mdt:getVehicleData", src, result)
end) 



RegisterServerEvent("np-mdt:knownInformation")
AddEventHandler("np-mdt:knownInformation", function(dbid, type, status, plate)
	local saveData = {type = type, status = status}
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('SELECT * FROM `vehicle_mdt` WHERE `plate` = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			if type == "stolen" then
				exports.ghmattimysql:execute('UPDATE `vehicle_mdt` SET `stolen` = @stolen WHERE `plate` = @plate AND `dbid` = @dbid', {
				    ['@stolen'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
				TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated stolen tag on vehicle: " .. plate .. " to: " .. status, time)
			elseif type == "code5" then
			    exports.ghmattimysql:execute('UPDATE `vehicle_mdt` SET `code` = @code WHERE `plate` = @plate AND `dbid` = @dbid', {
				    ['@code'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
				TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated Code5 tag on vehicle: " .. plate .. " to: " .. status, time)
			end
		else
			if type == "stolen" then
			    exports.ghmattimysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `stolen`, `dbid`) VALUES (@plate, @stolen, @dbid)', {
			        ['@dbid'] = dbid,
			    	['@plate'] = plate,
			        ['@stolen'] = status
			    })
				TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated stolen tag on vehicle: " .. plate .. " to: " .. status, time)
			elseif type == "code5" then
			    exports.ghmattimysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `code`, `dbid`) VALUES (@plate, @code, @dbid)', {
			        ['@dbid'] = dbid,
				    ['@plate'] = plate,
			        ['@code'] = status
			    })
				TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated Code5 tag on vehicle: " .. plate .. " to: " .. status, time)
			end
		end
	end)
end)




RegisterServerEvent("np-mdt:searchVehicles")
AddEventHandler("np-mdt:searchVehicles", function(plate)
    local src = source
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    WHERE LOWER(`license_plate`) LIKE ? ORDER BY id ASC
    ]]
    local result =  Await(SQL.execute(query, string.lower('%'..plate..'%')))
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
	end
	TriggerClientEvent("np-mdt:searchVehicles", src, result)
end)



RegisterServerEvent("np-mdt:saveVehicleInfo")
AddEventHandler("np-mdt:saveVehicleInfo", function(dbid, plate,imageurl, notes)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end
	
	local usource = source
	exports.ghmattimysql:execute('SELECT * FROM `vehicle_mdt` WHERE `plate` = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			exports.ghmattimysql:execute('UPDATE `vehicle_mdt` SET `image` = @image, `notes` = @notes WHERE `plate` = @plate AND `dbid` = @dbid', {
			    ['@image'] = imageurl,
				['@dbid'] = dbid,
				['@plate'] = plate,
				['@notes'] = notes
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated notes on vehicle: " .. plate .. " to: " .. notes, time)
		else
			exports.ghmattimysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `stolen`, `notes`, `image`, `dbid`) VALUES (@plate, @stolen, @notes, @image, @dbid)', {
			    ['@dbid'] = dbid,
				['@plate'] = plate,
				['@stolen'] = 0,
				['@image'] = imageurl,				
				['@notes'] = notes
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated notes on vehicle: " .. plate .. " to: " .. notes, time)
		end
	end)
end)

RegisterServerEvent("np-mdt:saveProfile")
AddEventHandler("np-mdt:saveProfile", function(profilepic, information, cid, fName, sName)
	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end
	
	local usource = source
	exports.ghmattimysql:execute('SELECT * FROM `___mdw_profiles` WHERE `cid` = @cid', {
		['@cid'] = cid
	}, function(result)
		if result[1] then
			exports.ghmattimysql:execute('UPDATE `___mdw_profiles` SET `image` = @image, `description` = @description, `name` = @name WHERE `cid` = @cid', {
			    ['@image'] = profilepic,
				['@description'] = information,
				['@name'] = fName .. " " .. sName,
				['@cid'] = cid
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated indiviuals profile for: " .. cid .. " to: (name)" .. fName .. " " .. sName .. " to: (image)" .. profilepic .. " (description)" .. information, time)
		else
			exports.ghmattimysql:execute('INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)', {
			    ['@cid'] = cid,
				['@image'] = profilepic,
				['@description'] = information,
				['@name'] = fName .. " " .. sName
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated indiviuals profile for: " .. cid .. " to: (name)" .. fName .. " " .. sName .. " to: (image)" .. profilepic .. " (description)" .. information, time)
		end
	end)
end)

RegisterServerEvent("np-mdt:addGalleryImg")
AddEventHandler("np-mdt:addGalleryImg", function(cid, url)
    local query = "SELECT * FROM `___mdw_profiles` WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid)))
	if result and result[1] then
		result[1].gallery = json.decode(result[1].gallery)
		table.insert(result[1].gallery, url)
		exports.ghmattimysql:execute('UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@gallery'] = json.encode(result[1].gallery),
		})	
		TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " added image to profile gallery for: " .. cid .. " (image): " .. url, time)
	end
end)		

RegisterServerEvent("np-mdt:removeGalleryImg")
AddEventHandler("np-mdt:removeGalleryImg", function(cid, url)
    local query = "SELECT * FROM `___mdw_profiles` WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid)))

	if result and result[1] then
		result[1].gallery = json.decode(result[1].gallery)
		for k,v in ipairs(result[1].gallery) do
			if v == url then
				table.remove(result[1].gallery, k)
			end
		end
		exports.ghmattimysql:execute('UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@gallery'] = json.encode(result[1].gallery),
		})	
		TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " removed image from profile gallery for: " .. cid .. " (image): " .. url, time)
	end
end)

function toBool(val)
	if (val == 1) then
		return true
	else
		return false
	end
end
	
RegisterServerEvent("np-mdt:searchProfile")
AddEventHandler("np-mdt:searchProfile", function(query)
    local src = source
    local stringtoboolean = { [0] = false, [1] = true }
    local queryData = string.lower('%'..query..'%')
    local query = "SELECT * FROM `characters` WHERE LOWER(`first_name`) LIKE ? OR LOWER(`id`) LIKE ? OR LOWER(`last_name`) LIKE ? OR CONCAT(LOWER(`first_name`), ' ', LOWER(`last_name`), ' ', LOWER(`id`)) LIKE ?"
    local result = Await(SQL.execute(query, queryData, queryData, queryData, queryData)) 
	local mdw_profiles = Await(SQL.execute("SELECT * FROM ___mdw_profiles")) 	

	for k, v in pairs(result) do	
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name
		
		if (result[k].licenses) then
			for _, l in pairs(json.decode(result[k].licenses)) do
				if (l.license == "Weapon") then 
					result[k].Weapon = l.issued;
				end
				if (l.license == "Drivers") then 
					result[k].Drivers = l.issued;
				end
				if (l.license == "Hunting") then 
					result[k].Hunting = l.issued;
				end
				if (l.license == "Fishing") then 
					result[k].Fishing = l.issued;
				end
				if (l.license == "Pilot") then 
					result[k].Pilot = l.issued;
				end
				if (l.license == "Bar") then 
					result[k].Bar = l.issued;
				end
				if (l.license == "Business") then 
					result[k].Business = l.issued;
				end
			end
		end
		
		result[k].policemdtinfo = ""
		result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		for i=1, #mdw_profiles do
			if mdw_profiles[i].cid == v.id then
				if mdw_profiles[i].image and mdw_profiles[i].image ~= nil and mdw_profiles[i].image ~= "" then
					result[k].pp = mdw_profiles[i].image		
				end

				if mdw_profiles[i].description and mdw_profiles[i].description ~= nil and mdw_profiles[i].description ~= "" then
					result[k].policemdtinfo = mdw_profiles[i].description
				else
					result[k].policemdtinfo = mdw_profiles[i].description
				end
			end
		end	
        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.id
	end
	
	TriggerClientEvent("np-mdt:searchProfile", src, result, true)
end)	

function getProfile(id)
    local query = "SELECT * FROM characters WHERE id = ? LIMIT 1"
    local result = Await(SQL.execute(query, id)) 
    local resultI = Await(SQL.execute("SELECT * FROM ___mdw_incidents")) 
    for k, v in pairs(resultI) do
	    for k2, v2 in ipairs(json.decode(v.associated)) do
	    	if v2.cid == result[1].id then
                result[1].convictions = v2.charges
		    end
    	end	
    end	
    local vehresult = Await(SQL.execute("SELECT * FROM characters_cars WHERE cid = ?", id)) 
    result[1].vehicles = vehresult
    result[1].firstname = result[1].first_name
    result[1].lastname  = result[1].last_name
	
	if (result[1].licenses) then
		for _, l in pairs(json.decode(result[1].licenses)) do
			if (l.license == "Weapon") then 
				result[1].Weapon = l.issued;
			end
			if (l.license == "Drivers") then 
				result[1].Drivers = l.issued;
			end
			if (l.license == "Hunting") then 
				result[1].Hunting = l.issued;
			end
			if (l.license == "Fishing") then 
				result[1].Fishing = l.issued;
			end
			if (l.license == "Pilot") then 
				result[1].Pilot = l.issued;
			end
			if (l.license == "Bar") then 
				result[1].Bar = l.issued;
			end
			if (l.license == "Business") then 
				result[1].Business = l.issued;
			end
		end
	end
	
    result[1].warrant = false
    result[1].cid = result[1].id
	result[1].job = result[1].lastjob

    local proresult = Await(SQL.execute("SELECT * FROM ___mdw_profiles WHERE cid = ? LIMIT 1", id)) 		
    if proresult and proresult[1] ~= nil then
        result[1].profilepic = proresult[1].image		
	    result[1].tags = json.decode(proresult[1].tags)		
	    result[1].gallery = json.decode(proresult[1].gallery)		
	    result[1].policemdtinfo = proresult[1].description
    else
	    result[1].tags = {}			
	    result[1].gallery = {}			
	    result[1].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
	end
	return result[1]
end


function getProfiles(src)
	local query = [[
        SELECT *
        FROM characters aa
	    LEFT JOIN ___mdw_profiles at ON at.cid = aa.id 
		ORDER BY id ASC  		
    ]]

    local result =  Await(SQL.execute(query))
	for k, v in pairs(result) do
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name
	
		if (result[k].licenses) then
			for _, l in pairs(json.decode(result[k].licenses)) do
				if (l.license == "Weapon") then 
					result[k].Weapon = l.issued;
				end
				if (l.license == "Drivers") then 
					result[k].Drivers = l.issued;
				end
				if (l.license == "Hunting") then 
					result[k].Hunting = l.issued;
				end
				if (l.license == "Fishing") then 
					result[k].Fishing = l.issued;
				end
				if (l.license == "Pilot") then 
					result[k].Pilot = l.issued;
				end
				if (l.license == "Bar") then 
					result[k].Bar = l.issued;
				end
				if (l.license == "Business") then 
					result[k].Business = l.issued;
				end
			end
		end

        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.id
		
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].pp = v.image  
		else
		    result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		end
	   	exports.ghmattimysql:execute('SELECT * FROM `___mdw_profiles` WHERE `cid` = @cid', {
		    ['@cid'] = v.id
		}, function(proresult)
            if proresult and proresult[1] ~= nil then
	
        	result[k].pp = proresult[1].image		
       	    result[k].policemdtinfo = proresult[1].description
			end
		end)
    end
	TriggerClientEvent("np-mdt:searchProfile", src, result, true)
end



RegisterServerEvent("np-mdt:updateLicense")
AddEventHandler("np-mdt:updateLicense", function(cid, type, status)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local name = char.first_name .. " " .. char.last_name
	local time = exports["np-lib"]:getDate()
	if status == "revoke" then action = "Revoked" else action = "Given" end

	local profile = getProfile(cid)

	local updatedInfo = {}
	if status == "revoke" then
		if (profile.licenses) then
			for _, l in pairs(json.decode(profile.licenses)) do
				if (l.license == type) then 
					license = {}
					license["license"] = l.license
					license["issued"] = 0
					license["issuedDate"] = time
					license["issuedBy"] = name

					TriggerEvent("np-mdt:newLog", name .. " revoked license for: " .. l.license .. " from: " .. cid, time)

					table.insert(updatedInfo, license)
				else
					license = {}
					license["license"] = l.license
					license["issued"] = l.issued
					license["issuedDate"] = l.issuedDate
					license["issuedBy"] = l.issuedBy

					table.insert(updatedInfo, license)
				end
			end
		end
	else
		if (profile.licenses) then
			for _, l in pairs(json.decode(profile.licenses)) do
				if (l.license == type) then 
					license = {}
					license["license"] = l.license
					license["issued"] = 1
					license["issuedDate"] = time
					license["issuedBy"] = name

					TriggerEvent("np-mdt:newLog", name .. " issued license to: " .. l.license .. " from: " .. cid, time)

					table.insert(updatedInfo, license)
				else
					license = {}
					license["license"] = l.license
					license["issued"] = l.issued
					license["issuedDate"] = l.issuedDate
					license["issuedBy"] = l.issuedBy

					table.insert(updatedInfo, license)
				end
			end
		end
	end

	exports.ghmattimysql:execute("UPDATE `characters` SET `licenses` = @licenses WHERE `id` = @cid;", {['cid'] = cid, ['licenses'] = json.encode(updatedInfo)})
	TriggerClientEvent("np-mdt:refreshProfileData", src)
end)


RegisterServerEvent("np-mdt:newBulletin")
AddEventHandler("np-mdt:newBulletin", function(title, info, time, id)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local Bulletin = {
	    title = title,
		id = id,
		info = info,
		time = time,
		src = src,
		author = name
	}
	local query = "INSERT INTO ___mdw_bulletin (title, info, time, src, author, id) VALUES(?, ?, ?, ?, ?, ?)"
	SQL.execute(query, title, info, time, tostring(src), name, id)
    TriggerEvent("np-mdt:newLog", name .. " Opened a new Bulletin: Title " .. title .. ", Info " .. info, time)
    TriggerClientEvent("np-mdt:newBulletin", -1, src, Bulletin, "police")
end)

RegisterServerEvent("np-mdt:deleteBulletin")
AddEventHandler("np-mdt:deleteBulletin", function(id)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	local query = "DELETE FROM ___mdw_bulletin WHERE id = ?"
	Await(SQL.execute(query,id)) 	

	TriggerEvent("np-mdt:newLog", name .. " deleted Bulletin: " .. id, time)

    TriggerClientEvent("np-mdt:deleteBulletin", -1, src, id, "police")
end)

RegisterServerEvent("np-mdt:newLog")
AddEventHandler("np-mdt:newLog", function(text, time)
    local query = "INSERT INTO ___mdw_logs (text, time) VALUES(?, ?)"
	Await(SQL.execute(query, text, time)) 	
end)

-- RegisterServerEvent("np-mdt:getAllLogs")
-- AddEventHandler("np-mdt:getAllLogs", function()
    
-- 	TriggerClientEvent("np-mdt:getAllLogs", src, result)
-- end) 

RPC.register("MDT:GetAllLogs", function(pSource)
	local src = source
	local query = "SELECT * FROM ___mdw_logs ORDER BY id DESC LIMIT 250"
    local result = Await(SQL.execute(query))

    return result
end)

RPC.register("MDT:GetAllIncidents", function(pSource)
	local src = source
	local query = "SELECT * FROM ___mdw_incidents"
    local result = Await(SQL.execute(query))

    return result
end)

RPC.register("MDT:GetAllStaff", function(pSource, jobLabel)
    local returnData = Await(SQL.execute("SELECT characters.id AS cid, characters.first_name, characters.last_name, jobs_whitelist.id, jobs_whitelist.job, jobs_whitelist.rank, jobs_whitelist.callsign, jobs_whitelist.nickname, jobs_whitelist.dept, jobs_whitelist.badgeImage FROM jobs_whitelist INNER JOIN characters ON jobs_whitelist.cid = characters.id WHERE jobs_whitelist.job = \"" .. jobLabel .. "\" ORDER BY jobs_whitelist.dept DESC, jobs_whitelist.rank ASC", { }))

    return returnData
end)

RPC.register("MDT:GetStaffInfo", function(pSource, staffid)
    local returnData = Await(SQL.execute("SELECT characters.id AS cid, characters.first_name, characters.last_name, jobs_whitelist.id, jobs_whitelist.job, jobs_whitelist.rank, jobs_whitelist.callsign, jobs_whitelist.nickname, jobs_whitelist.dept, jobs_whitelist.badgeImage FROM jobs_whitelist INNER JOIN characters ON jobs_whitelist.cid = characters.id WHERE jobs_whitelist.id = \"" .. staffid .. "\"", { }))

    return returnData[1]
end)

RPC.register("MDT:UpdateStaffInfo", function(pSource, data)
	local user = exports["np-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()
	exports.ghmattimysql:execute('UPDATE `jobs_whitelist` SET `callsign` = @callsign, `nickname` = @nickname, `dept` = @dept, `badgeImage` = @badgeImage, `rank` = @rank WHERE `id` = @id', {
			['@id'] = data["dbid"],
			['@callsign'] = data["callsign"],
			['@nickname'] = data["nickname"],
			['@dept'] = data["dept"],
			['@rank'] = data["rank"],
			['@badgeImage'] = data["badgeImage"] or ""
		})
	TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated Staff Info: " .. json.encode(data), time)
	return true
end)

RPC.register("MDT:DismissStaffMember", function(pSource, id)
	exports.ghmattimysql:execute('DELETE FROM `jobs_whitelist` WHERE `id` = @id', {
			['@id'] = id
		})
	TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " dismissed staff member " .. id, time)
	return true
end)

RPC.register("MDT:HireStaffMember", function(pSource, cid, job)
	local user = exports["np-base"]:getModule("Player"):GetUser(pSource)
    local char = user:getCurrentCharacter()

	local query = "SELECT owner FROM characters WHERE id = ?"
    local result = Await(SQL.execute(query, cid))	

	exports.ghmattimysql:execute('INSERT INTO `jobs_whitelist` (`owner`, `cid`, `job`, `callsign`, `dept`, `rank`, `nickname`) VALUES (@owner, @cid, @job, @callsign, @dept, @rank, @nickname);', {
			['@owner'] = result[1]["owner"],
			['@cid'] = cid,
			['@job'] = job,
			['@callsign'] = "000",
			['@dept'] = 0,
			['@rank'] = 0,
			['@nickname'] = ""
		})
	TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " hired staff member " .. cid .. "/" .. result[1]["owner"], time)
	return true
end)

RegisterServerEvent("np-mdt:getIncidentData")
AddEventHandler("np-mdt:getIncidentData", function(id)
	local src = source
	local query = "SELECT * FROM ___mdw_incidents WHERE id = ?"
    local result = Await(SQL.execute(query, id))	
	
	
    	
	result[1].tags = json.decode(result[1].tags)
	result[1].officersinvolved = json.decode(result[1].officers)
	result[1].civsinvolved = json.decode(result[1].civilians)
	result[1].evidence = json.decode(result[1].evidence)
	result[1].convictions = json.decode(result[1].associated)
	result[1].charges = json.decode(result[1].associated.charges)
	TriggerClientEvent("np-mdt:updateIncidentDbId", src, result[1].id)
	TriggerClientEvent("np-mdt:getIncidentData", src, result[1], json.decode(result[1].associated))
end) 

RegisterServerEvent("np-mdt:incidentSearchPerson")
AddEventHandler("np-mdt:incidentSearchPerson", function(query1)
	local src = source
	local queryData = string.lower('%'..query1..'%')
	local query = "SELECT first_name, last_name, id FROM `characters`  WHERE LOWER(`first_name`) LIKE ? OR LOWER(`id`) LIKE ? OR LOWER(`last_name`) LIKE ? OR CONCAT(LOWER(`first_name`), ' ', LOWER(`last_name`), ' ', LOWER(`id`)) LIKE ?"	
	local result = Await(SQL.execute(query, queryData, queryData, queryData, queryData)) 
	local mdw_profiles = Await(SQL.execute("SELECT * FROM ___mdw_profiles")) 	
	for k, v in pairs(result) do	
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name
		result[k].profilepic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		for i=1, #mdw_profiles do
			if mdw_profiles[i].cid == v.id then
				if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
					result[k].profilepic = mdw_profiles[i].image		
				end
			end
		end			
	end		
	TriggerClientEvent('np-mdt:incidentSearchPerson', src, result)
end)	

RegisterServerEvent("np-mdt:removeIncidentCriminal")
AddEventHandler("np-mdt:removeIncidentCriminal", function(cid, icId)

	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local name = char.first_name .. " " .. char.last_name
	local time = exports["np-lib"]:getDate()
    local action = "Removed a criminal from an incident, incident ID: " .. icId	
    local Cname = ""
	local result = Await(SQL.execute("SELECT * FROM ___mdw_incidents WHERE id = ?", icId))
	for k, v in pairs(result) do
		for k2, v2 in ipairs(json.decode(v.associated)) do
			if tonumber(v2.cid) == tonumber(cid) then
				table.remove(v2, k)
				Cname = v2.name
			end	
        end
    end
	TriggerEvent("np-mdt:newLog", name .. ", " .. action ..", Criminal Citizen Id: " .. cid .. ", Name: " .. Cname .. "", time)
	local query = "UPDATE ___mdw_incidents SET tags = ? WHERE id = ?"
	SQL.execute(query, json.encode(result[1].associated), icId)
end)

RegisterServerEvent("np-mdt:searchIncidents")
AddEventHandler("np-mdt:searchIncidents", function(query)
    local src = source
	exports.ghmattimysql:execute("SELECT * FROM `___mdw_incidents` WHERE id = @query", {
		['@query'] = tonumber(query)
	}, function(result)

		TriggerClientEvent('np-mdt:getIncidents', src, result)
	end)
end)	

RegisterServerEvent("np-mdt:saveIncident")
AddEventHandler("np-mdt:saveIncident", function(data)
    local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
		
	for i=1, #data.associated do
		local query2 = "SELECT * FROM characters WHERE id = ?"
        local result2 = Await(SQL.execute(query2, data.associated[i].cid))	
	    data.associated[i].name = result2[1].first_name .. " " ..result2[1].last_name
	end
    if data.ID ~= 0 then
		exports.ghmattimysql:execute('UPDATE `___mdw_incidents` SET `title` = @title, `author` = @author, `time` = @time, `details` = @details, `tags` = @tags, `officers` = @officers, `civilians` = @civilians, `evidence` = @evidence, `associated` = @associated WHERE `id` = @id', {
			['@id'] = data.ID,
			['@title'] = data.title,
			['@author'] = name,
			['@time'] = data.time,
			['@details'] = data.information,
			['@tags'] = json.encode(data.tags),
			['@officers'] = json.encode(data.officers),
			['@civilians'] = json.encode(data.civilians),
			['@evidence'] = json.encode(data.evidence),
			['@associated'] = json.encode(data.associated)		
		})

		TriggerEvent("np-mdt:newLog", name .. " updated incident #" .. data.ID .. " with info: " .. json.encode(data), time)
	else
		exports.ghmattimysql:execute('INSERT INTO `___mdw_incidents` (`title`, `author`, `time`, `details`, `tags`, `officers`, `civilians`, `evidence`, `associated`) VALUES (@title, @author, @time, @details, @tags, @officers, @civilians, @evidence, @associated)', {
			['@title'] = data.title,
			['@author'] = name,
			['@time'] = data.time,
			['@details'] = data.information,
			['@tags'] = json.encode(data.tags),
			['@officers'] = json.encode(data.officers),
			['@civilians'] = json.encode(data.civilians),
			['@evidence'] = json.encode(data.evidence),
			['@associated'] = json.encode(data.associated)		
		})
		TriggerEvent("np-mdt:newLog", name .. " created new incident with info: " .. json.encode(data), time)
	end
end)



RegisterServerEvent("np-mdt:newTag")
AddEventHandler("np-mdt:newTag", function(cid, tag)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()

    local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local result = Await(SQL.execute(query, cid))	
    local newTags = {}
    if result and result[1] then
	
		result[1].tags = json.decode(result[1].tags)
		table.insert(result[1].tags, tag)
		exports.ghmattimysql:execute('UPDATE `___mdw_profiles` SET `tags` = @tags WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@tags'] = json.encode(result[1].tags),	
		})
		TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " added new tag to: " .. cid .. " tag: " .. tag, time)
	else
		newTags[1] = tag
		exports.ghmattimysql:execute('INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)', {
			['@cid'] = cid,
			['@image'] = "",
			['@description'] = "",
			['@tags'] = json.encode(newTags),
			['@name'] = ""
		})
		TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " added new tag to: " .. cid .. " tag: " .. tag, time)
	end
end)

RegisterServerEvent("np-mdt:removeProfileTag")
AddEventHandler("np-mdt:removeProfileTag", function(cid, tag)
    local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid))) 
	if result and result[1] then
		result[1].tags = json.decode(result[1].tags)
		for k,v in ipairs(result[1].tags) do
			if v == tag then
			    table.remove(result[1].tags, k)
				TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " remvoed tag from: " .. cid .. " tag: " .. tag, time)
		    end
		end
		local query = "UPDATE ___mdw_profiles SET tags = ? WHERE cid = ?"
		SQL.execute(query, json.encode(result[1].tags), tonumber(cid))
	end	
end)


RegisterServerEvent("np-mdt:getPenalCode")
AddEventHandler("np-mdt:getPenalCode", function()
    local src = source
    local titles = {}
	local penalcode = {}
    local query = "SELECT * FROM fine_types ORDER BY category ASC"
    local result = Await(SQL.execute(query)) 
	for i=1, #result do
	    local id = result[i].id
		local res = result[i]
		
	    titles[id] = result[i].label
	    penalcode[id] = {}

		local color = "green"
		class = "Infraction"

		if res.category == 1 then
			color = "orange"
			class = "Misdemeanor"
		elseif res.category == 2 or res.category == 3 then 
			color =  "red"
			class = "Felony"
		end

		penalcode[id].color = color
		
		penalcode[id].title = res.label		
		penalcode[id].id = res.id
		penalcode[id].class = class
		penalcode[id].months = res.jailtime		
		penalcode[id].fine = res.jailtime		
	end
	TriggerClientEvent('np-mdt:getPenalCode',src, titles, penalcode)
end)	


RegisterServerEvent("np-mdt:getAllBolos")
AddEventHandler("np-mdt:getAllBolos", function()
    local src = source
	local query = "SELECT * FROM ____mdw_bolos"
    local result = Await(SQL.execute(query))
	
	TriggerClientEvent("np-mdt:getBolos", src, result)
end)


RegisterServerEvent("np-mdt:getBoloData")
AddEventHandler("np-mdt:getBoloData", function(id)
    local src = source
	local query = "SELECT * FROM ____mdw_bolos WHERE dbid = ?"
    local result = Await(SQL.execute(query, id))
	result[1].tags = json.decode(result[1].tags)
	result[1].gallery = json.decode(result[1].gallery)
	result[1].officersinvolved = json.decode(result[1].officers)	
	result[1].officers = json.decode(result[1].officers)
	
	
    TriggerClientEvent("np-mdt:getBoloData", src, result[1])
end)


RegisterServerEvent("np-mdt:searchBolos")
AddEventHandler("np-mdt:searchBolos", function(query)
    local src = source
	exports.ghmattimysql:execute("SELECT * FROM `____mdw_bolos` WHERE LOWER(`plate`) LIKE @query OR LOWER(`title`) LIKE @query OR CONCAT(LOWER(`plate`), ' ', LOWER(`title`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

       	TriggerClientEvent("np-mdt:getBolos", src, result)
	end)
end)	

RegisterServerEvent("np-mdt:newBolo")
AddEventHandler("np-mdt:newBolo", function(data)
    if data.title == "" then return end
	if data.plate == "" then return end
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	exports.ghmattimysql:execute('SELECT * FROM `____mdw_bolos` WHERE `dbid` = @id', {
		['@id'] = data.id
	}, function(result)
		if data.id ~= nil and data.id ~= 0 then
			exports.ghmattimysql:execute('UPDATE `____mdw_bolos` SET `title` = @title, `plate` = @plate, `owner` = @owner, `individual` = @individual, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `time` = @time, `author` = @author WHERE `dbid` = @id', {
			    ['@title'] = data.title,
				['@plate'] = data.plate,
				['@owner'] = data.owner,
				['@individual'] = data.individual,				
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@time'] = data.time,
				['@author'] = name,
				['@id'] = data.id
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated BOLO: " .. data.title .. "/" .. data.id .. " with information: " .. json.encode(data), time)
		else
			exports.ghmattimysql:execute('INSERT INTO `____mdw_bolos` (`title`, `plate`, `owner`, `individual`, `detail`, `tags`, `gallery`, `officers`, `time`, `author`) VALUES (@title, @plate, @owner, @individual, @detail, @tags, @gallery, @officers, @time, @author)', {
			    ['@title'] = data.title,
				['@plate'] = data.plate,
				['@owner'] = data.owner,
				['@individual'] = data.individual,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@time'] = data.time,
				['@author'] = name
				
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " created new BOLO: " .. data.title .. " with information: " .. json.encode(data), time)

		    local query = "SELECT * FROM ____mdw_bolos ORDER BY dbid DESC LIMIT 1"
  			local result2 = Await(SQL.execute(query, id))
		    TriggerClientEvent("np-mdt:boloComplete", src, result2[1].dbid)
		end
	end)
end)



RegisterServerEvent("np-mdt:deleteBolo")
AddEventHandler("np-mdt:deleteBolo", function(id)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()

	local query = "DELETE FROM ____mdw_bolos WHERE dbid = ?"
	Await(SQL.execute(query, id)) 
	TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " deleted BOLO: " .. id, time)
end)	

local attachedUnits = {}
RegisterServerEvent("np-mdt:attachedUnits")
AddEventHandler("np-mdt:attachedUnits", function(callid)
    local src = source
	if not attachedUnits[callid] then
		local id = #attachedUnits + 1
		attachedUnits[callid] = {}		
	end
    TriggerClientEvent("np-mdt:attachedUnits", src, attachedUnits[callid], callid)
end)

RegisterServerEvent("np-mdt:callDragAttach")
AddEventHandler("np-mdt:callDragAttach", function(callid, cid)
    local src = source

	local user = getUserFromCid(cid)
	if user == false then return end
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local userjob = user:getVar("job")

	local id = callid

	attachedUnits[id] = {}
	attachedUnits[id][cid] = {}

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end

	attachedUnits[id][cid].job = userjob
	attachedUnits[id][cid].callsign = GetRankInfo(char.id)
	attachedUnits[id][cid].fullname = name
	attachedUnits[id][cid].cid = char.id
	attachedUnits[id][cid].callid = callid
	attachedUnits[id][cid].radio = units
    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)


RegisterServerEvent("np-mdt:callAttach")
AddEventHandler("np-mdt:callAttach", function(callid)
    local src = source

	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local userjob = user:getVar("job")
	local id = callid
	local cid = char.id
	attachedUnits[id] = {}
	attachedUnits[id][cid] = {}

	local units = 0
	for k, v in pairs(attachedUnits[id]) do
		units = units + 1
	end
	attachedUnits[id][cid].job = userjob
	attachedUnits[id][cid].callsign = GetRankInfo(char.id)
	attachedUnits[id][cid].fullname = name
	attachedUnits[id][cid].cid = char.id
	attachedUnits[id][cid].callid = callid
	attachedUnits[id][cid].radio = units

    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDetach")
AddEventHandler("np-mdt:callDetach", function(callid)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local id = callid
    attachedUnits[id][char.id] = nil

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end
    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDispatchDetach")
AddEventHandler("np-mdt:callDispatchDetach", function(callid, cid)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local id = tonumber(callid)

    attachedUnits[id][cid] = nil

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end
    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)


RegisterServerEvent("np-mdt:setWaypoint:unit")
AddEventHandler("np-mdt:setWaypoint:unit", function(cid)
    local src = source

	local user = getUserFromCid(cid)
    if user == false then return end
	local uSrc = user:getVar("source")
	local coords = GetEntityCoords(GetPlayerPed(uSrc))
    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("np-mdt:setDispatchWaypoint")
AddEventHandler("np-mdt:setDispatchWaypoint", function(callid, cid)
    local src = source
	local user = getUserFromCid(cid)
    if user == false then return end
	local uSrc = user:getVar("source")
	local coords = GetEntityCoords(GetPlayerPed(uSrc))
    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

local CallResponses = {}

RegisterServerEvent("np-mdt:getCallResponses")
AddEventHandler("np-mdt:getCallResponses", function(callid)
    local src = source
	if not CallResponses[callid] then
		CallResponses[callid] = {}
	end	
    TriggerClientEvent("np-mdt:getCallResponses", src, CallResponses[callid], callid)
end)

RegisterServerEvent("np-mdt:sendCallResponse")
AddEventHandler("np-mdt:sendCallResponse", function(message, time, callid, name)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()	
	local name = char.first_name .. " " .. char.last_name
	if not CallResponses[callid] then
		CallResponses[callid] = {}
	end	
    local id = #CallResponses[callid] + 1
	CallResponses[callid][id] = {}

	CallResponses[callid][id].name = name
	CallResponses[callid][id].message = message
	CallResponses[callid][id].time = time
    
    TriggerClientEvent("np-mdt:sendCallResponse", src, message, time, callid, name)
end)               





RegisterServerEvent("np-mdt:getAllReports")
AddEventHandler("np-mdt:getAllReports", function()
    local src = source
	local query = "SELECT * FROM ____mdw_reports"
    local result = Await(SQL.execute(query))
	
	TriggerClientEvent("np-mdt:getAllReports", src, result)
end)

RegisterServerEvent("np-mdt:getReportData")
AddEventHandler("np-mdt:getReportData", function(id)
    local src = source
	local query = "SELECT * FROM ____mdw_reports WHERE dbid = ?"
    local result = Await(SQL.execute(query, id))
	result[1].tags = json.decode(result[1].tags)
	result[1].gallery = json.decode(result[1].gallery)
	result[1].officersinvolved = json.decode(result[1].officers)	
	result[1].officers = json.decode(result[1].officers)
	result[1].civsinvolved = json.decode(result[1].civsinvolved)	
    TriggerClientEvent("np-mdt:getReportData", src, result[1])
end)

RegisterServerEvent("np-mdt:searchReports")
AddEventHandler("np-mdt:searchReports", function(querydata)
    local src = source
		local query = [[
			SELECT *
			FROM ____mdw_reports aa
			WHERE LOWER(`type`) LIKE ? OR LOWER(`title`) LIKE ? OR LOWER(`dbid`) LIKE ? OR CONCAT(LOWER(`type`), ' ', LOWER(`title`), ' ', LOWER(`dbid`)) LIKE ?
		]]
		local string = string.lower('%'..querydata..'%')
		local result = Await(SQL.execute(query, string, string, string, string))

       	TriggerClientEvent("np-mdt:getAllReports", src, result)
end)	


RegisterServerEvent("np-mdt:newReport")
AddEventHandler("np-mdt:newReport", function(data)
    if data.title == "" then return end
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	local time = exports["np-lib"]:getDate()

	exports.ghmattimysql:execute('SELECT * FROM `____mdw_reports` WHERE `dbid` = @id', {
		['@id'] = data.id
	}, function(result)
		if data.id ~= nil and data.id ~= 0 then

			local action = "Edit A Report, Rrofile ID: " .. data.id	

			exports.ghmattimysql:execute('UPDATE `____mdw_reports` SET `title` = @title, `type` = @type, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `civsinvolved` = @civsinvolved, `time` = @time, `author` = @author WHERE `dbid` = @id', {
			    ['@title'] = data.title,
			    ['@type'] = data.type,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@civsinvolved'] = json.encode(data.civilians),
				['@time'] = data.time,
				['@author'] = name,
				['@id'] = data.id
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " updated report: " .. data.id .. " with information: " .. json.encode(data), time)
		else
			exports.ghmattimysql:execute('INSERT INTO `____mdw_reports` (`title`, `type`, `detail`, `tags`, `gallery`, `officers`, `civsinvolved`, `time`, `author`) VALUES (@title, @type, @detail, @tags, @gallery, @officers, @civsinvolved, @time, @author)', {
			    ['@title'] = data.title,
			    ['@type'] = data.type,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@civsinvolved'] = json.encode(data.civilians),
				['@time'] = data.time,
				['@author'] = name			
			})
			TriggerEvent("np-mdt:newLog", char.first_name .. " " .. char.last_name .. " new report with information: " .. json.ncode(data), time)
			Wait(500)
		    local query = "SELECT * FROM ____mdw_reports ORDER BY dbid DESC LIMIT 1"
  			local result2 = Await(SQL.execute(query, id))
		    TriggerClientEvent("np-mdt:reportComplete", src, result2[1].dbid)
		end
	end)
end)

function UpdateDispatch(src)
	local query = "SELECT * FROM ___mdw_messages LIMIT 200"
    local result = Await(SQL.execute(query))
    TriggerClientEvent("np-mdt:dashboardMessages", src, result)
end

RegisterServerEvent("np-mdt:sendMessage")
AddEventHandler("np-mdt:sendMessage", function(message, time)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name


	local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local pic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
	
    local result = Await(SQL.execute(query, char.id))
    if result and result[1] ~= nil then
		if result[1].image and result[1].image ~= nil and result[1].image ~= "" then 
		    pic = result[1].image  
		end
	end	
	local query = "INSERT INTO ___mdw_messages (name, message, time, profilepic, job) VALUES(?, ?, ?, ?, ?)"
	Await(SQL.execute(query, name, message, time, pic, "police")) 	
	local lastMsg = {
        name = name,
		message = message,
		time = time,
		profilepic = pic,
		job = "police"
	}
	TriggerClientEvent("np-mdt:dashboardMessage", -1, lastMsg)
end)

RegisterServerEvent("np-mdt:refreshDispatchMsgs")
AddEventHandler("np-mdt:refreshDispatchMsgs", function()
    local src = source
	local query = "SELECT * FROM ___mdw_messages LIMIT 200"
    local result = Await(SQL.execute(query))
    TriggerClientEvent("np-mdt:dashboardMessages", src, result)
end)


-- RegisterNetEvent('np-mdt:dashboardMessage')
-- AddEventHandler('np-mdt:dashboardMessage', function(sentData)
--     local job = exports["isPed"]:isChar("myjob")
--     if job == "police" or job.name == 'ambulance' then
--         SendNUIMessage({ type = "dispatchmessage", data = sentData })
--     end
-- end)

RegisterServerEvent("np-mdt:setCallsign")
AddEventHandler("np-mdt:setCallsign", function(cid, callsign)
	exports.ghmattimysql:execute("UPDATE jobs_whitelist SET `callsign` = @callsign WHERE cid = @cid", {['callsign'] = callsign, ['cid'] = cid})
	TriggerEvent("np-mdt:newLog", cid .. " updated callsign to: " .. callsign, time)
end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
           -- print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end

function getUserFromCid(cid)
	local users = exports["np-base"]:getModule("Player"):GetUsers()
	for k,v in pairs(users) do
		local user = exports["np-base"]:getModule("Player"):GetUser(v)
		if user then
		    local char = user:getCurrentCharacter()
            if char.id == cid then
				return user
			end
		end
	end
    return false
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end