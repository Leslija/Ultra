local QBCore = exports['qb-core']:GetCoreObject()

--Slow and visible cleaning command

RegisterNetEvent('jim-mechanic:client:cleanVehicle', function(skip)
	if Config.RequiresJob and not skip then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes limpar de dentro do veículo", "error")
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		if DoesEntityExist(vehicle) then
			local cleaning = true								
			TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
			Wait(150)
			TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
			while cleaning do
				if GetVehicleDirtLevel(vehicle) >= 1.0 then SetVehicleDirtLevel(vehicle, (tonumber(GetVehicleDirtLevel(vehicle))) - 0.3) --TriggerEvent("QBCore:Notify", GetVehicleDirtLevel(vehicle), "success") 
				elseif GetVehicleDirtLevel(vehicle) <= 1.0 then SetVehicleDirtLevel(vehicle, 0.0) cleaning = false TriggerEvent('animations:client:EmoteCommandStart', {"c"}) TriggerEvent("QBCore:Notify", "Veículo Limpo", "success") end
				Wait(300)
			end
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")	
	end
end)

--Multipurpose Door command
RegisterNetEvent('jim-mechanic:client:openDoor', function(door)
	local doornum = tonumber(door)
	if doornum < 0 or doornum > 5 then
		TriggerEvent("QBCore:Notify", "Erro porta", "error")
		return
	end
	local coords = GetEntityCoords(PlayerPedId())
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedSittingInAnyVehicle(PlayerPedId()) then	vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71) NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle) end
		
		if DoesEntityExist(vehicle) then
			if GetVehicleDoorLockStatus(vehicle) == 2 then
				TriggerEvent("QBCore:Notify", "Portas do Veículo Fechadas", "error")
				return
			else
				if GetVehicleDoorAngleRatio(vehicle, doornum) > 0.0 then SetVehicleDoorShut(vehicle, doornum, false)
				else SetVehicleDoorOpen(vehicle, doornum, false, false) end
			end
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")	
	end
end)

RegisterNetEvent("jim-mechanic:flipvehicle", function()
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local vehicle = nil
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Estás dentro do carro e queres virá-lo?", "error")
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		SetVehicleModKit(vehicle, 0)
		if DoesEntityExist(vehicle) then
			QBCore.Functions.Progressbar("accepted_key", "A virar veículo", 12000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				task = "CODE_HUMAN_MEDIC_TEND_TO_DEAD"
			}, {}, {}, function() -- Done
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				vehiclecoords = GetEntityCoords(vehicle)
				SetEntityCoords(vehicle, vehiclecoords.x+0.5, vehiclecoords.y+0.5, vehiclecoords.z+1)
				Wait(200)
				SetEntityRotation(vehicle, GetEntityRotation(PlayerPedId(), 2), 2)
				Wait(500)
				SetVehicleOnGroundProperly(vehicle)
				TriggerEvent("QBCore:Notify", "Successo! Veículo virado", "success")
			end, function() -- Cancel

				TriggerEvent("QBCore:Notify", "Falhou a virar o veículo!", "error")
				FreezeEntityPosition(playerPed, false)
				ClearPedTasks(playerPed)								
			end)
		else
			TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
		end
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent("jim-mechanic:seat", function(seat)
	if not seat then TriggerEvent("QBCore:Notify", "Nenhum assento escohido", "error") return end
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local IsSeatFree = IsVehicleSeatFree(vehicle, tonumber(seat))
	local speed = GetEntitySpeed(vehicle)
	local HasHarnass = exports['qb-smallresources']:HasHarness()
	if not HasHarnass then
		local kmh = (speed * 3.6);
			if IsSeatFree then
				if kmh <= 100.0 then
					SetPedIntoVehicle(PlayerPedId(), vehicle, tonumber(seat))
					QBCore.Functions.Notify('Tu foste para o assento '..seat..'!')
				else
					QBCore.Functions.Notify('O veículo está a ir muito de pressa..')
				end
			else
				QBCore.Functions.Notify('Este assento não está disponivel..')
			end
	else
		QBCore.Functions.Notify('Estás com cinto de corrida não consegues trocar..', 'error')
	end
end)