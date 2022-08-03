If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/xKgQZ6wZvS


Update v1.8:
	- Reogranised the Stores.Lua
		- 3 separate stores to pick from a qb-menu: Tools, Performance, Costmetics
	- Changed how the polyzone reacts to you being in the correct zone
		- It is now linked job duty and works smoother
		- This required rewriting the polyzone detection
		- A LOT of tiny changes were made, all "injob" was renamed to "onduty"
		- This obviously includes changes to locations.lua
	- Payment systems are now external
		- Now uses my free script: jim-payments
		- Register locations are still in this script
		- This includes complete changes to payment.lua and paymentserver.lua
	
Update v1.7:
	New:
	- Added /cleancar command
		- This is a simple command that slowly and visibly cleans the car
		- Added an override so that cleaningkits should use my cleancar command
		- Item is usable by all, /cleancar comamnd limited to mechanics
	- Added door opening / commands
		- /hood, /trunk, /door [0-3]
		- These are usable in and out of a car
		- These are only usable if the car doors are unlocked	
	- Added new items, BulletProof Tires and Drift Tires
		- These work like performance items, consumed on use but can be removed from vehicle
		- Only one type of tire can be installed at a time
		- This has been added to the toolbox item(check_tunes.lua) to show when checking what parts are installed
	- New tire smoke icon included to separate them from these new items
	- Added store.lua for a basic shop
		- Only accessible by chosen job roles
		- You can easily place the box location for these		
	- Added the ability to remove items from a new job stash for repairs
		- This is toggleable in with Config.StashRepair
		- You need to add their locations and job role in repair.lua
		- This resulted in a rework of repairs.lua
	- Added option of Cash or Card to payment.lua and /charge command
	
	Fixes:
	- Updated MySQL syntax to work with updated cores
		- This can be reverted easily for older cores
	- Reverted GetPlate commands from the new QBCore Function to GetVehicleNumberPlateText
		- This is to help with compatability with older versions of QBCore
	- Fix for vehicle cosmetics not showing for others in the server until the one who changed the cosmetics sits in the driver seat
		- This adds a line of two native events to each cosmetic item file, every time the vehicle is found
		- NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	- Added heading's and box sizes to the payments.lua s_target, they used to default to 0
	- Changed window tint animation to "clean2" due to rag prop sticking to hand
		- The sponge prop seems to want to be removed more often than not so I've opted to this instead
	- Moved "flipvehicle" and "seat" from repair.lua to the new extras.lua

Update v1.6:
    - Fixed a CPU leak with my terribly optimized PolyZone script, thanks to FjamZoo.
        - Your locations will be the same, you just need to move them around a bit in the locations.lua
    - Added blip system to the locations
        - Forgot about this one, but now available
        - Simple naming system, if no blip name is provided it defaults to "Mechanic Shop"
        - Included blip colour to help differenciate between locations
    - Fixed some issues with custom garage scripts
        - Add a built in callback that checks to see if the vehicle is owned or not
        - This means it doesn't need to touch any garage system and removes the qb-garage dependancy
	
Update v1.5:
	- Fixed a missing loop for the modelnames, this fixes a repairing error (thought I caught them all..)
	- Fixed help info on /togglesound command
	- Fixed the completely broken vehicle ownership system, some were broken, and some were missing.
		- Every script has been altered to fix this adding a callback.
		- Cosmetic items are only called once when the menu opens
		- Performance items are called more than once for adding and removing
		- This can disabled through the config.lua BUT still adds a dependancy of qb-garages. (or atleast the callback that is used)
	- Added the ability to add mechanic shop locations for specific jobs
		- There are several new config commands, these can change how the systems work drastically
		- Toggles for when a location is required, if a job is required for that location or even if any player can customise things but HAVE to do it in a shop.
		- It depends on what is enabled and disabled.
	- New file locations.lua
		- This is your physical job locations, instructions on how to use are in the file itself.
		- Supports multiple job locations
		- Supports not requiring a job for the mechanic shop location
	- New file payments.lua and paymentservers.lua
		- This is a new payment script, if you have a different system for payments, you won't need this.
		- Uses qb-menu and repurposed events from qb-phone to create an invoice system for jobs
		- Commission becomes possible with this system through slight edits of qb-phones config.
		- Ticket system from my other scripts is an option, you only need to add one line to qb-phone's client.lua
		- Option to add till locations usable with s_target.
	- New /charge command
		- This is essentially the bill command but usable by all people specified by Config.JobRoles
		- This works the same as the till register system but is simply a command.
		- If you don't want to use s_target register systems, this is a viable replacement
		- This can easily be removed by commenting it out in paymentserver.lua
		
Update v1.4:
	- Fixed a bug, due to a weird FiveM native, when grabbing the model names it calls some incorrectly
		- eg. landstalker2 is called as landstlkr2
		- I've added loop events to correct this
		- If you have issues and there are some vehicles I missed, then check repair.lua for the debugging info
		- I've found imports don't get their names correctly either, use the debug notification to find what it "thinks" it should be and add it to the config to correct it
	- Changed how the items menu's call on the names
	    - this goes along with the bug above but works as it is
	- Added a workaround for the "vehicleStatus" being nil issues
		- If the info can't be found it forces a new setup of vehicleStatus
		- Until I can work out a better way, it forces the setup, alerts the mechanic then halts the command.
		- This makes it so sometimes you need to use the mechanic tools twice, but it alerts the user about it.
	- Repair costs are now based on vehicle damage with the config values being their max
		- For Example: If the engine repair cost is set to 10 and the engine is 40% damaged, it will cost 4 of the chosen material
		- These are still ignored if you set free repairs in the config
		
Update v1.3:
	- Added Support for more multiple job roles
	    - "Config.JobRole" dictates what jobs will be allowed to use the items if "Config.RequiresJob = true", otherwise it will ignore the job requirement code
	    - Removed some unnecessary job requirement calls, these were hidden behind a job required menu
	- Attempted to make your character face the vehicle, so you don't end up changing an engine while facing away from the car.
	    - Thank the cats from the CatCafe for teaching me how to implement this.
	- Removed the double + incorrectly worded notifications when using items that would be removed or added from inventory
	- Fixed % numbers for extra parts on the vehicle
	    - Un-comment out the exports from qb-vehiclefailure to enable damage to these parts
	    - Make sure they match the name of the script used for your default mechanic's job (qb-mechanicjob)

Update v1.2
	- Fixed non-mechanic menus notifying "only a mechanic can use this" when closing the menu.
	- Updated all commands to use QBCores built-in command function so they now show descriptions.
	- Changed /vehicledamage to /checkdamage so its matches /checkmods
	- Fixed cars without mods showing 0 possible mods
	    - This has made changes to most files in this script, if a command/item needs to fetch mods its been edited to for this fix	
	- Added Duct Tape item, these repair the chosen amount to the body and engine and will only repair to a max of what you decide (this is intended as an alternate to repairkits)
	    - To install copy and paste the folder, add the new ducttape item to the shared (provided in the shared.lua) and add the bodyrepair.png image to your qb-inventory
	    - This item is highly customisable, wether to set it to a one time temporary repair, if it needs to be used multiple times, if it is consumed on use.

Update v1.1
	- Added support for QBCore's drivingdistance.lua
	    - This bascially adds the extra repairable parts: Radiator, Drive Shaft, Brakes, Clutch and Fuel Tank
	    - These are found in the Mechanic Tools menu
	- Added a new command /vehicledamage
	    - This allows non-mechanic's to only VIEW vehicle damage
	    - This was added (and can be easily removed) because of the amount of repairable items now accessable



---------------------- INSTALLATION

I've changed so much with this version I was tempted to released it as a v2.0
But for now. It's better to treat this as a new installation, starting over. Sorry to those who editted it.

- To install simply place this in your resource folder

- Add the lines from the included shared.lua to your qb-core > shared lua under the Items section

- Add the image files from the zip to your qb-inventory > html > images folder

----------------------

- This requires qb-menu for all the menus
- This requires qb-customs to save the mods
- This requires qb-mechanicjob to get extra part to repair
- This requires qb-tunerchip for NOS

	- It should work with all vehicles as long as they are added to your shared.lua
	- Rims menu can be a bit..weird, but thats unfortunately due to GTA's way of indexing the wheels ID's and Names
		- Custom Rims will possibly be named "NULL"
		- Custom Wheel variants for the rims will posibly be named " - Type 1" and " - Type 2" this is due to different wheels just being another version of the rims.

----------------------

	- Several Config options
	
		- Config.RequiresJob
			- Do the performance items require the mechanic job?

		- Config.LocationRequired
			- If this is enabled, a location is required to do anything to a vehicle

		- Config.JobRequiredForLocation
			- If this is enabled, mechanics can only work in their specified shop
		
		- Config.CosmeticsJob
			- If this is enabled, Cosmetic items require a mechanic job role.
		
	- If making use of the ticket system:
	
		- Config.PayPerTicket = 500
			- How much per ticket given at the bank, change the number to math.random(400,600) to get between $400 and $600 per ticket

		- Config.MinAmountforTicket = 1000
			- This is the minimum amount for a customer to spend before the workers get a ticket to cash in at the bank
			- This should be set to your cheapest product price

---------------------------------------------------------------------------------------------------------------

If you wish to have the extra damagable parts and don't have it enabled:
	- un-comment out all the exports in qb-vehicledamage
	- if they are named "qb-vehicletuning", change this to "qb-mechanicjob"