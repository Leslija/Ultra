local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Turbo
RegisterNetEvent('jim-mechanic:client:applyTurbo', function()
	if Config.LocationRequired and not onDuty then
		TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
		return
	end
	if Config.RequiresJob == true then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local playerPed	= PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
	if IsPedSittingInAnyVehicle(playerPed) then
		QBCore.Functions.Notify("Não podes instalar dentro do veículo", "error", 3500)
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if tostring(vehProps.modTurbo) ~= "false" then
						TriggerEvent("QBCore:Notify", "Turbo já instalado", "error")
					else
						playAnim("mini@repair", "fixing_a_ped", 35000, 16)
						SetVehicleEngineOn(vehicle, false, false, true)
						SetVehicleDoorOpen(vehicle, 4, false, false)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						
						QBCore.Functions.Progressbar("drink_something", "A instalar turbo..", time, false, true, { 
							disableMovement = true, 
							disableCarMovement = true, 
							disableMouse = false, 
							disableCombat = true, 
						}, {
							animDict = "mini@repair",
							anim = "fixing_a_ped",
							flags = 16,
						}, {}, {}, function()
							SetVehicleModKit(vehicle, 0)
							ToggleVehicleMod(vehicle, 18, true)
							SetVehicleDoorShut(vehicle, 4, false)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							--SetVehicleEngineOn(vehicle, true, true)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							TriggerServerEvent('jim-mechanic:server:removeTurbo')
							TriggerEvent("QBCore:Notify", "Successo! Turbo Instalado", "success")
						end, function() -- Cancel
							TriggerEvent("QBCore:Notify", "Falhou a instalar turbo!", "error")
							SetVehicleDoorShut(vehicle, 4, false)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
						end)
					end
				end
			end
		end, GetVehicleNumberPlateText(vehicle))		
	else
		QBCore.Functions.Notify("Nenhum veículo por perto", "error", 3500)
	end
end)

RegisterNetEvent('jim-mechanic:client:giveTurbo')
AddEventHandler('jim-mechanic:client:giveTurbo', function()
	if Config.LocationRequired and not onDuty then
		TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
		return
	end
	if Config.RequiresJob == true then havejob = false
		for k, v in pairs(Config.JobRoles) do
			if v == PlayerJob.name then havejob = true end
		end
		if havejob == false then TriggerEvent('QBCore:Notify', "Apenas os mecânicos sabem fazer isto", "error") return end
	end
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)	
	QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
		if Config.isVehicleOwned and not owned then
			TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
			return
		else
			SetVehicleDoorOpen(vehicle, 4, false, false)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("accepted_key", "A remover turbo", 8000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "mini@repair",
				anim = "fixing_a_ped",
				flags = 16,
			}, {}, {}, function() -- Done
				SetVehicleModKit(vehicle, 0)
				ToggleVehicleMod(vehicle, 18, false)
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				--SetVehicleEngineOn(vehicle, true, true)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:giveTurbo')
				TriggerEvent("QBCore:Notify", "Successo! Turbo Removido", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remover turbo!", "error")
				ClearPedTasks(playerPed)								
			end)
		end
	end, GetVehicleNumberPlateText(vehicle))
end)