local listening = false

local banks = {
	{name="Bank", id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", id=108, x=-351.534, y=-49.529, z=49.042},
	{name="Bank", id=108, x=241.727, y=220.706, z=106.286},
	{name="Bank", id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}	


local function listenForKeypress(type, data)
  listening = true
  Citizen.CreateThread(function()
      while listening do
          if IsControlJustReleased(0, 38) then
              listening = false
              exports["np-textui"]:hideInteraction()
              TriggerEvent("np-banking:open-bank")
          end
          Wait(0)
      end
  end)
end

function enterPoly(name, data)
  listenForKeypress(name, data)
  exports["np-textui"]:showInteraction("[E] " .. name)
end

function leavePoly(name, data)
  listening = false
  exports["np-textui"]:hideInteraction()
end

AddEventHandler("np-polyzone:enter", function(name, data)
  if name == "banking" then
    enterPoly("Bank", data)
  end
end)

AddEventHandler("np-polyzone:exit", function(name, data)
  if name == "banking" then
    leavePoly("Bank", data)
  end
end)

Citizen.CreateThread(function()

    exports["np-polyzone"]:AddBoxZone("banking", vector3(149.97, -1040.54, 29.37), 1.5, 2, {
      name="banking",
      heading=157.96,
      debugPoly=false,
      minZ=27.6,
      maxZ=31.99
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(-1212.980, -330.841, 37.787), 1.5, 2, {
      name="banking",
      heading=208.95,
      debugPoly=false,
      minZ=36.68,
      maxZ=40.38
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(-2962.582, 482.627, 15.703), 1.5, 2, {
      name="banking",
      heading=264.78,
      debugPoly=false,
      minZ=14.6,
      maxZ=18.1
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(-108.88, 6469.86, 31.63), 1.1, 4.8, {
      name="banking",
      heading=45,
      minZ=29.03,
      maxZ=33.03
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(314.187, -278.621, 54.170), 1.5, 2, {
      name="banking",
      heading=161.0,
      debugPoly=false,
      minZ=53.23,
      maxZ=56.82
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(-350.8, -49.53, 49.04), 1.5, 2, {
      name="banking",
      heading=163.22,
      debugPoly=false,
      minZ=48.04,
      maxZ=51.44
    })

    exports["np-polyzone"]:AddBoxZone("banking", vector3(1175.06, 2706.64, 38.09), 1.5, 2, {
      name="banking",
      heading=359.12,
      debugPoly=false,
      minZ=36.99,
      maxZ=40.59
    })


    exports["np-polyzone"]:AddBoxZone("banking", vector3(262.01, 224.91, 106.28), 1.2, 12.2, {
      name="banking",
      heading=340,
      minZ=104.28,
      maxZ=108.28
    })
    
    
end)

-- Bank blips
Citizen.CreateThread(function()
	for k,v in ipairs(banks) do
	  local blip = AddBlipForCoord(v.x, v.y, v.z)
	  SetBlipSprite(blip, v.id)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 0.7)
	  SetBlipColour (blip, 4)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(tostring(v.name))
	  EndTextCommandSetBlipName(blip)
	end
end)

