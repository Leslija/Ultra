local QBCore = exports['qb-core']:GetCoreObject()

props = {}
Targets = {}
peds = {}

CreateThread(function()
	--Hide the mineshaft doors
	CreateModelHide(vector3(-596.04, 2089.01, 131.41), 10.5, -1241212535, true)
	-- Add Map Blips
	if Config.Blips then
		for k, v in pairs(Config.Locations) do
			if Config.Locations[k].blipTrue then
				local blip = AddBlipForCoord(v.location)
				SetBlipAsShortRange(blip, true)
				SetBlipSprite(blip, v.spr)
				SetBlipColour(blip, v.col)
				SetBlipScale(blip, 0.7)
				SetBlipDisplay(blip, 6)
				BeginTextCommandSetBlipName('STRING')
				if Config.BlipNamer then AddTextComponentString(Config.Locations[k].name)
				else AddTextComponentString(tostring(Loc[Config.Lan].info["blip_mining"])) end
				EndTextCommandSetBlipName(blip)
			end
		end
	end
	if Config.PropSpawn then
		--Quickly add outside lighting
		RequestModel(`prop_worklight_03a`)
		while not HasModelLoaded(`prop_worklight_03a`) do Citizen.Wait(1) end
		props[#props+1] = CreateObject(`prop_worklight_03a`,-593.29, 2093.22, 131.7-1.05,false,false,false)
		SetEntityHeading(props[#props],260.0)
		FreezeEntityPosition(props[#props], true)
		
		props[#props+1] = CreateObject(`prop_worklight_03a`,-604.55, 2089.74, 131.15-1.05,false,false,false)
		SetEntityHeading(props[#props],80.0)
		FreezeEntityPosition(props[#props], true)

		for k,v in pairs(Config.OrePositions) do
			props[#props+1] = CreateObject(`cs_x_rubweec`,v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
			SetEntityHeading(props[#props],90.0)
			FreezeEntityPosition(props[#props], true)           
		end
		for k,v in pairs(Config.MineLights) do
			props[#props+1] = CreateObject(`xs_prop_arena_lights_ceiling_l_c`,v.coords.x, v.coords.y, v.coords.z+1.03,false,false,false)
			FreezeEntityPosition(props[#props], true)           
		end
		--Jewel Cutting Bench
		props[#props+1] =  CreateObject(`gr_prop_gr_bench_04b`,Config.Locations['JewelCut'].location,false,false,false)
		SetEntityHeading(props[#props], Config.Locations['JewelCut'].location[4])
		FreezeEntityPosition(props[#props], true)

		--Stone Cracking Bench
		props[#props+1] = CreateObject(`prop_tool_bench02`, Config.Locations['Cracking'].location, false, false, false)
		SetEntityHeading(props[#props], Config.Locations['Cracking'].location[4])
		FreezeEntityPosition(props[#props], true)
		--Stone Prop for bench
		props[#props+1] = CreateObject(`cs_x_rubweec`,Config.Locations['Cracking'].location.x, Config.Locations['Cracking'].location.y, Config.Locations['Cracking'].location.z+0.83, false, false, false)
		SetEntityHeading(props[#props], Config.Locations['Cracking'].location[4]+90.0)
		FreezeEntityPosition(props[#props], true)
		
		props[#props+1] = CreateObject(`prop_worklight_03a`,Config.Locations['Cracking'].location.x-1.4, Config.Locations['Cracking'].location.y+1.08, Config.Locations['Cracking'].location.z, false, false, false)
		SetEntityHeading(props[#props], Config.Locations['Cracking'].location[4]-40)
		FreezeEntityPosition(props[#props], true)
	end
	if Config.Pedspawn then
		for k, v in pairs(Config.PedList) do
			RequestModel(v.model) while not HasModelLoaded(v.model) do Wait(0) end
			peds[#peds+1] = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords[4], false, false)
			SetEntityInvincible(peds[#peds], true)
			SetBlockingOfNonTemporaryEvents(peds[#peds], true)
			FreezeEntityPosition(peds[#peds], true)
			TaskStartScenarioInPlace(peds[#peds], v.scenario, 0, true)
			if Config.Debug then print("Ped Created") end
		end
	end
	Targets["MineShaft"] =
	exports['s_target']:AddCircleZone("MineShaft", vector3(Config.Locations['Mine'].location.x, Config.Locations['Mine'].location.y, Config.Locations['Mine'].location.z), 2.0, { name="MineShaft", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:openShop", icon = "fas fa-certificate", label = Loc[Config.Lan].info["browse_store"], }, }, 
		distance = 2.0 })
	Targets["Quarry"] =
	exports['s_target']:AddCircleZone("Quarry", vector3(Config.Locations['Quarry'].location.x, Config.Locations['Quarry'].location.y, Config.Locations['Quarry'].location.z), 2.0, { name="Quarry", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:openShop", icon = "fas fa-certificate", label = Loc[Config.Lan].info["browse_store"], }, },
		distance = 2.0
	})
	--Smelter to turn stone into ore
	Targets["Smelter"] =
	exports['s_target']:AddCircleZone("Smelter", vector3(Config.Locations['Smelter'].location.x, Config.Locations['Smelter'].location.y, Config.Locations['Smelter'].location.z), 3.0, { name="Smelter", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:CraftMenu", icon = "fas fa-certificate", label = Loc[Config.Lan].info["use_smelter"], craftable = Crafting.SmeltMenu }, },
		distance = 10.0
	})
	--Ore Buyer
	Targets["Buyer"] =
	exports['s_target']:AddCircleZone("Buyer", vector3(Config.Locations['Buyer'].location.x, Config.Locations['Buyer'].location.y, Config.Locations['Buyer'].location.z), 2.0, { name="Buyer", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:SellOre", icon = "fas fa-certificate", label = Loc[Config.Lan].info["sell_ores"], }, },
		distance = 2.0
	})
	--Jewel Cutting Bench
	Targets["JewelCut"] =
	exports['s_target']:AddCircleZone("JewelCut", vector3(Config.Locations['JewelCut'].location.x, Config.Locations['JewelCut'].location.y, Config.Locations['JewelCut'].location.z), 2.0,{ name="JewelCut", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:JewelCut", icon = "fas fa-certificate", label = Loc[Config.Lan].info["jewelcut"], }, },
		distance = 2.0
	})
	--Jewel Buyer
	Targets["JewelBuyer"] =
	exports['s_target']:AddCircleZone("JewelBuyer",vector3(Config.Locations['Buyer2'].location.x, Config.Locations['Buyer2'].location.y, Config.Locations['Buyer2'].location.z), 2.0, { name="JewelBuyer", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:JewelSell", icon = "fas fa-certificate", label = Loc[Config.Lan].info["jewelbuyer"], },	},
		distance = 2.0
	})
	--Cracking Bench
	Targets["CrackingBench"] =
	exports['s_target']:AddCircleZone("CrackingBench", vector3(Config.Locations['Cracking'].location.x, Config.Locations['Cracking'].location.y, Config.Locations['Cracking'].location.z), 2.0, { name="CrackingBench", debugPoly=Config.Debug, useZ=true, }, 
	{ options = { { event = "s_mineiros:CrackStart", icon = "fas fa-certificate", label = Loc[Config.Lan].info["crackingbench"], },	},
		distance = 2.0
	})
	for k,v in pairs(Config.OrePositions) do
		Targets["ore"..k] =
		exports['s_target']:AddCircleZone("ore"..k, v.coords, 2.0, { name="ore"..k, debugPoly=Config.Debug, useZ=true, }, 
		{ options = { { event = "s_mineiros:MineOre", icon = "fas fa-certificate", label = Loc[Config.Lan].info["mine_ore"], },	},
			distance = 2.5
		})
	end
end)

--------------------------------------------------------
--Mining Store Opening
RegisterNetEvent('s_mineiros:openShop', function() TriggerServerEvent("inventory:server:OpenInventory", "shop", "mine", Config.Items) end)
------------------------------------------------------------
-- Mine Ore Command / Animations

function loadAnimDict(dict) while not HasAnimDictLoaded(dict) do RequestAnimDict(dict) Wait(5) end end 

RegisterNetEvent('s_mineiros:MineOre', function ()
	local p = promise.new()	QBCore.Functions.TriggerCallback("QBCore:HasItem", function(cb) p:resolve(cb) end, "drill")
	if Citizen.Await(p) then 
		RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
		RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
		RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
		soundId = GetSoundId()
		local pos = GetEntityCoords(PlayerPedId())
		loadAnimDict("anim@heists@fleeca_bank@drilling")
		TaskPlayAnim(PlayerPedId(), 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle' , 3.0, 3.0, -1, 1, 0, false, false, false)
		local pos = GetEntityCoords(PlayerPedId(), true)
		local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(DrillObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
		PlaySoundFromEntity(soundId, "Drill", DrillObject, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
		QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["drilling_ore"], math.random(10000,15000), false, true, {
			disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
			StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
			SetEntityAsMissionEntity(DrillObject)--nessesary for gta to even trigger DetachEntity
			StopSound(soundId)
			Wait(5)
			DetachEntity(DrillObject, true, true)
			Wait(5)
			DeleteObject(DrillObject)
			TriggerServerEvent('s_mineiros:MineReward')
			IsDrilling = false
		end, function() -- Cancel
			StopAnimTask(PlayerPedId(), "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
			StopSound(soundId)
			DetachEntity(DrillObject, true, true)
			Wait(5)
			DeleteObject(DrillObject)
			IsDrilling = false
		end, "drill")
	else
		TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["no_drill"], 'error')
	end
end)

------------------------------------------------------------

-- Cracking Command / Animations
-- Command Starts here where it calls to being the stone inv checking
RegisterNetEvent('s_mineiros:CrackStart', function ()
	local p = promise.new()	QBCore.Functions.TriggerCallback("QBCore:HasItem", function(cb) p:resolve(cb) end, "stone")
	if Citizen.Await(p) then 
		local pos = GetEntityCoords(PlayerPedId())
		loadAnimDict('amb@prop_human_parking_meter@male@idle_a')
		TaskPlayAnim(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a' , 3.0, 3.0, -1, 1, 0, false, false, false)
		QBCore.Functions.Progressbar("open_locker_drill", Loc[Config.Lan].info["cracking_stone"], math.random(10000,15000), false, true, {
			disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
			StopAnimTask(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
			TriggerServerEvent('s_mineiros:CrackReward')
			IsDrilling = false
		end, function() -- Cancel
			StopAnimTask(PlayerPedId(), 'amb@prop_human_parking_meter@male@idle_a', 'idle_a', 1.0)
			IsDrilling = false
		end)
	else 
		TriggerEvent('QBCore:Notify', Loc[Config.Lan].info["no_stone"], 'error')
	end
end)

RegisterNetEvent('s_mineiros:MakeItem', function(data)
	if data.ret then 
		local p = promise.new() QBCore.Functions.TriggerCallback("s_mineiros:Cutting:Check:Tools",function(cb) p:resolve(cb) end)
		if Citizen.Await(p) == false then TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["no_drill_bit"], 'error')	TriggerEvent('s_mineiros:JewelCut') return end
	end
	for k, v in pairs(data.craftable[data.tablenumber]) do
		if data.item == k then
			Wait(0) local p = promise.new()
			QBCore.Functions.TriggerCallback('s_mineiros:Check', function(cb) p:resolve(cb) end, data.item, data.tablenumber, data.craftable)
			if not Citizen.Await(p) then 
				TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["no_ingredients"], 'error')
				TriggerEvent('s_mineiros:CraftMenu', data)
			else itemProgress(data) end		
		end
	end
end)

function itemProgress(data)
	if data.craftable then
		if not data.ret then bartext = Loc[Config.Lan].info["smelting"]..QBCore.Shared.Items[data.item].label
		else bartext = Loc[Config.Lan].info["cutting"]..QBCore.Shared.Items[data.item].label end
		bartime = 7000
		animDictNow = "amb@prop_human_parking_meter@male@idle_a"
		animNow = "idle_a"
	end
	QBCore.Functions.Progressbar('making_food', bartext, bartime, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
	{ animDict = animDictNow, anim = animNow, flags = 8, }, {}, {}, function()  
		TriggerServerEvent('s_mineiros:GetItem', data)
		StopAnimTask(PlayerPedId(), animDictNow, animNow, 1.0)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', Loc[Config.Lan].error["error.cancelled"], 'error')
	end, data.item)
end
------------------------------------------------------------
--These also lead to the actual selling commands

--Selling animations are simply a pass item to seller animation
--Sell Ore Animation
RegisterNetEvent('s_mineiros:SellAnim', function(data)
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('s_mineiros:Selling', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (peds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
		ppRot = GetEntityRotation(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")
			SetEntityRotation(v, 0,0,ppRot.z,0,0,false)		
			break
		end
	end
	TriggerEvent('s_mineiros:SellOre')
end)

--Sell Anim small Test
RegisterNetEvent('s_mineiros:SellAnim:Jewel', function(data)
	local pid = PlayerPedId()
	loadAnimDict("mp_common")
	TriggerServerEvent('s_mineiros:SellJewel', data) -- Had to slip in the sell command during the animation command
	for k,v in pairs (peds) do
        pCoords = GetEntityCoords(PlayerPedId())
        ppCoords = GetEntityCoords(v)
		ppRot = GetEntityRotation(v)
        dist = #(pCoords - ppCoords)
        if dist < 2 then 
			TaskPlayAnim(pid, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            TaskPlayAnim(v, "mp_common", "givetake2_a", 100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
            Wait(1500)
            StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
            StopAnimTask(v, "mp_common", "givetake2_a", 1.0)
            RemoveAnimDict("mp_common")
			SetEntityRotation(v, 0,0,ppRot.z,0,0,false)
			break
		end
	end	
	if string.find(data, "ring") then TriggerEvent('s_mineiros:JewelSell:Rings')
	elseif string.find(data, "chain") or string.find(data, "necklace") then TriggerEvent('s_mineiros:JewelSell:Necklace')
	elseif string.find(data, "emerald") then TriggerEvent('s_mineiros:JewelSell:Emerald')
	elseif string.find(data, "ruby") then TriggerEvent('s_mineiros:JewelSell:Ruby')
	elseif string.find(data, "diamond") then TriggerEvent('s_mineiros:JewelSell:Diamond')
	elseif string.find(data, "sapphire") then TriggerEvent('s_mineiros:JewelSell:Sapphire')
	else TriggerEvent('s_mineiros:JewelSell') end
end)

------------------------------------------------------------
--Context Menus
--Selling Ore
RegisterNetEvent('s_mineiros:SellOre', function()
	exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["header_oresell"], txt = Loc[Config.Lan].info["oresell_txt"], isMenuHeader = true },
		{ header = "", txt = Loc[Config.Lan].info["close"], params = { event = "s_mineiros:CraftMenu:Close" } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["copperore"].image.." width=30px>"..Loc[Config.Lan].info["copper_ore"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['copperore'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim", args = 'copperore' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["ironore"].image.." width=30px>"..Loc[Config.Lan].info["iron_ore"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['ironore'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim", args = 'ironore' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["goldore"].image.." width=30px>"..Loc[Config.Lan].info["gold_ore"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['goldore'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim", args = 'goldore' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["carbon"].image.." width=30px>"..Loc[Config.Lan].info["carbon"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['carbon'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim", args = 'carbon' } }, 
	})
end)
------------------------
--Jewel Selling Main Menu
RegisterNetEvent('s_mineiros:JewelSell', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["close"], params = { event = "s_mineiros:CraftMenu:Close" } },
		{ header = Loc[Config.Lan].info["emeralds"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Emerald", } },
		{ header = Loc[Config.Lan].info["rubys"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Ruby", } },
		{ header = Loc[Config.Lan].info["diamonds"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Diamond", } },
		{ header = Loc[Config.Lan].info["sapphires"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Sapphire", } },
		{ header = Loc[Config.Lan].info["rings"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Rings", } },
		{ header = Loc[Config.Lan].info["necklaces"], txt = Loc[Config.Lan].info["see_options"], params = { event = "s_mineiros:JewelSell:Necklace", } },
	})
end)
--Jewel Selling - Emerald Menu
RegisterNetEvent('s_mineiros:JewelSell:Emerald', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["emerald"].image.." width=30px>"..Loc[Config.Lan].info["emeralds"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['emerald'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'emerald' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["uncut_emerald"].image.." width=30px>"..Loc[Config.Lan].info["uncut_emerald"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['uncut_emerald'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'uncut_emerald' } }, 
	})
end)
--Jewel Selling - Ruby Menu
RegisterNetEvent('s_mineiros:JewelSell:Ruby', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["ruby"].image.." width=30px>"..Loc[Config.Lan].info["rubys"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['ruby'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'ruby' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["uncut_ruby"].image.." width=30px>"..Loc[Config.Lan].info["uncut_ruby"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['uncut_ruby'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'uncut_ruby' } },
	})
end)
--Jewel Selling - Diamonds Menu
RegisterNetEvent('s_mineiros:JewelSell:Diamond', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["diamond"].image.." width=30px>"..Loc[Config.Lan].info["diamonds"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['diamond'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'diamond' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["uncut_diamond"].image.." width=30px>"..Loc[Config.Lan].info["uncut_diamond"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['uncut_diamond'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'uncut_diamond' } },
	})
end)
--Jewel Selling - Sapphire Menu
RegisterNetEvent('s_mineiros:JewelSell:Sapphire', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["sapphire"].image.." width=30px>"..Loc[Config.Lan].info["sapphires"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['sapphire'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'sapphire' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["uncut_sapphire"].image.." width=30px>"..Loc[Config.Lan].info["uncut_sapphire"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['uncut_sapphire'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'uncut_sapphire' } },
	})
end)

--Jewel Selling - Jewellry Menu
RegisterNetEvent('s_mineiros:JewelSell:Rings', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["gold_ring"].image.." width=30px>"..Loc[Config.Lan].info["gold_rings"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['gold_ring'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'gold_ring' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["diamond_ring"].image.." width=30px>"..Loc[Config.Lan].info["diamond_rings"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['diamond_ring'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'diamond_ring'} },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["emerald_ring"].image.." width=30px>"..Loc[Config.Lan].info["emerald_rings"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['emerald_ring'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'emerald_ring' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["ruby_ring"].image.." width=30px>"..Loc[Config.Lan].info["ruby_rings"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['ruby_ring'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'ruby_ring' } },	
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["sapphire_ring"].image.." width=30px>"..Loc[Config.Lan].info["sapphire_rings"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['sapphire_ring'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'sapphire_ring' } },
	})
end)
--Jewel Selling - Jewellery Menu
RegisterNetEvent('s_mineiros:JewelSell:Necklace', function()
    exports['qb-menu']:openMenu({
		{ header = Loc[Config.Lan].info["jewel_buyer"], txt = Loc[Config.Lan].info["sell_jewel"], isMenuHeader = true }, 
		{ header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelSell", } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["goldchain"].image.." width=30px>"..Loc[Config.Lan].info["gold_chains"],	txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['goldchain'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'goldchain' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["10kgoldchain"].image.." width=30px>"..Loc[Config.Lan].info["10kgold_chain"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['10kgoldchain'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = '10kgoldchain' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["diamond_necklace"].image.." width=30px>"..Loc[Config.Lan].info["diamond_neck"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['diamond_necklace'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'diamond_necklace' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["emerald_necklace"].image.." width=30px>"..Loc[Config.Lan].info["emerald_neck"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['emerald_necklace'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'emerald_necklace' } },
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["ruby_necklace"].image.." width=30px>"..Loc[Config.Lan].info["ruby_neck"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['ruby_necklace'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'ruby_necklace' } },	
		{ header = "<img src=nui://"..Config.img..QBCore.Shared.Items["sapphire_necklace"].image.." width=30px>"..Loc[Config.Lan].info["sapphire_neck"], txt = Loc[Config.Lan].info["sell_all"].." "..Config.SellItems['sapphire_necklace'].." "..Loc[Config.Lan].info["sell_each"], params = { event = "s_mineiros:SellAnim:Jewel", args = 'sapphire_necklace' } },
	})
end)
------------------------

RegisterNetEvent('s_mineiros:CraftMenu:Close', function() exports['qb-menu']:closeMenu() end)

--Cutting Jewels
RegisterNetEvent('s_mineiros:JewelCut', function()
    exports['qb-menu']:openMenu({
	{ header = Loc[Config.Lan].info["craft_bench"], txt = Loc[Config.Lan].info["req_drill_bit"], isMenuHeader = true },
	{ header = "", txt = Loc[Config.Lan].info["close"], params = { event = "s_mineiros:CraftMenu:Close" } },
	{ header = Loc[Config.Lan].info["gem_cut"],	txt = Loc[Config.Lan].info["gem_cut_section"], params = { event = "s_mineiros:CraftMenu", args = { craftable = Crafting.GemCut, ret = true  } } },
	{ header = Loc[Config.Lan].info["make_ring"], txt = Loc[Config.Lan].info["ring_craft_section"], params = { event = "s_mineiros:CraftMenu", args = { craftable = Crafting.RingCut, ret = true  } } },
	{ header = Loc[Config.Lan].info["make_neck"], txt = Loc[Config.Lan].info["neck_craft_section"], params = { event = "s_mineiros:CraftMenu", args = { craftable = Crafting.NeckCut, ret = true } } },
	})
end)

RegisterNetEvent('s_mineiros:CraftMenu', function(data)
	local CraftMenu = {}
	if data.ret then 
		CraftMenu[#CraftMenu + 1] = { header = Loc[Config.Lan].info["craft_bench"], txt = Loc[Config.Lan].info["req_drill_bit"], isMenuHeader = true }
		CraftMenu[#CraftMenu + 1] = { header = "", txt = Loc[Config.Lan].info["return"], params = { event = "s_mineiros:JewelCut" } }
	else 
		CraftMenu[#CraftMenu + 1] = { header = Loc[Config.Lan].info["smelter"], txt = Loc[Config.Lan].info["smelt_ores"], isMenuHeader = true }
		CraftMenu[#CraftMenu + 1] = { header = "", txt = Loc[Config.Lan].info["close"], params = { event = "s_mineiros:CraftMenu:Close" } } 
	end
		for i = 1, #data.craftable do
			for k, v in pairs(data.craftable[i]) do
				if k ~= "amount" then
					local text = ""
					if data.craftable[i]["amount"] then amount = " x"..data.craftable[i]["amount"] else amount = "" end
					setheader = QBCore.Shared.Items[k].label..tostring(amount)
					Wait(0) local p = promise.new()
					QBCore.Functions.TriggerCallback('s_mineiros:Check', function(cb) p:resolve(cb) end, tostring(k), i, data.craftable) --check = Citizen.Await(p)
					if Citizen.Await(p) then setheader = setheader.." ✅" end p = nil check = nil
					for l, b in pairs(data.craftable[i][tostring(k)]) do
						if b == 1 then number = "" else number = " x"..b end
						text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
						settext = text
					end
					CraftMenu[#CraftMenu + 1] = { header = "<img src=nui://"..Config.img..QBCore.Shared.Items[k].image.." width=35px> "..setheader, txt = settext, params = { event = "s_mineiros:MakeItem", args = { item = k, tablenumber = i, craftable = data.craftable, ret = data.ret } } }
					settext, amount, setheader = nil
				end
			end
		end
	exports['qb-menu']:openMenu(CraftMenu)
end)

AddEventHandler('onResourceStop', function(resource) if resource ~= GetCurrentResourceName() then return end
	for k, v in pairs(Targets) do exports['s_target']:RemoveZone(k) end		
	for k, v in pairs(peds) do DeletePed(peds[k]) end
	for i = 1, #props do DeleteObject(props[i]) end
end)
