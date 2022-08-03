Config = {}

-- Main variables

Config.isVehicleOwned = false -- Keep this true if you only want changes to be made to owned vehicles


Config.RequiresJob = true  -- Do the specfic items require the mechanic job?

Config.LocationRequired = true -- Are the mecahnics locked to specific locations? -- IF FALSE DISABLE REQUIRES JOB --

Config.JobRequiredForLocation = true -- Enable this if the job locations require a SPECIFIED ROLE (specified in locations.lua)

Config.CosmeticsJob = false -- Do vehicle cosmetics require a mechanic job role?


Config.FreeRepair = false  -- Do repairs cost materials? True means yes

Config.StashRepair = true -- Enable for materials to be removed from a job stash

--THESE ARE MAX AMOUNTS
Config.RepairEngine = "iron"  ---Engine repair item and its cost
Config.RepairEngineCost = 8

Config.RepairBody = "plastic"  ---Body Repair item and its cost
Config.RepairBodyCost = 8

Config.RepairRadiator = "plastic"  ---Radiator Repair item and its cost
Config.RepairRadiatorCost = 8

Config.RepairAxle = "steel"  ---DriveShaft Repair item and its cost
Config.RepairAxleCost = 8

Config.RepairBrakes = "iron"  ---Brakes Repair item and its cost
Config.RepairBrakesCost = 8

Config.RepairClutch = "aluminum"  ---Clutch Repair item and its cost
Config.RepairClutchCost = 8

Config.RepairFuel = "plastic"  ---Fuel Repair item and its cost
Config.RepairFuelCost = 8

--DuctTape Controllers
Config.DuctSimpleMode = true -- This will repair the engine to the max (set below)

Config.MaxDuctEngine = 450.0 -- 450.0 is 45% health, this will be the max amount that it can be repaired to
Config.DuctAmountEngine = 100.0 -- Repairs the engine by 10% each use

Config.DuctTapeBody = true  --Enable if you want duct tape to repair body at the same time as engine
Config.MaxDuctBody = 450.0
Config.DuctAmountBody = 100.0 -- Repairs the engine by 10% each use

Config.RemoveDuctTape = true --If Enabled it will remove 1 duct after use. If false it will be constantly reusable

Config.JobRoles = { "strtunners", "bennys" } -- Add your extra job roles here or just leave as "mechanic"

--Example--
--Config.JobRoles = { "mechanic", "tuner" }



Config.carNames = {
	[1] = { name = "schwarze", newName = "schwarzer" },
	[2] = { name = "cavcade", newName = "cavalcade2" },
	[3] = { name = "landstal", newName = "landstalker" },
	[4] = { name = "landstlkr2", newName = "landstalker2" },
	[5] = { name = "dilettan", newName = "dilettante" },
	[6] = { name = "stingerg", newName = "stingergt" },
	[7] = { name = "trophy2", newName = "trophytruck2" },
	[8] = { name = "bfinject", newName = "bfinjection" },
	[9] = { name = "rancherx", newName = "rancherxl" },
	[10] = { name = "sandkin2", newName = "sandking2" },
	[11] = { name = "trophy", newName = "trophytruck" },
	[12] = { name = "cogcabri", newName = "cogcabrio" },
	[13] = { name = "cognosc", newName = "cognoscenti" },
	[14] = { name = "schafter", newName = "schafter2" },
	[15] = { name = "tailgate", newName = "tailgater" },
	[16] = { name = "washingt", newName = "washington" },
	[17] = { name = "carboniz", newName = "carbonizzare" },
	[18] = { name = "khamel", newName = "khamelion" },
	[19] = { name = "verlier", newName = "verlierer2" },
	[20] = { name = "buccanee", newName = "buccaneer" },
	[21] = { name = "buccanee2", newName = "buccaneer2" },
	[22] = { name = "dominato", newName = "dominator" },
	[23] = { name = "dominato2", newName = "dominator2" },
	[24] = { name = "dominato3", newName = "dominator3" },
	[25] = { name = "niteshad", newName = "nightshade" },
	[26] = { name = "rloader", newName = "ratloader" },
	[27] = { name = "rloader2", newName = "ratloader2" },
	[28] = { name = "buffalo02", newName = "buffalo2" },
}


--Below are names of items/mods that can't be reteived natively
vehicleHorns = {
	{ name = "Truck Horn", id = 0 },
	{ name = "Cop Horn", id = 1 },
	{ name = "Clown Horn", id = 2 },
	{ name = "Musical Horn 1", id = 3 },
	{ name = "Musical Horn 2", id = 4 },
	{ name = "Musical Horn 3", id = 5 },
	{ name = "Musical Horn 4", id = 6 },
	{ name = "Musical Horn 5", id = 7 },
	{ name = "Sad Trombone", id = 8 },
	{ name = "Classical Horn 1", id = 9 },
	{ name = "Classical Horn 2", id = 10 },
	{ name = "Classical Horn 3", id = 11 },
	{ name = "Classical Horn 4", id = 12 },
	{ name = "Classical Horn 5", id = 13 },
	{ name = "Classical Horn 6", id = 14 },
	{ name = "Classical Horn 7", id = 15 },
	{ name = "Scale - Do", id = 16 },
	{ name = "Scale - Re", id = 17 },
	{ name = "Scale - Mi", id = 18 },
	{ name = "Scale - Fa", id = 19 },
	{ name = "Scale - Sol", id = 20 },
	{ name = "Scale - La", id = 21 },
	{ name = "Scale - Ti", id = 22 },
	{ name = "Scale - Do", id = 23 },
	{ name = "Jazz Horn 1", id = 24 },
	{ name = "Jazz Horn 2", id = 25 },
	{ name = "Jazz Horn 3", id = 26 },
	{ name = "Jazz Horn Loop", id = 27 },
	{ name = "Star Spangled Banner 1", id = 28 },
	{ name = "Star Spangled Banner 2", id = 29 },
	{ name = "Star Spangled Banner 3", id = 30 },
	{ name = "Star Spangled Banner 4", id = 31 },
	{ name = "Classical Horn 8 Loop", id = 32 },
	{ name = "Classical Horn 9 Loop", id = 33 },
	{ name = "Classical Horn 10 Loop", id = 34 },
	{ name = "Classical Horn 8", id = 35 },
	{ name = "Classical Horn 9", id = 36 },
	{ name = "Classical Horn 10", id = 37 },
	{ name = "Funeral Loop", id = 38 },
	{ name = "Funeral", id = 39 },
	{ name = "Spooky Loop", id = 40 },
	{ name = "Spooky", id = 41 },
	{ name = "San Andreas Loop", id = 42 },
	{ name = "San Andreas", id = 43 },
	{ name = "Liberty City Loop", id = 44 },
	{ name = "Liberty City", id = 45 },
	{ name = "Festive 1 Loop", id = 46 },
	{ name = "Festive 1", id = 47 },
	{ name = "Festive 2 Loop", id = 48 },
	{ name = "Festive 2", id = 49 },
	{ name = "Festive 3 Loop", id = 50 },
	{ name = "Festive 3", id = 51 }
}

vehicleResprayOptionsClassic = {
	{ name = "Black", id = 0 },
	{ name = "Carbon Black", id = 147 },
	{ name = "Graphite", id = 1 },
	{ name = "Anhracite Black", id = 11 },
	{ name = "Black Steel", id = 11 },
	{ name = "Dark Steel", id = 3 },
	{ name = "Silver", id = 4 },
	{ name = "Bluish Silver", id = 5 },
	{ name = "Rolled Steel", id = 6 },
	{ name = "Shadow Silver", id = 7 },
	{ name = "Stone Silver", id = 8 },
	{ name = "Midnight Silver", id = 9 },
	{ name = "Cast Iron Silver", id = 10 },
	{ name = "Red", id = 27 },
	{ name = "Torino Red", id = 28 },
	{ name = "Formula Red", id = 29 },
	{ name = "Lava Red", id = 150 },
	{ name = "Blaze Red", id = 30 },
	{ name = "Grace Red", id = 31 },
	{ name = "Garnet Red", id = 32 },
	{ name = "Sunset Red", id = 33 },
	{ name = "Cabernet Red", id = 34 },
	{ name = "Wine Red", id = 143 },
	{ name = "Candy Red", id = 35 },
	{ name = "Hot Pink", id = 135 },
	{ name = "Pfsiter Pink", id = 137 },
	{ name = "Salmon Pink", id = 136 },
	{ name = "Sunrise Orange", id = 36 },
	{ name = "Orange", id = 38 },
	{ name = "Bright Orange", id = 138 },
	{ name = "Gold", id = 99 },
	{ name = "Bronze", id = 90 },
	{ name = "Yellow", id = 88 },
	{ name = "Race Yellow", id = 89 },
	{ name = "Dew Yellow", id = 91 },
	{ name = "Dark Green", id = 49 },
	{ name = "Racing Green", id = 50 },
	{ name = "Sea Green", id = 51 },
	{ name = "Olive Green", id = 52 },
	{ name = "Bright Green", id = 53 },
	{ name = "Gasoline Green", id = 54 },
	{ name = "Lime Green", id = 92 },
	{ name = "Midnight Blue", id = 141 },
	{ name = "Galaxy Blue", id = 61 },
	{ name = "Dark Blue", id = 62 },
	{ name = "Saxon Blue", id = 63 },
	{ name = "Blue", id = 64 },
	{ name = "Mariner Blue", id = 65 },
	{ name = "Harbor Blue", id = 66 },
	{ name = "Diamond Blue", id = 67 },
	{ name = "Surf Blue", id = 68 },
	{ name = "Nautical Blue", id = 69 },
	{ name = "Racing Blue", id = 73 },
	{ name = "Ultra Blue", id = 70 },
	{ name = "Light Blue", id = 74 },
	{ name = "Chocolate Brown", id = 96 },
	{ name = "Bison Brown", id = 101 },
	{ name = "Creeen Brown", id = 95 },
	{ name = "Feltzer Brown", id = 94 },
	{ name = "Maple Brown", id = 97 },
	{ name = "Beechwood Brown", id = 103 },
	{ name = "Sienna Brown", id = 104 },
	{ name = "Saddle Brown", id = 98 },
	{ name = "Moss Brown", id = 100 },
	{ name = "Woodbeech Brown", id = 102 },
	{ name = "Straw Brown", id = 99 },
	{ name = "Sandy Brown", id = 105 },
	{ name = "Bleached Brown", id = 106 },
	{ name = "Schafter Purple", id = 71 },
	{ name = "Spinnaker Purple", id = 72 },
	{ name = "Midnight Purple", id = 142 },
	{ name = "Bright Purple", id = 145 },
	{ name = "Cream", id = 107 },
	{ name = "Ice White", id = 111 },
	{ name = "Frost White", id = 112 },
}
vehicleResprayOptionsMetallic = {	
	{ name = "Black", id = 0 },
	{ name = "Carbon Black", id = 147 },
	{ name = "Graphite", id = 1 },
	{ name = "Anhracite Black", id = 11 },
	{ name = "Black Steel", id = 11 },
	{ name = "Dark Steel", id = 3 },
	{ name = "Silver", id = 4 },
	{ name = "Bluish Silver", id = 5 },
	{ name = "Rolled Steel", id = 6 },
	{ name = "Shadow Silver", id = 7 },
	{ name = "Stone Silver", id = 8 },
	{ name = "Midnight Silver", id = 9 },
	{ name = "Cast Iron Silver", id = 10 },
	{ name = "Red", id = 27 },
	{ name = "Torino Red", id = 28 },
	{ name = "Formula Red", id = 29 },
	{ name = "Lava Red", id = 150 },
	{ name = "Blaze Red", id = 30 },
	{ name = "Grace Red", id = 31 },
	{ name = "Garnet Red", id = 32 },
	{ name = "Sunset Red", id = 33 },
	{ name = "Cabernet Red", id = 34 },
	{ name = "Wine Red", id = 143 },
	{ name = "Candy Red", id = 35 },
	{ name = "Hot Pink", id = 135 },
	{ name = "Pfsiter Pink", id = 137 },
	{ name = "Salmon Pink", id = 136 },
	{ name = "Sunrise Orange", id = 36 },
	{ name = "Orange", id = 38 },
	{ name = "Bright Orange", id = 138 },
	{ name = "Gold", id = 99 },
	{ name = "Bronze", id = 90 },
	{ name = "Yellow", id = 88 },
	{ name = "Race Yellow", id = 89 },
	{ name = "Dew Yellow", id = 91 },
	{ name = "Dark Green", id = 49 },
	{ name = "Racing Green", id = 50 },
	{ name = "Sea Green", id = 51 },
	{ name = "Olive Green", id = 52 },
	{ name = "Bright Green", id = 53 },
	{ name = "Gasoline Green", id = 54 },
	{ name = "Lime Green", id = 92 },
	{ name = "Midnight Blue", id = 141 },
	{ name = "Galaxy Blue", id = 61 },
	{ name = "Dark Blue", id = 62 },
	{ name = "Saxon Blue", id = 63 },
	{ name = "Blue", id = 64 },
	{ name = "Mariner Blue", id = 65 },
	{ name = "Harbor Blue", id = 66 },
	{ name = "Diamond Blue", id = 67 },
	{ name = "Surf Blue", id = 68 },
	{ name = "Nautical Blue", id = 69 },
	{ name = "Racing Blue", id = 73 },
	{ name = "Ultra Blue", id = 70 },
	{ name = "Light Blue", id = 74 },
	{ name = "Chocolate Brown", id = 96 },
	{ name = "Bison Brown", id = 101 },
	{ name = "Creeen Brown", id = 95 },
	{ name = "Feltzer Brown", id = 94 },
	{ name = "Maple Brown", id = 97 },
	{ name = "Beechwood Brown", id = 103 },
	{ name = "Sienna Brown", id = 104 },
	{ name = "Saddle Brown", id = 98 },
	{ name = "Moss Brown", id = 100 },
	{ name = "Woodbeech Brown", id = 102 },
	{ name = "Straw Brown", id = 99 },
	{ name = "Sandy Brown", id = 105 },
	{ name = "Bleached Brown", id = 106 },
	{ name = "Schafter Purple", id = 71 },
	{ name = "Spinnaker Purple", id = 72 },
	{ name = "Midnight Purple", id = 142 },
	{ name = "Bright Purple", id = 145 },
	{ name = "Cream", id = 107 },
	{ name = "Ice White", id = 111 },
	{ name = "Frost White", id = 112 },
}
vehicleResprayOptionsMatte = {
	{ name = "Black", id = 12 },
	{ name = "Gray", id = 13 },
	{ name = "Light Gray", id = 14 },
	{ name = "Ice White", id = 131 },
	{ name = "Blue", id = 83 },
	{ name = "Dark Blue", id = 82 },
	{ name = "Midnight Blue", id = 84 },
	{ name = "Midnight Purple", id = 149 },
	{ name = "Schafter Purple", id = 148 },
	{ name = "Red", id = 39 },
	{ name = "Dark Red", id = 40 },
	{ name = "Orange", id = 41 },
	{ name = "Yellow", id = 42 },
	{ name = "Lime Green", id = 55 },
	{ name = "Green", id = 128 },
	{ name = "Forest Green", id = 151 },
	{ name = "Foliage Green", id = 155 },
	{ name = "Olive Darb", id = 152 },
	{ name = "Dark Earth", id = 153 },
	{ name = "Desert Tan", id = 154 },
}
vehicleResprayOptionsMetals = {
	{ name = "Brushed Steel", id = 117 },
	{ name = "Brushed Black Steel", id = 118 },
	{ name = "Brushed Aluminium", id = 119 },
	{ name = "Pure Gold", id = 158 },
	{ name = "Brushed Gold", id = 159 },
	{ name = "Chrome", id = 120 },
}