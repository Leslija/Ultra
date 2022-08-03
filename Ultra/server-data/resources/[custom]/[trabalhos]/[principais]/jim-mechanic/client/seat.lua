local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Seat

RegisterNetEvent('jim-mechanic:client:Seat:Apply', function(mod)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if mod == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		exports['qb-menu']:closeMenu()
	else
		local label = GetModTextLabel(vehicle, 32, tonumber(mod))
		local modName = GetLabelText(label)
		if modName == "NULL" then modName = "Stock Seat" end
		if GetVehicleMod(vehicle, 32) == tonumber(mod) then
			TriggerEvent('QBCore:Notify', modName.." já instalado!", "error")
			TriggerEvent('jim-mechanic:client:Seat:Check')
		elseif GetVehicleMod(vehicle, 32) ~= tonumber(mod) then
			time = math.random(3000,5000)
			SetVehicleDoorOpen(vehicle, 0, false, true)
			Wait(100)
			SetVehicleDoorOpen(vehicle, 1, false, true)
			Wait(100)
			SetVehicleDoorOpen(vehicle, 2, false, true)
			Wait(100)
			SetVehicleDoorOpen(vehicle, 3, false, true)
			TaskTurnPedToFaceEntity(playerPed, vehicle, 1000)
			Wait(1000)
			QBCore.Functions.Progressbar("drink_something", "A instalar "..modName.."..", time, false, true, { 
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
				ClearPedTasks(playerPed)

				Wait(500)
				SetVehicleMod(vehicle, 32, tonumber(mod))
				Wait(500)
				SetVehicleDoorShut(vehicle, 0, true)
				SetVehicleDoorShut(vehicle, 1, true)
				SetVehicleDoorShut(vehicle, 2, true)
				SetVehicleDoorShut(vehicle, 3, true)
								
				FreezeEntityPosition(playerPed, false)
				CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerEvent('jim-mechanic:client:Seat:Check')
				TriggerEvent("QBCore:Notify", "Successo! Assento Instalado", "success")
			end, function() -- Cancel
				TriggerEvent("QBCore:Notify", "Falhou a instalar assento!", "error")
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)	
			end)
		end
	end
end)

RegisterNetEvent('jim-mechanic:client:Seat:Check', function()
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
			for i = 1, GetNumVehicleMods(vehicle, 32) do
				local label = GetModTextLabel(vehicle, 32, (i - 1))
				local modName = GetLabelText(label)
				if GetVehicleMod(vehicle, 32) == (i-1) then
					txt = "Já Instalado"
				elseif GetVehicleMod(vehicle, 32) ~= (i-1) then
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
					if GetNumVehicleMods(vehicle, 32) == 0 then
						TriggerEvent("QBCore:Notify", "Não podes instalar assentos neste veículo", "error")
						return
					end				
					if GetVehicleMod(vehicle, 32) == -1 then
						stockinstall = "Já Instalado"
					elseif GetVehicleMod(vehicle, 32) ~= 1 then
						stockinstall = ""
					end
					local SeatMenu = {
							{
								isMenuHeader = true,
								header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Assentos',
								txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 32)+1,
							},
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Seat:Apply", args = -2 } },
							{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Seat:Apply", args = -1 }
							}	
						}
						for k,v in pairs(validMods) do
							SeatMenu[#SeatMenu + 1] = { header = v.name, txt = v.install, params = { event = 'jim-mechanic:client:Seat:Apply', args = tostring(v.id) } }
						end
					exports['qb-menu']:openMenu(SeatMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)