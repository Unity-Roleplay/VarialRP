-- phoneNotification("sms", message,pname)
function phoneNotification(app,data,handle)
    -- print("phone notification is working?",app,"message",data,"handle",handle)
    if hasPhone() then
        SendNUIMessage({
            openSection = "notify",
             Napp = app, 
             Ndata = data, 
             Nhandle = handle, 
             Ntime = 2500
        })
    end
end

exports('phoneNotification', phoneNotification)

function phoneCallNotification(app,data,handle)
    -- print("phone notification is working?",app,"message",data,"handle",handle)
    if hasPhone() then
        SendNUIMessage({
            openSection = "rcall",
            pNotify = false,
            Napp = app, 
            Ndata = data, 
            Nhandle = handle, 
            Ntime = 2500
        })
    end
end

function phonePingNotification(app,handle)
    -- print("PHONE PING NOTIFICATION",app,handle)
    if hasPhone() then
        if handle ~= nil then
            SendNUIMessage({
                openSection = "notify",
                pNotify = false,
                Napp = app, 
                Ndata = "sent you a ping.", 
                Nhandle = handle, 
                Ntime = 2500
            })
        end
    end
    -- SendNUIMessage({
    --     openSection = 'pingNotif',
    --     pingName = pCharacterName
    --   })
end

function phoneBillNotification(icon,data,title)
    -- print("PHONE PING NOTIFICATION",app,handle)
    -- available icon = car(vehicle icon) or business(home icon)
    if hasPhone() then
        if title ~= nil then
            SendNUIMessage({
                openSection = "sendBill",
                icon = icon,
                Ndata = data, 
                Nhandle = title, 
                Ntime = 3500
              })
        end
    end
    -- SendNUIMessage({
    --     openSection = 'pingNotif',
    --     pingName = pCharacterName
    --   })
end

---this is the fucking notifation motherfucker
-- <div class="notification-container" style="display: block;">
--                     <div class="app-bar" style="display: block;">
--                         <div class="icon"><i style="color: #35baf8;" class="rounded-square-icon fab fa-twitter-square twittercs"></i>
--                         </div>
--                         <div class="text name">Twaatter</div>
--                         <p> Just now</p>
--                         <div class="content">
--                            This is only test shit
--                         </div>
--                     </div>
--                 </div>