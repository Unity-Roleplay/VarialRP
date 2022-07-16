commands = {}

function checkCommand(command)
    return (commands[command] ~= nil)
end

function getCommand(command)
    if checkCommand(command) then
        return commands[command]
    else
        return false
    end
end

function registerCommand(name, sqlc)
    commands[name] = sqlc
end

function getCommands()
    return commands
end