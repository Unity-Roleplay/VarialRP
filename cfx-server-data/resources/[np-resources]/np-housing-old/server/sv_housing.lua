local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer


RegisterServerEvent('house:updatespawns')
AddEventHandler('house:updatespawns', function(info, house_id)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if IsRealtor(src) == "real_estate" then
        exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ?', {house_id}, function(result)
            exports.ghmattimysql:execute("UPDATE __housedata SET `data` = @data WHERE `house_id` = @house_id", {
                ['@data'] = json.encode(info),
                ['@house_id'] = house_id
            })
            TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, json.encode(info))
        end)
    end
end)


RegisterServerEvent('housing:attemptsale')
AddEventHandler('housing:attemptsale', function(cid,price,house_id,house_model, storage, clothing,garages)
    TriggerClientEvent('housing:findsalecid', -1, cid, price, house_id, house_model, storage, clothing, garages)
end)

RegisterServerEvent('house:purchasehouse')
AddEventHandler('house:purchasehouse', function(cid,house_id,house_model,upfront,price,housename,garages)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(source)
    local char = user:getVar("character")
    if tonumber(user:getCash()) >= tonumber(price) then
        user:removeMoney(tonumber(price))
        exports.ghmattimysql:execute('SELECT `housename` FROM __housedata WHERE `housename`= ?', {housename}, function(data)
            if data[1].cid == nil then
                exports.ghmattimysql:execute("UPDATE __housedata SET `cid` = @cid, `upfront` = @upfront, `housename` = @housename, `garages` = @garages, `house_model` = @house_model, `overall` = @overall, `payments` = @payments, `due` =@due, `days` = @days WHERE `house_id` = @house_id", {
                    ['@cid'] = cid,
                    ['@upfront'] = upfront,
                    ['@housename'] = housename,
                    ['@garages'] = json.encode(garages),
                    ['@house_model'] = house_model,
                    ['@overall'] = price,
                    ['@payments'] = "14",
                    ['@house_id'] = house_id,
                    ['@days'] = repayTime,
                    ['@due'] = price - upfront
                })
                TriggerClientEvent('DoLongHudText', src, "Congratulations, you now own " .. housename .. "!", 6)
                local payout = price
                TriggerClientEvent('np-motels:RealtorPay', src, payout)
            else
                TriggerClientEvent("DoLongHudText", src, "This house is already sold...", 2)
            end
        end)
    else
        TriggerEvent("DoLongHudText","You do not have enough money for this purchase.",2)
    end
end)


RegisterServerEvent('housing:requestSpawnTable')
AddEventHandler('housing:requestSpawnTable', function(table, id, house_name, house_model)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id` = @house_id', { ['@house_id'] = id }, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('UpdateCurrentHouseSpawns', src, id, result[1].data)
        else
            exports.ghmattimysql:execute("INSERT INTO __housedata (data, house_id, house_model, housename) VALUES (@data, @house_id, @house_model, @housename)", {
                ['@house_id'] = id,
                ['@data'] = json.encode(table),
                ['@house_model'] = house_model,
                ['@housename'] = house_name
            })
        end
    end)
end)

RegisterServerEvent('housing:getGarage')
AddEventHandler('housing:getGarage', function(house_id, house_model)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local cid = user:getCurrentCharacter().id
    exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `house_id`= ? AND `house_model`= ?  AND `cid` = ?', {house_id, house_model, cid}, function(returnData)
        if returnData[1] ~= nil then
            local pGarageName = returnData[1].housename.. "-" ..returnData[1].house_id
            TriggerClientEvent("menu:send:house:garages", src, json.decode(returnData[1].garages), pGarageName)
        end
    end)
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id`= ? AND `house_model`= ?  AND `cid` = ?', {house_id, house_model, cid}, function(penis)
        if penis[1] ~= nil then
            if penis[1].garages ~= "{}" then
                local pGarageName = penis[1].housename.. "-" ..penis[1].house_id
                TriggerClientEvent("menu:send:house:garages", src, json.decode(penis[1].garages), pGarageName)
            end
        end
    end)
end)


RegisterServerEvent('house:enterhouse')
AddEventHandler('house:enterhouse', function(cid,isRealEstate,house_id,house_model,furniture)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id`= ? AND `house_model`= ?', {house_id, house_model}, function(house)
        if house[1].force_locked ~= "locked" then
            if house[1].cid == cid then
                if house[1].furniture ~= {} then
                    TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(house[1].furniture), nil, nil, nil)
                else
                    TriggerClientEvent('house:entersuccess', src, house_id, house_model) 
                end
                TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, house[1].data)
            else
                exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `house_id`= ? AND `house_model`= ? AND `cid` = ?', {house_id, house_model, cid}, function(house2)
                    if house2[1] ~= nil then
                        exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id`= ? AND `house_model`= ?', {house_id, house_model}, function(penis)
                            if penis[1].furniture ~= {} then
                                TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(penis[1].furniture), nil, nil, nil)
                            else
                                TriggerClientEvent('house:entersuccess', src, house_id, house_model) 
                            end
                            TriggerClientEvent('UpdateCurrentHouseSpawns', src, house_id, penis[1].data)
                        end)
                        TriggerClientEvent('DoLongHudText', src, "Entering shared property", 1)
                    end
                end)
            end    
            
            exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id`= ? AND `house_model`= ?', {house_id, house_model}, function(guest)
                if isRealEstate == true then
                    if guest[1].furniture ~= {} then
                        TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(guest[1].furniture), nil, nil, nil)
                    else
                        TriggerClientEvent('house:entersuccess', src, house_id, house_model) 
                    end
                else
                    if guest[1].cid ~= cid then
                        if guest[1].status ~= "locked" then
                            if guest[1].furniture ~= {} then
                                TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(guest[1].furniture), nil, nil, nil)
                            else
                                TriggerClientEvent('house:entersuccess', src, house_id, house_model) 
                            end
                        else
                            exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `house_id`= ? AND `house_model`= ? AND `cid` = ?', {house_id, house_model, cid}, function(guest2)
                                if guest2[1] == nil then
                                    TriggerClientEvent('DoLongHudText', src, "This house is locked", 2)
                                end
                            end)
                        end
                    end
                end
            end)
        else
            TriggerClientEvent('DoLongHudText', src, "This house is forced locked by a realtor", 2)
        end
    end)
end)

local function checkKeyExist(cid, housename, cb)
    exports.ghmattimysql:execute("SELECT * FROM __housekeys WHERE cid = @cid AND housename = @housename LIMIT 1;", {["cid"] = cid, ["housename"] = housename}, function(result)
        local exists = result and result[1] and result[1].housename and true or false
        cb(exists)
    end)
end

RegisterServerEvent('house:givekey')
AddEventHandler('house:givekey', function(house_id,house_model,house_name,target)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local zUser = exports["np-base"]:getModule("Player"):GetUser(target)
    local zchar = zUser:getCurrentCharacter()
    exports.ghmattimysql:execute("SELECT * FROM __housedata WHERE house_id = @house_id AND house_model = @house_model", {['@house_id'] = house_id, ['@house_model'] = house_model}, function(result)
        if result[1].cid == char.id then  
            exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `cid`= ?', {zchar.id}, function(data)
                checkKeyExist(zchar.id, house_name, function(exists)
                    if not exists then
                        local name = zchar.first_name .. " " .. zchar.last_name
                        exports.ghmattimysql:execute('INSERT INTO __housekeys(cid, house_id, house_model, housename, name) VALUES(?, ?, ?, ?, ?)', {zchar.id, house_id, house_model, house_name, name})
                        TriggerClientEvent('DoLongHudText', target, "You have received keys to " .. house_name .. ".", 6)
                        TriggerClientEvent('DoLongHudText', src, "You gave " .. zchar.first_name .. " " .. zchar.last_name .. " keys to " .. house_name .. ".", 1)
                    else 
                        TriggerClientEvent('DoLongHudText', src, 'You already gave key to this person.', 2)
                        TriggerClientEvent('DoLongHudText', target, 'You already received key for this house.', 2)
                    end
                end)
            end)
        else
            TriggerClientEvent('DoLongHudText', src, 'You dont own this house.', 2)
        end
    end)
end)

RegisterServerEvent('house:retrieveKeys')
AddEventHandler('house:retrieveKeys', function(house_id, house_model)
    local src = source
    local shared = {}
    exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE `house_id`= ?', {house_id}, function(data)
        for k, v in pairs(data) do
            if v ~= nil then
                if v.house_id == house_id then
                    local random = math.random(1111,9999)
                    shared[random] = {}
                    table.insert(shared[random], {["sharedHouseName"] = v.housename, ["sharedId"] = v.cid, ["sharedName"] = v.name})
                    TriggerClientEvent('house:returnKeys', src, shared)
                end
            end
        end
    end)
end)

RegisterServerEvent("housing:unlockRE")
AddEventHandler("housing:unlockRE", function(house_id, house_model)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if IsRealtor(src) == "real_estate" then
        exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ?', {house_id}, function(result)
            local address = result[1].housename
            if result[1].force_locked == "unlocked" then
                exports.ghmattimysql:execute("UPDATE __housedata SET `force_locked` = @force_locked WHERE `house_id` = @house_id ", {
                    ['@force_locked'] = "locked",
                    ['@house_id'] = house_id
                })
                TriggerClientEvent("DoLongHudText", src, "Property " ..address.. " has been locked", 1)
            elseif result[1].force_locked == "locked" then
                exports.ghmattimysql:execute("UPDATE __housedata SET `force_locked` = @force_locked WHERE `house_id` = @house_id ", {
                    ['@force_locked'] = "unlocked",
                    ['@house_id'] = house_id
                })
                TriggerClientEvent("DoLongHudText", src, "Property " ..address.. " has been unlocked", 2)
            end
        end)
    end
end)

RegisterServerEvent("housing:unlock")
AddEventHandler("housing:unlock", function(house_id, house_model)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ?', {house_id}, function(result)
        local address = result[1].housename
        if result[1].status == "unlocked" then
            exports.ghmattimysql:execute("UPDATE __housedata SET `status` = @status WHERE `house_id` = @house_id ", {
                ['@status'] = "locked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been locked", 1)
        elseif result[1].status == "locked" then                                                                    
            exports.ghmattimysql:execute("UPDATE __housedata SET `status` = @status WHERE `house_id` = @house_id ", {
                ['@status'] = "unlocked",
                ['@house_id'] = house_id
            })
            TriggerClientEvent("DoLongHudText", src, "The Property " ..address.. " has been unlocked", 2)
        end
    end)
end)

RegisterServerEvent('house:removeKey')
AddEventHandler('house:removeKey', function(house_id, house_model, target)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housekeys WHERE house_id = ? AND cid = ?', {house_id, target}, function(data)
        local name = data[1].name
        TriggerClientEvent('DoLongHudText', src, "You removed " .. name .. "'s keys.")
        exports.ghmattimysql:execute('DELETE FROM __housekeys WHERE `house_id`= ? AND `house_model`= ? AND `cid`= ?', {house_id, house_model, target})
        TriggerClientEvent("np-phone:keys:reload", src)
    end)
 
end)

RegisterServerEvent("houses:removeSharedKey")
AddEventHandler("houses:removeSharedKey", function(house_id, cid)
    local src = source
    exports.ghmattimysql:execute('DELETE FROM __housekeys WHERE `house_id`= ? AND `cid`= ?', {house_id, cid})
    TriggerClientEvent('DoLongHudText', src, "You have removed your shared key.", 2)

end)

RegisterServerEvent('CheckFurniture')
AddEventHandler('CheckFurniture', function(house_id, house_model)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE `house_id`= ? AND `house_model`= ?', {house_id, house_model}, function(data)
        if data[1].furniture ~= {} then
            TriggerClientEvent('openFurnitureConfirm', src, house_id, house_model, json.decode(data[1].furniture))
        else
            TriggerClientEvent('openFurnitureConfirm', src, house_id, house_model, nil)
        end
    end)
end) 


RegisterServerEvent("house:enterhousebackdoor")
AddEventHandler("house:enterhousebackdoor", function(house_id, house_model)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ?', {house_id}, function(result)
        local info = json.decode(result[1].data).backdoorinside
        TriggerClientEvent('house:entersuccess', src, house_id, house_model, json.decode(result[1].furniture), info.x, info.y, info.z)
    end)
end)


RegisterServerEvent('house:evictHouse')
AddEventHandler('house:evictHouse', function(hid, model, cid)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if IsRealtor(src) == "real_estate" then
        exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ? AND house_model = ?', {hid, model}, function(result)
            if result[1] ~= nil then
                TriggerClientEvent("DoLongHudText", src, result[1].housename.. " has been deleted", 2)
                exports.ghmattimysql:execute("DELETE FROM __housedata WHERE house_id = @house_id AND house_model = @house_model", {['house_id'] = hid, ['house_model'] = model})
            end
        end)
    end
end)

RegisterServerEvent("houses:PropertyOutstanding")
AddEventHandler("houses:PropertyOutstanding", function()
    local src = source
    TriggerClientEvent("housing:info:realtor", src, "PropertyOutstanding")
end)

RegisterServerEvent("house:PropertyOutstanding")
AddEventHandler("house:PropertyOutstanding", function(house_id, house_model)
    local src = source
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ? AND house_model = ?', {house_id, house_model}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent("DoLongHudText", src, "The Property Outstanding Balance is $" ..result[1].overall - result[1].due.. " with a pending payment of $" ..math.floor(result[1].due/result[1].payments))
        end
    end)    
end)

RegisterServerEvent("housing:garagesSET")
AddEventHandler("housing:garagesSET", function(garages, house_id)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if IsRealtor(src) == "real_estate" then
        exports.ghmattimysql:execute("UPDATE __housedata SET `garages` = @garages WHERE `house_id` = @house_id", {
            ['@garages'] = json.encode(garages),
            ['@house_id'] = house_id
        })

        exports.ghmattimysql:execute("UPDATE __housekeys SET `garages` = @garages WHERE `house_id` = @house_id", {
            ['@garages'] = json.encode(garages),
            ['@house_id'] = house_id
        })
    end
end)

RegisterServerEvent("house:transferHouse")
AddEventHandler("house:transferHouse", function(house_id, house_model, cid)
    local src = source
    local transfercid = tonumber(cid)
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    if IsRealtor(src) == "real_estate" then
        exports.ghmattimysql:execute("UPDATE __housedata SET `cid` = @cid WHERE `house_model` = @house_model AND `house_id` = @house_id", {
            ['@cid'] = transfercid,
            ['@house_id'] = house_id,
            ['@house_model'] = house_model
        })
        
        TriggerClientEvent("DoLongHudText", src, "The house has been transfered over to cid: " ..transfercid, 1)
    end
end)


RegisterServerEvent("house:dopayment")
AddEventHandler("house:dopayment", function(house_id, house_model)
    local src = source
    local user = exports["np-base"]:getModule("Player"):GetUser(src)
    exports.ghmattimysql:execute('SELECT * FROM __housedata WHERE house_id = ? AND house_model = ?', {house_id, house_model}, function(result)
        if result[1] ~= nil then
            local amountdue = math.floor(result[1].due/result[1].payments)
            if result[1].can_pay ~= "false" then
                if result[1].due ~= tonumber(0) then
                    if user:getBalance() >= amountdue then
                        user:removeBank(amountdue)
                        exports.ghmattimysql:execute("UPDATE __housedata SET `payments` = @payments, `due` = @due, `days` = @days, `can_pay` = @can_pay WHERE `house_id` = @house_id AND `house_model` = @house_model", {
                            ['@payments'] = result[1].payments - 1,
                            ['@due'] = result[1].due - amountdue,
                            ['@house_id'] = house_id,
                            ['@days'] = repayTime,
                            ['@can_pay'] = "false",
                            ['@house_model'] = house_model
                        })
                        local paymentsleft = result[1].payments - 1
                        Citizen.Wait(5000)
                        TriggerClientEvent("DoLongHudText", src, "You still have " ..paymentsleft.. " payments left and a existing mortage of $" ..result[1].due - amountdue, 1)
                    else
                        TriggerClientEvent("DoLongHudText", src, "You cant afford the payment of $" ..amountdue, 2)
                    end
                 
                else
                    Citizen.Wait(10000)
                    TriggerClientEvent("DoLongHudText", src, "Your house is fully paid off!")
                end
            else
                TriggerClientEvent("DoLongHudText", src, "You just recently paid your mortgage payment. You need to wait a week", 2)
            end
        end
    end)
   
end)



function updateFinance()
    exports.ghmattimysql:execute('SELECT days, house_id FROM __housedata WHERE days > @days', {
        ["@days"] = 0
    }, function(result)
        for i=1, #result do
            local financeTimer = result[i].days
            local house_id = result[i].house_id
            local newTimer = financeTimer - 10
            if financeTimer ~= nil then
                exports.ghmattimysql:execute('UPDATE __housedata SET days = @days WHERE house_id = @house_id', {
                    ['@house_id'] = house_id,
                    ['@days'] = newTimer
                })
            end
            if financeTimer < 100 then
                exports.ghmattimysql:execute("UPDATE __housedata SET `can_pay` = @can_pay WHERE `house_id` = @house_id ", {
                    ['@can_pay'] = "true",
                    ['@house_id'] = house_id
                })
            end
        end
    end)
    SetTimeout(timer, updateFinance)
end
SetTimeout(timer, updateFinance)



RegisterServerEvent('UpdateFurniture')
AddEventHandler('UpdateFurniture', function(house_id, house_model, modifiedObjects)
    exports.ghmattimysql:execute("UPDATE __housedata SET `furniture` = @furniture WHERE `house_id` = @house_id AND `house_model` = @house_model", {
        ['@furniture'] = json.encode(modifiedObjects),
        ['@house_id'] = house_id,
        ['@house_model'] = house_model
    })
end)


function IsRealtor(pSrc)
    local user = exports["np-base"]:getModule("Player"):GetUser(pSrc)
    local pCid = user:getCurrentCharacter().id
    exports.ghmattimysql:execute('SELECT `name` FROM character_passes WHERE cid = ?', {pCid}, function(data)
        pJob = data[1].name
    end)

    Citizen.Wait(100)
    return pJob
end

-- Real Estate Hire / Fire-------------------------------------------------------------

RegisterCommand("hirere", function(source)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "real_estate" and v.rank >= 5 then
				TriggerClientEvent('np-jobsystem:reJobMenuHire', src)
			end
		end
	end)
end)

RegisterCommand("firere", function(source)
	local src = source
	local user = exports["np-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "real_estate" and v.rank >= 5 then
				TriggerClientEvent('np-jobsystem:reJobMenuFire', src)
			end
		end
	end)
end)