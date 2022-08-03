local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Brakes
RegisterNetEvent('jim-mechanic:client:applyBrakes', function()
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
	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent("QBCore:Notify", "Não podes instalar dentro do veículo", "error")
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
					
					if GetNumVehicleMods(vehicle, 12) == 0 then
						TriggerEvent("QBCore:Notify", "Travões não podem ser instalados neste veículo", "error")
						return
					end
				
					if vehProps.modBrakes+1 == GetNumVehicleMods(vehicle,12) then
						TriggerEvent("QBCore:Notify", "Travões de corrida já estão instalados", "error")
					else
						playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 35000, 8)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						SetVehicleEngineOn(vehicle, false, false, true)

						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						QBCore.Functions.Progressbar("accepted_key", "A instalar travões", time, false, true, {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						}, {
							animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
							anim = "machinic_loop_mechandplayer",
							flags = 8,
						}, {}, {}, function() -- Done
							SetVehicleModKit(vehicle, 0)
							SetVehicleMod(vehicle, 12, GetNumVehicleMods(vehicle,12)-1)
							--SetVehicleDoorShut(vehicle, 4, false)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							--SetVehicleEngineOn(vehicle, true, true)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							TriggerServerEvent('jim-mechanic:server:removeBrakes')
							TriggerEvent("QBCore:Notify", "Successo! Travões instalados", "success")
						end, function() -- Cancel
							TriggerEvent("QBCore:Notify", "Falhou instalação dos travões!", "error")
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)								
						end)
					end
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:giveBrakes')
AddEventHandler('jim-mechanic:client:giveBrakes', function()
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
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("accepted_key", "A remover travões", 8000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
				anim = "machinic_loop_mechandplayer",
				flags = 8,
			}, {}, {}, function() -- Done
				SetVehicleModKit(vehicle, 0)
				SetVehicleMod(vehicle, 12, 0)
				--SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				--SetVehicleEngineOn(vehicle, true, true)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:giveBrakes')
				TriggerEvent("QBCore:Notify", "Successo! Travões removidos", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remover os travões!", "error")
				ClearPedTasks(playerPed)								
			end)
		end
	end, GetVehicleNumberPlateText(vehicle))
end)