local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Engines
RegisterNetEvent('jim-mechanic:client:applyEngine', function(level)
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
			SetVehicleModKit(vehicle, 0)
			vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
			currentEngine = vehProps.modEngine
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetNumVehicleMods(vehicle, 11) == 0 then
						TriggerEvent("QBCore:Notify", "Motores não podem ser instalados neste veículo", "error")
						return
					end
					
					if vehProps.modEngine-1 == level then
						TriggerEvent("QBCore:Notify", "Motor já instalado", "error")
					else						
						playAnim("mini@repair", "fixing_a_ped", 35000, 16)
						TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
						Wait(1000)
						SetVehicleEngineOn(vehicle, false, false, true)
						SetVehicleDoorOpen(vehicle, 4, false, false)	
						FreezeEntityPosition(playerPed, true)
						time = math.random(7000,10000)
						QBCore.Functions.Progressbar("drink_something", "A instalar motor..", time, false, true, { 
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
							if level == 1 then 
								SetVehicleMod(vehicle, 11, 2) 
							else
								SetVehicleMod(vehicle, 11, 3)
							end
							SetVehicleDoorShut(vehicle, 4, false)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
							TriggerServerEvent('updateVehicle', CurrentVehicleData)
							TriggerServerEvent('jim-mechanic:server:removeEngines', level, currentEngine)
							--TriggerServerEvent('jim-mechanic:server:giveEngines', currentEngine)
							TriggerEvent("QBCore:Notify", "Motor Instalado", "success")						
						end, function()
							TriggerEvent("QBCore:Notify", "Falhou a instalação do motor!", "error")
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

RegisterNetEvent('jim-mechanic:client:giveEngine')
AddEventHandler('jim-mechanic:client:giveEngine', function()
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
			SetVehicleModKit(vehicle, 0)
			--Grab info which engine is already in
			currentEngine = GetVehicleMod(vehicle, 11)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			QBCore.Functions.Progressbar("accepted_key", "A remover motor", 8000, false, true, {
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
				SetVehicleMod(vehicle, 11, -1)
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				--SetVehicleEngineOn(vehicle, true, true)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('jim-mechanic:server:removeEngines', 0, currentEngine)
				TriggerEvent("QBCore:Notify", "Successo! Motor removido", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a remover o motor!", "error")
				ClearPedTasks(playerPed)								
			end)
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

local vehicle_sounds = {}
RegisterNetEvent("engine:sound")
AddEventHandler("engine:sound", function(name,plate)
    if vehicle_sounds[plate] == nil then
        vehicle_sounds[plate] = {}
    end
    vehicle_sounds[plate].plate = plate
    vehicle_sounds[plate].name = name
end)

Citizen.CreateThread(function()
    while true do
        local mycoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(GetGamePool('CVehicle')) do
            if #(mycoords - GetEntityCoords(v, false)) < 100 then
                local plate = string.gsub(GetVehicleNumberPlateText(v), "%s+", "")
                if vehicle_sounds[plate] ~= nil and vehicle_sounds[plate].plate ~= nil and plate == vehicle_sounds[plate].plate and vehicle_sounds[plate].current ~= vehicle_sounds[plate].name then
                    ForceVehicleEngineAudio(v,vehicle_sounds[plate].name)
                    vehicle_sounds[plate].current = vehicle_sounds[plate].name
                end
            end
        end
        Wait(2000)
    end
end)

RegisterNetEvent("jim-mechanic:togglesound", function(toggle)
	if toggle ~= "on" and toggle ~= "off" then TriggerEvent('QBCore:Notify', "Argumento inválido", "error") return end

	vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	--Grab info which engine is already in
	currentEngine = GetVehicleMod(vehicle, 11)
	if toggle == "on" then
		if currentEngine == 3 then ForceVehicleEngineAudio(vehicle,"monster")
		elseif currentEngine == 2 then	ForceVehicleEngineAudio(vehicle,"zorrusso") end
	elseif toggle == "off" then
		ForceVehicleEngineAudio(vehicle,string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))))
	end
end, false)