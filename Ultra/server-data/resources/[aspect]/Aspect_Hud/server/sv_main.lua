ASPT = exports[Config.HandlerName]:GetSharedObject()

if Config.Framework == 'ESX' then
TriggerEvent('esx:getSharedObject', function(obj) 
	Framework = obj 
end)

elseif Config.Framework == 'QBCore' then
Framework = exports['qb-core']:GetCoreObject()

Framework.Functions.CreateCallback('qb:'..GetCurrentResourceName()..':GetStatus', function(source, cb)
	local _source = source
	local Player = Framework.Functions.GetPlayer(_source)
	local Hunger = Player.PlayerData.metadata["hunger"]
	local Thirst = Player.PlayerData.metadata["thirst"]
	cb(Hunger, Thirst)
end)
end