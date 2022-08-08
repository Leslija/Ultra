Citizen.CreateThread(function()
	while not ASPT do
		ASPT = exports[Config.HandlerName]:GetSharedObject()
		Citizen.Wait(10)
	end
end)

if Config.Framework == 'ESX' then

Citizen.CreateThread(function()
	while not Framework do
		TriggerEvent('esx:getSharedObject', function(obj) 
			Framework = obj 
		end)
		Citizen.Wait(10)
	end
	UI.Functions.StartMainThread()
	UI.Functions.StartSideThread()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	while not UI.Ready do
		Citizen.Wait(10)
	end
	UI.Enabled = true
	UI.Functions.BootMenu()
end)

AddEventHandler('esx_status:onTick', function(data)
	for i = 1, #data, 1 do
		if data[i].name == 'hunger' and UI.Settings.Hunger then 
			UI.StatusData.Hunger = data[i].percent
		end
		if data[i].name == 'thirst' and UI.Settings.Thirst then
			UI.StatusData.Thirst = data[i].percent
		end
	end
end)

elseif Config.Framework == 'QBCore' then

Citizen.CreateThread(function()
	while not Framework do
		Framework = exports['qb-core']:GetCoreObject()
		Citizen.Wait(10)
	end
	UI.Functions.StartMainThread()
	UI.Functions.StartSideThread()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	while not UI.Ready do
		Citizen.Wait(10)
	end
	UI.Enabled = true
	UI.Functions.BootMenu()
   	Framework.Functions.TriggerCallback('qb:'..GetCurrentResourceName()..':GetStatus', function(hunger, thirst)
		UI.StatusData.Hunger = hunger
		UI.StatusData.Thirst = thirst
    end)
end)

RegisterNetEvent('hud:client:UpdateNeeds')
AddEventHandler('hud:client:UpdateNeeds', function(hunger, thirst)
	UI.StatusData.Hunger = hunger
	UI.StatusData.Thirst = thirst
end)

end

RegisterNetEvent(UI.ScriptName..':ToggleUI')
AddEventHandler(UI.ScriptName..':ToggleUI', function(state)
	UI.Functions.ToggleUI(state)
end)

RegisterNetEvent(UI.ScriptName..':AddNotification')
AddEventHandler(UI.ScriptName..':AddNotification', function(header, text, duration, icon)
	UI.Functions.AddNotification(header, text, duration, icon)
end)

RegisterNetEvent(UI.ScriptName..':SetVoice')
AddEventHandler(UI.ScriptName..':SetVoice', function(state)
	UI.Functions.SetVoice(state)
end)

AddEventHandler(Config.HandlerName..':IsTalking', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'update', 
			type = 'talking', 
			data = 'on'
		})
	end
end)

AddEventHandler(Config.HandlerName..':IsNotTalking', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'update', 
			type = 'talking', 
			data = 'off'
		})
	end
end)

AddEventHandler(Config.HandlerName..':IsUnderWater', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'open', 
			type = 'oxygen'
		})
	end
end)

AddEventHandler(Config.HandlerName..':IsNotUnderWater', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'close', 
			type = 'oxygen'
		})
	end
end)

AddEventHandler(Config.HandlerName..':IsSprinting', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'open', 
			type = 'stamina'
		})
	end
end)

AddEventHandler(Config.HandlerName..':IsNotSprinting', function()
	if UI.Ready then
		SendNUIMessage({
			action = 'close', 
			type = 'stamina'
		})
	end
end)

AddEventHandler(Config.HandlerName..':OnVehicleEnter', function()
	UI.SeatBelt = false
	if UI.Ready then
		SendNUIMessage({
			action = 'open', 
			type = 'carhud'
		})
		SendNUIMessage({
			action = 'open', 
			type = 'streetlabel'
		})
	end
end)

AddEventHandler(Config.HandlerName..':OnVehicleExit', function()
	UI.SeatBelt = false
	if UI.Ready then
		SendNUIMessage({
			action = 'close', 
			type = 'carhud'
		})
		SendNUIMessage({
			action = 'close', 
			type = 'streetlabel'
		})
	end
end)

AddEventHandler(Config.HandlerName..':OnVehicleHit', function(ped, velocity, coords)
	if not UI.SeatBelt then
		SetEntityCoords(ped, coords.x, coords.y, coords.z - 0.47, true, true, true)
		SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
		SetEntityVelocity(ped, velocity.x, velocity.y, velocity.z)
	end
end)

RegisterNUICallback('NUIReady', function()
	UI.Functions.StartUI()
end)

RegisterNUICallback('UIReady', function(data)
	UI.Settings = data
	UI.Ready = true
end)

RegisterNUICallback('GetPlayerUISettings', function(data)
	UI.Settings = data
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

RegisterNUICallback('NUIFocusOn', function()
	SetNuiFocus(true, true)
end)

RegisterCommand('openuisettings', function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'open', 
		type = 'settings'
	})
end, false)
RegisterKeyMapping('openuisettings', 'Definições UI', 'keyboard', Config.SettingsButton)

RegisterCommand('toggleui', function()
	local state = not UI.Functions.GetUIState()
	UI.Functions.ToggleUI(state)
end, false)
RegisterKeyMapping('toggleui', 'Abrir UI', 'keyboard', '')

RegisterCommand('toggleseatbelt', function()
	UI.Functions.ToggleSeatBelt()
end, false)
RegisterKeyMapping('toggleseatbelt', 'UI Cinto', 'keyboard', Config.SeatBeltButton)