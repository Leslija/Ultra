local QBCore = exports['qb-core']:GetCoreObject()

Config.StoreLocations = {
    --Add your poly zone box locations and job name for each store and it will add it to the s_target loop above
    { coords = vector3(153.91, -3010.74, 10.7), w = 7.2, d = 1.0, heading = 0, job = "strtunners" }, --- TUNNERS
	{ coords = vector3(-224.27, -1319.63, 30.89), w = 3.2, d = 1.0, heading = 270, job = "bennys" }, --- LIBERTYWALK
   -- { coords = vector3(146.44, -3014.29, 6.97), heading = 0, job = "mechanic" },
}
-- Add the store locations
Citizen.CreateThread(function()
	for k, v in pairs(Config.StoreLocations) do
		exports['s_target']:AddBoxZone("MechStore"..k, v.coords, v.w, v.d, { name="MechStore"..k, heading = v.heading, debugPoly=false, minZ=v.coords.z-1.0, maxZ=v.coords.z+1.0 }, 
			{ options = { { event = "jim-mechanic:client:Store:Menu", icon = "fas fa-cogs", label = "Loja Mecânicos", job = v.job }, },
			  distance = 2.0
		})
	end
end)

-- Menu to pick the store
RegisterNetEvent('jim-mechanic:client:Store:Menu', function(data)
    exports['qb-menu']:openMenu({
        { header = "Ferramentas", txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 1, job = data.job } } },
        { header = "Items Perfomance", txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 2, job = data.job } } },
        { header = "Items Cosméticos", txt = "", params = { event = "jim-mechanic:client:Store", args = { id = 3, job = data.job } } },
    })
end)

-- Open the selected store
RegisterNetEvent('jim-mechanic:client:Store', function(data)
	if data.id == 1 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.ToolItems) 
	elseif data.id == 2 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.PerformItems)
	elseif data.id == 3 then TriggerServerEvent("inventory:server:OpenInventory", "shop", data.job, Config.StoreItems) end
end)

Config.ToolItems = {
    label = "Loja Ferramentas",  slots = 8,
    items = {
	[1] = { name = "mechanic_tools", price = 0, amount = 10, info = {}, type = "item", slot = 1, },
	[2] = { name = "toolbox", price = 0, amount = 10, info = {}, type = "item", slot = 2, },
	[3] = { name = "ducttape", price = 50, amount = 100, info = {}, type = "item", slot = 3, },
	[4] = { name = "paintcan", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
	[5] = { name = "tint_supplies", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
	[6] = { name = "underglow_controller", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
	[7] = { name = "cleaningkit", price = 25, amount = 100, info = {}, type = "item", slot = 7, }, 
	[8] = { name = "repairkit", price = 100, amount = 100, info = {}, type = "item", slot = 8, }, 
	}
}

Config.PerformItems = {
    label = "Loja Perfomance",  slots = 12,
    items = {
	[1] = { name = "turbo", price = 2500, amount = 50, info = {}, type = "item", slot = 1, }, 
	[2] = { name = "v8engine",	price = 7500, amount = 50, info = {}, type = "item", slot = 2, }, 
	[3] = { name = "shonen",	price = 5000, amount = 50, info = {}, type = "item",	slot = 3, },
	[4] = { name = "race_transmission", price = 2500, amount = 50, info = {}, type = "item", slot = 4, },		
	[5] = { name = "race_brakes", price = 1500, amount = 50, info = {}, type = "item", slot = 5, },
	[6] = { name = "car_armor", price = 1000, amount = 50, info = {}, type = "item", slot = 6, },
	[7] = { name = "suspension", price = 1000, amount = 50, info = {}, type = "item", slot = 7, },
	[8] = { name = "suspension2", price = 1500, amount = 50, info = {}, type = "item", slot = 8, },
	[9] = { name = "bprooftires", price = 100, amount = 50, info = {}, type = "item", slot = 9, },
	[10] = { name = "drifttires", price = 100, amount = 50, info = {}, type = "item", slot = 10, },
	[11] = { name = "nos", price = 5000, amount = 50, info = {}, type = "item", slot = 11, }, 
	[12] = { name = "tunerlaptop", price = 50000, amount = 50, info = {}, type = "item", slot = 12, },  }
}

Config.StoreItems = {
    label = "Loja Cosméticos",  slots = 15,
    items = {
	[1] = { name = "hood", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
	[2] = { name = "roof", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
	[3] = { name = "spoiler", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
	[4] = { name = "bumper", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
	[5] = { name = "skirts", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
	[6] = { name = "exhaust", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
	[7] = { name = "seat", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
	[8] = { name = "livery", price = 0, amount = 50, info = {}, type = "item", slot = 8, },
	[9] = { name = "tires", price = 0, amount = 50, info = {}, type = "item", slot = 9, },
	[10] = { name = "horn", price = 0, amount = 50, info = {}, type = "item", slot = 10, },
	[11] = { name = "internals", price = 0, amount = 50, info = {}, type = "item", slot = 11, },
	[12] = { name = "externals", price = 0, amount = 50, info = {}, type = "item", slot = 12, },
	[13] = { name = "customplate", price = 0, amount = 50, info = {}, type = "item", slot = 13, },
	[14] = { name = "headlights", price = 0, amount = 50, info = {}, type = "item", slot = 14, },
	[15] = { name = "rims", price = 0, amount = 100, info = {}, type = "item", slot = 15, }, }
}