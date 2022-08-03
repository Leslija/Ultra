local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Windows

RegisterNetEvent('jim-mechanic:client:Windows:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		if GetVehicleWindowTint(vehicle) == tonumber(data.mod) then
			TriggerEvent('QBCore:Notify', data.name.." já aplicado!", "error")
			TriggerEvent('jim-mechanic:client:Windows:Check')
		elseif GetVehicleWindowTint(vehicle) ~= tonumber(data.mod) then
			time = math.random(3000,5000)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			TriggerEvent('animations:client:EmoteCommandStart', {"maid"})
			QBCore.Functions.Progressbar("drink_something", "A aplicar "..data.name.."..", time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {

			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				ClearPedTasks(playerPed)

				SetVehicleWindowTint(vehicle, tonumber(data.mod))
				
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Windows:Check')
				TriggerEvent("QBCore:Notify", "Successo! Película aplicada", "success")
				TriggerEvent('animations:client:EmoteCommandStart', {"c"})
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a aplicar película!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
				TriggerEvent('animations:client:EmoteCommandStart', {"c"})
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Windows:Check', function()
	if Config.CosmeticsJob then
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
	end
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	local validMods = { }
	local amountValidMods = 0   
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
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetVehicleWindowTint(vehicle) == 0 then applied1 = "Atualmente aplicado"  else applied1 = "" end
					if GetVehicleWindowTint(vehicle) == 4 then applied2 = "Atualmente aplicado"  else applied2 = "" end
					if GetVehicleWindowTint(vehicle) == 5 then applied3 = "Atualmente aplicado"  else applied3 = "" end
					if GetVehicleWindowTint(vehicle) == 3 then applied4 = "Atualmente aplicado"  else applied4 = "" end
					if GetVehicleWindowTint(vehicle) == 2 then applied5 = "Atualmente aplicado"  else applied5 = "" end
					if GetVehicleWindowTint(vehicle) == 1 then applied6 = "Atualmente aplicado" else applied6 = "" end

					exports['qb-menu']:openMenu({
						{ header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))).." Window Tints", txt = "", isMenuHeader = true },
						{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Windows:Apply", args = -2 } },
						{ header = "Remoção Tinta", txt = applied1, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 0, name = "Tint Removal" } } },
						{ header = "Limo", txt = applied2, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 4, name = "Limo Tint" } } },
						{ header = "Green", txt = applied3, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 5, name = "Green Tint" } } },
						{ header = "Light Smoke", txt = applied4, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 3, name = "Light Smoke Tint" } } },
						{ header = "Dark Smoke", txt = applied5, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 2, name = "Dark Smoke Tint" } } },
						{ header = "Pure Black", txt = applied6, params = { event = "jim-mechanic:client:Windows:Apply", args = { mod = 1, name = "Pure Black Tint" } } },
					})
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)