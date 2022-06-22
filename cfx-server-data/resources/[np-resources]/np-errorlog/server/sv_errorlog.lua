RegisterServerEvent('error')
AddEventHandler('error',function(resource, args)
    sendToDiscord("```Error in "..resource..'```', args)
end)

function sendToDiscord(name, args, color)
    local connect = {
          {
              ["color"] = 16711680,
              ["title"] = "".. name .."",
              ["description"] = args,
              ["footer"] = {
                  ["text"] = "Made by Tristen L.",
              },
          }
      }
    PerformHttpRequest('https://discord.com/api/webhooks/806715468928122881/nrgfT-swymiEFAOq_D9OIBv_WrIjj3tXHekKQ3GElvgDDDCT8no4dt-dZul7wL7A1sB7', function(err, text, headers) end, 'POST', json.encode({username = "Error Log", embeds = connect, avatar_url = "https://i.imgur.com/VuKnN5P_d.webp?maxwidth=728&fidelity=grand"}), { ['Content-Type'] = 'application/json' })
end

-- it must be saving into a file with io.open("test.lua", "r")
