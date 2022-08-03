local QBCore = exports['qb-core']:GetCoreObject()

--========================================================== Armour
RegisterNetEvent('jim-mechanic:client:applyArmour', function()
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
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "O veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetNumVehicleMods(vehicle, 16) == 0 then
						TriggerEvent("QBCore:Notify", "Armadura não pode ser instalada neste veículo", "error")
						return
					end
					if vehProps.modArmor+1 == GetNumVehicleMods(vehicle, 16) then
						TriggerEvent("QBCore:Notify", "Armadura já instalada", "error")
					else
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						SetVehicleEngineOn(vehicle, false, false, true)
						SetVehicleDoorOpen(vehicle, 4, false, false)
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						QBCore.Functions.Progressbar("drink_something", "A instalar armadura..", time, false, true, { 
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
							SetVehicleMod(vehicle, 16, GetNumVehicleMods(vehicle, 16)-1)
							SetVehicleDoorShut(vehicle, 4, false)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							TriggerServerEvent('jim-mechanic:server:removeArmour')
							TriggerEvent("QBCore:Notify", "Successo! Armadura Instalada", "success")
						end, function() -- Cancel
							TriggerEvent("QBCore:Notify", "Falhou a instalação da armadura!", "error")
							SetVehicleDoorShut(vehicle, 4, false)
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

RegisterNetEvent('jim-mechanic:client:giveArmor')
AddEventHandler('jim-mechanic:client:giveArmor', function()
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
			TriggerEvent("QBCore:Notify", "O veículo não é de ninguém, não pode ser modificado", "error")
			return
		else
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			QBCore.Functions.Progressbar("accepted_key", "A remover armadura", 8000, false, true, {
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
				SetVehicleMod(vehicle, 16, -1)
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				--SetVehicleEngineOn(vehicle, true, true)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:giveArmour')
				TriggerEvent("QBCore:Notify", "Successo! Armadura removida", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remoção da armadura!", "error")
				ClearPedTasks(playerPed)								
			end)	
		end
	end, GetVehicleNumberPlateText(vehicle))
end)