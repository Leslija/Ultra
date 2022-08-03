local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Drift
RegisterNetEvent('jim-mechanic:client:applyDrift', function()
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
		QBCore.Functions.Notify("Não podes instalar dentro do veículo", "error", 3500)
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetDriftTyresEnabled(vehicle) ~= false then
						TriggerEvent("QBCore:Notify", "Pneus de drift já instalados", "error")
					else
						playAnim("mini@repair", "fixing_a_ped", 35000, 16)
						SetVehicleEngineOn(vehicle, false, false, true)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						
						QBCore.Functions.Progressbar("drink_something", "A instalar pneus de drift..", time, false, true, { 
							disableMovement = true, 
							disableCarMovement = true, 
							disableMouse = false, 
							disableCombat = true, 
						}, {
							animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
							anim = "machinic_loop_mechandplayer",
							flags = 8,
						}, {}, {}, function()
							SetVehicleModKit(vehicle, 0)
							
							SetVehicleTyreFixed(vehicle, 0)
							SetVehicleTyreFixed(vehicle, 1)
							SetVehicleTyreFixed(vehicle, 2)
							SetVehicleTyreFixed(vehicle, 3)
							SetVehicleTyreFixed(vehicle, 4)
							
							SetDriftTyresEnabled(vehicle, true)

							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							
							TriggerServerEvent('jim-mechanic:server:removeDrift')
							
							if GetVehicleTyresCanBurst(vehicle) ~= 1 then 
								TriggerServerEvent('jim-mechanic:server:giveBulletProof')
								SetVehicleTyresCanBurst(vehicle, true)
								TriggerEvent("QBCore:Notify", "Pneus à prova de bala removidos!", "success")
							end
				
							TriggerEvent("QBCore:Notify", "Successo! Pneus de drift instalados", "success")
						end, function() -- Cancel
							TriggerEvent("QBCore:Notify", "Falhou a instalação de pneus de drift!", "error")
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

RegisterNetEvent('jim-mechanic:client:giveDrift')
AddEventHandler('jim-mechanic:client:giveDrift', function()
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
			QBCore.Functions.Progressbar("accepted_key", "A remover pneus de drift", 8000, false, true, {
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

				SetVehicleTyreFixed(vehicle, 0)
				SetVehicleTyreFixed(vehicle, 1)
				SetVehicleTyreFixed(vehicle, 2)
				SetVehicleTyreFixed(vehicle, 3)
				SetVehicleTyreFixed(vehicle, 4)
				
				SetDriftTyresEnabled(vehicle, false)

				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:giveDrift')
				TriggerEvent("QBCore:Notify", "Successo! Pneus de drift removidos", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remover pneus de drift!", "error")
				ClearPedTasks(playerPed)								
			end)
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

--========================================================== Bullet Proof
RegisterNetEvent('jim-mechanic:client:applyBulletProof', function()
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
		QBCore.Functions.Notify("Não podes instalar dentro do veículo", "error", 3500)
		ClearPedTasks(playerPed)
		return
	end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetVehicleTyresCanBurst(vehicle) == false then
						TriggerEvent("QBCore:Notify", "Pneus à prova de bala já instalados", "error")
					else
						playAnim("mini@repair", "fixing_a_ped", 35000, 16)
						SetVehicleEngineOn(vehicle, false, false, true)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						
						QBCore.Functions.Progressbar("drink_something", "A instalar pneus à prova de bala..", time, false, true, { 
							disableMovement = true, 
							disableCarMovement = true, 
							disableMouse = false, 
							disableCombat = true, 
						}, {
							animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
							anim = "machinic_loop_mechandplayer",
							flags = 8,
						}, {}, {}, function()
							SetVehicleModKit(vehicle, 0)
							
							SetVehicleTyreFixed(vehicle, 0)
							SetVehicleTyreFixed(vehicle, 1)
							SetVehicleTyreFixed(vehicle, 2)
							SetVehicleTyreFixed(vehicle, 3)
							SetVehicleTyreFixed(vehicle, 4)
							
							SetVehicleTyresCanBurst(vehicle, false)

							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							TriggerServerEvent('jim-mechanic:server:removeBulletProof')
							if GetDriftTyresEnabled(vehicle) ~= false then
								TriggerServerEvent('jim-mechanic:server:giveDrift')
								SetDriftTyresEnabled(vehicle, false)
								TriggerEvent("QBCore:Notify", "Pneus de drift removidos!", "success")
							end
							TriggerEvent("QBCore:Notify", "Successo! Pneus à prova de bala instalados", "success")
						end, function() -- Cancel
							TriggerEvent("QBCore:Notify", "Falhou a instalar pneus à prova de bala!", "error")
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

RegisterNetEvent('jim-mechanic:client:giveBulletProof')
AddEventHandler('jim-mechanic:client:giveBulletProof', function()
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
			QBCore.Functions.Progressbar("accepted_key", "A remover pneus à prova de bala", 8000, false, true, {
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

				SetVehicleTyreFixed(vehicle, 0)
				SetVehicleTyreFixed(vehicle, 1)
				SetVehicleTyreFixed(vehicle, 2)
				SetVehicleTyreFixed(vehicle, 3)
				SetVehicleTyreFixed(vehicle, 4)
				
				SetVehicleTyresCanBurst(vehicle, true)

				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:giveBulletProof')
				TriggerEvent("QBCore:Notify", "Successo! Pneus à prova de bala removidos", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remover pneus à prova de bala!", "error")
				ClearPedTasks(playerPed)								
			end)
		end
	end, GetVehicleNumberPlateText(vehicle))
end)