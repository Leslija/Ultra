local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Roof

RegisterNetEvent('jim-mechanic:client:Roof:Apply', function(mod)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if mod == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		local label = GetModTextLabel(vehicle, 10, tonumber(mod))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Roof" end
		if GetVehicleMod(vehicle, 10) == tonumber(mod) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Roof:Check')
		elseif GetVehicleMod(vehicle, 10) ~= tonumber(mod) then
			time = math.random(3000,5000)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("drink_something", "A instalar "..modName.."..", time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {
				task = "WORLD_HUMAN_WELDING"
			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				ClearPedTasks(playerPed)

				SetVehicleMod(vehicle, 10, tonumber(mod))
				
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Roof:Check')
				TriggerEvent("QBCore:Notify", "Successo! Teto instalado", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar teto!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Roof:Check', function()
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
			for i = 1, GetNumVehicleMods(vehicle, 10) do
				local label = GetModTextLabel(vehicle, 10, (i - 1))
				local modName = GetLabelText(label)
				if GetVehicleMod(vehicle, 10) == (i-1) then
					txt = "Já Instalado"
				elseif GetVehicleMod(vehicle, 10) ~= (i-1) then
					txt = ""
				end
				validMods[i] =
				{
					id = (i - 1),
					name = modName,
					install = txt
				}
				amountValidMods = amountValidMods + 1
			end
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetNumVehicleMods(vehicle, 10) == 0 then
						TriggerEvent("QBCore:Notify", "Tetos não podem ser instalados neste veículo", "error")
						return
					end
					if GetVehicleMod(vehicle, 10) == -1 then
						stockinstall = "Já Instalado"
					elseif GetVehicleMod(vehicle, 10) ~= 1 then
						stockinstall = ""
					end
					local RoofMenu = {
							{
								isMenuHeader = true,
								header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Teto',
								txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 10)+1,
							},
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Roof:Apply", args = -2 } },
							{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Roof:Apply", args = -1 }
							}	
						}
						for k,v in pairs(validMods) do
							RoofMenu[#RoofMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Roof:Apply', args = tostring(v.id) } }
						end
					exports['qb-menu']:openMenu(RoofMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)