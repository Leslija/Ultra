ASPT = nil

Framework = nil

UI = {}

UI.ScriptName = GetCurrentResourceName()

UI.Ready = false
UI.Enabled = false
UI.SeatBelt = false

UI.Functions = {}
UI.Settings = {}
UI.StatusData = {
	Hunger = 0,
	Thirst = 0
}

UI.SpeedMultiplier = 3.6

UI.ClientTick = 0

UI.Functions.StartUI = function()
	if Config.Units == 'kmh' then
		UI.SpeedMultiplier = 3.6
	elseif Config.Units == 'mph' then
		UI.SpeedMultiplier = 2.23694
	end
	SendNUIMessage({
		action = 'ready',
		data = Config
	})
end

UI.Functions.BootMenu = function()
	SendNUIMessage({
		action = 'bootmenu'
	})
end


UI.Functions.ToggleUI = function(state)
	UI.Enabled = state
	SendNUIMessage({
		action = 'toggle', 
		type = 'ui',
		data = state
	})
end

UI.Functions.GetUIState = function()
	return UI.Enabled
end

UI.Functions.SetVoice = function(state)
	local Voice = 50
	if Config.Voice == 'esx' then
		if state == 0 then
			Voice = 50
		elseif state == 1 then
			Voice = 100
		elseif state == 2 then
			Voice = 33
		end
	elseif Config.Voice == 'tokovoip' then
		if state == 1 then
			Voice = 50
		elseif state == 2 then
			Voice = 33
		elseif state == 3 then
			Voice = 100
		end
	elseif Config.Voice == 'mumblevoip' or Config.Voice == 'pmavoice' then
		if state == 1 then
			Voice = 33
		elseif state == 2 then
			Voice = 50
		elseif state == 3 then
			Voice = 100
		end
	end
	SendNUIMessage({
		action = 'update', 
		type = 'voice',
		data = Voice
	})
end

UI.Functions.CalibrateRPM = function(engine, speed, rpm, scale)
	if not engine then
		rpm = 0
	elseif rpm > 0.99 then
		rpm = rpm * 100
		rpm = rpm + math.random(-2,2)
		rpm = rpm / 100
		if rpm < 0.12 then
			rpm = 0.12
		end
	else
		rpm = rpm - 0.1
	end
	rpm = math.floor(scale * rpm + 0.5)
	if rpm < 0 then
		rpm = 0
	elseif ASPT.PedData.Speed == 0.0 and r ~= 0 then
		rpm = math.random(rpm, (rpm + 50))
	end
	return math.floor(rpm / 10) * 10
end

UI.Functions.CalibrateFuel = function(vehicle)
	local fuel = 0
	if Config.UseFuel then
		if Config.FuelScript == 's_fuel' then
			fuel = exports['s_fuel']:GetFuel(vehicle)
		end
	end
	return fuel
end

UI.Functions.UpdateVehicle = function()
	local RPM = UI.Functions.CalibrateRPM(ASPT.PedData.Engine, ASPT.PedData.Speed, ASPT.PedData.RPM, ASPT.PedData.RPMScale)
	local Fuel = UI.Functions.CalibrateFuel(ASPT.PedData.CurrentVehicle)
	SendNUIMessage({
		action = 'update', 
		type = 'carhud', 
		data = {
			speed = math.floor(ASPT.PedData.Speed * UI.SpeedMultiplier), 
			rpm = RPM,
			fuel = math.floor(Fuel),
			seatbelt = UI.SeatBelt,
			direction = ASPT.PedData.StreetLabel.Direction,
			street = ASPT.PedData.StreetLabel.Street
		}
	})
end

UI.Functions.UpdatePlayer = function()
	if ASPT.PedData.Stamina == nil then
		ASPT.PedData.Stamina = 0
	end
	if ASPT.PedData.UnderWaterTime == nil then
		ASPT.PedData.UnderWaterTime = 0
	end
	if ASPT.PedData.Health == nil then
		ASPT.PedData.Health = 200
	end
	SendNUIMessage({
		action = 'update', 
		type = 'player', 
		data = {
			health = ASPT.PedData.Health - 100,
			armour = ASPT.PedData.Armour,
			hunger = UI.StatusData.Hunger,
			thirst = UI.StatusData.Thirst,
			stamina = (100 - ASPT.PedData.Stamina),
			oxygen = ASPT.PedData.UnderWaterTime * 10
		}
	})
end

UI.Functions.AddNotification = function(header, text, duration, icon)
	if UI.Ready then
		if not header then
			header = ''
		end
		if not text then
			text = ''
		end
		if not duration then
			duration = 5000
		end
		if not icon then
			icon = 'fas fa-inbox'
		end
		SendNUIMessage({
			action = 'add', 
			type = 'notification', 
			data = {
				header = header, 
				text = text, 
				duration = duration, 
				icon = icon
			}
		})
	end
end

UI.Functions.ToggleSeatBelt = function()
	UI.SeatBelt = not UI.SeatBelt
	SendNUIMessage({
		action = 'sound',
		type = 'belt',
		data = UI.SeatBelt
	})
end

UI.Functions.StartMainThread = function()
	Citizen.CreateThread(function()
		SetPedConfigFlag(PlayerPedId(), 32, true)
		while true do
			Citizen.Wait(100)
			UI.ClientTick = UI.ClientTick + 1
			if UI.Ready and UI.Enabled then
				ASPT.PedData = ASPT.Functions.GetPedData()
				if ASPT.PedData.InVehicle then
					UI.Functions.UpdateVehicle()
				end
				if UI.ClientTick >= 10 then
					UI.ClientTick = 0
					UI.Functions.UpdatePlayer()
				end
			end
		end
	end)
end

UI.Functions.StartSideThread = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			local Sleep = true
			if ASPT.PedData.InVehicle then
				Sleep = false
				if UI.SeatBelt then
					DisableControlAction(0, 75)
				end
			end
			if Sleep then
				Citizen.Wait(500)
			end
		end
	end)
end

exports('ToggleUI', function(state)
	UI.ToggleUI(state)
end)

exports('GetUIState', function()
	return UI.GetUIState()
end)

exports('AddNotification', function(header, text, duration, icon)
	UI.Functions.AddNotification(header, text, duration, icon)
end)

exports('SetVoice', function(state)
	UI.Functions.SetVoice(state)
end)