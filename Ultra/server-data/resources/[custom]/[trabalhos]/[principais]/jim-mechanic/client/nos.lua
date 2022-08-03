local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== NOS
local function trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end
RegisterNetEvent('jim-mechanic:client:applyNOS', function()
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
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
			SetVehicleModKit(vehicle, 0)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
			SetVehicleModKit(vehicle, 0)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if tostring(vehProps.modTurbo) == "false" then
						TriggerEvent("QBCore:Notify", "Turbo não está instalado", "error")
					else
						playAnim("mini@repair", "fixing_a_ped", 35000, 16)
						SetVehicleEngineOn(vehicle, false, false, true)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						SetVehicleDoorOpen(vehicle, 4, false, false)
						local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
						Skillbar.Start({
							duration = math.random(2500,5000),
							pos = math.random(10, 30),
							width = math.random(10, 20),
						}, function()
							TriggerEvent("QBCore:Notify", "Successo! A instalar NOS", "success")
							FreezeEntityPosition(playerPed, true)
							time = math.random(7000,10000)
							
							QBCore.Functions.Progressbar("drink_something", "A instalar NOS..", time, false, true, { 
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
								
								local Plate = trim(GetVehicleNumberPlateText(vehicle))
								TriggerServerEvent('nitrous:server:LoadNitrous', Plate)
									
								SetVehicleDoorShut(vehicle, 4, false)
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
								--SetVehicleEngineOn(vehicle, true, true)
								CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
								TriggerServerEvent('updateVehicle', CurrentVehicleData)
								TriggerServerEvent('jim-mechanic:server:removeNOS')
								TriggerEvent("QBCore:Notify", "Successo! NOS Instalado", "success")
							end, function() -- Cancel
								TriggerEvent("QBCore:Notify", "Falhou a instalar NOS!", "error")
								SetVehicleDoorShut(vehicle, 4, false)
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
							end)
						end, function()
							TriggerEvent("QBCore:Notify", "Falhou a instalar NOS!", "error")
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
