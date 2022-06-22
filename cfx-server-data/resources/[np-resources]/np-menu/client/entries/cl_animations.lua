local GeneralEntries, SubMenu = MenuEntries['general'], {}

local Animations = {
    {
        id = 'animations:arrogant',
        title = "Arrogant",
        icon = "#animation-arrogant",
        event = "AnimSet:Arrogant",
    },
    {
        id = 'animations:casual',
        title = "Casual",
        icon = "#animation-casual",
        event = "AnimSet:Casual",
    },
    {
        id = 'animations:casual2',
        title = "Casual 2",
        icon = "#animation-casual",
        event = "AnimSet:Casual2",
    },
    {
        id = 'animations:casual3',
        title = "Casual 3",
        icon = "#animation-casual",
        event = "AnimSet:Casual3",
    },
    {
        id = 'animations:casual4',
        title = "Casual 4",
        icon = "#animation-casual",
        event = "AnimSet:Casual4",
    },
    {
        id = 'animations:casual5',
        title = "Casual 5",
        icon = "#animation-casual",
        event = "AnimSet:Casual5",
    },
    {
        id = 'animations:casual6',
        title = "Casual 6",
        icon = "#animation-casual",
        event = "AnimSet:Casual6",
    },
    {
        id = 'animations:confident',
        title = "Confident",
        icon = "#animation-confident",
        event = "AnimSet:Confident",
    },
    {
        id = 'animations:business2',
        title = "Business 2",
        icon = "#animation-business",
        event = "AnimSet:Business2",
    },
    {
        id = 'animations:business3',
        title = "Business 3",
        icon = "#animation-business",
        event = "AnimSet:Business3",
    },

    {
        id = 'animations:femme',
        title = "Femme",
        icon = "#animation-female",
        event = "AnimSet:Femme",
    },
    {
        id = 'animations:flee',
        title = "Flee",
        icon = "#animation-flee",
        event = "AnimSet:Flee",
    },
    {
        id = 'animations:gangster',
        title = "Gangster",
        icon = "#animation-gangster",
        event = "AnimSet:Gangster",
    },
    {
        id = 'animations:gangster2',
        title = "Gangster 2",
        icon = "#animation-gangster",
        event = "AnimSet:Gangster2",
    },
    {
        id = 'animations:gangster3',
        title = "Gangster 3",
        icon = "#animation-gangster",
        event = "AnimSet:Gangster3",
    },
    {
        id = 'animations:gangster4',
        title = "Gangster 4",
        icon = "#animation-gangster",
        event = "AnimSet:Gangster4",
    },
    {
        id = 'animations:gangster5',
        title = "Gangster 5",
        icon = "#animation-gangster",
        event = "AnimSet:Gangster5",
    },
    {
        id = 'animations:heels',
        title = "Heels",
        icon = "#animation-female",
        event = "AnimSet:Heels",
    },
    {
        id = 'animations:heels2',
        title = "Heels 2",
        icon = "#animation-female",
        event = "AnimSet:Heels2",
    },
    {
        id = 'animations:hiking',
        title = "Hiking",
        icon = "#animation-hiking",
        event = "AnimSet:Hiking",
    },
    {
        id = 'animations:muscle',
        title = "Muscle",
        icon = "#animation-tough",
        event = "AnimSet:Muscle",
    },
    {
        id = 'animations:quick',
        title = "Quick",
        icon = "#animation-quick",
        event = "AnimSet:Quick",
    },
    {
        id = 'animations:wide',
        title = "Wide",
        icon = "#animation-wide",
        event = "AnimSet:Wide",
    },
    {
        id = 'animations:scared',
        title = "Scared",
        icon = "#animation-scared",
        event = "AnimSet:Scared",
    },
    {
        id = 'animations:brave',
        title = "Brave",
        icon = "#animation-brave",
        event = "AnimSet:Brave",
    },
    {
        id = 'animations:tipsy',
        title = "Tipsy",
        icon = "#animation-tipsy",
        event = "AnimSet:Tipsy",
    },
    {
        id = 'animations:injured',
        title = "Injured",
        icon = "#animation-injured",
        event = "AnimSet:Injured",
    },
    {
        id = 'animations:tough',
        title = "Tough",
        icon = "#animation-tough",
        event = "AnimSet:ToughGuy",
    },
    {
        id = 'animations:sassy',
        title = "Sassy",
        icon = "#animation-sassy",
        event = "AnimSet:Sassy",
    },
    {
        id = 'animations:sad',
        title = "Sad",
        icon = "#animation-sad",
        event = "AnimSet:Sad",
    },
    {
        id = 'animations:posh',
        title = "Posh",
        icon = "#animation-posh",
        event = "AnimSet:Posh",
    },
    {
        id = 'animations:alien',
        title = "Alien",
        icon = "#animation-alien",
        event = "AnimSet:Alien",
    },
    {
        id = 'animations:nonchalant',
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        event = "AnimSet:NonChalant",
    },
    {
        id = 'animations:hobo',
        title = "Hobo",
        icon = "#animation-hobo",
        event = "AnimSet:Hobo",
    },
    {
        id = 'animations:money',
        title = "Money",
        icon = "#animation-money",
        event = "AnimSet:Money",
    },
    {
        id = 'animations:swagger',
        title = "Swagger",
        icon = "#animation-swagger",
        event = "Animation:Set:Gait",
    },
    {
        id = 'animations:shady',
        title = "Shady",
        icon = "#animation-shady",
        event = "Animation:Set:Gait",
    },
    {
        id = 'animations:maneater',
        title = "Man Eater",
        icon = "#animation-maneater",
        event = "Animation:Set:Gait",
    },
    {
        id = 'animations:chichi',
        title = "ChiChi",
        icon = "#animation-chichi",
        event = "Animation:Set:Gait",
    },
    {
        id = 'animations:default',
        title = "Default",
        icon = "#animation-default",
        event = "AnimSet:default"
    }
}

Citizen.CreateThread(function()
    for index, data in ipairs(Animations) do
        SubMenu[index] = data.id
        MenuItems[data.id] = {data = data}
    end
    GeneralEntries[#GeneralEntries+1] = {
        data = {
            id = "animations",
            icon = "#walking",
            title = "Walk Style",
        },
        subMenus = SubMenu,
        isEnabled = function()
            return not isDead
        end,
    }
end)




