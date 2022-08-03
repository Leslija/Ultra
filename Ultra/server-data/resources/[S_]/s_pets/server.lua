QBCore = nil

local QBCore = exports['qb-core']:GetCoreObject()


--	local xPlayer = QBCore.Functions.GetPlayer(source)



RegisterServerEvent('s_pets:buyPet')
AddEventHandler('s_pets:buyPet', function(petType,price)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)


	exports['oxmysql']:execute('SELECT * FROM s_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.PlayerData.citizenid,
	}, function (result)
		local ifOwner = table.unpack(result)
		if ifOwner ~= nil then
			TriggerClientEvent('QBCore:Notify', _source, "Já tens um animal", "error")
		else
			if xPlayer.PlayerData.money.cash > price then
				TriggerClientEvent('QBCore:Notify', _source, "Agora tens um melhor amigo verdadeiro!", "success")
				xPlayer.Functions.RemoveMoney('cash', price)
				exports['oxmysql']:execute('INSERT INTO s_pets (owner, modelname) VALUES (@owner, @modelname)',
				{
					['@owner']   = xPlayer.PlayerData.citizenid,
					['@modelname']   = petType,
				}, function (rowsChanged)

				end)
			else
				TriggerClientEvent('QBCore:Notify', _source, "Não tens dinheiro suficiente", "error")
			end
		end
	end)
end)


RegisterServerEvent('s_pets:buyFood')
AddEventHandler('s_pets:buyFood', function(price)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.money.cash >= price then
		xPlayer.Functions.RemoveMoney('cash', price)
		xPlayer.Functions.AddItem(Config.FoodItem,1)
	end
end)


RegisterServerEvent('s_pets:getOwnedPet')
AddEventHandler('s_pets:getOwnedPet',function()

	local xPlayer = QBCore.Functions.GetPlayer(source)

	exports['oxmysql']:execute('SELECT * FROM s_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.PlayerData.citizenid,
		['@modelname'] = modelname,
	}, function (result)
		TriggerClientEvent('s_pets:spawnPet',modelname,health,illness)
	end)

end)

RegisterServerEvent('s_pets:chargeABitch')
AddEventHandler('s_pets:chargeABitch',function(fee)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.money.cash >= (Config.HealPrice + fee) then
		xPlayer.removeMoney((Config.HealPrice + fee))
	end
end)

RegisterServerEvent('s_pets:returnBall')
AddEventHandler('s_pets:returnBall',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.AddItem('tennisball',1)
end)

RegisterServerEvent('s_pets:removeBall')
AddEventHandler('s_pets:removeBall',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	xPlayer.Functions.RemoveItem('tennisball',1)
end)

QBCore.Functions.CreateUseableItem("tennisball", function(source)
	local xPlayer = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('s_pets:useTennisBall', source)
	xPlayer.Functions.RemoveItem('tennisball', 1)
end)



function getPet(citizenid)

	exports['oxmysql']:execute('SELECT * FROM s_pets WHERE owner = @owner', {
		['@owner'] = citizenid,
	}, function (result)
		id = result[1].id
		owner = result[1].owner
		modelname = result[1].modelname
		health = result[1].health
		illnesses = result[1].illnesses
		cb(id,owner,modelname,health,illnesses)
	end)


end

QBCore.Functions.CreateCallback("s_pets:getPetSQL", function(source, cb)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    --cb(getPet(xPlayer.PlayerData.citizenid))
    	exports['oxmysql']:execute('SELECT * FROM s_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.PlayerData.citizenid,
	}, function (result)
		cb(result)
	end)
end)


RegisterServerEvent('s_pets:updatePet')
AddEventHandler('s_pets:updatePet',function(health,illness)
    local xPlayer = QBCore.Functions.GetPlayer(source)

	exports['oxmysql']:execute('UPDATE s_pets SET health = @health, illnesses = @illness WHERE owner = @owner', {
		['@health'] = health,
		['@illness'] = illness,				
		['@owner']   = xPlayer.PlayerData.citizenid,
	}, function(rowsChanged)

	end)

end)

RegisterServerEvent('s_pets:buyTennisBall')
AddEventHandler('s_pets:buyTennisBall',function(price)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer.PlayerData.money.cash >= price then
		xPlayer.Functions.RemoveMoney('cash', price)
		xPlayer.Functions.AddItem('tennisball',1)
	end	
end)


RegisterServerEvent('s_pets:updatePetName')
AddEventHandler('s_pets:updatePetName',function(name)
    local xPlayer = QBCore.Functions.GetPlayer(source)

	exports['oxmysql']:execute('UPDATE s_pets SET name = @name WHERE owner = @owner', {
		['@name'] = name,		
		['@owner']   = xPlayer.PlayerData.citizenid,
	}, function(rowsChanged)

	end)

end)



RegisterServerEvent('s_pets:removePet')
AddEventHandler('s_pets:removePet',function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	exports['oxmysql']:execute('DELETE FROM s_pets WHERE owner = @owner', {
		['@owner'] = xPlayer.PlayerData.citizenid
	})

end)


RegisterNetEvent('s_pets:k9Search')
AddEventHandler('s_pets:k9Search',function(ID,targetID)
	local itemFound = false
	local source = source
	local targetPlayer = QBCore.Functions.GetPlayer(targetID)
	        for k, v in pairs(Config.SearchableItems.IllegalItems) do
            	if targetPlayer.Functions.GetItemByName(k).count >= v then
            		itemFound = true
            	end
        	end

		TriggerClientEvent('s_pets:k9ItemCheck', source, itemFound)

end)
