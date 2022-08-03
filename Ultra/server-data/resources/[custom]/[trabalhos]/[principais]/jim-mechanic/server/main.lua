
local QBCore = exports['qb-core']:GetCoreObject()


--========================================================== Engines

RegisterNetEvent('jim-mechanic:server:removeSuspension', function(level, current)
    local Player = QBCore.Functions.GetPlayer(source)
	if level == 1 then 
		Player.Functions.RemoveItem('suspension', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['suspension'], "remove", 1)
	elseif level == 3 then
		Player.Functions.RemoveItem('suspension2', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['suspension2'], "remove", 1)
	end
	if current == 1 then		
		Player.Functions.AddItem('suspension', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['suspension'], "add", 1)
	elseif current == 3 then
		Player.Functions.AddItem('suspension2', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['suspension2'], "add", 1)	
	end		
end)

QBCore.Functions.CreateUseableItem("suspension", function(source, item) TriggerClientEvent("jim-mechanic:client:applySuspension", source, 1) end)

QBCore.Functions.CreateUseableItem("suspension2", function(source, item) TriggerClientEvent("jim-mechanic:client:applySuspension", source, 3) end)

--========================================================== Engines

RegisterNetEvent('jim-mechanic:server:removeEngines', function(level, current)
    local Player = QBCore.Functions.GetPlayer(source)
	if level == 1 then 
		Player.Functions.RemoveItem('shonen', 1) 
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['shonen'], "remove", 1)
	elseif level == 2 then
		Player.Functions.RemoveItem('v8engine', 1)
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['v8engine'], "remove", 1)
	end
	if current == 2 then		
		Player.Functions.AddItem('shonen', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['shonen'], "add", 1)
	elseif current == 3 then
		Player.Functions.AddItem('v8engine', 1, false, {["quality"] = nil})
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['v8engine'], "add", 1)	
	end		
end)

QBCore.Functions.CreateUseableItem("shonen", function(source, item)	TriggerClientEvent("jim-mechanic:client:applyEngine", source, 1) end)

QBCore.Functions.CreateUseableItem("v8engine", function(source, item) TriggerClientEvent("jim-mechanic:client:applyEngine", source, 2) end)

--========================================================== Brakes

RegisterNetEvent('jim-mechanic:server:removeBrakes', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('race_brakes', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['race_brakes'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveBrakes', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('race_brakes', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['race_brakes'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("race_brakes", function(source, item) TriggerClientEvent("jim-mechanic:client:applyBrakes", source) end)
--========================================================== Transmission

RegisterNetEvent('jim-mechanic:server:removeTransmission', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('race_transmission', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['race_transmission'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveTransmission', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('race_transmission', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['race_transmission'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("race_transmission", function(source, item) TriggerClientEvent("jim-mechanic:client:applyTransmission", source) end)

--========================================================== Armour

RegisterNetEvent('jim-mechanic:server:removeArmour', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('car_armor', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['car_armor'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveArmour', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('car_armor', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['car_armor'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("car_armor", function(source, item) TriggerClientEvent('jim-mechanic:client:applyArmour', source) end)

--========================================================== Turbo

RegisterNetEvent('jim-mechanic:server:removeTurbo', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('turbo', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['turbo'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveTurbo', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('turbo', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['turbo'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("turbo", function(source, item) TriggerClientEvent("jim-mechanic:client:applyTurbo", source) end)

--========================================================== BulletProof Tires

RegisterNetEvent('jim-mechanic:server:removeBulletProof', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('bprooftires', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['bprooftires'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveBulletProof', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('bprooftires', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['bprooftires'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("bprooftires", function(source, item) TriggerClientEvent("jim-mechanic:client:applyBulletProof", source) end)

--========================================================== Drift Tires

RegisterNetEvent('jim-mechanic:server:removeDrift', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('drifttires', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['drifttires'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveDrift', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('drifttires', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['drifttires'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("drifttires", function(source, item) TriggerClientEvent("jim-mechanic:client:applyDrift", source) end)

--========================================================== NOS

RegisterNetEvent('jim-mechanic:server:removeNOS', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('nos', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['nos'], "remove", 1)
end)

QBCore.Functions.CreateUseableItem("nos", function(source, item) TriggerClientEvent("jim-mechanic:client:applyNOS", source) end)

--========================================================== Headlights & Underglow

RegisterNetEvent('jim-mechanic:server:removeXenon', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('headlights', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['headlights'], "remove", 1)
end)

RegisterNetEvent('jim-mechanic:server:giveXenon', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem('headlights', 1, false, {["quality"] = nil})
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['headlights'], "add", 1)
end)

QBCore.Functions.CreateUseableItem("headlights", function(source, item) TriggerClientEvent("jim-mechanic:client:applyXenons", source) end)

QBCore.Functions.CreateUseableItem("underglow_controller", function(source, item) TriggerClientEvent('jim-mechanic:client:neonMenu', source) end)

--========================================================== Toolbox
QBCore.Functions.CreateUseableItem("toolbox", function(source, item) TriggerClientEvent('jim-mechanic:client:Menu', source) end)

--========================================================== REPAIR
QBCore.Functions.CreateUseableItem("mechanic_tools", function(source, item) TriggerClientEvent('jim-mechanic:client:Repair:Check', source) end)

--========================================================== Seats
QBCore.Functions.CreateUseableItem("seat", function(source, item) TriggerClientEvent('jim-mechanic:client:Seat:Check', source) end)

--========================================================== Interior
QBCore.Functions.CreateUseableItem("internals", function(source, item) TriggerClientEvent('jim-mechanic:client:Interior:Check', source) end)

--========================================================== Exterior
QBCore.Functions.CreateUseableItem("externals", function(source, item) TriggerClientEvent('jim-mechanic:client:Exterior:Check', source) end)

--========================================================== Rims
QBCore.Functions.CreateUseableItem("rims", function(source, item) TriggerClientEvent('jim-mechanic:client:Rims:Check', source) end)

--========================================================== Exhaust
QBCore.Functions.CreateUseableItem("exhaust", function(source, item) TriggerClientEvent('jim-mechanic:client:Exhaust:Check', source) end)

--========================================================== Horn
QBCore.Functions.CreateUseableItem("horn", function(source, item) TriggerClientEvent('jim-mechanic:client:Horn:Check', source) end)

--========================================================== Paints
QBCore.Functions.CreateUseableItem("paintcan", function(source, item) TriggerClientEvent('jim-mechanic:client:Paints:Check', source) end)

--========================================================== Livery
QBCore.Functions.CreateUseableItem("livery", function(source, item) TriggerClientEvent('jim-mechanic:client:Livery:Check', source) end)

--========================================================== Tire Smoke
QBCore.Functions.CreateUseableItem("tires", function(source, item) TriggerClientEvent('jim-mechanic:client:Tires:Check', source) end)

--========================================================== Skirts
QBCore.Functions.CreateUseableItem("skirts", function(source, item) TriggerClientEvent('jim-mechanic:client:Skirts:Check', source) end)

--========================================================== Spoiler
QBCore.Functions.CreateUseableItem("spoiler", function(source, item) TriggerClientEvent('jim-mechanic:client:Spoilers:Check', source) end)

--========================================================== Roof
QBCore.Functions.CreateUseableItem("roof", function(source, item) TriggerClientEvent('jim-mechanic:client:Roof:Check', source) end)

--========================================================== Hood
QBCore.Functions.CreateUseableItem("hood", function(source, item) TriggerClientEvent('jim-mechanic:client:Hood:Check', source) end)

--========================================================== Bumpers
QBCore.Functions.CreateUseableItem("bumper", function(source, item) TriggerClientEvent('jim-mechanic:client:Bumpers:Check', source) end)

--========================================================== Plates
QBCore.Functions.CreateUseableItem("customplate", function(source, item) TriggerClientEvent('jim-mechanic:client:Plates:Check', source) end)

--========================================================== Cleaning Car
QBCore.Functions.CreateUseableItem("cleaningkit", function(source, item) TriggerClientEvent('jim-mechanic:client:cleanVehicle', source, true) end)

--========================================================== Windowtint

RegisterNetEvent('jim-mechanic:server:removeTintSupplies', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('tint_supplies', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['tint_supplies'], "remove", 1)
end)

QBCore.Functions.CreateUseableItem("tint_supplies", function(source, item) TriggerClientEvent('jim-mechanic:client:Windows:Check', source) end)

--========================================================== REPAIRS

QBCore.Functions.CreateCallback('jim-mechanic:repairCost',function(source, cb, data)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
	if data.part == "Engine" then
		local item = Player.Functions.GetItemByName(Config.RepairEngine)
		if item ~= nil and item.amount >= tonumber(data.cost) then cb(true)
		else cb(false) end
	elseif data.part == "Body" then
		local item = Player.Functions.GetItemByName(Config.RepairBody)
		if item ~= nil and item.amount >= data.cost then cb(true)
		else cb(false) end	
	elseif data.part == "Radiator" then
		local item = Player.Functions.GetItemByName(Config.RepairRadiator)
		if item ~= nil and item.amount >= tonumber(data.cost) then cb(true)
		else cb(false) end
	elseif data.part == "Drive Shaft" then
		local item = Player.Functions.GetItemByName(Config.RepairAxle)
		if item ~= nil and item.amount >= data.cost then cb(true)
		else cb(false) end
	elseif data.part == "Brakes" then
		local item = Player.Functions.GetItemByName(Config.RepairBrakes)
		if item ~= nil and item.amount >= data.cost then cb(true)
		else cb(false) end
	elseif data.part == "Clutch" then
		local item = Player.Functions.GetItemByName(Config.RepairClutch)
		if item ~= nil and item.amount >= data.cost then cb(true)
		else cb(false) end
	elseif data.part == "Fuel Tank" then
		local item = Player.Functions.GetItemByName(Config.RepairFuel)
		if item ~= nil and item.amount >= data.cost then cb(true)
		else cb(false) end
	end
end)

RegisterServerEvent('jim-mechanic:ItemRemove')
AddEventHandler('jim-mechanic:ItemRemove', function(data)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
	if data.part == "Engine" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairEngine], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairEngine, data.cost)
	elseif data.part == "Body" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairBody], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairBody, data.cost)
	elseif data.part == "Radiator" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairRadiator], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairRadiator, data.cost)
	elseif data.part == "Drive Shaft" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairAxle], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairAxle, data.cost)
	elseif data.part == "Brakes" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairBrakes], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairBrakes, data.cost)
	elseif data.part == "Clutch" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairClutch], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairClutch, data.cost)
	elseif data.part == "Fuel Tank" then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.RepairFuel], "remove", data.cost) 
		Player.Functions.RemoveItem(Config.RepairFuel, data.cost)
	end
end)

--========================================================== REPAIRS

QBCore.Functions.CreateUseableItem("ducttape", function(source, item) TriggerClientEvent("jim-mechanic:quickrepair", source) end)

RegisterNetEvent('jim-mechanic:server:removeTape', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('ducttape', 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ducttape'], "remove", 1)
end)


QBCore.Commands.Add("verificardano", "Ver dano do veículo", {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:vehicledamage", source)
end)

QBCore.Commands.Add("verificarmods", "Ver mods disponiveis no veículo", {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:Menu:List", source)
end)

QBCore.Commands.Add("virar veiculo", "Virar o veículo mais próximo", {}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:flipvehicle", source)
end)

QBCore.Commands.Add("lugarveiculo", "Mover para outro lugar [-1 to 10]", {{name="id", help="Lugar ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:seat", source, args[1])
end)

QBCore.Commands.Add("togglesound", "Enable upgraded engine sounds", {{name="on/off", help="Set engine sounds ON or OFF"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:togglesound", source, args[1])
end)

QBCore.Commands.Add("limparcarro", "Limpar o carro", {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:cleanVehicle", source, false)
end)

--[[QBCore.Commands.Add("hood", "Open/Close Hood", {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 4)
end)

QBCore.Commands.Add("trunk", "Open/Close trunk", {}, false, function(source)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, 5)
end)

QBCore.Commands.Add("door", "Open/Close Door [0-3]", {{name="0-3", help="Door ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:client:openDoor", source, args[1])
end)

QBCore.Commands.Add("seat", "Move to another seat [-1 to 10]", {{name="id", help="Seat ID"}}, false, function(source, args)
	TriggerClientEvent("jim-mechanic:seat", source, args[1])
end)--]]

QBCore.Functions.CreateCallback("jim-mechanic:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    exports.oxmysql:execute('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',{plate, pData.PlayerData.citizenid}, function(result) if result[1] then cb(true) else cb(false) end
    end)
end)

--
RegisterNetEvent("updateVehicle", function(myCar)
    local src = source
    if IsVehicleOwned(myCar.plate) then
        MySQL.Async.execute('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(myCar), myCar.plate})
    end
end)

function IsVehicleOwned(plate)
    local retval = false
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        retval = true
    end
    return retval
end
