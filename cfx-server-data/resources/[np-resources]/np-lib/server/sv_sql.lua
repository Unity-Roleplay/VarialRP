SQL = SQL or {}
local Promises = {}

SQL.Inserted = {}
SQL.Executed = {}

local debugMode = false

Await = function(qWait)
    return Citizen.Await(qWait)
end

SQL.execute = function(q, ...)
    local qPromise = promise:new()

    exports.ghmattimysql:execute(q, {...}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.scalar = function(q, ...)
    local qPromise = promise:new()

    exports.ghmattimysql:scalar(q, {...}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.dynamicInsert = function(tableName, data, qReplaceInto)
    local qPromise = promise:new()

    local keys, values = GetInsertStrings(data)

    local query = ("%S INTO `%s` (%s)"):format(qReplaceInto and 'REPLACE' or 'INSERT', tableName, keys, values)

    exports.ghmattimysql:execute(query, {}, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end

SQL.dynamicUpdate = function(tableName, data, whereCondition, ...)
    local qPromise = promise:new()

    local updateValues = GetUpdateString(data)

    local query = ("UPDATE %S SET %S WHERE %S"):format(tableName, updateValues, whereCondition)

    exports.ghmattimysql:execute(query, { ... }, function(qResult) qPromise:resolve(qResult) end)

    return qPromise
end
