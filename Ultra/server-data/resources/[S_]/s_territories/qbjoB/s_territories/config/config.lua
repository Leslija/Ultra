Config = {}
--##FRAMEWORK
Config.Framework = 'ESX' -- 'ESX' or 'QBCore'.
Config.getSharedObject = "esx:getSharedObject" --Change if you use an ESX Custom or ignore it.
--##MENU AND EYE-TARGET
Config.MenuExport = 's_menu' -- For QBCore use qb-menu
Config.MenuKeyboard = 's_keyboard' -- For QBCore use qb-input
Config.TargetType = 's_target' -- For QBCore use s_target
Config.Target = false -- Enable eye-target system
--##TERRITORIES
Config.Blips = { enabled = true, sprite = 362, display = 6, scale = 0.5, colour = 1}
Config.BlipsAlert = { enabled = true, sprite = 9, display = 4, colour = 1, alpha = 200, flashes = true}
Config.Prop = 'prop_box_wood01a' 
Config.MaxTerritories = 2 -- How many territories a job/gang can control
Config.RequiredJob = true
Config.JobsAbleToControl = {"ballas", "families", "bloods"} -- This jobs will be able to control the territories
--##REWARDS
Config.IncreaseValueStash = true -- Increase each territory's vault value by time
Config.IncreaseAmount = 25000
Config.IncreaseTime = 30 -- Minutes (time to increase the value of money in each stash)
--##STASH
Config.PaymentType = 'black_money' -- Choose between 'money', 'black_money' or 'item', the player will receive when taking out of the stash
Config.PaymentItem = 'black_money'
--##SELL DRUGS
Config.SellDrugsTerritories = true -- Enable the sale of drugs in each territory
Config.TimeSell = 10 -- Seconds
Config.PaymentTypeDrugs = 'black_money' -- Choose between 'money', 'black_money' or 'item', the player will receive when sell drugs
Config.PaymentItemDrugs = 'black_money'
Config.Percentage = 0.10  -- Percentage that will go to territory's when players sell drugs

Config.Territories = {
    TERMINA = { 
        label = "Boat",
        selldrug = { item = 'cokebaggy', label = 'Cocaine', quantity = 10, price = 250},
        control = { enabled = true, location = vector3(1012.523, -2871.969, 39.15381), controlTime = 30}},
    DESRT = {
        label = "Hangar",
        selldrug = { item = 'weed_baggy', label = 'Weed', quantity = 10, price = 120},
        control = { enabled = true, location = vector3(2340.752, 3125.196, 48.20215), controlTime = 30}},
    HUMLAB = {
        label = "Human Labs",
        selldrug = { item = 'meth', label = 'Meth', quantity = 50, price = 230},
        control = { enabled = true, location = vector3(3598.906, 3663.798, 33.86304), controlTime = 30}},
    --[[EAST_V = {
        label = "Favela",
        selldrug = { item = 'meth', label = 'Meth', quantity = 10, price = 200},
        control = { enabled = true,  location = vector3(1316.202, -225.4813, 126.0146), controlTime = 1}},--]]
}

function ShowNotification(msg, type) -- If u want u can change here the notifications 
    if type == 'inform' then 
		ESX.ShowNotification(msg)
		--QBCore.Functions.Notify(msg, "primary")
    end
    if type == 'error' then 
        ESX.ShowNotification(msg)
	  	--QBCore.Functions.Notify(msg, "error")
    end
    if type == 'success' then 
        ESX.ShowNotification(msg)
		--QBCore.Functions.Notify(msg, "success")
    end
end

Config.CommandGetZoneName = 'territory'