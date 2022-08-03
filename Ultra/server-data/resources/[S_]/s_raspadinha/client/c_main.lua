local cooldown = 0

RegisterNetEvent("s_raspadinha:isActiveCooldown", function()
	TriggerServerEvent("s_raspadinha:handler", cooldown > 0 and true or false, cooldown)
end)

RegisterNetEvent("s_raspadinha:setCooldown", function()
  cooldown = Config.ScratchCooldownInSeconds
	CreateThread(function()
		while (cooldown ~= 0) do
			Wait(1000)
			cooldown = cooldown - 1
		end
	end)
end)

RegisterNetEvent("s_raspadinha:startScratchingEmote", function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_PARKING_METER", 0, true)
end)

RegisterNetEvent("s_raspadinha:stopScratchingEmote", function()
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('s_raspadinha:deposit', data.key, data.price, data.amount, data.type)
end)