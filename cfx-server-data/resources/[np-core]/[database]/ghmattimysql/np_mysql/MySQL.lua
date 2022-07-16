local MySQL = {}

function MySQL.createCommand(name, command)
  if not exports.np_mysql:checkCommand(name) then
    exports.np_mysql:registerCommand(name, command)
  else
    print("^1MySQL: error the command "..name.." does exist already.^0")
  end
end

function MySQL.execute(name, args, cb)
  if exports.np_mysql:checkCommand(name) then
      local args2 = {}
      if args then
          for k, v in pairs(args) do
              args2['@'..k] = v
          end
      end
      exports.ghmattimysql:execute(exports.np_mysql:getCommand(name), args2)
      if cb then
          local task = Task(cb)
          task({})
      end
  else
    print("^1MySQL: error the command "..name.." doesn't exist.^0")
  end
end

function MySQL.query(name, args, cb)
  if exports.np_mysql:checkCommand(name) then
    local args2 = {}
    if args then
        for k, v in pairs(args) do
            args2['@'..k] = v
        end
    end
    if cb then
        local task = Task(cb)
        exports.ghmattimysql:execute(exports.np_mysql:getCommand(name), args2, function (result)
          task({result})
        end)
    else
      exports.ghmattimysql:execute(exports.np_mysql:getCommand(name), args2)
    end
  else
    print("^1MySQL: error the command "..name.." doesn't exist.^0")
  end
end

return MySQL