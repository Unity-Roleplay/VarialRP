# This is the NP-Base Vesion of ethicalpixel-Bossting


# Dependencies
* [ethicalpixel-minigame](https://github.com/uNwinD-Development/ethicalpixel-minigame)
* [unwind-rpc](https://github.com/uNwinD-Development/unwind-rpc))

# Instruction
* 1 . Add this to your shared list in the inventory

------------------------------------

	itemList["pixellaptop"] = {
		fullyDegrades: false,
		decayrate: 0.0,
		displayname: "Pixel Laptop",
		price: 10,
		weight: 0,
		nonStack: true,
		model: "",
		image: 'pixellaptop.png',
		information: "The damn laptop",
		deg: false
	};

	itemList["disabler"] = {
		fullyDegrades: false,
		decayrate: 0.0,
		displayname: "Tracker Disabling Tool",
		price: 10,
		weight: 0,
		nonStack: true,
		model: "",
		image: 'disabler.png',
		information: "The damn disabler",
		deg: false
	};

------------------------------------


* 2 . Add this to your functions.lua (client side) - inventory foler and add the icons

		if (itemid == "pixellaptop")  then
			TriggerServerEvent("ethicalpixel-boosting:usedlaptop")
		end    

		if (itemid == "disabler")  then
			TriggerServerEvent("ethicalpixel-boosting:useddisabler")
		end  

------------------------------------

* 3 . Place ethicalpixel-boosting and ethicalpixel-minigame and unwind-rpc into your resources folder and copy the following commands to your resources.cfg or server.cfg 

------------------------------------
    * ensure unwind-rpc
    * ensure ethicalpixel-minigame
    * ensure ethicalpixel-boosting






PS : Please don't change the folders names as it will cause you in game problems



```
<EthicalPixel> Development Team
```