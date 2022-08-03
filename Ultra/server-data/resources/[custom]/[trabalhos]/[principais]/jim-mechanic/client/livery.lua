local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Livery

RegisterNetEvent('jim-mechanic:client:Livery:Apply', function(mod)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if mod == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		local label = GetModTextLabel(vehicle, 48, tonumber(mod))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock" end
		if GetVehicleLivery(vehicle) == tonumber(mod) then
			TriggerEvent('QBCore:Notify', modName.." já aplicada!", "error")
			TriggerEvent('jim-mechanic:client:Livery:Check')
		elseif GetVehicleLivery(vehicle) ~= tonumber(mod) then
			time = math.random(3000,5000)
			TriggerEvent('animations:client:EmoteCommandStart', {"clean"})
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			QBCore.Functions.Progressbar("drink_something", "A aplicar "..modName.." livery..", time, false, true, { 
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
			}, {
				--task = "WORLD_HUMAN_WELDING"
			}, {}, {}, function()
				SetVehicleModKit(vehicle, 0)
				SetVehicleMod(vehicle, 48, tonumber(mod), true)
				SetVehicleLivery(vehicle, tonumber(mod))
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Livery:Check')
				TriggerEvent("QBCore:Notify", "Successo! Livery aplicada", "success")
				TriggerEvent('animations:client:EmoteCommandStart', {"c"})
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a aplicar livery!", "error")
				TriggerEvent('animations:client:EmoteCommandStart', {"c"})
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Livery:Check', function()
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
			for i = 1, GetNumVehicleMods(vehicle, 48) do
				local label = GetModTextLabel(vehicle, 48, (i - 1))
				local modName = GetLabelText(label)
				if GetVehicleLivery(vehicle) == (i-1) then
					txt = "Aplicada atualmente"
				elseif GetVehicleLivery(vehicle) ~= (i-1) then
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
					if GetNumVehicleMods(vehicle, 48) == 0 then
						TriggerEvent("QBCore:Notify", "Liveries can't be installed on this vehicle", "error")
						return
					end
					if GetVehicleLivery(vehicle) == -1 then
						stockinstall = "Já Instalado"
					elseif GetVehicleLivery(vehicle) ~= 1 then
						stockinstall = ""
					end
					local LiveryMenu = {
							{
								isMenuHeader = true,
								header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Livery',
								txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 48)+1,
							},
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Livery:Apply", args = -2 } },
							{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Livery:Apply", args = -1 }
							}	
						}
						for k,v in pairs(validMods) do
							LiveryMenu[#LiveryMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Livery:Apply', args = tostring(v.id) } }
						end

					exports['qb-menu']:openMenu(LiveryMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)