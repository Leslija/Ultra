local QBCore = exports['qb-core']:GetCoreObject()
--========================================================== Horn

RegisterNetEvent('jim-mechanic:client:Horn:Apply', function(data)
	local playerPed	= PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	NetworkHasControlOfEntity(vehicle) NetworkRequestControlOfEntity(vehicle)
	if data == -2 then
		ClearPedTasks(playerPed)
		FreezeEntityPosition(playerPed, false)	
		SetVehicleDoorShut(vehicle, 4, false, false)
		exports['qb-menu']:closeMenu()
	else
		time = math.random(3000,5000)
		SetVehicleDoorOpen(vehicle, 4, false, false)
		QBCore.Functions.Progressbar("drink_something", "A instalar "..data.name.."..", time, false, true, { 
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
			ClearPedTasks(playerPed)
			SetVehicleMod(vehicle, 14, tonumber(data.mod))
			SetVehicleDoorShut(vehicle, 4, false, false)
			FreezeEntityPosition(playerPed, false)
			CurrentVehicleData = QBCore.Functions.GetVehicleProperties(vehicle)
			TriggerServerEvent('updateVehicle', CurrentVehicleData)
			TriggerEvent('jim-mechanic:client:Horn:Check')
			TriggerEvent("QBCore:Notify", "Successo! Buzina Instalada", "success")
		end, function() -- Cancel
			TriggerEvent("QBCore:Notify", "Falhou a instalar a buzina!", "error")
			ClearPedTasks(playerPed)
			SetVehicleDoorShut(vehicle, 4, false, false)
			FreezeEntityPosition(playerPed, false)	
		end)
	end
end)

RegisterNetEvent('jim-mechanic:client:Horn:Check', function()
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
			hornCheck = GetVehicleMod(vehicle, 14)
			for k, v in pairs(vehicleHorns) do	
				if hornCheck == tonumber(v.id) then installed = "Atualmente instalado" else installed = "" end
				validMods[k] = {
					id = v.id,
					name = v.name,
					txt = installed,
				}
			end
		end
		QBCore.Functions.TriggerCallback('jim-mechanic:checkVehicleOwner', function(owned)
			if Config.isVehicleOwned and not owned then
				TriggerEvent("QBCore:Notify", "Veículo não é de ninguém, não pode ser modificado", "error")
				return
			else	
				if DoesEntityExist(vehicle) then
					local plate = GetVehicleNumberPlateText(vehicle)
					if GetVehicleMod(vehicle, 14) == -1 then
						stockinstall = "Já Instalado"
					elseif GetVehicleMod(vehicle, 14) ~= 1 then
						stockinstall = ""
					end
					local HornMenu = {
							{
								header = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..' Modificações Buzina',
								txt = 'Quantidade de Opções: '..GetNumVehicleMods(vehicle, 14)+1,
								params = { event = "jim-mechanic:client:Horn:Test" },
							},
							{ header = "", txt = "✘ Fechar", params = { event = "jim-mechanic:client:Horn:Apply", args = -2 } },
							{ header = "Stock", txt = stockinstall,	params = { event = "jim-mechanic:client:Horn:Apply", args = { mod = -1, name = "Stock" } }
							}	
						}
						for k,v in pairs(validMods) do
							HornMenu[#HornMenu + 1] = { header = v.name, txt = v.txt, params = { event = 'jim-mechanic:client:Horn:Apply', args = { mod = v.id, name = v.name } } }
						end
					exports['qb-menu']:openMenu(HornMenu)
				end
			end
		end, GetVehicleNumberPlateText(vehicle))
	else
		TriggerEvent("QBCore:Notify", "Nenhum veículo por perto", "error")
	end
end)

RegisterNetEvent('jim-mechanic:client:Horn:Test', function()
	local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
	vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
	StartVehicleHorn(vehicle, 2000, "HELDDOWN", false)
	TriggerEvent('jim-mechanic:client:Horn:Check')
end)