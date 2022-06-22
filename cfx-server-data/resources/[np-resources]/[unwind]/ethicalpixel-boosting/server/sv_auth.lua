local authorized = true
local urls = {}


RegisterNetEvent('ethicalpixel-boosting:loadNUI')
AddEventHandler('ethicalpixel-boosting:loadNUI' , function()
    if(authorized == true) then
        local src = source
        local url = 'http://tunisianunderground.com/boosting/'
        TriggerClientEvent('ethicalpixel-boosting:authorized:ReciveS', src, url) 
    end
end)

CreateThread(function()
    Wait(100)
    local url = 'http://tunisianunderground.com/boosting/'
    TriggerClientEvent('ethicalpixel-boosting:authorized:ReciveS', -1, url)  
end)
