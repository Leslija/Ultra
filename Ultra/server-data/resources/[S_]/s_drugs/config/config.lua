Config = {}

--#FRAMEWORK
Config.Framework = 'QBCore' -- 'ESX' or 'QBCore'.
Config.getSharedObject = "esx:getSharedObject" --Change if you use an ESX Custom or ignore it.
--#EYE-TARGET
Config.Target = false -- Set this to true if u want to use s_target or qtarget
Config.TargetType = 's_target' -- choose between s_target/qtarget/s_target
--#SELLING CONFIG
Config.SellRequiredJob = true -- set it to true to block selling drugs to specific jobs
Config.SellJobRoles = { "ballas", "families", "bloods"} -- Add here the jobs u want to wash money
Config.PaymentType = 1 -- [0=money]; [1=black_money]; [2=item]
Config.PaymentItem = 'black_money' -- If u choose payment type item, here u put the item that will be the reward

--#GERAL CONFIGS
Config['Drugs'] = {
    ['cocaine'] = { 
        { coords = vector3(3268.642, 5224.457, 18.49597)}, -- Coords of the field u can change or add more below
		{ coords = vector3(3258.409, 5214.382, 20.41687)}, -- Coords of the field u can change or add more below
		{ coords = vector3(3275.341, 5206.246, 18.68127)}, -- Coords of the field u can change or add more below
		{ coords = vector3(3294.752, 5211.64, 17.18164)}, -- Coords of the field u can change or add more below
		{ coords = vector3(3285.956, 5223.666, 16.6593)}, -- Coords of the field u can change or add more below
    },
	['processcocaine'] = vector3(3309.824, 5190.178, 19.71142),
	['cocainevalues'] = { 
		['pickup'] = 3, -- Amount to pick up each time
		['processneeded'] = 3, -- Amount that will be removed to process one time
		['processreward'] = 1, -- Reward of the process 
		['cutneeded'] = 1, -- Amount that will be removed to cut one time
		['cutreward'] = 3, -- Reward of the cut
		['sellquantity'] = 10, -- Amount that will be selled each time
		['price1g'] = 350, -- Value of 1 bag selling
	},
	['weed'] = { 
		{ coords = vector3(2197.055, 5584.879, 53.62781)},
		{ coords = vector3(2192.439, 5576.4, 53.79639)},
		{ coords = vector3(2194.075, 5565.336, 53.74585)},
		{ coords = vector3(2185.134, 5561.183, 53.62781)},
		{ coords = vector3(2177.881, 5570.703, 53.86377)},
	},
	['processweed'] = vector3(2220.208, 5614.396, 54.72401),
	['weedvalues'] = { 
		['pickup'] = 3,
		['processneeded'] = 3,
		['processreward'] = 1,
		['cutneeded'] = 1,
		['cutreward'] = 3, 
		['sellquantity'] = 20,
		['price1g'] = 300,
	},
	['meth'] = { 
		{ coords = vector3(1405.187, 3628.286, 34.89087)},
		{ coords = vector3(1394.018, 3629.446, 34.90771)},
		{ coords = vector3(1382.703, 3623.815, 34.89087)},
		{ coords = vector3(1380.211, 3615.323, 34.89087)},
		{ coords = vector3(1369.648, 3613.292, 34.89087)},
	},
	['processmeth'] = vector3(1388.801, 3616.286, 38.92101),
	['methvalues'] = { 
		['pickup'] = 3,
		['processneeded'] = 3,
		['processreward'] = 1,
		['cutneeded'] = 1,
		['cutreward'] = 3, 
		['sellquantity'] = 10,
		['price1g'] = 370,
	},
	['selldrugs'] = vector3(60.28282, 3689.756, 39.83429),
	['bagsneeded'] = 3, -- Bags needed to cut
	['PedsModels'] = {
		['ProcessCocaine'] = 'ig_chef2',
		['ProcessWeed'] = 'ig_chef',
		['ProcessMeth'] = 'a_f_y_beach_01',
		['SellDrug'] = 'u_m_m_streetart_01',
	},
	['Peds'] = { -- Needs to be the same as above
		{ coords = vector3(3309.89, 5189.974, 18.70911), heading = 67.15556, model = 'ig_chef2'}, -- PROCESS COCAINE
		{ coords = vector3(2220.751, 5614.588, 53.71953), heading = 109.363, model = 'ig_chef'}, -- PROCESS WEED
		{ coords = vector3(1388.801, 3616.286, 37.92101), heading = 23.66672, model = 'a_f_y_beach_01'}, -- PROCESS METH
		{ coords = vector3(60.28282, 3689.756, 38.83429), heading = 240.6707, model = 'u_m_m_streetart_01'}, -- SELL DRUGS
	},
}

-- WASH DIRTYMONEY
Config.WashMoneyAtive = true -- set it to false if u dont want to use our system of washing money.
Config.WashRequiredJob = true -- set it to true to block wash dirty money to specific jobs
Config.WashJobRoles = { "vanilla", "bahamas"} -- Add here the jobs u want to wash money
Config.BlackMoneyType = 1 -- 0 = Account Type , 1 = Item
Config.BlackMoneyItem = 'black_money' -- If u use QBCore or choosed blackmoney = 1 put here the name of your dirty cash item
Config['WashMoney'] = {
	['amount'] = 50000, -- amount of money will wash each time
	['time'] = 30, -- time to wash the amount of money each time in SECONDS
	['percentage'] = 1, -- this is the percentage that the player will get after finishing washing dirty money. 1 = 100% 
	['ped'] = { coords = vector3(-3108.916, 751.8737, 23.70186), heading = 154.5323, model = 'a_m_m_hasjew_01'},
}


Config['Items'] = {
	-- Here u can change the items
	-- GLOBAL
	['drugscale'] = 'drug_scales',
	['cutkit'] = 'drug_cuttingkit',
	['emptybag'] = 'empty_weed_bag',
	-- COCAINE
    ['pickupcocaine'] = 'cocaine',
	['processcocaine'] = 'coke_brick',
	['cutcocaine'] = 'cokebaggy',
	-- WEED
	['pickupweed'] = 'weedleaf',
	['processweed'] = 'weed_brick',
	['cutweed'] = 'weed_baggy',
	-- METH
	['pickupmeth'] = 'chemicals',
	['processmeth'] = 'meth_1oz',
	['cutmeth'] = 'meth',
}

function ShowNotification(msg, type) -- If u want u can change here the notifications 
    if type == 'inform' then 
		ESX.ShowNotification(msg)
		--QBCore.Functions.Notify(msg)
    end
    if type == 'error' then 
        ESX.ShowNotification(msg)
	  	--QBCore.Functions.Notify(msg)
    end
    if type == 'success' then 
        ESX.ShowNotification(msg)
		--QBCore.Functions.Notify(msg)
    end
end


Translations = {
	-- NOTIFICATIONS
	['donthave'] = 'You dont have what is necessary!',
	['canceled'] = 'Canceled',
	['permissions'] = 'You dont have permission!',
	-- 3D DRAW TEXT
    ['catchcocaine'] = '[E] Cocaine Leaf',
	['catchweed'] = '[E] Weed Leaf',
	['catchmeth'] = '[E] Chemicals',
	['processcocaine'] = '[E] Process Cocaine',
	['processweed'] = '[E] Process Weed',
	['processmeth'] = '[E] Process Meth',
	['selldrugs'] = '[E] Sell Drugs',
	['washmoney'] = '[E] Wash Money',
	-- PROGRESSBARS
	['pcocaine'] = 'Cocaine Leaves...',
	['pweed'] = 'Weed Leaves..',
	['pmeth'] = 'Chemicals...',
	['ppcocaine'] = 'Processing Cocaine...',
	['ppweed'] = 'Processing Weed...',
	['ppmeth'] = 'Processing Chemicals...',
	['ppcutcocaine'] = 'Cutting Cocaine...',
	['ppcutweed'] = 'Cutting Weed...',
	['ppcutmeth'] = 'Cutting Meth...',
	['sellcocaine'] = 'Selling Cocaine',
	['sellweed'] = 'Selling Weed',
	['sellmeth'] = 'Selling Meth',
	['washingmoney'] = 'Washing Dirty Money...',
	-- MENUS
	['empty_bags'] = 'Empty Bags',
	['drug_scale'] = 'Drug Scale',
	['processedcocaine'] = 'Cocaine Brick',
	['processedmeth'] = 'Meth 1oz',
	['processedweed'] = 'Weed Brick',
	['headerprocesscocaine'] = '💉 Process Cocaine 💉',
	['textprocesscocaine'] = 'Process Cocaine into a brick',
	['headerprocessweed'] = '💉 Process Weed 💉',
	['textprocessweed'] = 'Process Weed into a brick',
	['headerprocessmeth'] = '💉 Process Meth 💉',
	['textprocessmeth'] = 'Process Chemicals into meth',
	['cutmenu'] = '✂️ Cut Kit ✂️',
	['headercutcocaine'] = 'Cocaine',
	['textcutcocaine'] = 'Cut Cocaine and put on bags',
	['headercutweed'] = 'Weed',
	['textcutweed'] = 'Cut Weed and put on bags',
	['headercutmeth'] = 'Meth',
	['textcutmeth'] = 'Cut Meth and put on bags',
	['selldrugsmenu'] = '💸 Sell Drugs 💸',
	['headersellcocaine'] = 'Cocaine',
	['headersellweed'] = 'Weed',
	['headersellmeth'] = 'Meth',
	['headerwashmoney'] = '🧼 Wash Money 🧼',
	['washmoney2'] = 'Start some laundry!',
	-- TARGETS
	['processcocainelabel'] = 'Process Cocaine',
	['processweedlabel'] = 'Process Weed',
	['processmethlabel'] = 'Process Meth',
	['selldrugslabel'] = 'Sell Drugs',
	['washmoneylabel'] = 'Wash Money',

}



