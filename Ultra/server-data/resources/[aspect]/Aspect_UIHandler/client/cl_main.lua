if Config.Framework == 'ESX' then

Citizen.CreateThread(function()
	while Framework == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			Framework = obj 
		end)
		Citizen.Wait(0)
	end
	while Framework.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ASPT.PlayerData = Framework.GetPlayerData()
	ASPT.Functions.GetPedDataThread()
end)

elseif Config.Framework == 'QBCore' then

Citizen.CreateThread(function()
	Framework = exports['qb-core']:GetCoreObject()
	while Framework.Functions.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ASPT.PlayerData = Framework.Functions.GetPlayerData()
	ASPT.Functions.GetPedDataThread()
end)

end

RegisterNetEvent(ASPT.HandlerName..':IsTalking')
RegisterNetEvent(ASPT.HandlerName..':IsNotTalking')
RegisterNetEvent(ASPT.HandlerName..':IsUnderWater')
RegisterNetEvent(ASPT.HandlerName..':IsNotUnderWater')
RegisterNetEvent(ASPT.HandlerName..':IsSprinting')
RegisterNetEvent(ASPT.HandlerName..':IsNotSprinting')
RegisterNetEvent(ASPT.HandlerName..':IsOnFoot')
RegisterNetEvent(ASPT.HandlerName..':IsNotOnFoot')
RegisterNetEvent(ASPT.HandlerName..':OnVehicleEnter')
RegisterNetEvent(ASPT.HandlerName..':OnVehicleExit')
RegisterNetEvent(ASPT.HandlerName..':OnVehicleHit')
RegisterNetEvent(ASPT.HandlerName..':HasEnteredZone')
RegisterNetEvent(ASPT.HandlerName..':HasLeftZone')