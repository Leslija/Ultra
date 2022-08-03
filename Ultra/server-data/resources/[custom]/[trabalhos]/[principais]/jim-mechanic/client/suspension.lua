local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Suspensions
RegisterNetEvent('jim-mechanic:client:applySuspension', function(level)
	if Config.LocationRequired and not onDuty then
		TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
	else
		if Config.RequiresJob == true then havejob = false
			for k, v in pairs(Config.JobRoles) do
				if v == PlayerJob.name then	havejob = true end
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
				NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
				SetVehicleModKit(vehicle, 0)
				vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
				currentSuspension = vehProps.modSuspension
			end
			QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
				if Config.isVehicleOwned and not owned then
					TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
					return
				else
					if DoesEntityExist(vehicle) then
						local plate = GetVehicleNumberPlateText(vehicle)
						if GetNumVehicleMods(vehicle, 15) == 0 then
							TriggerEvent("QBCore:Notify", "Não podes instalar suspensões neste veículo", "error")
							return
						end
					
						if vehProps.modSuspension == level then
							TriggerEvent("QBCore:Notify", "Suspensões já instaladas", "error")
						else						
							playAnim("mini@repair", "fixing_a_ped", 35000, 16)
							TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
							Wait(1000)				
							FreezeEntityPosition(playerPed, true)
							time = math.random(7000,10000)
							QBCore.Functions.Progressbar("drink_something", "A instalar suspensão..", time, false, true, { 
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
								if level == 1 then 
									SetVehicleMod(vehicle, 15, 1) 
								else
									SetVehicleMod(vehicle, 15, 3)
								end
								SetVehicleDoorShut(vehicle, 4, false)
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
								CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
								TriggerServerEvent('updateVehicle', CurrentVehicleData)
								TriggerServerEvent('jim-mechanic:server:removeSuspension', level, currentSuspension)
								--TriggerServerEvent('jim-mechanic:server:giveSuspensions', currentSuspension)
								TriggerEvent("QBCore:Notify", "Suspensão instalada", "success")						
							end, function()
								TriggerEvent("QBCore:Notify", "Falhou a instalar suspensão!", "error")
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
	end
end)

RegisterNetEvent('jim-mechanic:client:giveSuspension')
AddEventHandler('jim-mechanic:client:giveSuspension', function()
	if Config.LocationRequired and not onDuty then
		TriggerEvent("QBCore:Notify", "Não estás na oficina", "error")
	else
		local playerPed	= PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)	
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				--Grab info which Suspension is already in
				currentSuspension = GetVehicleMod(vehicle, 15)
				TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
				Wait(1000)
				QBCore.Functions.Progressbar("accepted_key", "A remover suspensão", 8000, false, true, {
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
					SetVehicleMod(vehicle, 15, -1)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					--SetVehicleSuspensionOn(vehicle, true, true)
					CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
					TriggerServerEvent('updateVehicle', CurrentVehicleData)
					TriggerServerEvent('jim-mechanic:server:removeSuspension', 0, currentSuspension)
					TriggerEvent("QBCore:Notify", "Successo! Suspensão Removida", "success")
				end, function() -- Cancel
					TriggerEvent("QBCore:Notify", "Falhou a remover a suspensão!", "error")
					ClearPedTasks(playerPed)								
				end)
			end
		end, GetVehicleNumberPlateText(vehicle))
	end
end)
