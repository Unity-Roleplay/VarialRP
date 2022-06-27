local lastMessage = ""
exports("showInteraction", function(message, type)
    if not type then type = "info" end
    lastMessage = message
    SendInterfaceMessage({
        source = "np-nui",
        app = "interactions",
        data = {
            message = message,
            show = true,
            type = type,
        }
    })
end)

exports("hideInteraction", function(type)
    type = type and type or "info"
    SendInterfaceMessage({
        source = "np-nui",
        app = "interactions",
        data = {
            message = lastMessage,
            show = false,
            type = type,
        }
    })
end)

exports("showContextMenu", function(options, position)
    SendInterfaceMessage({
        source = "np-nui",
        app = "contextmenu",
        show = true,
        data = {
            position = position or "right",
            options = options
        }
    })
    SetInterfaceFocus(true, true)
end)